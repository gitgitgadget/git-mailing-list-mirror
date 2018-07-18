Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27111F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeGRQvV (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46519 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbeGRQvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so4572622ljj.13
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajGQyvATq69PhhV7d0Au9iWgiF9AuXjXF/Fd8GLgUzs=;
        b=KBDjfTm86gXIriKP+bEa4IsFVihzrAEWqtrL/kTnTbzTkKqM6sQTtcyhDLZimgDz7y
         CuRU65FVUqpToXf9PG677JxDS1V1ur7xI5tMHvcf9Vduv50yi7scr17UqhIyZnttc0zG
         Qqzp6yFPGZUSb3dBRD4LoTpkzDwooMgGbwK9BwIl2MXMbcgBJ6yhdJVJYcVC6Z+Q2nKT
         E7o7aGbMDM/EK009nZCdMK5M6uYVhOZHk32tw8wm6Oy2MEOakrnSD0ojaJk7zXBiONPA
         qbtDZtO7vWUaCYoUVPqscak4npPhuLX5gY1m7CB6z/6Gp3EYYTbgu1GdQnLlSKryK04H
         UZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajGQyvATq69PhhV7d0Au9iWgiF9AuXjXF/Fd8GLgUzs=;
        b=Vb/W0KAn8evM9e62cNqRJ98rVjyUxnTsgHl67UX9upDnMSplW3nUfA1lJKnqny9gjk
         c+h4VlrEVnpccEUJrf3M6hhMtn7cv2Xgciw6nUpgDNdALi3dsxI4FPSegqJNgtCDdNym
         rPLHY6op1V5S4ZXI6ub7qd4lGYTJ61DYFySct4kTMsQgveTnnLsRihmdgyZrgWbWIg0P
         XPmbYP1/gFP2XFDyJz3M0NztoQaBgvjFz2BEJ3vJjLnkHEaP+Wb2d0lmAHHr38mxzIO5
         Z5S488qmj5Fk8OZSEqSZHEUhXcHLj6y+21r5mDP80ss8tz9kAmW4wusqScsvJHwAYT7p
         94kw==
X-Gm-Message-State: AOUpUlGzpLxOcHM9HwpWoQiqBTZCGKfKPt4/+E58HzFQ9Lr03v9g3zXH
        w7pDKyOOd/BzU6rbLzRhipkUKA==
X-Google-Smtp-Source: AAOMgpeStsa7XyPMImNVakFe/YYUlarLlhgPfWYprTec43gS+Jzxkzb4H+D2hyZY6Q4DF4Bu0ZV0/Q==
X-Received: by 2002:a2e:4d9d:: with SMTP id c29-v6mr4867198ljd.132.1531930362459;
        Wed, 18 Jul 2018 09:12:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 03/23] archive-zip.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:41 +0200
Message-Id: <20180718161101.19765-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive-zip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 48d843489c..7ad46d8854 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -309,11 +309,11 @@ static int write_zip_entry(struct archiver_args *args,
 		if (is_utf8(path))
 			flags |= ZIP_UTF8;
 		else
-			warning("path is not valid UTF-8: %s", path);
+			warning(_("path is not valid UTF-8: %s"), path);
 	}
 
 	if (pathlen > 0xffff) {
-		return error("path too long (%d chars, SHA1: %s): %s",
+		return error(_("path too long (%d chars, SHA1: %s): %s"),
 				(int)pathlen, oid_to_hex(oid), path);
 	}
 
@@ -340,7 +340,7 @@ static int write_zip_entry(struct archiver_args *args,
 		    size > big_file_threshold) {
 			stream = open_istream(oid, &type, &size, NULL);
 			if (!stream)
-				return error("cannot stream blob %s",
+				return error(_("cannot stream blob %s"),
 					     oid_to_hex(oid));
 			flags |= ZIP_STREAM;
 			out = buffer = NULL;
@@ -348,7 +348,7 @@ static int write_zip_entry(struct archiver_args *args,
 			buffer = object_file_to_archive(args, path, oid, mode,
 							&type, &size);
 			if (!buffer)
-				return error("cannot read %s",
+				return error(_("cannot read %s"),
 					     oid_to_hex(oid));
 			crc = crc32(crc, buffer, size);
 			is_binary = entry_is_binary(path_without_prefix,
@@ -357,7 +357,7 @@ static int write_zip_entry(struct archiver_args *args,
 		}
 		compressed_size = (method == 0) ? size : 0;
 	} else {
-		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
+		return error(_("unsupported file mode: 0%o (SHA1: %s)"), mode,
 				oid_to_hex(oid));
 	}
 
@@ -466,7 +466,7 @@ static int write_zip_entry(struct archiver_args *args,
 			zstream.avail_in = readlen;
 			result = git_deflate(&zstream, 0);
 			if (result != Z_OK)
-				die("deflate error (%d)", result);
+				die(_("deflate error (%d)"), result);
 			out_len = zstream.next_out - compressed;
 
 			if (out_len > 0) {
@@ -601,7 +601,7 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 	struct tm *t;
 
 	if (date_overflows(*timestamp))
-		die("timestamp too large for this system: %"PRItime,
+		die(_("timestamp too large for this system: %"PRItime),
 		    *timestamp);
 	time = (time_t)*timestamp;
 	t = localtime(&time);
-- 
2.18.0.rc2.476.g39500d3211

