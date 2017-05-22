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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2202023D
	for <e@80x24.org>; Mon, 22 May 2017 17:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758051AbdEVRKf (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 13:10:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35467 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbdEVRKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 13:10:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so21281029pfd.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDq1QszAzFcfIs6d2O3B87T0fOgiwfEtkjLIxTGJPAQ=;
        b=YMA2rhGL+t3GaGnjidLnfwAAAzsQTdvvN752tq5MWvf4jdVBx0c+zig6ZwRtwFZ3F3
         Htym5bxAqj4vhf+B2hLLoyrBIk3mh4VjCSdq6qCHAc7Ob1WeF/gT+Z6n4PfFZM1HVO6H
         mxEF0bFPk/0R82L9eSqPvF0rlyOfzxGyMPOz9TcBhY+I5n1QLdR0a0qqW96+qJGPib+q
         4b8WelJJonrYmvkwm46Ra2+vijmcvufZBE5iDSfJzTG78OvgwflsWBKzA+ieURigPfiN
         MJSIw9t3f/U/IvDyeynQRef7nEMwHstm6jf8leOCuQIJtbRn1O5fibd12RkMWfCO5y4A
         2d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDq1QszAzFcfIs6d2O3B87T0fOgiwfEtkjLIxTGJPAQ=;
        b=O14SIyw3Eqpl0a9jHQ7Hh3gVlZfvkaCCqAVOw0HTxyfaI6vrkU2ugE0yJHxuML/4i3
         dAUXewfafl5Ec2E+VFo5BAU492Gb5DWPJCxo2k/jpZOyrVOL+ofxWp600YsJpvJNscRP
         jZAhC2DmFZwD59JiFqxV6QTvI3qruNdb2fykSFY1OEWtV9UJdxdZK/OjfMt9+FMQ0zbu
         NvkJGf4gAp8b4oRer70ScZgioVV2VMbwaAjKsjaMjh3uEeHyG8PMyw/gR82KVrA9EluA
         Gl3ym4gCV5KEvDOrcYdTafRubcuPh1aRE8Jnl5EDsm7X+xtlO6iVd+VqAPVEUM1pf3f1
         QRtg==
X-Gm-Message-State: AODbwcBlU5UdDHv1LQwMHDpYrx6UoG8q3DnqO6LOGoTtZ4yDgTyhaTPJ
        907UaR+XzaAtkw==
X-Received: by 10.98.210.199 with SMTP id c190mr26652139pfg.87.1495473033213;
        Mon, 22 May 2017 10:10:33 -0700 (PDT)
Received: from localhost.localdomain ([116.87.142.169])
        by smtp.gmail.com with ESMTPSA id q24sm33385836pfj.3.2017.05.22.10.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 10:10:32 -0700 (PDT)
From:   DOAN Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     animi.vulpis@gmail.com, j6t@kdbg.org, peff@peff.net,
        gitster@pobox.com, git@grubix.eu, pclouds@gmail.com,
        karthik.188@gmail.com,
        =?UTF-8?q?=C4=90O=C3=80N=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3] ref-filter: trim end whitespace in subject
Date:   Tue, 23 May 2017 01:10:14 +0800
Message-Id: <20170522171014.33384-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.13.0.67.g10c78a1
In-Reply-To: <20170522145753.83810-1-congdanhqx@gmail.com>
References: <20170522145753.83810-1-congdanhqx@gmail.com>
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
Sorry for the noise, after sending out v2,
I found that the body is calculated incorrectly.

 ref-filter.c             | 40 ++++++++++++++++++++++++++++++++--------
 t/t3203-branch-output.sh |  3 ++-
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1fc5e9970..4b30edf61 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -942,6 +942,25 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	}
 }
 
+/*
+ * check if line in range [start, end) is a blank line or not
+ * data in range [start, end) must be valid before calling this function
+ */
+static int is_blank_line(const char *start, const char *end)
+{
+	while (start != end && isspace(*start))
+		start++;
+	return start == end;
+}
+
+static const char* find_next_eol(const char *buf)
+{
+	const char* eol = strchrnul(buf, '\n');
+	if (*eol)
+		eol++;
+	return eol;
+}
+
 static void find_subpos(const char *buf, unsigned long sz,
 			const char **sub, unsigned long *sublen,
 			const char **body, unsigned long *bodylen,
@@ -949,6 +968,7 @@ static void find_subpos(const char *buf, unsigned long sz,
 			const char **sig, unsigned long *siglen)
 {
 	const char *eol;
+	int has_empty_line = 0;
 	/* skip past header until we hit empty line */
 	while (*buf && *buf != '\n') {
 		eol = strchrnul(buf, '\n');
@@ -967,20 +987,24 @@ static void find_subpos(const char *buf, unsigned long sz,
 	/* subject is first non-empty line */
 	*sub = buf;
 	/* subject goes to first empty line */
-	while (buf < *sig && *buf && *buf != '\n') {
-		eol = strchrnul(buf, '\n');
-		if (*eol)
-			eol++;
+	while (buf < *sig && !has_empty_line) {
+		eol = find_next_eol(buf);
+		has_empty_line = is_blank_line(buf, eol);
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
-		buf++;
+	while (buf < *sig) {
+		eol = find_next_eol(buf);
+		if (is_blank_line(buf, eol))
+			buf = eol;
+		else
+			break;
+	}
 	*body = buf;
 	*bodylen = strlen(buf);
 	*nonsiglen = *sig - buf;
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
Danh

