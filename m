Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF92C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbiGSSco (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiGSSc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:32:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828395A2CE
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h17so22946122wrx.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wUcU9+utoeDhxzmTfqLOUcpeP81ZgxDQ3dtaZOHD2Pk=;
        b=m+T4Iyk2a2kDGSb18d2VmbnBHBbkS21h073PcsyEtthxVmKbRkVEsx+c6ByPHFFEUl
         ZqTN8DJTeKfpsoLjOP582+VxG6Ci6syeItUkQRBzwQ0M5R2qcBMcNq85VvKAnNwGYUBA
         7+xOGIqR6dKx8/d/kJwqOKV1lz5at1I7k10563/c+inYUluBz5sOvH3G3ULr4EJWeUg/
         Neq8c4Y52cMBhNM4FnNmEHHAYpjL2rDFka0EFb2tnL1eV4IGhi7n1IH/6SY+H7NJNEaG
         WidoM8SKKQnpaIel7gC2iYPnJ7MNoNeQT5PY8oYVSPb9hK5uGEeUmGPHGam5D/ILqquW
         GJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wUcU9+utoeDhxzmTfqLOUcpeP81ZgxDQ3dtaZOHD2Pk=;
        b=wDfk2v4EPXtcc9hvP9/MMZ5Pn8Bm0o5pO/V0zzgg7+9kIsJuQXHptvM4M8YnGLUawd
         Rlc8CIlTNoOeSMFzpB3Lo65Fv923qW2cHMoVmvZP2f4vZI7GlozqlM8YuljmYKLL50bZ
         flHnBsH/l54lepJv8nHB6Cdd/3OJBt1pAxKnHd5szggYWkIPb+LspGKFaLPXvbeR56t5
         ez+g34dVBcTzoO2+4APERPNMw4bM3JIRh6M9w3Lo6Fswy0UiEqqLbz44ccsodCje+9jy
         dyUA2t3D4ODcVKKVQNwkF1UmwBvQE24ZGftb7qur3VEtIgWt2ayNJlIOelfAXtaIJy3l
         C0Zg==
X-Gm-Message-State: AJIora8VUYao5KgHGwehBIaYS8baD4cmlfyOhxT0lcObXpUBuA3TZh7D
        JTM1ntyWpd9SlFAORb/l/LnT9KSST0Y=
X-Google-Smtp-Source: AGRyM1vfZalfCNdpg5RWX5nQS4brgcCBMxE7gIU6PvJrb6G5cUMyTlzsPLpME5qaKzGJyImKwUJKgw==
X-Received: by 2002:adf:9d8d:0:b0:21d:e5c0:2d86 with SMTP id p13-20020adf9d8d000000b0021de5c02d86mr16041367wre.482.1658255544754;
        Tue, 19 Jul 2022 11:32:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020adf9cc7000000b0021d8faf57d5sm14611687wre.74.2022.07.19.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:32:24 -0700 (PDT)
Message-Id: <a4f31877b15e46413cb62378577d95886720b020.1658255537.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
References: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
        <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:32:17 +0000
Subject: [PATCH v3 5/5] transport.c: avoid "whitelist"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The word "whitelist" has cultural implications that are not inclusive.
Thankfully, it is not difficult to reword and avoid its use.

The GIT_ALLOW_PROTOCOL environment variable was referred to as a
"whitelist", but the word "allow" is already part of the variable.
Replace "whitelist" with "allow_list" in these cases to demonstrate that
we are processing a list of allowed protocols.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 52db7a3cb09..b51e991e443 100644
--- a/transport.c
+++ b/transport.c
@@ -940,7 +940,7 @@ static int external_specification_len(const char *url)
 	return strchr(url, ':') - url;
 }
 
-static const struct string_list *protocol_whitelist(void)
+static const struct string_list *protocol_allow_list(void)
 {
 	static int enabled = -1;
 	static struct string_list allowed = STRING_LIST_INIT_DUP;
@@ -1020,9 +1020,9 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 
 int is_transport_allowed(const char *type, int from_user)
 {
-	const struct string_list *whitelist = protocol_whitelist();
-	if (whitelist)
-		return string_list_has_string(whitelist, type);
+	const struct string_list *allow_list = protocol_allow_list();
+	if (allow_list)
+		return string_list_has_string(allow_list, type);
 
 	switch (get_protocol_config(type)) {
 	case PROTOCOL_ALLOW_ALWAYS:
-- 
gitgitgadget
