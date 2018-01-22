Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72471F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeAVLDt (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:03:49 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43100 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeAVLDs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:03:48 -0500
Received: by mail-pg0-f68.google.com with SMTP id n17so6809446pgf.10
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJAvfCQTfIMGqv86ovdqbO5KAYvlSwQbXX6uTfYV3ak=;
        b=Ih3JvQaZ3MAokyz0VCkQJZ0BF0qQ+hTa9a6HrN2c29aGlNMvRTYkGKlylRsPxkKYWr
         Tjef6a1ODWttdC/e2gzwNWSSuUIevLWpDxhKfxk3h1fJGOEz7a9q0AhIAdOKuY1Vtzit
         HRYFyHepWhFXnNWfiEhbFoCf9cr2HgyULTGl+8VQYnjwd5TR4hnFQLq6KsRjIC7gh19c
         EIrU1RVEU+0Cs2BsEWsLijBBwJxZAwc8NJvgL34JSdWmvi1nXZK1vt0oqDX3D/HOdQIh
         61z1mIvZCzzZow/A67sKxvf20jBTsnO40WBBxcMk2g3WjgBx/lRo98Kg3nt4gumt0yhX
         rvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJAvfCQTfIMGqv86ovdqbO5KAYvlSwQbXX6uTfYV3ak=;
        b=jywpWuNJjus72dY/YT7pQG1cyTbcAbedNkhLAkPDFNCKn0r8PyV7biARaf5YsFLc9c
         7F+A9GnYFwIihw4zXhmi+qw0J6I1hzbODktAIf5pD8ARdite7Lcng1as3l2hOnIIKW5j
         zjWiy3SbzqNdAT45lzxgpsT47ObrHE8ytXoKA/3zOrhGlrU8HPR38YiZtzlIhpbwOO1R
         v8oG4KpSJxvaJhLv3lAB2v3fTLktslS8xSOT7tTTS03ZW7WVMF/xrKzthneh4o/81ayK
         Cux4ThrI7BHbd1wuE/mQUbDNtjGawk8mkgdRDIBs8/ucNG9NVzXP3xNRMgsH2kYwh284
         ALSA==
X-Gm-Message-State: AKwxytfmR5yqE/hLANVTJPlGuBaDLImgGaN/+RzjpQHjR3swHCA8aEJO
        hCAMOsRdPh3go+vRIbTtCQAk9Q==
X-Google-Smtp-Source: AH8x225Q9VjjhxTbCP4MjqGanUaa8foBf/Gwb38V3cMdFnu7ET5nf1ZgaaLfc1RAOfLKIb2SXmfhtQ==
X-Received: by 10.98.214.7 with SMTP id r7mr8172499pfg.213.1516619028334;
        Mon, 22 Jan 2018 03:03:48 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id s14sm26564989pgc.36.2018.01.22.03.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 03:03:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Jan 2018 18:03:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] read-cache.c: change type of "temp" in write_shared_index()
Date:   Mon, 22 Jan 2018 18:03:32 +0700
Message-Id: <20180122110334.4411-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180122110334.4411-1-pclouds@gmail.com>
References: <20180122110334.4411-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This local variable 'temp' will be passed in from the caller in the next
patch. To reduce patch noise, let's change its type now while it's still
a local variable and get all the trival conversion out of the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..536086e1fe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2474,30 +2474,32 @@ static int clean_shared_index_files(const char *current_hex)
 static int write_shared_index(struct index_state *istate,
 			      struct lock_file *lock, unsigned flags)
 {
-	struct tempfile *temp;
+	struct tempfile *real_temp;
+	struct tempfile **temp = &real_temp;
 	struct split_index *si = istate->split_index;
 	int ret;
 
-	temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
-	if (!temp) {
+	real_temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
+	if (!real_temp) {
 		hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
 	}
+	temp = &real_temp;
 	move_cache_to_base_index(istate);
-	ret = do_write_index(si->base, temp, 1);
+	ret = do_write_index(si->base, *temp, 1);
 	if (ret) {
-		delete_tempfile(&temp);
+		delete_tempfile(temp);
 		return ret;
 	}
-	ret = adjust_shared_perm(get_tempfile_path(temp));
+	ret = adjust_shared_perm(get_tempfile_path(*temp));
 	if (ret) {
 		int save_errno = errno;
-		error("cannot fix permission bits on %s", get_tempfile_path(temp));
-		delete_tempfile(&temp);
+		error("cannot fix permission bits on %s", get_tempfile_path(*temp));
+		delete_tempfile(temp);
 		errno = save_errno;
 		return ret;
 	}
-	ret = rename_tempfile(&temp,
+	ret = rename_tempfile(temp,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret) {
 		hashcpy(si->base_sha1, si->base->sha1);
-- 
2.16.0.47.g3d9b0fac3a

