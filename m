Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A77B1FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 22:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbcLDWbp (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 17:31:45 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32885 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbcLDWbo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 17:31:44 -0500
Received: by mail-pg0-f65.google.com with SMTP id 3so14359069pgd.0
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y5My14j1LrVgBXKLtyoHtAT+DYT5RTwo7e3o4hfwQ/c=;
        b=qG6GuQhC6Z1SKXEAX8MObVjv4urE9nquFPHCAhbwAYTimiI16P192pJR98xtAT8YL6
         y/7oKgV1GmznGx0AqTjLT8IiajVTNo2N3g7uVdfN3gSDqDNtPnC8bsWKR0v7Mdn4PdUe
         iByRV9vqyAKdTx0va1xDSditGTZHqjiLEs8o5+oq1Yp6cX8GZkQL7CZ5NHsyMaCEdgEq
         vXYKXcdq0ZIdnxaa0yZaxHsszNyVk+mjvKYzBUUnnQQnr7bUbh7P7D3+G6XTKXX0aPo6
         OsuZYb3lX2Ohn12k/1xhuZy7ZyTskfHe6Co7iazG2xzZ/5B4cILEfdF7iiU24pJ8qtf4
         LsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y5My14j1LrVgBXKLtyoHtAT+DYT5RTwo7e3o4hfwQ/c=;
        b=Tpfh4rj984klXtGHXzzFyVCSWMVZ2eCUcaM6ndAa0gjr7Lz/MCb4jQxwo5Yo0ncFIi
         FcAFUoG7Xol+qZsNAF/14tx6RCrrlvdiTQTxrvhY88UrCVqZHDApq4tUbqkAQ2h9ZMEq
         rAqWCuF+Q+4t6gLYi3P/asVRZgOcsvq6Q8SJym+pGLfuclK97O4CNCj72ya6bn5EOfwY
         8vmXMYZauKjSDNlXMmFlWV1nhnzF8MeQ46YvxekM8jdzz+z1jURkTd4dwDjLJx4IeDwL
         lMRA/QWMAiq1mBiDUq4S7DkVualSDxPlFgNaEZRIvg3AiCSUkf1JJq8KnYN9sYZ/Hh1i
         Fniw==
X-Gm-Message-State: AKaTC02WmCot9uGV7HeM5msgMvZhkZpLpjZE4uZ8a2njvH/xpI+GeeYFuLVH3X4V6TTMoA==
X-Received: by 10.98.27.132 with SMTP id b126mr54133489pfb.171.1480890703489;
        Sun, 04 Dec 2016 14:31:43 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id y29sm22177245pfd.63.2016.12.04.14.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Dec 2016 14:31:42 -0800 (PST)
Date:   Sun, 4 Dec 2016 14:31:39 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Frank Becker <fb@mooflu.com>
Cc:     git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d not populating left correctly when not in git root
Message-ID: <20161204223139.kk2ejrfc5elxmsro@gmail.com>
References: <68f49f5e-4e71-fd52-cd6f-64e92face962@mooflu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68f49f5e-4e71-fd52-cd6f-64e92face962@mooflu.com>
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 03:04:01PM -0800, Frank Becker wrote:
> Hi,
> 
> looks like this broke between 2.9.2 and 2.9.3
> 
> cat ~/.gitconfig
> [difftool "diff"]
>     cmd = ls -l ${LOCAL}/* ${REMOTE}/*
>     #cmd = diff -r ${LOCAL} ${REMOTE} | less
> 
> ~/stuff/gittest> ls -l *
> d1:
> total 8
> -rw-r--r--  1 frank  staff  16  2 Dec 14:30 test.txt
> 
> d2:
> total 8
> -rw-r--r--  1 frank  staff  18  2 Dec 14:30 anothertest.tst
> 
> 
> ~/stuff/gittest> git status
> On branch master
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
> 
>     modified:   d1/test.txt
>     modified:   d2/anothertest.tst
> 
> 
> ~/stuff/gittest> ~/stuff/git_tmp/bin/git --version
> git version 2.11.0
> 
> ~/stuff/gittest> ~/stuff/git_tmp/bin/git difftool -d -t diff
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.0oGRF/left/d1:
> total 8
> -rw-r--r--  1 frank  staff  6  2 Dec 14:52 test.txt
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.0oGRF/left/d2:
> total 8
> -rw-r--r--  1 frank  staff  7  2 Dec 14:52 anothertest.tst
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.0oGRF/right/d1:
> total 8
> lrwxr-xr-x  1 frank  staff  38  2 Dec 14:52 test.txt ->
> /Users/frank/stuff/gittest/d1/test.txt
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.0oGRF/right/d2:
> total 8
> lrwxr-xr-x  1 frank  staff  45  2 Dec 14:52 anothertest.tst ->
> /Users/frank/stuff/gittest/d2/anothertest.tst
> 
> 
> cd d2
> ~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git difftool -d -t diff
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.eRXhB/left/d2:
> total 8
> -rw-r--r--  1 frank  staff  7  2 Dec 14:52 anothertest.tst
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.eRXhB/right/d1:
> total 8
> lrwxr-xr-x  1 frank  staff  38  2 Dec 14:52 test.txt ->
> /Users/frank/stuff/gittest/d1/test.txt
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.eRXhB/right/d2:
> total 8
> lrwxr-xr-x  1 frank  staff  45  2 Dec 14:52 anothertest.tst ->
> /Users/frank/stuff/gittest/d2/anothertest.tst
> 
> 
> Note that left does not contain d1
> 
> 
> 
> ~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git --version
> git version 2.9.2
> ~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git difftool -d -t diff
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.YxtVw/left/d1:
> total 8
> -rw-r--r--  1 frank  staff  6  2 Dec 15:02 test.txt
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.YxtVw/left/d2:
> total 8
> -rw-r--r--  1 frank  staff  7  2 Dec 15:02 anothertest.tst
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.YxtVw/right/d1:
> total 8
> lrwxr-xr-x  1 frank  staff  38  2 Dec 15:02 test.txt ->
> /Users/frank/stuff/gittest/d1/test.txt
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.YxtVw/right/d2:
> total 8
> lrwxr-xr-x  1 frank  staff  45  2 Dec 15:02 anothertest.tst ->
> /Users/frank/stuff/gittest/d2/anothertest.tst
> 
> 
> 
> ~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git --version
> git version 2.9.3
> ~/stuff/gittest/d2> ~/stuff/git_tmp/bin/git difftool -d -t diff
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.TpJ5u/left/d2:
> total 8
> -rw-r--r--  1 frank  staff  7  2 Dec 15:01 anothertest.tst
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.TpJ5u/right/d1:
> total 8
> lrwxr-xr-x  1 frank  staff  38  2 Dec 15:01 test.txt ->
> /Users/frank/stuff/gittest/d1/test.txt
> 
> /var/folders/0j/3pk3pdsx7rzb9_njdpyjwm000000gn/T/git-difftool.TpJ5u/right/d2:
> total 8
> lrwxr-xr-x  1 frank  staff  45  2 Dec 15:01 anothertest.tst ->
> /Users/frank/stuff/gittest/d2/anothertest.tst

This regression was not caught by our test suite.

This looks like it's an edge case not handled by:
9ec26e797781 "difftool: fix argument handling in subdirs"
The current "rewrite difftool in C" topic may need a
similar adjustment.

The problem:

When preparing the right-side of the diff we only construct the
parts that changed.  When constructing the left side we
construct a full index, but we were constructing it relative to
the subdirectory, and thus it ends up empty because we are in a
subdirectory and the paths are incorrect.

The fix seems simple -- when preparing the index files we need
to chdir to the toplevel to ensure that the index construction
steps find the correct toplevel-relative paths.

Thanks for the heads-up,
David

--- 8< ---
Date: Sun, 4 Dec 2016 14:27:17 -0800
Subject: [PATCH] difftool: properly handle being launched from a subdirectory

9ec26e797781239b36ebccb87c590e5778358007 corrected how path arguments
are handled in a subdirectory, but it introduced a regression in how
entries outside of the subdirectory are handled by the dir-diff.

When preparing the right-side of the diff we only construct the parts
that changed.

When constructing the left side we construct an index, but we were
constructing it relative to the subdirectory, and thus it ends up empty
because we are in a subdirectory and the paths are incorrect.

Teach difftool to chdir to the toplevel of the repository before
preparing its temporary indexes.  This ensures that all of the
toplevel-relative paths are valid.

Add a test case to exercise this use case.

Reported-by: Frank Becker <fb@mooflu.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl   | 4 ++++
 t/t7800-difftool.sh | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index a5790d03a..959822d5f 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -182,6 +182,10 @@ EOF
 		}
 	}
 
+	# Go to the root of the worktree so that the left index files
+	# are properly setup -- the index is toplevel-relative.
+	chdir($workdir);
+
 	# Setup temp directories
 	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
 	my $ldir = "$tmpdir/left";
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 70a2de461..caab4b5ca 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -413,8 +413,11 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory' '
 	(
 		cd sub &&
 		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
-		grep sub output &&
-		grep file output
+		# "sub" must only exist in "right"
+		# "file" and "file2" must be listed in both "left" and "right"
+		test "1" = $(grep sub output | wc -l) &&
+		test "2" = $(grep file"$" output | wc -l) &&
+		test "2" = $(grep file2 output | wc -l)
 	)
 '
 
-- 
2.11.0.dirty
