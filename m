Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0E920A17
	for <e@80x24.org>; Sat, 21 Jan 2017 10:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdAUKtM (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 05:49:12 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34371 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdAUKtL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 05:49:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so12760139wmi.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 02:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XgRz9qF9rBESFxbZ0RApnxwvjOrD1hCun8DgKCtY7Qg=;
        b=JwxNZu5oE7+/ki4cuQIl27vxjcsJYPOegYrjexhZRcnrLSiO+9KAVmCCYXjwrvhQ+i
         MmSegZ1kyLpEH4hKbofDSDHnwHeA9EwJfIR588+pFZKtKstP31HYrXSqoHQaVsBahPrT
         2gcIjg7RrgS8aRN7d15BpPqOLdSWq3lVJTu/Ht6C8ebhCJbhsMwhMuDI9PVNnKSflHGU
         00vUopiQ2v0Cxhw5J1ydhUuDAqqE7yHj4SFsL8Gjp0EOVnlSAJH8Cf1+GDu+sh+e1ec8
         WlWJ+1C73I/PRsME8ALZtlFLySjGaj8m+aWDsibt5iXJSprcBorDI6MPL+kvwQsCVLDS
         cfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XgRz9qF9rBESFxbZ0RApnxwvjOrD1hCun8DgKCtY7Qg=;
        b=qaQ+OfRPr6dJT8xRUSEc7sFdvDPHoaVw8nKC5yfXyT+6Q9WjxH1ZLTa2iosVlo+hi2
         8Qr646CYN9vjQ09KLpEuwo6ipOBJci/eubu/f49qavdmy2+f4pL/IGBdJc64UddA2I5p
         XS5RrAEmoHa3VBZciOCD38jbqhYRfvK0E0QoHDFFdp8BMP5WtFrDLcyFcZ2UhK7vM91z
         lZRD/Yg78L22URJiX1Tz5JkeBt2UURBib1zfzfkNOS8I4dkOnVjFakVONLhRAaP/W6ug
         xFH01QNBuvnGtEUmpBHnV8d2bMOPgMBAVuSNcRu++30EJqd4Qe9F3gkKDg1c4X30+YR7
         uI3w==
X-Gm-Message-State: AIkVDXK2I2XQDZfdrsYBd8vD589Oe9Rp9XZiLurK5ugSSKT1FXADuj/HIh2K0s5KgbMpwg==
X-Received: by 10.28.84.14 with SMTP id i14mr7050112wmb.51.1484995749604;
        Sat, 21 Jan 2017 02:49:09 -0800 (PST)
Received: from localhost ([151.74.133.189])
        by smtp.gmail.com with ESMTPSA id x135sm10296017wme.23.2017.01.21.02.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jan 2017 02:49:08 -0800 (PST)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     <git@vger.kernel.org>
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] rebase: pass --signoff option to git am
Date:   Sat, 21 Jan 2017 11:49:04 +0100
Message-Id: <20170121104904.15132-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.11.0.585.g56041942c3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-rebase.txt | 5 +++++
 git-rebase.sh                | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 67d48e6883..e6f0b93337 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -385,6 +385,11 @@ have the long commit hash prepended to the format.
 	Recreate merge commits instead of flattening the history by replaying
 	commits a merge commit introduces. Merge conflict resolutions or manual
 	amendments to merge commits are not preserved.
+
+--signoff::
+	This flag is passed to 'git am' to sign off all the rebased
+	commits (see linkgit:git-am[1]).
+
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
diff --git a/git-rebase.sh b/git-rebase.sh
index 48d7c5ded4..e468a061f9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,6 +34,7 @@
 autosquash         move commits that begin with squash!/fixup! under -i
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
+signoff!           passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
@@ -321,7 +322,7 @@ run_pre_rebase_hook ()
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date)
+	--committer-date-is-author-date|--ignore-date|--signoff)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
-- 
2.11.0.585.g56041942c3.dirty

