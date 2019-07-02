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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D67C1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 10:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfGBKnJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 06:43:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42663 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfGBKnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 06:43:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so17192112wrl.9
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 03:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4kEWPBLulCI5h1irJ03T9oEh9JAT6xdNZxT83C9G3Ks=;
        b=Ol+px/TnOmFtDHhTh3H3Ro6my9DAs14HOintIsMRSly83ffUmU66UN01VNuFvNqt7R
         YhLv1DOfRwldRBm3S9I/B7XMVvQWW9IphGsNqea/0p0Yw37L8zIJpyztVVQbfZEngCr4
         4dB14mw/c9CkNplbpn7HxhS+LeN22mOQiWqUCzpmcPY9sK3dmpbUdNbOBDYAJob0LREJ
         5gF1PCGR3M1kPvmlwQg7ufXjnqGIB8I+EyUBNkrhhj0zE+bvhoq+l5vVxySGr47u/rHC
         kAzC3vvGg9BZvardqQm0VGp1i2U1mjWU5zvxdTqipGRg1BEqzDGUH8bilQQ6qRT4M8QB
         izzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4kEWPBLulCI5h1irJ03T9oEh9JAT6xdNZxT83C9G3Ks=;
        b=L7w8LRshiDvtENC+nYx8ol78xazC+5rih7wSvWoLteJW7W0w4qzXiWmn0QgA556jCy
         SAY/sn6USyvs9x4oxXiy2BPNrwwnblhm7C4NRQZVbErqd4A3f3etgsPaFTiSNEijETtZ
         e78iXrIkR5YYqlnwveDRjdLC2uKBbF82YrqeYMT9ruQH/+glHChh0lYB+BjQPuBXjWBK
         NWcatDc7+YEfyJDTEdTBDNvcUhd99YV5oBWWPq7FVPv35Eay6+ECTj/Gd4o4DlZ8sIcB
         2jyHYiiCC6Mtf7Iu8uuejimvTIcpAaL2b1ilGYRJsCttKUMmtK1Pj4I/NSQKDy2QoZc7
         Cntw==
X-Gm-Message-State: APjAAAVtCOOAfduN8ipM7cfrQPW+YHWyOEoLD8phI2NmQNNHJo6omfu9
        YClhzqkhE4J/xTm+Iq1Plk0PSk2w
X-Google-Smtp-Source: APXvYqy39mDLKjgaBE9M7IH4YNxMGJ019dGuxtnYPKNFHdl8HIRwBc91UvvahuVTUxX/az2ujza4/g==
X-Received: by 2002:a05:6000:1011:: with SMTP id a17mr13008545wrx.0.1562064186693;
        Tue, 02 Jul 2019 03:43:06 -0700 (PDT)
Received: from szeder.dev (x4dbd205f.dyn.telefonica.de. [77.189.32.95])
        by smtp.gmail.com with ESMTPSA id b9sm7246965wrx.57.2019.07.02.03.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:43:05 -0700 (PDT)
Date:   Tue, 2 Jul 2019 12:43:03 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, eckhard.s.maass@googlemail.com,
        git@vger.kernel.org, jacob.keller@gmail.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 07/27] checkout: inform the user when removing branch
 state
Message-ID: <20190702104303.GM21574@szeder.dev>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-8-pclouds@gmail.com>
 <20190702080611.GL21574@szeder.dev>
 <20190702090308.GA27775@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702090308.GA27775@ash>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 02, 2019 at 04:03:09PM +0700, Duy Nguyen wrote:
> On Tue, Jul 02, 2019 at 10:06:11AM +0200, SZEDER Gábor wrote:
> > On Fri, Mar 29, 2019 at 05:38:59PM +0700, Nguyễn Thái Ngọc Duy wrote:
> > > After a successful switch, if a merge, cherry-pick or revert is ongoing,
> > > it is canceled. This behavior has been with us from the very early
> > > beginning, soon after git-merge was created but never actually
> > > documented [1]. It may be a good idea to be transparent and tell the
> > > user if some operation is canceled.
> > 
> > After this entered 'next' last week, today it greeted me with 167(!)
> > of these warnings...  before I even had my breakfast.
> > 
> > Now, my script does a lot of repeated cherry-picks and expects that
> > rerere is able to deal with most of the conflicts, i.e. it does
> > approximately this:
> > 
> >   if ! git cherry-pick $oid >/dev/null 2>&1
> >   then
> >       if was_the_conflict_resolved
> >       then
> >           echo "using previous conflict resolution"
> >           git commit --no-edit --cleanup=strip --quiet
> >       else
> >           die "uh-oh"
> >       fi
> >   fi
> > 
> > That 'git commit' in there always prints:
> > 
> >   warning: cancelling a cherry picking in progress
> > 
> > I don't understand why committing after a cherry-pick is considered
> > "cancelling"...  in my view it's finishing it and there should be no
> > warning whatsoever.
> > 
> 
> I agree, this is not "canceling". I think this series causes conflicts
> with pw/clean-sequencer-state-upon-final-commit and the warning is
> accidentally enabled (partly my fault since I named the argument
> "verbose").
> 
> Junio, in this conflict resolution (merging nd/switch-and-restore to
> next), we should pass '0' instead of 'verbose' to
> sequencer_post_commit_cleanup().
> 
> diff --cc builtin/commit.c
> index 1921401117,fa5982cc86..145d50caf0
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@@ -1658,7 -1666,8 +1658,7 @@@ int cmd_commit(int argc, const char **a
>   		die("%s", err.buf);
>   	}
>   
> - 	sequencer_post_commit_cleanup(the_repository);
>  -	unlink(git_path_cherry_pick_head(the_repository));
>  -	unlink(git_path_revert_head(the_repository));
> ++	sequencer_post_commit_cleanup(the_repository, verbose);
>   	unlink(git_path_merge_head(the_repository));
>   	unlink(git_path_merge_msg(the_repository));
>   	unlink(git_path_merge_mode(the_repository));

Thanks, this indeed takes care of it.

