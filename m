Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A08620969
	for <e@80x24.org>; Sun, 26 Mar 2017 02:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbdCZCnQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:43:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34252 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZCnP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:43:15 -0400
Received: by mail-pg0-f68.google.com with SMTP id o123so1928970pga.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2pWtMiVPBHs8TZXprLJ+TvX2I6HW3ISu4A2Q+2yvkog=;
        b=IS3lfnAHe9790ZMvu5g2WM1mVFZjEj9gqDTbc06P1MXPyZ28MKX0G/ttW0NOByYjaI
         7jTtsMfNnPZHQ+mT8IJs2Z/S5bDvYCJjJjsW+iZLRRN2iLl/av/x8wfB70DbemOjkcOF
         2CYiA0ghJPlNT0flzRg7iJGEntbtY9mD3qNksaSEZbKVdF5nioFaQrJLLwdV2ulmdxKy
         dJVfNT9RqWy9pafSbNIemJrOqusVLKtazq5haeO92nYXGj1fcN+xqdpQoP434cxXZKpo
         VqSff/b4VkECq3qnaxa3bS7pmRageNMwGLudkqk/hKSgBL4+Fay9j7rPodckmXaayezl
         j8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pWtMiVPBHs8TZXprLJ+TvX2I6HW3ISu4A2Q+2yvkog=;
        b=tVy5n3Pcl3os4VyVJ7CSqJg4kT3toUHtWofW//ZtzTYhsdNdpbbuLCfG5X8MsQxtyl
         3fEGvU2CxFrfuhtkGfQNUGnvyY9ctijabwdk75av+sEsxIcDubcVlrjJTBrPynS1sfdf
         fQNfi5gO5MI3QQKwOxDvT2lJCA0x6iCv3TZQ6ArzqaVzFeSUXHjbd31CFyGMbDRJzoYx
         U4VbFPZbl1eb+zVXPI+qsD0haBdf+6KY30QyimMG6ugqo9+GxyH3AKsynThistSb1hLj
         WVh8EBRV4h8WRmm3eUyegPzW/fYnNYcV7Art0lu2bwZ3Rin5vrLQcurf5tx+naE0bmKn
         qjFA==
X-Gm-Message-State: AFeK/H2YnwZ1Q6hEQK2Gz/g92tbt2HKTIPuYkeJup5ZmfyJ3wAwMuHcw7Vf61IlpViCArQ==
X-Received: by 10.84.202.194 with SMTP id q2mr20752392plh.108.1490496194085;
        Sat, 25 Mar 2017 19:43:14 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id c204sm12785364pfc.92.2017.03.25.19.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:43:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:43:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 04/28] files-backend: delete dead code in files_init_db()
Date:   Sun, 26 Mar 2017 09:42:17 +0700
Message-Id: <20170326024241.31984-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

safe_create_dir() can do adjust_shared_perm() internally, and init-db
has always created 'refs' in shared mode since the beginning,
af6e277c5e (git-init-db: initialize shared repositories with --shared -
2005-12-22). So this code looks like extra adjust_shared_perm calls are
unnecessary.

And they are. But let's see why there are here in the first place.

This code was added in 6fb5acfd8f (refs: add methods to init refs db -
2016-09-04). From the diff alone this looks like a faithful refactored
code from init-db.c. But there is a subtle difference:

Between the safe_create_dir() block and adjust_shared_perm() block in
the old init-db.c, we may copy/recreate directories from the repo
template. So it makes sense that adjust_shared_perm() is re-executed
then to fix potential permission screwups.

After 6fb5acfd8f, refs dirs are created after template is copied. Nobody
will change directory permission again. So the extra adjust_shared_perm()
is redudant. Delete them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index caeb8188fd..9a9dc4e50c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4107,10 +4107,6 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 	 */
 	safe_create_dir(git_path("refs/heads"), 1);
 	safe_create_dir(git_path("refs/tags"), 1);
-	if (get_shared_repository()) {
-		adjust_shared_perm(git_path("refs/heads"));
-		adjust_shared_perm(git_path("refs/tags"));
-	}
 	return 0;
 }
 
-- 
2.11.0.157.gd943d85

