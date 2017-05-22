Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314432023D
	for <e@80x24.org>; Mon, 22 May 2017 14:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbdEVO6N (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:58:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34804 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934539AbdEVO6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 10:58:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so20586219pfk.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8l648rI/6Sx7s/PKrZYc+RHZ5CUW70PRvY2iMdhGUQ=;
        b=V78knIH+PENqn3vdY6T9dEa8wmLzqNx3I6EEASKHWJImB2UJ6deCCXcuTgOzc7ywEU
         R/qFt7MwdQmfjMBw4ld4a8F9JPQDYBhNsxMPsQ9GuYLilROmVXaA9+PW7+hpc6X52XLp
         8dFUxFNtUH6jX8XMdaRnQziwWGBizplgSYIjoRTNYstUL1xzPlNq5wHqdhehMB5a/58n
         IPQ3Bv97xlKjx+/ckt5i5GIWJ+niDNHKgD32InhXIKYqdkvNUpvPBhdORT+gnM2UEY/r
         EnLlLzH453lV6OdcF/Z9E5XVV4r1itlQz5MBEcrIgRBex9o7umU+H2zVZta7dLNYFOu0
         H1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8l648rI/6Sx7s/PKrZYc+RHZ5CUW70PRvY2iMdhGUQ=;
        b=NLY9+6Xz/hadzi+OUu4k8RX3oaro7vGpAQm74kw9elnq3L394SglhHefehpuIr0vZm
         F6/z36euh4aIWBzI4Z5mrseUMqChFWVmlpRfdxHDpaW941E+BfK8nla+IUQDb/6KXcqE
         JRBIR+TbHr2pPowGkqyr5UuQ1b4Yrp3Xb/E8KaT2+178KxOzu6ss1yo6SKcwk1AQzRg9
         eqibwpbAabuKHYPqPJ2qNLZtQXVguWAhqKdo3hhA+IIVS2UYR09UEIhszFf/d24+ES9+
         EkxMIpDozXJban1uZThGHUfx4SraSSK9qygb5LDIM4TFNIOhhHN/rz15reG63H9+gz8Q
         81VA==
X-Gm-Message-State: AODbwcDlG3BOIOI3cWgOLQQO73BVd3xGZ0ymwqckL7RwTqRzhyoGeFND
        FLDYnDJOKGIQ8w==
X-Received: by 10.98.205.65 with SMTP id o62mr25784681pfg.105.1495465092051;
        Mon, 22 May 2017 07:58:12 -0700 (PDT)
Received: from localhost.localdomain ([116.87.142.169])
        by smtp.gmail.com with ESMTPSA id r69sm8640232pfj.42.2017.05.22.07.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 07:58:11 -0700 (PDT)
From:   DOAN Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     animi.vulpis@gmail.com, j6t@kdbg.org, peff@peff.net,
        gitster@pobox.com, git@grubix.eu, pclouds@gmail.com,
        karthik.188@gmail.com,
        =?UTF-8?q?=C4=90O=C3=80N=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2] ref-filter: trim end whitespace in subject
Date:   Mon, 22 May 2017 22:57:53 +0800
Message-Id: <20170522145753.83810-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.13.0.67.g10c78a1
In-Reply-To: <20170521141059.2767-1-congdanhqx@gmail.com>
References: <20170521141059.2767-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ĐOÀN Trần Công Danh <congdanhqx@gmail.com>

Commit 949af0684 ("branch: use ref-filter printing APIs", 2017-01-10)
make `git branch -v` stops trimming end-whitespace in subject,
and it stops treating next all-whitespace-line as an empty line.

Quote from git mailing-list:

> Here is a recipe to reproduce the error:
>
>    git init
>    git commit --allow-empty -m initial
>    git branch crlf $(printf '%s\r\n' subject '' line3_long line4 |
>        git commit-tree HEAD:)
> The reason for the "bug" is obviously that a line having CR in addition
> to LF is not "an empty line". Consequently, the second line is not
> treated as a separator between subject and body, whereupon Git
> concatenates all line into one large subject line. This strips the LFs
> but leaves the CRS in tact, which, when printed on a terminal move the
> cursor to the beginning of the line, so that text after the CRs
> overwrites what is already in the terminal.

To recover previous behavior, trim all whitespace at the end of
first line, and treat all-white-space line as empty line

Reported-by: Animi Vulpis <animi.vulpis@gmail.com>
Helped-by: Johannes Sixt <j6t@kbdg.org>
Signed-off-by: ĐOÀN Trần Công Danh <congdanhqx@gmail.com>
---
 ref-filter.c             | 21 +++++++++++++++++----
 t/t3203-branch-output.sh |  3 ++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1fc5e9970..3625d543c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -942,6 +942,17 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	}
 }
 
+/*
+ * check if line in range [start, end) is a blank line or not
+ * data in range [start, end) must be valid before calling this function
+ */
+static int is_blank_line(const char *start, const char *end)
+{
+	while (start != end && isspace(*start))
+		++start;
+	return start == end;
+}
+
 static void find_subpos(const char *buf, unsigned long sz,
 			const char **sub, unsigned long *sublen,
 			const char **body, unsigned long *bodylen,
@@ -967,19 +978,21 @@ static void find_subpos(const char *buf, unsigned long sz,
 	/* subject is first non-empty line */
 	*sub = buf;
 	/* subject goes to first empty line */
-	while (buf < *sig && *buf && *buf != '\n') {
+	while (buf < *sig) {
 		eol = strchrnul(buf, '\n');
 		if (*eol)
 			eol++;
+		if (is_blank_line(buf, eol))
+			break;
 		buf = eol;
 	}
 	*sublen = buf - *sub;
-	/* drop trailing newline, if present */
-	if (*sublen && (*sub)[*sublen - 1] == '\n')
+	/* drop trailing whitespace, if present */
+	while (*sublen && isspace((*sub)[*sublen - 1]))
 		*sublen -= 1;
 
 	/* skip any empty lines */
-	while (*buf == '\n')
+	while (isspace(*buf))
 		buf++;
 	*body = buf;
 	*bodylen = strlen(buf);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 5778c0afe..fa4441868 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -13,7 +13,8 @@ test_expect_success 'make commits' '
 
 test_expect_success 'make branches' '
 	git branch branch-one &&
-	git branch branch-two HEAD^
+	git branch branch-two $(printf "%s\r\n" one " " line3_long line4 |
+	     git commit-tree HEAD:)
 '
 
 test_expect_success 'make remote branches' '
-- 
2.13.0.67.g10c78a1

