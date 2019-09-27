Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5CAB1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 17:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfI0RKk (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 13:10:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46043 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0RKj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 13:10:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id q7so3806640pgi.12
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c4bhQYWaEGneMXjDpvNsGw7kCrBxAo0uIVy6FeyXWD8=;
        b=aN6nzrO2U6ijQc7a3NM03sHKy0fSpUgMVg4mMr8BvSZo/fREdNoQOjH2ztkE73AuLJ
         ODVrZFPXNBHGnkztttxbbWxoqYV0v6YxZhwz94SwYoENgwIjVmZXwXPCydvKy5aH1SsB
         aPmoESDr+mSDo66hb3w2ZzujUHwGGHpWQ3ODroKvmu5GGwqLdmfqO9IPH2v7dwcIkPDl
         MshN7ckKedPXvrDZq9t03FWBkPfehOVnOgxbFSbJz/x1lJY/jcHgQuqT1BP5v8pPLCf0
         3GGEtkVfyxyUg+tq+ETTtDwaS96s8LTJ2ryJmDXwviDewuLaU6HvevwdyuGJg6kDMCtI
         0jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c4bhQYWaEGneMXjDpvNsGw7kCrBxAo0uIVy6FeyXWD8=;
        b=tUf8O/EQA9+D6/qP2K+HTeTOwt6h28UTDxMtr7Mu4IKntzETM0E/EfCDtsiFBbpHzS
         heC/mpJJmmYAsz7x7Ika0soItq3Kn5BYd/2Eb3Mpd+41O63kLjVHfRfnVMfPISmuD5JE
         L2FX0c+HG0VIeqHIMQWtAF7/fn/h6y6wsTc1q8Y+eLKVg5QqK3HI7YQtSGvyaGZYI8ly
         Sn2gxSZabbErfsDNHT/GgWFiPIh7Ob8P4mY1bwKAPSPhyCR9l7f1b9RBO/+TQpbaT27z
         yHj4nWeAuqdZff9ZFTEFK1jSjL17lDIkZ4XncRMmuI8Vc1x/oHN+JjAJQ4kzJkMFq1b7
         7qUQ==
X-Gm-Message-State: APjAAAWOqu0C/08GFkFEyYSmIg/W2G2OrP9Ew+b9fe46Z/xmkCHkK42O
        AESvZ0Q02m07z9KiNKfLhFs=
X-Google-Smtp-Source: APXvYqyQbeyUd76jEW3VlS18ZHOd7ixKGlanVGpeEW2nUvWhsofsNDTkHQYJM9pb8NB25MkyrWHPDg==
X-Received: by 2002:a63:fe42:: with SMTP id x2mr10305932pgj.80.1569604238715;
        Fri, 27 Sep 2019 10:10:38 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id k9sm3199538pfk.72.2019.09.27.10.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 10:10:37 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:10:34 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [BUG] git is segfaulting, was [PATCH v4 04/12] dir: also check
 directories for matching pathspecs
Message-ID: <20190927171034.GA6542@generichostname>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
 <20190917163504.14566-5-newren@gmail.com>
 <20190925203919.GA89135@generichostname>
 <20190927010930.GK2637@szeder.dev>
 <20190927021746.GL2637@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190927021746.GL2637@szeder.dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 27, 2019 at 04:17:46AM +0200, SZEDER Gábor wrote:
> On Fri, Sep 27, 2019 at 03:09:30AM +0200, SZEDER Gábor wrote:
> > On Wed, Sep 25, 2019 at 01:39:19PM -0700, Denton Liu wrote:
> > > Hi Elijah,
> > > 
> > > I ran into a segfault on MacOS. I managed to bisect it down to
> > > 404ebceda0 (dir: also check directories for matching pathspecs,
> > > 2019-09-17), which should be the patch in the parent thread. The test
> > > case below works fine without this patch applied but segfaults once it
> > > is applied.
> > > 
> > > 	#!/bin/sh
> > > 
> > > 	git worktree add testdir
> > > 	git -C testdir checkout master
> > > 	git -C testdir fetch https://github.com/git/git.git todo
> > > 	bin-wrappers/git -C testdir checkout FETCH_HEAD # segfault here
> > > 
> > > Note that the worktree part isn't necessary to reproduce the problem but
> > > I didn't want my files to be constantly refreshed, triggering a rebuild
> > > each time.
> > > 
> > > I also managed to get this backtrace from running lldb at the segfault
> > > but it is based on the latest "jch" commit, 1cc52d20df (Merge branch
> > > 'jt/merge-recursive-symlink-is-not-a-dir-in-way' into jch, 2019-09-20).
> > > 
> > > 	* thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=1, address=0x8)
> > > 	  * frame #0: 0x00000001000f63a0 git`do_match_pathspec(istate=0x0000000100299940, ps=0x000000010200aa80, name="Gitweb/static/js/lib/", namelen=21, prefix=0, seen=0x0000000000000000, flags=0) at dir.c:420:2 [opt]
> > > 		frame #1: 0x00000001000f632c git`match_pathspec(istate=0x0000000100299940, ps=0x0000000000000000, name="Gitweb/static/js/lib/", namelen=21, prefix=0, seen=0x0000000000000000, is_dir=0) at dir.c:490:13 [opt]
> > > 		frame #2: 0x00000001000f8315 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=17, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1990:9 [opt]
> > > 		frame #3: 0x00000001000f82e9 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=14, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1984:5 [opt]
> > > 		frame #4: 0x00000001000f82e9 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=7, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1984:5 [opt]
> > > 		frame #5: 0x00000001000f60d1 git`read_directory(dir=0x00007ffeefbfe278, istate=0x0000000100299940, path="Gitweb/", len=7, pathspec=0x0000000000000000) at dir.c:2298:3 [opt]
> > > 		frame #6: 0x00000001001bded1 git`verify_clean_subdirectory(ce=<unavailable>, o=0x00007ffeefbfe8c0) at unpack-trees.c:1846:6 [opt]
> > > 		frame #7: 0x00000001001bdc1d git`check_ok_to_remove(name="Gitweb", len=6, dtype=4, ce=0x0000000103e70de0, st=0x00007ffeefbfe438, error_type=ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o=0x00007ffeefbfe8c0) at unpack-trees.c:1901:7 [opt]
> > 
> > That 'name="Gitweb" parameter caught my eye.  origin/todo contains a
> > 'Gitweb' file, with upper case 'G', while master contains a 'gitweb'
> > directory, with lower case 'g'.  
> > 
> > Could it be that case (in)sensitivity plays a crucial rule in
> > triggering the segfault?  FWIW I could reproduce it following Denton's
> > description on Travis CI's macOS VM with the debug shell access, and
> > it uses case insensitive file system.
> 
> Indeed, with 404ebceda0 the test below segfaults on case insensitive
> fs, but not on a case sensitive one.

