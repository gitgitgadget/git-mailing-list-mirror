Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616781F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbeAXJjM (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:39:12 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35373 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeAXJjL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:39:11 -0500
Received: by mail-pg0-f66.google.com with SMTP id o13so2314730pgs.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3+Y7vo5VsaY0g51y4fveBi+UQlkBC/9koUO2mSEDgk=;
        b=BL7XmqjnQTemfE4ONbqNsOf4F4HrzY6PbunIjTbOoWXh3Yx5Pqm0q4uRDot2lOHmDM
         xRZ+MRAsYAwggsVSHgLqh6XyDmuFgzgS6QKDCosb+hyIUbdqwDEjxm2RTxvL0TQqFu7r
         IM9j3Mv7HaiGT94h/Xe4tNpaTKTPqo57zEXZ0IYGrrtPgxyfDOFWmXgtoqfpeHtQ9mC6
         6ij3wTtKR2nGZ8E0AMq7LEPHHFai3CCBiFAsB+VFhNGNVuYGyBvbbtd0f8+5V1xFrBtd
         jKyZi1dye//kugoVvBPDTPz86Mi0MjunZII3a+L+OIdN4Hq9GmKFdWg8RNd/daJHAukp
         mGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3+Y7vo5VsaY0g51y4fveBi+UQlkBC/9koUO2mSEDgk=;
        b=UVIQ6leoHRfRsprGgv2HT6G5LOD99MqwBxoFZBWKqt0CtGHxjXGFvrX/vkx9NnTljT
         FbSyIKvJ3v4x+xM4Pgg+9941XWzHYlcLYZjRJGHCgcmotS8C+emQRCGgE8G0QanvSO2S
         ygLXQVqh48oFvPtz1+FZ9x41YUurcWpExwNBr7MHFAgy8Vz+qxhWvOFE4/3G86MR0G11
         xviPG329EV4Wt4maal5V6jVVvGGG4PlKEASfd0n3wTRbCZ+oIiY4sOifqr7r1ZQKRwK3
         iC76mN10yrAHvWG9lh+/Ca2AVm39MTHhv3lT56YHq0GSnydoGzFZafXR3aSxBjeGLNxh
         Qu4Q==
X-Gm-Message-State: AKwxytfbUOz0HHIVFKiYmQKJeQiWzXil+G3wpOrFh+GZQljZJBlwgTu7
        eneRxM+V8qeDh876MxqOa6mbCw==
X-Google-Smtp-Source: AH8x22790XaOWZdRvYRn7OkilxQbF8LYCKf+siQK1XLysipfZ8iW8EyTdyDrhRORj4CrbFhmR0W3tg==
X-Received: by 10.98.208.67 with SMTP id p64mr12479409pfg.158.1516786750387;
        Wed, 24 Jan 2018 01:39:10 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id i3sm124271pgs.63.2018.01.24.01.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:39:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:39:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] read-cache.c: move tempfile creation/cleanup out of write_shared_index
Date:   Wed, 24 Jan 2018 16:38:28 +0700
Message-Id: <20180124093829.12966-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124093829.12966-1-pclouds@gmail.com>
References: <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
 <20180124093829.12966-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For one thing, we have more consistent cleanup procedure now and always
keep errno intact.

The real purpose is the ability to break out of write_locked_index()
early when mks_tempfile() fails in the next patch. It's more awkward to
do it if this mks_tempfile() is still inside write_shared_index().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 536086e1fe..c568643f55 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2472,31 +2472,18 @@ static int clean_shared_index_files(const char *current_hex)
 }
 
 static int write_shared_index(struct index_state *istate,
-			      struct lock_file *lock, unsigned flags)
+			      struct tempfile **temp)
 {
-	struct tempfile *real_temp;
-	struct tempfile **temp = &real_temp;
 	struct split_index *si = istate->split_index;
 	int ret;
 
-	real_temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
-	if (!real_temp) {
-		hashclr(si->base_sha1);
-		return do_write_locked_index(istate, lock, flags);
-	}
-	temp = &real_temp;
 	move_cache_to_base_index(istate);
 	ret = do_write_index(si->base, *temp, 1);
-	if (ret) {
-		delete_tempfile(temp);
+	if (ret)
 		return ret;
-	}
 	ret = adjust_shared_perm(get_tempfile_path(*temp));
 	if (ret) {
-		int save_errno = errno;
 		error("cannot fix permission bits on %s", get_tempfile_path(*temp));
-		delete_tempfile(temp);
-		errno = save_errno;
 		return ret;
 	}
 	ret = rename_tempfile(temp,
@@ -2567,7 +2554,21 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	new_shared_index = istate->cache_changed & SPLIT_INDEX_ORDERED;
 
 	if (new_shared_index) {
-		ret = write_shared_index(istate, lock, flags);
+		struct tempfile *temp;
+		int saved_errno;
+
+		temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
+		if (!temp) {
+			hashclr(si->base_sha1);
+			ret = do_write_locked_index(istate, lock, flags);
+		} else
+			ret = write_shared_index(istate, &temp);
+
+		saved_errno = errno;
+		if (is_tempfile_active(temp))
+			delete_tempfile(&temp);
+		errno = saved_errno;
+
 		if (ret)
 			goto out;
 	}
-- 
2.16.0.47.g3d9b0fac3a

