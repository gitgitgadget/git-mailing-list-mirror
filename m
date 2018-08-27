Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6701F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeH0Xbo (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:31:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50200 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeH0Xbo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so116068wmc.0
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMmvUjfXPa7my9k4u98RuZmUBLQ3m7TdAM5w7txFXMA=;
        b=krvflm6evehUgpRcoEp35p9T22KSEuE8bPDU6PwhVLuG3PEgt/SA+LC/LRQaBiHbsu
         RKz1VaKIIjE4Z1d1QuV+SPCBIJM5FuyFtI/SY2WsGwYZYTIeFRSOHSQ6nNk2A8WJvcxv
         hZR/gQTGFN9oLZ2Qj/J9Sf6B9Kb0Qx284PijbsrC5VFWK/9zO39GNfgPEWGS4T/wGvDU
         t1XZKVegvYYJqDDe1I0RzWQ9ogOSbSKmGhqZhWbocn8qOu3767YwSMMCc/RosgoOnoAM
         mc5mydKmj6VUXt00whKkCY6IUtjB6GUroe0zEUgyUzcrBqEDKMp0WfgKlRYg3hBSdQ+F
         6tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMmvUjfXPa7my9k4u98RuZmUBLQ3m7TdAM5w7txFXMA=;
        b=VD7il30UHHsMayF0m8kfQ7KVqcdaMP/P1+CpDkprJ51MZt2SJkS5I4G22qcEoVr/Hl
         BLz6DtPczNfKhYLd6Nrl8sKLZ6hpkNXv6gsl4XM2e8Br7/LbCSr6O+GCI1PcHWF6gB6A
         MkvWhWgO0x6yUpiSAp5Tz5wKTivrLVPX/w+MRvkFrb5BLZCxIUoXxeD+uZ8luRaLRzGB
         yflsRK8LUH0GAMpmYo8S0GI4YfpyoI7a12nGAH982xQFwTD4UzIMipXHYaSXNOIkqUbQ
         xv/0LOwJRS4XYkLPtcxlEytwOVWSer2B0fKugoxG6IO5h9LFsgDucrrwVyIfleojpI7a
         lWLg==
X-Gm-Message-State: APzg51Bt7NuBRjwbhVE/yR3/JyEuSQZ4xMBpWNEIg8XGzDbefvaOzvMt
        +JhF1AqJN3nYOFr/l3f9gnovbmvggoM=
X-Google-Smtp-Source: ANB0VdaifLEYiG9SnffjfpPPp9ezue52kLicDuRXj+2aq/6ne/gND6I33DZTCNe5GRZ+Gx+J7dK0JQ==
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr6264426wmq.36.1535399022065;
        Mon, 27 Aug 2018 12:43:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm121958wmd.4.2018.08.27.12.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:43:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/7] fsck: use strbuf_getline() to read skiplist file
Date:   Mon, 27 Aug 2018 19:43:21 +0000
Message-Id: <20180827194323.17055-6-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180827194323.17055-1-avarab@gmail.com>
References: <20180827194323.17055-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

buffer is unlikely to contain a NUL character, so printing its contents
using %s in a die() format is unsafe (detected with ASan).

Use an idiomatic strbuf_getline() loop instead, which ensures the buffer
is always NUL-terminated, supports CRLF files as well, accepts files
without a newline after the last line, supports any hash length
automatically, and is shorter.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c                          | 25 ++++++++++++-------------
 t/t5504-fetch-receive-strict.sh |  2 +-
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fsck.c b/fsck.c
index a0cee0be59..972a26b9ba 100644
--- a/fsck.c
+++ b/fsck.c
@@ -183,8 +183,9 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 static void init_skiplist(struct fsck_options *options, const char *path)
 {
 	static struct oid_array skiplist = OID_ARRAY_INIT;
-	int sorted, fd;
-	char buffer[GIT_MAX_HEXSZ + 1];
+	int sorted;
+	FILE *fp;
+	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
 
 	if (options->skiplist)
@@ -194,25 +195,23 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 		options->skiplist = &skiplist;
 	}
 
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
+	fp = fopen(path, "r");
+	if (!fp)
 		die("Could not open skip list: %s", path);
-	for (;;) {
+	while (!strbuf_getline(&sb, fp)) {
 		const char *p;
-		int result = read_in_full(fd, buffer, sizeof(buffer));
-		if (result < 0)
-			die_errno("Could not read '%s'", path);
-		if (!result)
-			break;
-		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n')
-			die("Invalid SHA-1: %s", buffer);
+		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
+			die("Invalid SHA-1: %s", sb.buf);
 		oid_array_append(&skiplist, &oid);
 		if (sorted && skiplist.nr > 1 &&
 				oidcmp(&skiplist.oid[skiplist.nr - 2],
 				       &oid) > 0)
 			sorted = 0;
 	}
-	close(fd);
+	if (ferror(fp))
+		die_errno("Could not read '%s'", path);
+	fclose(fp);
+	strbuf_release(&sb);
 
 	if (sorted)
 		skiplist.sorted = 1;
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 38aaf3b928..c7224db3bb 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -185,7 +185,7 @@ test_expect_success 'fsck with invalid or bogus skipList input (comments & empty
 	test_i18ngrep "^fatal: Invalid SHA-1: " err-with-empty-line
 '
 
-test_expect_failure 'fsck no garbage output from comments & empty lines errors' '
+test_expect_success 'fsck no garbage output from comments & empty lines errors' '
 	test_line_count = 1 err-with-comment &&
 	test_line_count = 1 err-with-empty-line
 '
-- 
2.19.0.rc0.228.g281dcd1b4d0

