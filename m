Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815521F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeH1Nne (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35429 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeH1Nnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so967901wre.2
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCvMrVrVib/qWZN9yGFlV3SdWmoy6ChmQBAmC+fDwIs=;
        b=DVoOhK5rXRNoR1FDTTCtCxlPZm8cFTGDehTQaGD1quEDXpAKgIFU+fuCoLtSogKu5j
         mDZePXJCa/ouDR89cPKmpy4shEJO7v4Ud3DP+q1kO9ukC5j9ebqgUQ9iweprOihkUFMi
         bbFU4T7OcVnR/ECZNUn4NDyZjYIVx9t5NHrseuPMz2MAjxzNEgzZoxOE4Lb6zY8MK/A/
         bVrd6dgp1Zw+nP5jGKGUiJBNMdPrj7q/dJxssec43cOY5Ev1/ADyQ89j5X7xDl9MDsyw
         KMTitbeWwa8AbizvqYJAMNE/Ybmelo/fpEvYYEi7rk5FuVag07W0O4m8zpwQR9B9aKxi
         CDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCvMrVrVib/qWZN9yGFlV3SdWmoy6ChmQBAmC+fDwIs=;
        b=gGzMiozT2hXafRxHBfCmZDr2AVs/NTykUobVaDwPcNS5DbnmwdpKJOaL8wgGSQgYKx
         EQZIlFNtX3D9/qt2wyZOEsxMmpVXY3kyQTF7dOrxKmdGBrLDZKXgy14zkF6YTrAiR9Ng
         wFq6kG439HY8FU1J3UYnnqvcdpy+6Bef3Bbjw4rgvRjNWXaJUUJNfl87vVzIP00V9WFy
         yyGGPZwRHKE0OeHh2Hz5gdsYuKtxj6t6FEWvJsCwJVCQoT+WEqbQLQR5doKGMRdY2WdM
         vInw3KnHlgtqHXHbfbeWksjnz/Ot3QhAao83RYtfTDp1mxIIhhQo3QgeeUmCpdbm+pZv
         Co7w==
X-Gm-Message-State: APzg51AonhcgI5SV8ySKOKmaxyncCBqRo5fYIjnEtE/3JpBBC5Zj4m4Z
        VRu0WAQ0Lqxp9UWBg5aO2SiQ9irNI0s=
X-Google-Smtp-Source: ANB0VdZsfOj7jElr4ufljuW8XO3/8/U67GH1FDo1a6Z5aUQ8iwIlKF1uOeMBfCxTgAmw6CGKTuKwmw==
X-Received: by 2002:a5d:6984:: with SMTP id g4-v6mr588647wru.232.1535449960447;
        Tue, 28 Aug 2018 02:52:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:39 -0700 (PDT)
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
Subject: [PATCH v4 6/8] fsck: use strbuf_getline() to read skiplist file
Date:   Tue, 28 Aug 2018 09:52:17 +0000
Message-Id: <20180828095219.23296-7-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
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

    $ GIT_PERF_REPEAT_COUNT=5 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run HEAD~ HEAD p1450-fsck-skip-list.sh
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

