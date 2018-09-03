Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EEA1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeICTKY (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33542 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeICTKX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so985005wrc.0
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nd+/nkgOEja2uiPxab+wv4/HBBhlzSo3vdtpQQPSlBc=;
        b=o6GZZzvhlvdoU59bZp4FnQlm7y3R0fgpveDRkf/SPTf+FJ/tFN/NBwYSp8VfgCkG5r
         srohI76Ca6tMaqIeWgIPKmduskMlZvRdoHxYqJhFBR1ke+dXnJOcItNq9KeHWJ6gMnre
         +9c/RdQ5kgtQJI+I7WhH5cdxbYnXo22X7A0eTyouTGNu5aSeKdiXMtP9luhEGv7GdYx9
         4qXDYqGRWS+7eb05cjTI/sLdYTf9fpcW0ITj9mfPLiQvXpw7nFlLW2FvGY/2dQ4k7aV6
         0cs4nV1AvGzG60OJqw9lap0dDMgaeQc+11N1miFwmWjz2EBSkiRGGASgRxckTjz7qZPo
         rqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nd+/nkgOEja2uiPxab+wv4/HBBhlzSo3vdtpQQPSlBc=;
        b=E9VO3z/vyeaGkNO7ncUA3u1y/eEMgVnITVppHY086jypAMyF5mVcXgEMxGOdaJB3PN
         XSduNIR81fnd6H9L1G2CNxG/M4Su1Y5E9fqwaX5HDOzamjDhs9q/Sv9boY6EozynlMbG
         OXTn9HOW84WqD5Wsetu7+BmeL3ncBp6HvcFbtR/t6HUdbK9D/dkDVsV0xSLDW62wKm8c
         ToQq1hSA4ln2mydeX6kyp+FPLvEtRiBIP91RZe5lra+wDhGKXKUu3vQDjpmOzXvdkijE
         YOcYKoBLRp8HSCX3a4J/uIWfxdEQhpCXzUlVY3oQn/jQGma198ep/IAwvLPrKu4zJb2B
         iX2g==
X-Gm-Message-State: APzg51Dy+C+iVJUXerpJUFiRdm37qXLPE4ds7ZOvVxLIagxn8X7d/SzC
        0q16XM4ZphE12Y/JRHAEAl9PNjPmfOM=
X-Google-Smtp-Source: ANB0Vda4Rsuh88m5ZDPg3QFGzi+r0huw/WBLxPit73Ke6PaZUu9MuUfkQwhdilFAWtuPCB2YjHgh+g==
X-Received: by 2002:adf:ff0b:: with SMTP id k11-v6mr20931027wrr.15.1535986191266;
        Mon, 03 Sep 2018 07:49:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:50 -0700 (PDT)
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
Subject: [PATCH v5 08/10] fsck: use strbuf_getline() to read skiplist file
Date:   Mon,  3 Sep 2018 14:49:26 +0000
Message-Id: <20180903144928.30691-9-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

The buffer is unlikely to contain a NUL character, so printing its
contents using %s in a die() format is unsafe (detected with ASan).

Use an idiomatic strbuf_getline() loop instead, which ensures the buffer
is always NUL-terminated, supports CRLF files as well, accepts files
without a newline after the last line, supports any hash length
automatically, and is shorter.

This fixes a bug where emitting an error about an invalid line on say
line 1 would continue printing subsequent lines, and usually continue
into uninitialized memory.

The performance impact of this, on a CentOS 7 box with RedHat GCC
4.8.5-28:

    $ GIT_PERF_REPEAT_COUNT=5 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run HEAD~ HEAD p1451-fsck-skip-list.sh
    Test                                             HEAD~             HEAD
    ----------------------------------------------------------------------------------------
    1450.3: fsck with 0 skipped bad commits          7.75(7.39+0.35)   7.68(7.29+0.39) -0.9%
    1450.5: fsck with 1 skipped bad commits          7.70(7.30+0.40)   7.80(7.42+0.37) +1.3%
    1450.7: fsck with 10 skipped bad commits         7.77(7.37+0.40)   7.87(7.47+0.40) +1.3%
    1450.9: fsck with 100 skipped bad commits        7.82(7.41+0.40)   7.88(7.43+0.44) +0.8%
    1450.11: fsck with 1000 skipped bad commits      7.88(7.49+0.39)   7.84(7.43+0.40) -0.5%
    1450.13: fsck with 10000 skipped bad commits     8.02(7.63+0.39)   8.07(7.67+0.39) +0.6%
    1450.15: fsck with 100000 skipped bad commits    8.01(7.60+0.41)   8.08(7.70+0.38) +0.9%
    1450.17: fsck with 1000000 skipped bad commits   7.60(7.10+0.50)   7.37(7.18+0.19) -3.0%

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
index 96bf9facbd..d67ab37321 100755
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
2.19.0.rc1.350.ge57e33dbd1

