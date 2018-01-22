Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99BC1F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbeAVLDz (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:03:55 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43566 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeAVLDy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:03:54 -0500
Received: by mail-pf0-f194.google.com with SMTP id y26so6801887pfi.10
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3+Y7vo5VsaY0g51y4fveBi+UQlkBC/9koUO2mSEDgk=;
        b=ByFkdqlxkusvmnWa3T59tJNhfcH7AAjNM+xAotonZZTvLz4vCn8y3vKb5aFsjT/s96
         nxk4/zcsK9dyee8VJkUj7wzMr8oklFLjFQ+bp8RYrwql2ovzEpfHwhtP3d7vfyRdi55q
         Ae5JTOp8wn0Ldf4+VVQsYbOW60zHyk7DuXYVAfYc4m1E+Za+NDKUXPYkJHR+NMbsGOL3
         LcWaonEgkVby1gJwP+f3R3jmSyjmWWup0B7j/s/RiLHgV8epBPHnp7L5//dcjEFBVnLg
         bYzar3E5n7Lyqy4jLagicqoCYKQ3h0hQ4Ke76gQIp6mvxobgbrE9Yb3ilTbFdKE1xd+C
         KoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3+Y7vo5VsaY0g51y4fveBi+UQlkBC/9koUO2mSEDgk=;
        b=jNdUINXJ9pGkNNQUBJRWnWWmFGp0lQh+t+SOjuarSejXWrorDS1NfR9+4/+TtQFHG7
         Q5PgJRaRRiNFkipCWKPWMXvx9+2hP2fMj5YmW/9I5vFGPtTQPmFOGzHciQ5JlI0Q6DHB
         9T2W+f45j1TUQZn+uOQtGkMt1iS9bkhhe48Cw6nWij4UGwlYa8f5wv21iTBsGUVV32ko
         3h6BliKRFC/pyft9JEFI9BHP5FzfQLnu3apBfOt9QFY9i0jqsm7yS4TfA72om0h0SeFk
         F1ck7UxtlwahigVqQSq2MxRwrW+9BAsMYZfZOxwD3KRluI/nLFSdJKW8xLYQIO7Bi1lv
         +P7w==
X-Gm-Message-State: AKwxytd270v/LTxYE0Dwgnq/4QSC9xFNaZLi28SYAMxT0t08+2Q+zMBl
        XhUowfyYto0Z4aFkY26okQS01Q==
X-Google-Smtp-Source: AH8x227LGkkzS+zZKlMVW/LAx033mKp82XizYcACBE8liSDV8eZ9rF11JU2qbkAafd9amq+iehEgIA==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33-v6mr958565pll.279.1516619033610;
        Mon, 22 Jan 2018 03:03:53 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id u21sm69662pfl.114.2018.01.22.03.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 03:03:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Jan 2018 18:03:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] read-cache.c: move tempfile creation/cleanup out of write_shared_index
Date:   Mon, 22 Jan 2018 18:03:33 +0700
Message-Id: <20180122110334.4411-3-pclouds@gmail.com>
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

