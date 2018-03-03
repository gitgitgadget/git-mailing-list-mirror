Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343C81F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeCCLjr (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:47 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41070 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeCCLjp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:45 -0500
Received: by mail-pf0-f195.google.com with SMTP id f80so5138935pfa.8
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dW4w/NiBMChhnS192BvMT6TrAFLlvOeD2kt+1tA/fuE=;
        b=er6Tbtb2mqNCsCORWkd5r4I3VVNrZx9aQQIGX2C+/7MFL/92XkfQFKes9pTXHwt1VQ
         RaSR8R2dvFiRZex1hGieEpvNRrRRoeEq5hDLUvBLaDJHaqLzFE8TD4sY8L655soOBKEU
         ksS4Qq0QxPlDhuZWICqdG5B7TppXSpPjnt+yClYbaOiTZavvqHfF4/MrBwlaeYpD1Gb/
         t8bEMqdIFe/mloL1mvvE1/Hp5x2L8uaoUQtGsXUCVXgL+nxKOQsvCjymbl4Jq7Xodlps
         Et1xmClc+zqiMYzOp7W/EBWbbiHdrJXAmYDjggJj+hTX40cG4CKVxvcJfiwgP53xbp/g
         htGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dW4w/NiBMChhnS192BvMT6TrAFLlvOeD2kt+1tA/fuE=;
        b=tcpk+HLqKH/RK1ThvWauU8cfilYaNLTLnpu4p3HG+l9HE/QboKfL9PdBAm+7kknUub
         tdnmxcHEixN2392R3FfEuhwHVXou8Co6/Qg5iPXFEWPhzl6c3JYPPaBFWG2qfzBBDuRq
         D5AP3Yiva2qR2Pdr7G4RSX5YvSeE5JohIQ37Ul1vkHPTx+CTOPHqkiQc47XpWCu5rkSY
         EWUsIqi5HmuMusdbH3GVk18233tG6BLbIphlsANpMriDLdTQkQcMyK1mBWVI78MiGaJW
         nHxnk8azZA3+iipjmpI2ziWKF2CNPVpFFaQTIAaqs7mwgw5ISQgZ8+L1aYOXSXgTOj4/
         6lPQ==
X-Gm-Message-State: APf1xPAHBZkM7FZSFMWVa000/YzPtlCEn62e3jT/MVcYetQkDCw/jgbd
        h9psbvByGLTODJrt833ZZWPf4g==
X-Google-Smtp-Source: AG47ELvvHkpprvl99TlksbhGSDmQnqaOxNzBtcTat+ppVb7QFffYf8U2MJbHeJ8moz/2pY8VhHSmeQ==
X-Received: by 10.98.75.129 with SMTP id d1mr8838118pfj.19.1520077184813;
        Sat, 03 Mar 2018 03:39:44 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id v1sm13461898pgt.62.2018.03.03.03.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 36/44] packfile: add repository argument to prepare_packed_git_one
Date:   Sat,  3 Mar 2018 18:36:29 +0700
Message-Id: <20180303113637.26518-37-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index ba185daec2..d7658e6c45 100644
--- a/packfile.c
+++ b/packfile.c
@@ -734,7 +734,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-static void prepare_packed_git_one(char *objdir, int local)
+#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
+static void prepare_packed_git_one_the_repository(char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -888,10 +889,10 @@ void prepare_packed_git(void)
 
 	if (the_repository->objects.packed_git_initialized)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(the_repository, get_object_directory(), 1);
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(alt->path, 0);
+		prepare_packed_git_one(the_repository, alt->path, 0);
 	rearrange_packed_git(the_repository);
 	prepare_packed_git_mru(the_repository);
 	the_repository->objects.packed_git_initialized = 1;
-- 
2.16.1.435.g8f24da2e1a

