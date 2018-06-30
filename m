Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD91E1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934587AbeF3JIj (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:08:39 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:39955 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbeF3JI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:28 -0400
Received: by mail-lf0-f48.google.com with SMTP id y200-v6so2870771lfd.7
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajGQyvATq69PhhV7d0Au9iWgiF9AuXjXF/Fd8GLgUzs=;
        b=CyoEaOCHFaBTLgoR907qqokE5RkldTpsC7Sjj5+qYzE0CeNCR0ejZqXQffDX7r0HSO
         g6q+iVeAujJ6CSWV6mABxxmaI6fncWIGqgcBfOgEiyADj9n2ebXZfHuir/B9eA+Ja2jF
         WVkRBW2YptK7jTH6w3THjyzHzv5uKuZm0Xs7e4+Dq5jK5gqoNn5LPPk5Bn8Ul+qT9z2B
         o5pJNurYixaS5qdv6MDBLNcjXHB44QGRbW3dRcH5twZAPFy8TOWoXRHO1p5Bs6GHxlIu
         DfUw9Cx1/IDy/87TFHZMf5duTrGS0zLKh2NOJ5YpJmHCpmCxU/uS2dUsj+1sxVrKuJQL
         PMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajGQyvATq69PhhV7d0Au9iWgiF9AuXjXF/Fd8GLgUzs=;
        b=rcPX4m0dJDpb5oYy3mpwzKv8HH80t6wBZcwZ85t62Eho8Qy4DnH9C90LrqwgoYdWxa
         04dRpIGnl7q00ZwdauT9/P8cVElun7tHwZ39Cv56h+zHaJUE/BxF9Ae/oNyg9GRUrAHO
         yQNnlMRZAR7BDZib7cjwbcqwIfcZPJjukSi1vobXwQaSlIq8566MfEpKqQX0KGhtIyrv
         p/gW9DPyzb9jVRKPOBBLDjiaXhOENrt0noGaSS/iY6XspRMEHPiX1CR49q/jaKPsJ+pD
         CmoTCz0BxJZzq56/TD6elJnX2AxpeB6rNHPJc5VZB6KGlVfwfldWWVwNEBRP3xxxhe2S
         G0Cg==
X-Gm-Message-State: APt69E03xi8YlO67DEyUgzGExv3PTUl7MB/bRJFzTqfpcIu8L6AoQ4QX
        crB4Yso4lCSr8M8+l6WS2/jBYg==
X-Google-Smtp-Source: AAOMgpcAs72c/ezLABifvPTdcQVK30OF7XBvufVfGvXcG4Gsl1ATbKp7mmCrbOXHZqOsBoP1Ti/Isw==
X-Received: by 2002:a19:5c06:: with SMTP id q6-v6mr10508012lfb.6.1530349706730;
        Sat, 30 Jun 2018 02:08:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/23] archive-zip.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:07:58 +0200
Message-Id: <20180630090818.28937-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
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

