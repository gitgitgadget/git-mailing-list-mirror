Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F221F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeCFKml (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:42:41 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34251 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:42:40 -0500
Received: by mail-pf0-f194.google.com with SMTP id j20so8566883pfi.1
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 02:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rknBKE8e/G0DItTRW5MnCyAaQqihqxJVaJenvxvkyg=;
        b=okAfxrmCZ8PonXECB+xL1b36AyJcEjGRxWJlsvu/52gs1kUvrtsL8XNMVLyHe2Pfnf
         YZQVgtLmJALWzEUYcuQBsD4Nw1zYhiJETV5eo7PANMGPtAinn8AYsEpkC7mcx4Y6p4x7
         AhzXKW6gK30VmUxeAUuTJW8te8ou/ctxBOuQRMZp/zQbYmbPD0bf8OGH0dqisSEMnJdz
         c9yLZ77M3HVG5jWYtJUO+sMOLQ/L/G5PTLUrGyB6snqSwVB8cyTKPQ8wiCQeAkZAkovX
         mTfWood5OIgdd3bGNjc8S/giTWPlcA4ydBbLX4bxtYMnANWLzC6bdpXuNUl9OptN315c
         yoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rknBKE8e/G0DItTRW5MnCyAaQqihqxJVaJenvxvkyg=;
        b=LarYKA1DOnGq73D64QEzM6WycXqELHSYzsBy8APJ9SHvuj0k18Ap7JAajFROasQrfO
         GT72A4N7yYpjsged5noOleHYMK6FYLgCt7Ny8EnJMjUc7OBYpnxPl7NlCw+fXrCq71zy
         9IoHVVlDeR/7thd2e5dsEIdEgMcJsLTjTFsRLFiASrLArnO+974rwS357tjwcFIHsvJ3
         dvrQ1Cb9ZJMn+jmapD9aa57cwsX9hCGXrpzQbcxoRR7RyHzAtf1Ia1mnK3azNgGprbRt
         j0ezFcuCwaKXyf3Dl6CryDrM2JqvovK65Jtn3XrF+9VmEEhW4PGSv0jv6e1T9sHlto8X
         cL2A==
X-Gm-Message-State: APf1xPCh7z+Xf35IfRb2b8q073aYTpfFQcvKlwH4lIK9gMVPL5BSkh6R
        8g9DAzQMHw1QbDjY69RqCHuSOA==
X-Google-Smtp-Source: AG47ELtLJxQB37kHPOQGHVP7FcFIkR/oGBgS8JzCQQegElfC7OGLSOXtsYekPT5SR0QbMDhPB9Ytxg==
X-Received: by 10.101.99.90 with SMTP id p26mr13543875pgv.135.1520332959554;
        Tue, 06 Mar 2018 02:42:39 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id y124sm25026713pgb.29.2018.03.06.02.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:42:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Mar 2018 17:42:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] pack-objects: show some progress when counting kept objects
Date:   Tue,  6 Mar 2018 17:41:57 +0700
Message-Id: <20180306104158.6541-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.784.gb291bd247e
In-Reply-To: <20180306104158.6541-1-pclouds@gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com>
 <20180306104158.6541-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only show progress when there are new objects to be packed. But
when --keep-pack is specified on the base pack, we will exclude most
of objects. This makes 'pack-objects' stay silent for a long time
while the counting phase is going.

Let's show some progress whenever we visit an object instead. The
number of packed objects will be shown after if it's not the same as
the number of visited objects.

Since the meaning of this number has changed, use another word instead
of "Counting" to hint about the change.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fcdd398eb7..24af4068a9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,7 +44,7 @@ static const char *pack_usage[] = {
 static struct packing_data to_pack;
 
 static struct pack_idx_entry **written_list;
-static uint32_t nr_result, nr_written;
+static uint32_t nr_result, nr_written, nr_seen;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -1092,6 +1092,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
+	display_progress(progress_state, nr_seen++);
+
 	if (have_duplicate_entry(oid, exclude, &index_pos))
 		return 0;
 
@@ -1107,8 +1109,6 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1119,6 +1119,8 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 {
 	uint32_t index_pos;
 
+	display_progress(progress_state, nr_seen++);
+
 	if (have_duplicate_entry(oid, 0, &index_pos))
 		return 0;
 
@@ -1126,8 +1128,6 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, index_pos, pack, offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -3205,7 +3205,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	if (progress)
-		progress_state = start_progress(_("Counting objects"), 0);
+		progress_state = start_progress(_("Enumerating objects"), 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-- 
2.16.2.784.gb291bd247e

