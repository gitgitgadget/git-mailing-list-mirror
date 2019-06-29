Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07EB31F4B6
	for <e@80x24.org>; Sat, 29 Jun 2019 08:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfF2IDI (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 04:03:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33394 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfF2IDH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 04:03:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so8544772wru.0
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0X1IYBz6S/X8G7Yzb9utCILZhDhEMfklRI1Qa2RkuEw=;
        b=K+el21My0bgvLEB5xoXrN22HSl8JtXguUCL1F6hy1A3hfxrUifsBwgl/4XC71turnI
         RFsTIO0K2wzX9T0XKOuLIQaFqTore8yBpW+XhbiFYZds/TeQaIubElp3QIRfSprpDAQV
         RYAePKN76n7+ZGCTU9f72uXHGYo1vkxrxX5nlEOPvYA7BwzrCjm438/ZEpcmU2ZZYqlu
         tek/QGQJyftpap/qeh/Mxh/8lZliZPoWbEWudOgzHFtWPwxC4KVSWibMoLjVzd8GqEfd
         tEsimWdELPrMQu4yAC8NyCJK5YXA5o/wAGO4BblEeSVl6gejojuyZvhglpx/nQvvE3l3
         OY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0X1IYBz6S/X8G7Yzb9utCILZhDhEMfklRI1Qa2RkuEw=;
        b=nTsCA8nDqLVnwwt9aPYMr7d4B2vHQ6GhplYAtkTEa3pO/PMlJ66ojx+fp41IAT9sLd
         rt3nTP/I5r3Q5PFJzGFsLWjE+vqXW/dtywfNpK3d/jBxKQJOeyweHqOBTomukL+pW4Mp
         4r4K+qzT2cUXhWGkAIwDoLvls6+jPw9x0iD0Vb6wG1o/eFF982U77bE+Di+lCa6fsqQQ
         TngKj+/fgopShPP4nF/RAjfwa86ZJm0hGQtQDQ0fLGgiThDKtCtpju/Q9q0cX14zIIDO
         Qw0MWOi7htDswBRZiPhLbFMbvhr/DU1E+E+f9QqTFF8vHegC/pCUU48vDhM/1gacss4T
         Jt3Q==
X-Gm-Message-State: APjAAAUMr5binxnTp7pwWPH5LPMzpXAALuSdC5XQGI+Kl/x3mQOFqNfu
        oTi/EXNaaxjXWOo4BhU13KEFNwaC
X-Google-Smtp-Source: APXvYqyc/yVtn/q/3kr6cQkufo6nzgm5t8hM4o4V8HlKbwrZS33s3YQ5NodOx8mVzngN7rwhxrOroQ==
X-Received: by 2002:adf:b605:: with SMTP id f5mr11519469wre.305.1561795384962;
        Sat, 29 Jun 2019 01:03:04 -0700 (PDT)
Received: from szeder.dev (x4db511ea.dyn.telefonica.de. [77.181.17.234])
        by smtp.gmail.com with ESMTPSA id l1sm13182794wrf.46.2019.06.29.01.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 01:03:04 -0700 (PDT)
Date:   Sat, 29 Jun 2019 10:03:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] repack: disable bitmaps-by-default if .keep files exist
Message-ID: <20190629080302.GD21574@szeder.dev>
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
 <20190623180226.GA1100@sigill.intra.peff.net>
 <20190623180825.3ospajjgat3clwiu@dcvr>
 <20190623224244.GB1100@sigill.intra.peff.net>
 <20190628070211.hfweqcons6c6gy52@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628070211.hfweqcons6c6gy52@dcvr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 07:02:11AM +0000, Eric Wong wrote:
