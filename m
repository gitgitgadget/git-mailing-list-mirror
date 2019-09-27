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
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DBE1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 02:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfI0CRx (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 22:17:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46308 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfI0CRx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 22:17:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so833423wrv.13
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 19:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q42rhg6D0ZlDjdx3RaTorrAwZOv0epd07YjrGffdAd0=;
        b=vYbmakL+MiVbhNHtovdqUqlMzj/wEXwPiTu5x3w1+uIPlK8K5/PLZmefdtOi5TLd+2
         v8GVbcOe6QvKpTi+NSeA4cdB+44ZF4qLR3559xS3l3HtKOhG9M6F1N4U6o5nJJO766RY
         muRsyG4H4Z2pDkblDM9VeNpbdXK1s++Sio6ZJM5K8pBqu0wYD5NFV5WEX8lmAkzOEdxz
         gBj4SpOAyxCz9AFuuGO/jux4DNhBv3nD7lTueNHb5Oo/RzCTFE81wkNWhmH/LpcpRoHZ
         dvenlo/AGvw0WduhBwGUrsDhzhky/IT3fBC3e4p997ZMqcVN7BEYQNZPxgSFEUIf+Xyu
         95HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q42rhg6D0ZlDjdx3RaTorrAwZOv0epd07YjrGffdAd0=;
        b=rsb8Nc6H9ScRjtQxwCyEP9DTDm8dsHdFWSBOuLYh6NXyf+rUPbLbkdOfEJ6IrU2AkN
         MNDLhS5vq4nkpymFiH29bC+gxwGxH40yfoT9QK0tfCMuHwHTzzCFY6YArsyamGeqIHAL
         DxJ99L82Z5FNj8FTpdVkoOjQxLACgNL4FhGxm5cQyaUb7DIiVDzkbnLA1nlPssjN+sek
         kEN9vfbbUgFvK61n+iA57Lq5Rq2GmEughi1+qtOuzK8vEExGGr8oKvMrXKwPsLqUgTvV
         09vx5+9YExKLggSd5MYl3NZcQQ1eaHXFlSuNgetbwYw2xcsqxq0NjUc9JNHRo0OAWybn
         TxWQ==
X-Gm-Message-State: APjAAAV9kLAuzReZUwgYp2E0AMzHfuIAFFj+25Eu4odC/X3OGYO6OA4D
        jb5aW/cbayqhgOMhF+FH5qY=
X-Google-Smtp-Source: APXvYqxEi9N6Jba1pb1jlu60LueL7JYbbLs2oYFxgEpKJ1ByU8MGPMcWNQg2OcOLIHD9ihrobUPIhg==
X-Received: by 2002:a5d:67cc:: with SMTP id n12mr972510wrw.359.1569550670020;
        Thu, 26 Sep 2019 19:17:50 -0700 (PDT)
Received: from szeder.dev (x4db9381f.dyn.telefonica.de. [77.185.56.31])
        by smtp.gmail.com with ESMTPSA id h17sm2882518wmb.33.2019.09.26.19.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 19:17:49 -0700 (PDT)
Date:   Fri, 27 Sep 2019 04:17:46 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [BUG] git is segfaulting, was [PATCH v4 04/12] dir: also check
 directories for matching pathspecs
Message-ID: <20190927021746.GL2637@szeder.dev>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
 <20190917163504.14566-5-newren@gmail.com>
 <20190925203919.GA89135@generichostname>
 <20190927010930.GK2637@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190927010930.GK2637@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 27, 2019 at 03:09:30AM +0200, SZEDER Gábor wrote:
> On Wed, Sep 25, 2019 at 01:39:19PM -0700, Denton Liu wrote:
> > Hi Elijah,
> > 
> > I ran into a segfault on MacOS. I managed to bisect it down to
> > 404ebceda0 (dir: also check directories for matching pathspecs,
> > 2019-09-17), which should be the patch in the parent thread. The test
> > case below works fine without this patch applied but segfaults once it
> > is applied.
> > 
> > 	#!/bin/sh
> > 
> > 	git worktree add testdir
> > 	git -C testdir checkout master
> > 	git -C testdir fetch https://github.com/git/git.git todo
> > 	bin-wrappers/git -C testdir checkout FETCH_HEAD # segfault here
> > 
> > Note that the worktree part isn't necessary to reproduce the problem but
> > I didn't want my files to be constantly refreshed, triggering a rebuild
> > each time.
> > 
> > I also managed to get this backtrace from running lldb at the segfault
> > but it is based on the latest "jch" commit, 1cc52d20df (Merge branch
> > 'jt/merge-recursive-symlink-is-not-a-dir-in-way' into jch, 2019-09-20).
> > 
> > 	* thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=1, address=0x8)
> > 	  * frame #0: 0x00000001000f63a0 git`do_match_pathspec(istate=0x0000000100299940, ps=0x000000010200aa80, name="Gitweb/static/js/lib/", namelen=21, prefix=0, seen=0x0000000000000000, flags=0) at dir.c:420:2 [opt]
> > 		frame #1: 0x00000001000f632c git`match_pathspec(istate=0x0000000100299940, ps=0x0000000000000000, name="Gitweb/static/js/lib/", namelen=21, prefix=0, seen=0x0000000000000000, is_dir=0) at dir.c:490:13 [opt]
> > 		frame #2: 0x00000001000f8315 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=17, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1990:9 [opt]
> > 		frame #3: 0x00000001000f82e9 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=14, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1984:5 [opt]
> > 		frame #4: 0x00000001000f82e9 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=7, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1984:5 [opt]
> > 		frame #5: 0x00000001000f60d1 git`read_directory(dir=0x00007ffeefbfe278, istate=0x0000000100299940, path="Gitweb/", len=7, pathspec=0x0000000000000000) at dir.c:2298:3 [opt]
> > 		frame #6: 0x00000001001bded1 git`verify_clean_subdirectory(ce=<unavailable>, o=0x00007ffeefbfe8c0) at unpack-trees.c:1846:6 [opt]
> > 		frame #7: 0x00000001001bdc1d git`check_ok_to_remove(name="Gitweb", len=6, dtype=4, ce=0x0000000103e70de0, st=0x00007ffeefbfe438, error_type=ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o=0x00007ffeefbfe8c0) at unpack-trees.c:1901:7 [opt]
> 
> That 'name="Gitweb" parameter caught my eye.  origin/todo contains a
> 'Gitweb' file, with upper case 'G', while master contains a 'gitweb'
> directory, with lower case 'g'.  
> 
> Could it be that case (in)sensitivity plays a crucial rule in
> triggering the segfault?  FWIW I could reproduce it following Denton's
> description on Travis CI's macOS VM with the debug shell access, and
> it uses case insensitive file system.

