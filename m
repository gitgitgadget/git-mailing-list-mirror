Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D011F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 20:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbcH0UBr (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 16:01:47 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35703 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753204AbcH0UBq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 16:01:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id f65so31612010wmi.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lb7ZM5hwO+SD7hDzz6oRHJoFDF7x+qnJzA07Vf6tmyI=;
        b=eBRp6Q9Cc96foqv77kTTzi9eDNrGgwNJKctefjHmuUBVo4kPMySuFw1g1+ZcBXV12i
         1/utdp4D8gZS47OpSIEAagm7cTbBG3lJvSoZ3l3ZDVk6UYaUOslX6TjcZz7F0Q1wIvDA
         cAoB5s532KNMZ0zcUjt9Xpd59uH68bd1CrUjJtzHGvWaBSDuTCeEy9XvPnzunvzMoZz6
         dvDMzKtKhRbrujF0z+2x8UpI0ptRe1kkIgfgh6kGPGoYfV8Obd44P/5onKxnasoImxf1
         Bci5i94h84NIabC3evfXTnGLigh6/DUdDqxKpQeSzl29bQmUTSn/AAyd6SW40iHSCfA4
         RZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lb7ZM5hwO+SD7hDzz6oRHJoFDF7x+qnJzA07Vf6tmyI=;
        b=dx9pKR5bDhbZVcNfbL+Oz1KbtxgeGIIS0rhB3lYkgKoe42NWL6mC6WS+hkh4VYpxhL
         xdnABuCeinO+7rApgtfZdNxN8NDIAp36NJwdhREorc61smdlWSY3Bby+FMHCpPZ716Gz
         1Uw03WQ6soIgeSLy+voE9wfuf/zt+GVAbtnZfjqMYpX/xE5KP/Z/ZIZ2s5C5l/FMPDY1
         OjJH7flIATIpJjcD/Qz4m8c3OZ3coquJCTSoIWr541OAcQ+ulFoldxesLQkiPTPCvEvn
         0O1nmBLMc8ZGfclNJOAE07KWhNomImZgPJGsAvlWgR60CWGGdt99yll5OcH6yy78Th87
         2vmw==
X-Gm-Message-State: AE9vXwNSRwiXTDSRxfULgkRuN8LtOk+1BJWrAy2Ect1zsRAPjlTQVV1dKMvTTeOQqbW0Qw==
X-Received: by 10.194.78.74 with SMTP id z10mr9066378wjw.68.1472328104949;
        Sat, 27 Aug 2016 13:01:44 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id f187sm5190995wmf.15.2016.08.27.13.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Aug 2016 13:01:43 -0700 (PDT)
Date:   Sat, 27 Aug 2016 21:01:50 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Crash when using git blame on untracked file
Message-ID: <20160827200150.GA18723@hank>
References: <20160827175336.bphgkb6zclvwfntk@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160827175336.bphgkb6zclvwfntk@ruderich.org>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 08/27, Simon Ruderich wrote:
> Hello,
> 
> I'm seeing the following crash with Git 2.9.3 on Debian sid
> (amd64):
> 
>     $ git init foo
>     $ cd foo
>     $ touch x
>     $ git add x
>     $ git commit -m test
>     $ touch x.conf
>     $ git blame x.conf
>     segmentation fault
> 
> I've tested it on Debian stable's 2.1.4 which works fine:
> 
>     $ git blame x.conf
>     fatal: no such path 'x.conf' in HEAD
> 
> It requires the blamed file to be present, but in some cases it
> works only if the file e.g. "x" is already tracked in Git and the
> other file is called "x.conf" (".conf"-suffix). But in an empty
> repo it seems to happen always.
> 
> Sadly Debian's git has no dbg-package, so the stacktrace is not
> very useful:
> 
>     #0  __strcmp_sse2_unaligned () at ../sysdeps/x86_64/multiarch/strcmp-sse2-unaligned.S:31
>     #1  0x000000000041ad7a in ?? ()
>     #2  0x0000000000406171 in ?? ()
>     #3  0x0000000000405321 in ?? ()
>     #4  0x00007ffff6f9f700 in __libc_start_main (main=0x4051c0, argc=0x3, argv=0x7fffffffe1a8, init=<optimized out>, fini=<optimized out>, rtld_fini=<optimized out>, stack_end=0x7fffffffe198)
>         at ../csu/libc-start.c:291
>     #5  0x00000000004057d9 in ?? ()
> 

Thank you very much for the bug report.  A proposed fix for it below:

--- >8 ---
Subject: [PATCH] blame: fix segfault on untracked files

Since 3b75ee9 ("blame: allow to blame paths freshly added to the index",
2016-07-16) git blame also looks at the index to determine if there is a
file that was freshly added to the index.

cache_name_pos returns -pos - 1 in case there is no match is found, or
if the name matches, but the entry has a stage other than 0.  As git
blame should work for unmerged files, it uses strcmp to determine
whether the name of the returned position matches, in which case the
file exists, but is merely unmerged, or if the file actually doesn't
exist in the index.

If the repository is empty, or if the file would lexicographically be
sorted as the last file in the repository, -cache_name_pos - 1 is
outside of the length of the active_cache array, causing git blame to
segfault.  Guard against that, and die() normally to restore the old
behaviour.

Reported-by: Simon Ruderich <simon@ruderich.org>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/blame.c  | 3 ++-
 t/t8002-blame.sh | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 7ec7823..a5bbf91 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2244,7 +2244,8 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos >= 0)
 		; /* path is in the index */
-	else if (!strcmp(active_cache[-1 - pos]->name, path))
+	else if (-1 - pos < active_nr &&
+		 !strcmp(active_cache[-1 - pos]->name, path))
 		; /* path is in the index, unmerged */
 	else
 		die("no such path '%s' in HEAD", path);
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index ff09ace..7983bb7 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -6,6 +6,13 @@ test_description='git blame'
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
+test_expect_success 'blame untracked file in empty repo' '
+	touch untracked &&
+	test_must_fail git blame untracked 2>actual.err &&
+	echo "fatal: no such path '\''untracked'\'' in HEAD" >expected.err &&
+	test_cmp expected.err actual.err
+'
+
 PROG='git blame -c -e'
 test_expect_success 'blame --show-email' '
 	check_count \
-- 
2.8.4.1.g3b75ee9

