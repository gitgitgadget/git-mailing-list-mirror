Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520261F453
	for <e@80x24.org>; Thu,  2 May 2019 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfEBOtM (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:49:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46682 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEBOtL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:49:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id i31so2734330qti.13
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWCV+CWpi3XnwtnI5CIUo+JQ1nhJiKlP+GPCB1eYga4=;
        b=JFVta34k+qi+my0WI+awnYgdPccTOtCrROhkW+Cop7QGO9HUTQXoVpYQs9sZQjQzsk
         uQ9Dsle/i24dHqwzwpY5epLfErtqbsLDnOSEzlCbiMjE4ABcZ8g1P08szXZC0pcPt6K1
         U7nyHhidbeYywp1neM9klrC9gomvHycqUhMql8WHzBcIzlt850uIjma3GdIUn33Dwryh
         oLiWvNUGcz+pIsAHdMic73a2m21L3DpUs/mt73LmHeSt0/QtfxJvz+aQ6mldc8zkEWfV
         F3Qfhhm8bgjWbtXzlMEXU5uN7Cjk2sGLmzUX+NjwKfwi6oQf87f5Eal465tBJ/4Ho3mN
         LAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWCV+CWpi3XnwtnI5CIUo+JQ1nhJiKlP+GPCB1eYga4=;
        b=pKRanV3dofSB77bd6MZ4NQT9vXks4OUIOBxrpAF6xMgQ0VcPzkrJd8kz6ur/Ck+IbR
         0r1w+fAUOGCreRylYoznwFZdWqltpS/cQ7OTLmta7RoI7XmG7bAMSBIdEShPl3SUXvjD
         AcHjBioSoiQWoIOrcl1/ABynfPTIATjWCR35NPF2+EoVCsscsRvERx7gDRowuPLHMw3d
         RS845AUo16HVV2ykPSXiSYjMJfwRRBvxHy6DVE+7sX6hybUo+HbUb/3XvLR7IS8l8Ej3
         dl67x0m02dF1y+RQXQXsqN/3jgRV46yZRznd2fkj5pmhwXcOTfcLM28Uu3vi1DqRU3Pl
         gKCg==
X-Gm-Message-State: APjAAAUHsqSy/g44293yvj59cKCb4fiMz1Ms3xOVq+goTl6stAZclVwt
        KLud2YATfF5+P7O+gh21GCILoJV9HgI=
X-Google-Smtp-Source: APXvYqyzsVQMYjh+W0yU1Q9d3D8oT+Lbz1yNEJYbuqAPZttqNYJTxkEQmyf9Ul0wHnkVjOyS+u6/oA==
X-Received: by 2002:aed:3522:: with SMTP id a31mr3356037qte.269.1556808549347;
        Thu, 02 May 2019 07:49:09 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:49:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [GSoC][PATCH v6 08/10] clone: extract function from copy_or_link_directory
Date:   Thu,  2 May 2019 11:48:27 -0300
Message-Id: <20190502144829.4394-9-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502144829.4394-1-matheus.bernardino@usp.br>
References: <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190502144829.4394-1-matheus.bernardino@usp.br>
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
index f117a6b206..1ee6d6050e 100644
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

