Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B373A1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 00:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfGKAA1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 20:00:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32808 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGKAA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 20:00:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id r6so282008qtt.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPoy5SCr9H6wbbntCXImFSyMCGfsAC0sldlgcwIwbqI=;
        b=GMeilZ7P8+a3ZKH6C3/OXcGyd95DHBHbLrNf5TOZz93dqjoB/ARPIfRFKYUrwWsy8s
         2iVxLNyabrL3tahK5jXk1UT7abcZvtcJpLCs9kOWPFubuPaDrrE4+PcuHaWhi8YLqdFC
         h+lwuxHSmYP+HAi6ewcN4g7mRGBffbXJU0CUJy1/FfXpklMDLDxtFDjMeKGQGxn4V6/6
         FnBHC9ZhjQlMmtB7ZaYYfb/AtmlaWNAp8EI/kNohwpZVPqBrSCyXcOfZ9XM2Gp9uiUDa
         8xWRz09iLCVXR6/a7IoDTJNfaY8bLTap5+9DKQxm89MgmiOgMfpMtwXiElIqBJ9+NVh+
         AtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPoy5SCr9H6wbbntCXImFSyMCGfsAC0sldlgcwIwbqI=;
        b=XeX2Ig07ajBDkkh44rRB7HwiaFqMGEDR7QVUozDyEbWhpGzBiOzpwN2f+t/nZTe5ap
         uh/mn1lpbAa4FUmOwe65Xxo0etUZbvivKMksens6hoSnlKhUDyHsxZwjV06zNVfBDtkL
         AJgZmmPVeI/zaoGoBzW/PCQfY7zNONHQ0bAa/WrMEyOfZ32XzrkGJSPysQQUadePPAa4
         rev4jnFzaJ6vgesMdbS9APGfRxFa6h7q99IcI9O9w6uJb0e1gSg/lf7grh6LRT+yOETb
         hqV5Hu5arbzOXlw2BvxRFhnuPiZ6ST+58UtZJOnXeO/Kbq1eXJZ00CusbywBSyrF5/uc
         DOeQ==
X-Gm-Message-State: APjAAAWdysLk9Ao4tg9pySvPYypJXt4uZzFyBGvHOsjvECtvlj2ua1wG
        5wnbPBLYovZtDXzIR2kDxETgXA==
X-Google-Smtp-Source: APXvYqzmBdKMRx/F/+RQrouxUPTaIWVvU2Ee8LBvq3m16EJ2AbqeKsqJtZl2QDzuy2FbQkhs1Kcdbw==
X-Received: by 2002:ac8:2b01:: with SMTP id 1mr601262qtu.177.1562803226491;
        Wed, 10 Jul 2019 17:00:26 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.17.00.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:00:26 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v8 08/10] clone: extract function from copy_or_link_directory
Date:   Wed, 10 Jul 2019 20:59:02 -0300
Message-Id: <af7430eb2c29ce35691e15d68e1c59d48d6e9144.1562801255.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
References: <cover.1562801254.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract dir creation code snippet from copy_or_link_directory to its own
function named mkdir_if_missing. This change will help to remove
copy_or_link_directory's explicit recursion, which will be done in a
following patch. Also makes the code more readable.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9dd083e34d..96566c1bab 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -394,6 +394,21 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
+static void mkdir_if_missing(const char *pathname, mode_t mode)
+{
+	struct stat st;
+
+	if (!mkdir(pathname, mode))
+		return;
+
+	if (errno != EEXIST)
+		die_errno(_("failed to create directory '%s'"), pathname);
+	else if (stat(pathname, &st))
+		die_errno(_("failed to stat '%s'"), pathname);
+	else if (!S_ISDIR(st.st_mode))
+		die(_("%s exists and is not a directory"), pathname);
+}
+
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				   const char *src_repo, int src_baselen)
 {
@@ -406,14 +421,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	if (!dir)
 		die_errno(_("failed to open '%s'"), src->buf);
 
-	if (mkdir(dest->buf, 0777)) {
-		if (errno != EEXIST)
-			die_errno(_("failed to create directory '%s'"), dest->buf);
-		else if (stat(dest->buf, &buf))
-			die_errno(_("failed to stat '%s'"), dest->buf);
-		else if (!S_ISDIR(buf.st_mode))
-			die(_("%s exists and is not a directory"), dest->buf);
-	}
+	mkdir_if_missing(dest->buf, 0777);
 
 	strbuf_addch(src, '/');
 	src_len = src->len;
-- 
2.22.0

