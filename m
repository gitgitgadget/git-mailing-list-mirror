Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3171FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbdBMPUj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:20:39 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32842 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbdBMPUg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:20:36 -0500
Received: by mail-ot0-f194.google.com with SMTP id f9so11895292otd.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo3vDQk7f011U6wKVRvDwPig6hJtnp6rHHRthhhM0E0=;
        b=aeVnHxVui5Q8HzjLgeo/rYlnkbszeO9AHdeOARyxsv01dxwgFF0LTOAFlmPqJpEMCk
         EXP20gCcn1+Sdzefdd6cIAdiN5oACWQQr+68EFZC/2MFWA30BW0hqZrpO8+LqRsdzc2A
         3/zzuwD6UTpqcS5T39w/SpQ3gpwlOpbo35/S/IO+ICsKywdarWfA/1NgoL10sZ9VlcF+
         1K5HYwHNWX1Xb+sC376KXE0q84p1gwfjV+QZxpwNYfsmyA6oOY1zWbX6YFOwE6a2J33T
         AjwFW6uCUzYjmZf+F8HO8eAlpxtgAS5kjsYYQ2xWUCIoXYwyc7nrieYceuIEqpeEfRwg
         7hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo3vDQk7f011U6wKVRvDwPig6hJtnp6rHHRthhhM0E0=;
        b=o8UpMY1J/mU0dGS23weIqxvDiFmZv3Q1xB2peHHzKbsPdsGWrtGeReKmfrZoSAxf9/
         9N57tVjZur6YhMJD7xKES96SN+YA5qXpWxjItvV57KjllaXyiOcP9VI1QrOW31bwEyCO
         HbSRaOvTkIOAl/arm/bIdwy2D4EKtkn4OL8gQ3BdQwaO4+L00jJT1XOluMjpRK7ObwhR
         oMnWkofAeAilILLoP5hU3u624btrvcTvTK/6fOWgbXTKhPsJi1bu3aoZLWplMo9sCtO7
         Ko8FAU1twzeOu6P3Rl6zYvcbolBwKI1x2JLWrIaYLv56IHc45Xs5r/RhN0uif/RJKPdB
         NbmA==
X-Gm-Message-State: AMke39msirlX5ikos4bfdvD7y/rfdjwXxNlTQNZA0t8Oy267aAe9RinCruy4G84fYTuDXQ==
X-Received: by 10.99.140.28 with SMTP id m28mr27793500pgd.174.1486999225440;
        Mon, 13 Feb 2017 07:20:25 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id m29sm21690070pfi.54.2017.02.13.07.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:20:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:20:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/11] refs-internal.c: make files_log_ref_write() static
Date:   Mon, 13 Feb 2017 22:20:01 +0700
Message-Id: <20170213152011.12050-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
but probably never used outside refs-internal.c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 3 +++
 refs/refs-internal.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index cdb6b8ff5..75565c3aa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
+static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			       const unsigned char *new_sha1, const char *msg,
+			       int flags, struct strbuf *err);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 33adbf93b..59e65958a 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -222,10 +222,6 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err);
-
 /*
  * Check for entries in extras that are within the specified
  * directory, where dirname is a reference directory name including
-- 
2.11.0.157.gd943d85