Indeed, with 404ebceda0 the test below segfaults on case insensitive
fs, but not on a case sensitive one.


diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 192c94eccd..5b405c97d7 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -131,4 +131,27 @@ $test_unicode 'merge (silent unicode normalization)' '
 	git merge topic
 '
 
+test_expect_success CASE_INSENSITIVE_FS "Denton's segfault" '
+	git init repo &&
+	(
+		cd repo &&
+
+		echo foo >Gitweb &&
+		git add Gitweb &&
+		git commit -m "add Gitweb" &&
+
+		git checkout --orphan todo &&
+		git reset --hard &&
+		# the subdir is crucial, without it there is no segfault
+		mkdir -p gitweb/subdir &&
+		echo bar >gitweb/subdir/file &&
+		# it is not strictly necessary to add and commit the
+		# gitweb directory, its presence is sufficient
+		git add gitweb &&
+		git commit -m "add gitweb/subdir/file" &&
+
+		git checkout master
+	)
+'
+
 test_done



The end of its trace:

++git checkout master
./test-lib.sh: line 910: 11220 Segmentation fault: 11  git checkout master
error: last command exited with $?=139

Case insensitivity is important because check_ok_to_remove() is
invoked from verify_absent_1(), which looks like this:

  if (...)
     ....
  else if (...)
     ....
  else if (lstat(ce->name, &st))
      // That lstat() checked whether 'Gitweb' is absent.  On a case
      // sensitive fs it's absent, so it returns.  On a case
      // insensitive fs it finds 'master's 'gitweb' directory, so it
      // goes on to the else below, and eventually segfaults.
      return;
  else
      check_ok_to_remove()


Good night :)
