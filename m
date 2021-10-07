Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D99C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5193561139
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhJGU1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbhJGU1N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42FCC061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e12so22742509wra.4
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sKKIQRPCgQOmqYj1W2KplwCd5Z6lizGq2HbDILN4ZN4=;
        b=ePA4v0wYQLQm32MTbF10daetTDlviGokaowOJ5NCKEsMqiBGCeUFls+5ACDErVJwEF
         5UMs/LGvrkyqICxUS5SwkbprCz9O2weQSYe+3SlLAiVl+rR28Rxd2mtpmwnDVgTk19cW
         hV+6ymKaJkmJe59kXl8iMmzxKp14bkLJ+Q4ecHDrs0xPnx3XKVwtwmcoFhtSdTvnDI2a
         IajO/P5j5sMzz26/EOuW7QUkMjJ7em4MSD+yiYDWPlCGlOZkDYeBDX78yiUEUAzQNHOu
         x8mE1Z0gwLpdNc/toOB4sncp42f63vrJCodZVG1CHhr84qQBNdTTe9Ea53NQtIjjy+Hn
         YBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sKKIQRPCgQOmqYj1W2KplwCd5Z6lizGq2HbDILN4ZN4=;
        b=X5ICxF1J/EDPOeFGkbdxEzer/OK5db/5azr4shMlq2LaPFhWhXNNqzx67yshV2tB0q
         BBQdb51SK/sM0i5wOhzjbevUidqbQ6gS1wA+6rqqoKgvXWoSt/+APIBIrFgTzjWkyatq
         Rip7B4XUMEAC4qvORn4UglhzX2dXEJXZkzGET/L80wDtIA2FXezrJr8Rn1XimJOXiToH
         JNjBU3l5CcW9GQrgeINH10nFn1h0VkprHVL0DLhFM4ZaAxTel3RKk77adPgs5iidQNES
         3RCGuqyJkvqbTyPs2fvmR2PttUvXbB0F1o8AwOfS9WFcdHgQr5Y3KUJV1CGFC05tX1cA
         OWyg==
X-Gm-Message-State: AOAM530nAz5VYWVOlQ7N685MNJQxWs6oywsMl70pb/AfMJMadK5cNsOm
        syqzKn8yhtL7St37GfJ/0+R5GgYjwTg=
X-Google-Smtp-Source: ABdhPJwiC+eThA/AkbKRLjE32CKEBZLXJ7HMHtDF1hi7b2cScbQozLHmJtUNYoBrJiB3DHJdu8M92w==
X-Received: by 2002:a05:600c:1d1a:: with SMTP id l26mr2167242wms.98.1633638318354;
        Thu, 07 Oct 2021 13:25:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18sm378504wmb.27.2021.10.07.13.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:18 -0700 (PDT)
Message-Id: <9cc44f7837793c8da376eb34de90506696416682.1633638315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:24:57 +0000
Subject: [PATCH v4 01/19] hash.h: provide constants for the hash IDs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will simplify referencing them from code that is not deeply integrated with
Git, in particular, the reftable library.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 hash.h        | 6 ++++++
 object-file.c | 7 ++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hash.h b/hash.h
index 9e25c40e9ac..5d40368f18a 100644
--- a/hash.h
+++ b/hash.h
@@ -95,12 +95,18 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
 
+/* "sha1", big-endian */
+#define GIT_SHA1_FORMAT_ID 0x73686131
+
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
 /* The block size of SHA-1. */
 #define GIT_SHA1_BLKSZ 64
 
+/* "s256", big-endian */
+#define GIT_SHA256_FORMAT_ID 0x73323536
+
 /* The length in bytes and in hex digits of an object name (SHA-256 value). */
 #define GIT_SHA256_RAWSZ 32
 #define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
diff --git a/object-file.c b/object-file.c
index 112d9b4badc..b79ab75979f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -165,7 +165,6 @@ static void git_hash_unknown_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	BUG("trying to finalize unknown hash");
 }
 
-
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
 		NULL,
@@ -184,8 +183,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 	{
 		"sha1",
-		/* "sha1", big-endian */
-		0x73686131,
+		GIT_SHA1_FORMAT_ID,
 		GIT_SHA1_RAWSZ,
 		GIT_SHA1_HEXSZ,
 		GIT_SHA1_BLKSZ,
@@ -200,8 +198,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 	{
 		"sha256",
-		/* "s256", big-endian */
-		0x73323536,
+		GIT_SHA256_FORMAT_ID,
 		GIT_SHA256_RAWSZ,
 		GIT_SHA256_HEXSZ,
 		GIT_SHA256_BLKSZ,
-- 
gitgitgadget

