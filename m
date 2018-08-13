Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075CF1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbeHMUBl (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:01:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38801 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeHMUBl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:01:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so9574647wmi.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1tVCyt0hLKfgTY8L0/qQIsGbiw+kfqAjxqqaqu0x+wA=;
        b=O/3BeA6sj+lhWmH+Cm5SYov1Qj4WhcDcJbSeb2aK8BDKxq5ffnjfWplA0e+WyNKEGr
         6fe9TqujmufkuV7PS47MnXWVLhcjwI2DUkRt1tDLH50k50W6PpnNJULGUpmwEXDSRDkr
         U+/eN+CHz4906HzVg2/D8MAAz7SBSism56VEuL+LrQ4684rzlErKpMiAg+x4GqG2ZDkA
         7i0L8BDVqN8cNZNEhzrASwYXJd0uHeHnRB12l8MT2bp7wJWtUdCVVGWYX2UfV7VW37Xh
         6LtvJ3+lOcZ3nJyfbzpko1HZB/sbO8Q058lZqNkZFKl1TquxjMI42FVRLkJr3QlHOfoF
         R2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1tVCyt0hLKfgTY8L0/qQIsGbiw+kfqAjxqqaqu0x+wA=;
        b=oaEVcI+Ju1KOLrXyeK7jJDYBNeQ4X/m9pr+P9QOcNgJU2TsNzYjzkv9g7kALJrksb+
         MD7I3GXex/9PZvvmDIpiRcc21hFeLqzyyRm+pxm91Iuru6K7uUJ1gNPe9HVHteF/h2Pl
         MHTZcFyTdi3A70P6XGZ9yDX7ROLYKecnyoSW42kZEIFSm5LzWwiWamb7HrtuKF0V+k/l
         depjtMPLGBF2PxvSDeMAos2n8jVEjkzLqfQKRbyz/FGWKJOuenQEukkvGDdA6lIU4VzX
         4Rww3tVyKI6uPwmrXLO6ah7XXWawKGZmvqJxBmcqJfTI9m5gqh14+OdGlRWhIY7imD6O
         zAPQ==
X-Gm-Message-State: AOUpUlFdhb3UWsYEBbgTCl8OvOUhdeUkR6Dt6aggpwfyAI6GIOFywf+T
        jIM6BHBdv+O7lGk4jpVA2odDAnEW
X-Google-Smtp-Source: AA+uWPxjByDrVmNMxvlhrE1TMpTD3jpBHDHV2e/AIT/YwpYqciJ2Y3UiOeqmeV8Gd8qDM83Pl5D0Ew==
X-Received: by 2002:a1c:149:: with SMTP id 70-v6mr9094534wmb.2.1534180712425;
        Mon, 13 Aug 2018 10:18:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h5-v6sm18961630wrr.19.2018.08.13.10.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:18:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, tboegi@web.de,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4] clone: report duplicate entries on case-insensitive filesystems
References: <20180810153608.30051-1-pclouds@gmail.com>
        <20180812090714.19060-1-pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 10:18:31 -0700
In-Reply-To: <20180812090714.19060-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 12 Aug 2018 11:07:14 +0200")
Message-ID: <xmqq4lfy6v88.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Paths that only differ in case work fine in a case-sensitive
> filesystems, but if those repos are cloned in a case-insensitive one,
> you'll get problems. The first thing to notice is "git status" will
> never be clean with no indication what exactly is "dirty".
>
> This patch helps the situation a bit by pointing out the problem at
> clone time. Even though this patch talks about case sensitivity, the
> patch makes no assumption about folding rules by the filesystem. It
> simply observes that if an entry has been already checked out at clone
> time when we're about to write a new path, some folding rules are
> behind this.
>
> This patch is tested with vim-colorschemes repository on a JFS partition
> with case insensitive support on Linux. This repository has two files
> darkBlue.vim and darkblue.vim.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  v4 removes nr_duplicates (and fixes that false warning Szeder
>  reported). It also hints about case insensitivity as a cause of
>  problem because it's most likely the case when this warning shows up.

Ah, you no longer have that counter and the pointer to the counter,
as you do not even report how many paths collide ;-)  Makes sense.

> diff --git a/entry.c b/entry.c
> index b5d1d3cf23..c70340df8e 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -399,6 +399,31 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
>  	return lstat(path, st);
>  }
>  
> +static void mark_colliding_entries(const struct checkout *state,
> +				   struct cache_entry *ce, struct stat *st)
> +{
> +	int i;
> +
> +	ce->ce_flags |= CE_MATCHED;
> +
> +#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
> +	for (i = 0; i < state->istate->cache_nr; i++) {
> +		struct cache_entry *dup = state->istate->cache[i];
> +
> +		if (dup == ce)
> +			break;
> +
> +		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
> +			continue;
> +
> +		if (dup->ce_stat_data.sd_ino == st->st_ino) {
> +			dup->ce_flags |= CE_MATCHED;
> +			break;
> +		}
> +	}
> +#endif
> +}

OK.  The whole loop might want to become a call to a helper function
whose implementation is platform dependent in the future, but that
should be kept outside the topic and left for a future enhancement.

> @@ -455,6 +480,9 @@ int checkout_entry(struct cache_entry *ce,
>  			return -1;
>  		}
>  
> +		if (state->clone)
> +			mark_colliding_entries(state, ce, &st);

OK.  I haven't carefully looked at the codepath but is it more
involved to instead *not* check out this ce (and leave the working
tree file that is already there for another path in the index
alone)?  I suspect it won't be as simple as

		if (state->clone) {
			mark_colliding_entries(state, ce, &st);
			return -1;
		}

but I think it would give much more pleasant end-user experience if
we can do so, especially on GIT_WINDOWS_NATIVE.  I would imagine
that the first thing those who see the message "foo.txt have
collided with something else we are not telling you" would want to
do is to see what "foo.txt" contains---and it may be obvious to
human that it contains the contents intended for "Foo.txt" instead,
if we somehow refrained from overwriting it here, which would
compensate for the lack of "this is the other path that collided
with your file."

It is perfectly an acceptable answer if it is "I looked at it, and
it is a lot more involved as there are these fallouts from the
codepaths that the control flows later from this point you haven't
checked and considered---let's keep overwriting, it is much safer."

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 0b62037744..f2eb73bc74 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -624,10 +624,16 @@ test_expect_success 'clone on case-insensitive fs' '
>  			git hash-object -w -t tree --stdin) &&
>  		c=$(git commit-tree -m bogus $t) &&
>  		git update-ref refs/heads/bogus $c &&
> -		git clone -b bogus . bogus
> +		git clone -b bogus . bogus 2>warning
>  	)
>  '
>  
> +test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
> +	grep X icasefs/warning &&
> +	grep x icasefs/warning &&
> +	test_i18ngrep "the following paths have collided" icasefs/warning
> +'
> +

Ah, I was wondering why possible error message needs to be hidden in
the previous test---it is not hiding; it is capturing to look for
the paths in the message.  Makes sense.