Wow, good catch. I didn't even notice that in the backtrace.

> 
> 
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 192c94eccd..5b405c97d7 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -131,4 +131,27 @@ $test_unicode 'merge (silent unicode normalization)' '
>  	git merge topic
>  '
>  
> +test_expect_success CASE_INSENSITIVE_FS "Denton's segfault" '
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		echo foo >Gitweb &&
> +		git add Gitweb &&
> +		git commit -m "add Gitweb" &&
> +
> +		git checkout --orphan todo &&
> +		git reset --hard &&
> +		# the subdir is crucial, without it there is no segfault
> +		mkdir -p gitweb/subdir &&
> +		echo bar >gitweb/subdir/file &&
> +		# it is not strictly necessary to add and commit the
> +		# gitweb directory, its presence is sufficient
> +		git add gitweb &&
> +		git commit -m "add gitweb/subdir/file" &&
> +
> +		git checkout master
> +	)
> +'
> +
>  test_done

I can confirm that this test case reproduces for me. Thanks for writing
this.

> 
> 
> 
> The end of its trace:
> 
> ++git checkout master
> ./test-lib.sh: line 910: 11220 Segmentation fault: 11  git checkout master
> error: last command exited with $?=139
> 
> Case insensitivity is important because check_ok_to_remove() is
> invoked from verify_absent_1(), which looks like this:
> 
>   if (...)
>      ....
>   else if (...)
>      ....
>   else if (lstat(ce->name, &st))
>       // That lstat() checked whether 'Gitweb' is absent.  On a case
>       // sensitive fs it's absent, so it returns.  On a case
>       // insensitive fs it finds 'master's 'gitweb' directory, so it
>       // goes on to the else below, and eventually segfaults.
>       return;
>   else
>       check_ok_to_remove()
> 
> 
> Good night :)

Thanks for your help!
