Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800D01F406
	for <e@80x24.org>; Sun, 14 Jan 2018 10:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeANKSu (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 05:18:50 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39041 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeANKSt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 05:18:49 -0500
Received: by mail-pf0-f195.google.com with SMTP id e11so6801423pff.6
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 02:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuEJm2/eV9DbFae3j50j4UIyRhmVIBrHQDRJA1WqX20=;
        b=b+A14eagzB3bZccrQAIWdStfzOazqHo8bCvxD/QyKQYnuIjIf1rl5C5DJOfLWjUm/C
         IulPfqPtzzLbEEdfEdv97Fzswd3nvITRs3Ywc92diCgUdDMubUDg4YdDtoZ35gykXqOs
         6q6M+mTZ52ew9tqVPqY1sKDfSdOI9YhvCb6UPAMMqJ3Ukl89/xY2zp6da3Fash48Jt/I
         hZLLV4WKCmwwgU2ZdDTYh7LSOalfBKdMIoAcVkxUhyWJRxmnCSbB9D3Y9p0lxDW9wHV4
         uP22q6u+K9in3wpI6pHgVRbDJzooSFRQ4AZsbVnWoStQeJ/G1ja1iIoO+AkFVunELOTS
         3XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuEJm2/eV9DbFae3j50j4UIyRhmVIBrHQDRJA1WqX20=;
        b=eQRltBGrAAFgKNOHjBeodxhuvlHU/n7E6pMk2tbAtbrwjTzP4sUNIUoGTgZNiZjMFj
         FfS0qEysCFFjftpQl9FJ0vn8rdQNBL/XRberWR16WoQVYbGtKYspApZInUBTWdY0NxmK
         hH0u0pHIDLGwxtFUAZSa4a3xSeT65z9eTAGIi8xywM8cX49qSHQTaTD8+r78agnkFWgE
         5vFUnKI96lZddatyucZrE0GzJ3ElG6si1KnzXipAoLvva7JzBRPeYtX7bHn68nhgOUXh
         zmI4jofVdofSmZuOxYKtMOI3yFjqoHWMgRSXdlh7PePDMIVwA6fhQfAfcdWyCcMsFTL8
         dCkA==
X-Gm-Message-State: AKGB3mKKT53L/o14YFBFcnw7YN9022eIADXWcO1hgx1mzQWrx6JOFbO8
        kHrYv97iBAC37xOfSl8Z1iVR+g==
X-Google-Smtp-Source: ACJfBosd2n4G3XagUXrg0uXS0Z408ygkV/3vneCqq3JPhu38IDjcQN0pfIlkURAbjJ/cEG73Zp5fnw==
X-Received: by 10.101.83.9 with SMTP id m9mr24766045pgq.202.1515925128842;
        Sun, 14 Jan 2018 02:18:48 -0800 (PST)
Received: from ash ([115.73.186.82])
        by smtp.gmail.com with ESMTPSA id m10sm44066056pge.59.2018.01.14.02.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jan 2018 02:18:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 14 Jan 2018 17:18:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, larsxschneider@gmail.com, bmwill@google.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        szeder.dev@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] read-cache.c: move tempfile creation/cleanup out of write_shared_index
Date:   Sun, 14 Jan 2018 17:18:19 +0700
Message-Id: <20180114101820.4273-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180114101820.4273-1-pclouds@gmail.com>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com>
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
2.15.1.600.g899a5f85c6

