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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FBCD1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 01:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfI0BJg (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 21:09:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45198 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfI0BJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 21:09:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so735352wrm.12
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rOWjS+oXLLov0LyjWv69ehhTPMHkGaiS/F4Uf0V6SHU=;
        b=orQOeAsLT8SCE67V0JDcoT0TIMX1Cf44oFElN5sXBQNMdBfWgvBZOvvOO1QmdykpGk
         DJQHT1rHv4W7IAg4zyTnCRkrm5Zwvx1U0hQlDm5TR6/T4WZrGmBJljblIh0kdeU4KoZp
         2eaO4R0XZkSxzkBmHqIVJl3qwGHy6qllJ/N4evAdu3dYRIZJ4RU7TGu4vNvvMN2iL0iO
         n01PkABNSl+YRZ1GGnQT/LIWBPJBjKmHwETqHLLYUSyApLIMwxT0pb9midJY1yVIYm4U
         cJF6k0CHee2b0Hu8a14MvTnZDOQ882FvlaJGWa/kj7xUXqqnVzsjo8vK1mE6Im/XFYNy
         YqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rOWjS+oXLLov0LyjWv69ehhTPMHkGaiS/F4Uf0V6SHU=;
        b=ZseslQfED9AY0QqCezYKVbSJR830cE8sRdWpbbbwG6xvVSNUEdjX3pU+/cyMIk9Gb/
         yzMPfRhGQz2NN+iG760SRuHnhN+TzY+cdFJJDlQKogIrCICglDx675T3x56nYV30npV6
         BBZV3CETAEdkn5BAuIYGVFZ3DnFoGL3LKTteInvj0q1lMgmrE+SZfEKOUW8P7RlRO7lB
         l6j/nE2PVMeSlXEDA5lfj3PdMVjr0yXUlZq1c1tqoY9PnD3uzmhzuENDJMMHl0bEt0UT
         c5iz626YJg5sWSv5S9NrPwD84t5cMBWB/TAcCqrXnAeYOVHj3QQgf8KXlq/re+M6mFBe
         6Dcg==
X-Gm-Message-State: APjAAAUJ3nBLom88Jazpmh/+uBhcoHvU55dZotqVyEvDEYkGUvdb5VXx
        G8gXSRglESSh+8DGZWdYrRA=
X-Google-Smtp-Source: APXvYqyNT4nUDLMqlAM/f0mZTB5Zg780akSQT/cO+N+K6CAl52cdkZXm9V3V0/d1FpjMHRIxzQZbcA==
X-Received: by 2002:adf:f011:: with SMTP id j17mr767692wro.131.1569546573790;
        Thu, 26 Sep 2019 18:09:33 -0700 (PDT)
Received: from szeder.dev (x4db9381f.dyn.telefonica.de. [77.185.56.31])
        by smtp.gmail.com with ESMTPSA id r2sm6436574wma.1.2019.09.26.18.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 18:09:32 -0700 (PDT)
Date:   Fri, 27 Sep 2019 03:09:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [BUG] git is segfaulting, was [PATCH v4 04/12] dir: also check
 directories for matching pathspecs
Message-ID: <20190927010930.GK2637@szeder.dev>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
 <20190917163504.14566-5-newren@gmail.com>
 <20190925203919.GA89135@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925203919.GA89135@generichostname>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 01:39:19PM -0700, Denton Liu wrote:
> Hi Elijah,
> 
> I ran into a segfault on MacOS. I managed to bisect it down to
> 404ebceda0 (dir: also check directories for matching pathspecs,
> 2019-09-17), which should be the patch in the parent thread. The test
> case below works fine without this patch applied but segfaults once it
> is applied.
> 
> 	#!/bin/sh
> 
> 	git worktree add testdir
> 	git -C testdir checkout master
> 	git -C testdir fetch https://github.com/git/git.git todo
> 	bin-wrappers/git -C testdir checkout FETCH_HEAD # segfault here
> 
> Note that the worktree part isn't necessary to reproduce the problem but
> I didn't want my files to be constantly refreshed, triggering a rebuild
> each time.
> 
> I also managed to get this backtrace from running lldb at the segfault
> but it is based on the latest "jch" commit, 1cc52d20df (Merge branch
> 'jt/merge-recursive-symlink-is-not-a-dir-in-way' into jch, 2019-09-20).
> 
> 	* thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=1, address=0x8)
> 	  * frame #0: 0x00000001000f63a0 git`do_match_pathspec(istate=0x0000000100299940, ps=0x000000010200aa80, name="Gitweb/static/js/lib/", namelen=21, prefix=0, seen=0x0000000000000000, flags=0) at dir.c:420:2 [opt]
> 		frame #1: 0x00000001000f632c git`match_pathspec(istate=0x0000000100299940, ps=0x0000000000000000, name="Gitweb/static/js/lib/", namelen=21, prefix=0, seen=0x0000000000000000, is_dir=0) at dir.c:490:13 [opt]
> 		frame #2: 0x00000001000f8315 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=17, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1990:9 [opt]
> 		frame #3: 0x00000001000f82e9 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=14, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1984:5 [opt]
> 		frame #4: 0x00000001000f82e9 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=7, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1984:5 [opt]
> 		frame #5: 0x00000001000f60d1 git`read_directory(dir=0x00007ffeefbfe278, istate=0x0000000100299940, path="Gitweb/", len=7, pathspec=0x0000000000000000) at dir.c:2298:3 [opt]
> 		frame #6: 0x00000001001bded1 git`verify_clean_subdirectory(ce=<unavailable>, o=0x00007ffeefbfe8c0) at unpack-trees.c:1846:6 [opt]
> 		frame #7: 0x00000001001bdc1d git`check_ok_to_remove(name="Gitweb", len=6, dtype=4, ce=0x0000000103e70de0, st=0x00007ffeefbfe438, error_type=ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o=0x00007ffeefbfe8c0) at unpack-trees.c:1901:7 [opt]

That 'name="Gitweb" parameter caught my eye.  origin/todo contains a
'Gitweb' file, with upper case 'G', while master contains a 'gitweb'
directory, with lower case 'g'.  

Could it be that case (in)sensitivity plays a crucial rule in
triggering the segfault?  FWIW I could reproduce it following Denton's
description on Travis CI's macOS VM with the debug shell access, and
it uses case insensitive file system.

