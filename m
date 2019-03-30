Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5313220248
	for <e@80x24.org>; Sat, 30 Mar 2019 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfC3Wtf (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 18:49:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42376 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3Wtf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 18:49:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so6492662qtc.9
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Mi3ViTH8eD299yUFNsXA0ViLNKlpNXJVcqXyGd8Mf8=;
        b=T3AJMWChXU34PyJHNibacgbMxKPovZlAASU2g5dtr0SxeoCGnMsEQXe1GL0NC+orHd
         4InKlm6RACAJY2g1lt0dMjuVBte7M0gNJf09xvvahqKDzT6HtB1ovgXwHmnTh6IALk3+
         L0jBmfKq9ob/sEdui2xBA0E5vlqEZY+LEJ3FEADGomWPgc0VIgHfnBs8Ix6h7ru9WwlS
         8+dhgoAO8MCeOPam/NlZwNLOsCqPwwiEfshBwn6o4atqUvEnf4UZuA4Yccgi5/HGB08k
         XnehYxS7QXJgQe7hD35XQzmMp9/F0e5Em/0cRTxyFC8Luv7p5Hmaby27ns1ySpbVeceQ
         TrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Mi3ViTH8eD299yUFNsXA0ViLNKlpNXJVcqXyGd8Mf8=;
        b=t4005Igg+wQpHy4v7COPhJH2wXTdX2tZ0r/ZgPOLxG4ihL+Y7nyVX0vKUUFATel9g9
         Srn0tksymfthhdyVmbORjN5dDTnraUS9bZpfsLvXN/t+ukmDeIl8MilWOg/eQjCyFjsF
         nTUqome5PsX/zo8dp4CuDGxOhhZdXv7n/qpi23Tof3kg6tYAoMvsnGaHfjMFnSvUZLP4
         irMOS4ozhV7LpmRN3Mbc3EuEQrS6rmkbQ+PjASRk9l4QVuYfCLbeDQdoO8Q5fxQoPZJV
         jjJ+2JJjteXHgvqLy4Xb8DDXve7fy5qMvRj2KZzxq9OkMBu7U9gePqjCNRH9i+jsCbSd
         66EA==
X-Gm-Message-State: APjAAAXjui2UUEqDLjCYkq+zvEBM4juS6v1TqL6JQModYiEEXDdbJkrF
        Hblm9fmgG4/8AmT0moSc0qRG2g==
X-Google-Smtp-Source: APXvYqzo3iCoGselz7K1UDR3HHHs/BCYufzRCcpcSRUJt1kb9LdW9DfskzlNLbfu326/VZdL9X1K0g==
X-Received: by 2002:a0c:81a9:: with SMTP id 38mr45643782qvd.208.1553986173679;
        Sat, 30 Mar 2019 15:49:33 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::4])
        by smtp.gmail.com with ESMTPSA id x191sm3139943qka.78.2019.03.30.15.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:49:33 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v5 5/7] clone: extract function from copy_or_link_directory
Date:   Sat, 30 Mar 2019 19:49:05 -0300
Message-Id: <20190330224907.3277-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330224907.3277-1-matheus.bernardino@usp.br>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
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
index 81e1a39c61..f348eb02d4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -392,6 +392,21 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
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
@@ -404,14 +419,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
2.20.1

