Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7661C47089
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiLGR00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLGR0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 12:26:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950669A90
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 09:26:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l26so7976145wms.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qSHcM9yUUo0nD7eZW5ZD8SkIf1Ai0up1bzvnY0av0A=;
        b=fk/RKlwTeDijb3xzkNAdwnJBV5MhXWO4XBEMUCXYS6v19aTHBt5ymXdCb1b8Dtxpjo
         r/Z7LAHJGwibf7kjRgyIP79MV0FA0DB+pQH+YCqCqDM5fJdqm1x4Uc54hRTg6Rh5hxqk
         LQZvm3n6b6nYdIRkLBerESB+Cpr/4lM2nY2EOcA4xV08gpPRhqeoXwzOhHdzPM4TRVu2
         Xbk7lKMC0GE1hh5yaEgSqZ8M2TW8XjADot6LY2rIg3BPBrNW5dv/YGulax1uEu94UUv8
         iZvVLGcxJ59bzMvEj++UIxD9ITtfaK5yOszDKOld7GREnkfgqhz1befSAHjx58UTzV66
         gYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qSHcM9yUUo0nD7eZW5ZD8SkIf1Ai0up1bzvnY0av0A=;
        b=D5BKbHXv3ft7oimj+ZQtqOifUPe3gKIzAxMIO1O1fjsnmIUvLYXqKZgPzcdHH8noMI
         FArPAne90JT9ZXv3LPhPnrrw5CTx1Z0+Xa24dXTSTGG+35TMP4S8K6/3G8uA35l94mUw
         cd9oda7XFNP69UlyK2v9fqk3AMZ0LzA88BswS0PLjzWo/wmGevCeywBhN/0EClAdb2hS
         ttiPhrZ4MVUbM+tt/9/Fa9WIYcp5f4DNKn4O0C2t6O4cXXzwoYEzhBwH1v1XAIXomHEx
         ndw7yk5efTW/fQtSaZpTz/zYwBsZ/nDI3smNztBALUUPolrlI5uOol3ToPOsI8/fJwlG
         kfFg==
X-Gm-Message-State: ANoB5pleHGUJPI+iPdlEvRsjj9rr2ITMJSuZrB2i4ow1Kh+nDKYjM9zH
        8bFF00UBE24LQFVItob5OOIVaXgXQjU=
X-Google-Smtp-Source: AA0mqf4jJe5Nl+Fqcbj3c76KbJicG2J1Ialn7KCf3tNfSS/WqIBCMocuxX8QBSOyJSHVzIf1luq90g==
X-Received: by 2002:a05:600c:19d1:b0:3cf:4d12:1b4b with SMTP id u17-20020a05600c19d100b003cf4d121b4bmr69062314wmq.23.1670433960394;
        Wed, 07 Dec 2022 09:26:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05600c1f0a00b003d070e45574sm2537434wmb.11.2022.12.07.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:26:00 -0800 (PST)
Message-Id: <40ee8dbaef06f8f4265d12436455279499d7ac01.1670433958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 17:25:55 +0000
Subject: [PATCH 1/4] hashfile: allow skipping the hash function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The hashfile API is useful for generating files that include a trailing
hash of the file's contents up to that point. Using such a hash is
helpful for verifying the file for corruption-at-rest, such as a faulty
drive causing flipped bits.

Git's index file includes this trailing hash, so it uses a 'struct
hashfile' to handle the I/O to the file. This was very convenient to
allow using the hashfile methods during these operations.

However, hashing the file contents during write comes at a performance
penalty. It's slower to hash the bytes on their way to the disk than
without that step. This problem is made worse by the replacement of
hardware-accelerated SHA1 computations with the software-based sha1dc
computation.

This write cost is significant, and the checksum capability is likely
not worth that cost for such a short-lived file. The index is rewritten
frequently and the only time the checksum is checked is during 'git
fsck'. Thus, it would be helpful to allow a user to opt-out of the hash
computation.

We first need to allow Git to opt-out of the hash computation in the
hashfile API. The buffered writes of the API are still helpful, so it
makes sense to make the change here.

Introduce a new 'skip_hash' option to 'struct hashfile'. When set, the
update_fn and final_fn members of the_hash_algo are skipped. When
finalizing the hashfile, the trailing hash is replaced with the null
hash.

This use of a trailing null hash would be desireable in either case,
since we do not want to special case a file format to have a different
length depending on whether it was hashed or not. When the final bytes
of a file are all zero, we can infer that it was written without
hashing, and thus that verification is not available as a check for file
consistency. This also means that we could easily toggle hashing for any
file format we desire.

A version of this patch has existed in the microsoft/git fork since
2017 [1] (the linked commit was rebased in 2018, but the original dates
back to January 2017). Here, the change to make the index use this fast
path is delayed until a later change.

[1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201

Co-authored-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 csum-file.c | 14 +++++++++++---
 csum-file.h |  7 +++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 59ef3398ca2..3243473c3d7 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -45,7 +45,8 @@ void hashflush(struct hashfile *f)
 	unsigned offset = f->offset;
 
 	if (offset) {
-		the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
+		if (!f->skip_hash)
+			the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -64,7 +65,12 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	int fd;
 
 	hashflush(f);
-	the_hash_algo->final_fn(f->buffer, &f->ctx);
+
+	if (f->skip_hash)
+		memset(f->buffer, 0, the_hash_algo->rawsz);
+	else
+		the_hash_algo->final_fn(f->buffer, &f->ctx);
+
 	if (result)
 		hashcpy(result, f->buffer);
 	if (flags & CSUM_HASH_IN_STREAM)
@@ -108,7 +114,8 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * the hashfile's buffer. In this block,
 			 * f->offset is necessarily zero.
 			 */
-			the_hash_algo->update_fn(&f->ctx, buf, nr);
+			if (!f->skip_hash)
+				the_hash_algo->update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -153,6 +160,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->tp = tp;
 	f->name = name;
 	f->do_crc = 0;
+	f->skip_hash = 0;
 	the_hash_algo->init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
diff --git a/csum-file.h b/csum-file.h
index 0d29f528fbc..29468067f81 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -20,6 +20,13 @@ struct hashfile {
 	size_t buffer_len;
 	unsigned char *buffer;
 	unsigned char *check_buffer;
+
+	/**
+	 * If set to 1, skip_hash indicates that we should
+	 * not actually compute the hash for this hashfile and
+	 * instead only use it as a buffered write.
+	 */
+	unsigned int skip_hash;
 };
 
 /* Checkpoint */
-- 
gitgitgadget