> Jeff King <peff@peff.net> wrote:
> > On Sun, Jun 23, 2019 at 06:08:25PM +0000, Eric Wong wrote:
> > 
> > > > I'm not sure of the right solution. For maximal backwards-compatibility,
> > > > the default for bitmaps could become "if not bare and if there are no
> > > > .keep files". But that would mean bitmaps sometimes not getting
> > > > generated because of the problems that ee34a2bead was trying to solve.
> > > > 
> > > > That's probably OK, though; you can always flip the bitmap config to
> > > > "true" yourself if you _must_ have bitmaps.
> > > 
> > > What about something like this?  Needs tests but I need to leave, now.
> > 
> > Yeah, I think that's the right direction.
> 
> OK.  I have a real patch with one additional test, below.
> (don't have a lot of time for hacking)
> 
> > Though...
> > 
> > > +static int has_pack_keep_file(void)
> > > +{
> > > +	DIR *dir;
> > > +	struct dirent *e;
> > > +	int found = 0;
> > > +
> > > +	if (!(dir = opendir(packdir)))
> > > +		return found;
> > > +
> > > +	while ((e = readdir(dir)) != NULL) {
> > > +		if (ends_with(e->d_name, ".keep")) {
> > > +			found = 1;
> > > +			break;
> > > +		}
> > > +	}
> > > +	closedir(dir);
> > > +	return found;
> > > +}
> > 
> > I think this can be replaced with just checking p->pack_keep for each
> > item in the packed_git list.
> 
> Good point, I tend to forget git C API internals as soon as I
> learn them :x
> 
> > That's racy, but then so is your code here, since it's really the child
> > pack-objects which is going to deal with the .keep. I don't think we
> > need to care much about the race, though. Either:
> 
> Agreed.  <snip>
> 
> --------8<-------
> Subject: [PATCH] repack: disable bitmaps-by-default if .keep files exist
> 
> Bitmaps aren't useful with multiple packs, and users with
> .keep files ended up with redundant packs when bitmaps
> got enabled by default in bare repos.
> 
> So detect when .keep files exist and stop enabling bitmaps
> by default in that case.
> 
> Wasteful (but otherwise harmless) race conditions with .keep files
> documented by Jeff King still apply and there's a chance we'd
> still end up with redundant data on the FS:
> 
>   https://public-inbox.org/git/20190623224244.GB1100@sigill.intra.peff.net/
> 
> Fixes: 36eba0323d3288a8 ("repack: enable bitmaps by default on bare repos")
> Signed-off-by: Eric Wong <e@80x24.org>
> Helped-by: Jeff King <peff@peff.net>
> Reported-by: Janos Farkas <chexum@gmail.com>
> ---
>  builtin/repack.c  | 18 ++++++++++++++++--
>  t/t7700-repack.sh | 10 ++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index caca113927..a9529d1afc 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -89,6 +89,17 @@ static void remove_pack_on_signal(int signo)
>  	raise(signo);
>  }
>  
> +static int has_pack_keep_file(void)
> +{
> +	struct packed_git *p;
> +
> +	for (p = get_packed_git(the_repository); p; p = p->next) {
> +		if (p->pack_keep)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Adds all packs hex strings to the fname list, which do not
>   * have a corresponding .keep file. These packs are not to
> @@ -343,9 +354,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
>  		die(_("--keep-unreachable and -A are incompatible"));
>  
> -	if (write_bitmaps < 0)
> +	if (write_bitmaps < 0) {
>  		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
> -				 is_bare_repository();
> +				 is_bare_repository() &&
> +				 keep_pack_list.nr == 0 &&
> +				 !has_pack_keep_file();
> +	}
>  	if (pack_kept_objects < 0)
>  		pack_kept_objects = write_bitmaps;
>  
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 86d05160a3..0acde3b1f8 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -239,4 +239,14 @@ test_expect_success 'bitmaps can be disabled on bare repos' '
>  	test -z "$bitmap"
>  '
>  
> +test_expect_success 'no bitmaps created if .keep files present' '
> +	pack=$(ls bare.git/objects/pack/*.pack) &&
> +	test_path_is_file "$pack" &&
> +	keep=${pack%.pack}.keep &&
> +	>"$keep" &&
> +	git -C bare.git repack -ad &&
> +	bitmap=$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
> +	test -z "$bitmap"

This test fails when run with 'GIT_TEST_MULTI_PACK_INDEX=1':

  + ls bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.pack
  + pack=bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.pack
  + test_path_is_file bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.pack
  + test -f bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.pack
  + keep=bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.keep
  +
  + git -C bare.git repack -ad
  + ls bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.bitmap
  + bitmap=bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.bitmap
  + test -z bare.git/objects/pack/pack-51a6a758692f03f9e1f31fd087bba30584afad2f.bitmap
  error: last command exited with $?=1
  not ok 15 - no bitmaps created if .keep files present

When the new has_pack_keep_file() helper function calls
get_packed_git(the_repository) in the loop it returns with NULL
already on the first iteration, so the keep file goes unnoticed.

> +'
> +
>  test_done
> -- 
> EW
