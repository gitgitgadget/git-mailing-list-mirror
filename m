Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A87E1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeJVXzs (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 19:55:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35061 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeJVXzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 19:55:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id o14-v6so37432951ljj.2
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwseJcsDeKOxHkkj2tU3uX2iZw/g9zglK/8b8nw8HhM=;
        b=NDJEeggxXt5X24MLWcQbZwRQ/9cZboVHaRR/IYjOwMqVl+9Eh5lq9GeKEQG1b8LsKi
         DMM1MSEIZNbT0my/gGXhOGFKbCR+nexesd+cSPovbcrTSzDnw+Y2Necxa2KQa45fHPx0
         Kps0DZEOexPNwkY2hK4Wivg+Nc6Fw/NwpyyOB+0e3WKwjBc/2+Lgia+WQmJQ3FKhDSai
         3W7Sz6bg4zlb98qD8hcdHO9e0DQ9Mc7ngwCVBHK0W7cbT1LBzV2u3ghrROYZurLGloMr
         mT6X6CzrZLQK0I/e8MT2RY7mCfTqVYINq8hqnkCp/YLMGgGQtBytlzaUQOcZN1qB0pJy
         xuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwseJcsDeKOxHkkj2tU3uX2iZw/g9zglK/8b8nw8HhM=;
        b=NICU6QYDgGT42ZvSRaPBxiqRuslVr5pxW3I1vAaSnO0rYunbE1AOimQSs1WzC6lEDw
         HV3t+6ZLzZBSxo2q2HMuTltfev7y7U+79QRtltMJTE4SK2+lhCqMeRaDsLaCyaK8jxyk
         KhiuZcOkSukopl1o3UsWIgQ4ld6lc/w72AgR0FNW65e4UJhcB62ltL1L87fS+OVsHb6y
         TpOGf3YEPJO96HQbv/6II498ht8t9f8lKaDy/g8YTx9QYIlnDNpjJdP0Dk2ov7QBeYa/
         Bjkm6zwNg2+3lDqUSXL8zFkIj7uFqTJJZPXS4v6gXHx9gYXUU6JD/YxwUdeCex8MAf4G
         yX5Q==
X-Gm-Message-State: AGRZ1gJxq1ZmWZUQDEhjAIKdGq3VYvoK4pHOYCqtNwfEMYrksKrmJaiS
        STp0Xi8AnjkJnVTE06z8WDvygoX2
X-Google-Smtp-Source: ACcGV627sIhsR2IQUAWsFzqpJ4XrBmlj/pm/69Iedtb9LKAlqt3pu1wCnQsp3fQD9aNUF1QAEJBT7Q==
X-Received: by 2002:a2e:350e:: with SMTP id z14-v6mr11099834ljz.49.1540222604334;
        Mon, 22 Oct 2018 08:36:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d2-v6sm5312405lfc.11.2018.10.22.08.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 08:36:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] Poison gettext with the Ook language
Date:   Mon, 22 Oct 2018 17:36:33 +0200
Message-Id: <20181022153633.31757-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current gettext() function just replaces all strings with
'# GETTEXT POISON #' including format strings and hides the things
that we should be allowed to grep (like branch names, or some other
codes) even when gettext is poisoned.

This patch implements the poisoned _() with a universal and totally
legit language called Ook [1]. We could actually grep stuff even in
with this because format strings are preserved.

Long term, we could implement an "ook translator" for test_i18ngrep
and friends so that they translate English to Ook, allowing us to
match full text while making sure the text in the code is still marked
for translation.

[1] https://en.wikipedia.org/wiki/Unseen_University#Librarian

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This started out as something fun to do while running the test suite
 last weekend. But it turns out actually working! If this patch ends
 up in git.git, the Librarian would be so proud!

 gettext.c       | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 gettext.h       |  7 ++++---
 t/lib-rebase.sh |  2 +-
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/gettext.c b/gettext.c
index 7272771c8e..29901e1ddd 100644
--- a/gettext.c
+++ b/gettext.c
@@ -56,6 +56,60 @@ int use_gettext_poison(void)
 }
 #endif
 
+const char *gettext_poison(const char *msgid)
+{
+	/*
+	 * gettext() returns a string that is always valid. We would
+	 * need a hash map for that but let's stay simple and keep the
+	 * last 64 gettext() results. Should be more than enough.
+	 */
+	static char *bufs[64];
+	static int i;
+	struct strbuf sb = STRBUF_INIT;
+	char *buf;
+	const char *p;
+	const char *type_specifiers = "diouxXeEfFgGaAcsCSpnm%";
+
+	if (!strchr(msgid, '%'))
+		return "Eek!";
+
+	p = msgid;
+	while (*p) {
+		const char *type;
+		switch (*p) {
+		case '%':
+			/*
+			 * No strict parsing. We simply look for the end of a
+			 * format string
+			 */
+			type = p + 1;
+			while (*type && !strchr(type_specifiers, *type))
+				type++;
+			if (*type)
+				type++;
+			strbuf_add(&sb, p, (int)(type - p));
+			p = type;
+			break;
+		default:
+			if (!isalpha(*p)) {
+				strbuf_addch(&sb, *p);
+				p++;
+				break;
+			}
+			if (isupper(*p))
+				strbuf_addstr(&sb, "Ook");
+			else
+				strbuf_addstr(&sb, "ook");
+			while (isalpha(*p))
+				p++;
+		}
+	}
+	buf = bufs[(i++) % ARRAY_SIZE(bufs)];
+	free(buf);
+	buf = strbuf_detach(&sb, NULL);
+	return buf;
+}
+
 #ifndef NO_GETTEXT
 static int test_vsnprintf(const char *fmt, ...)
 {
diff --git a/gettext.h b/gettext.h
index 7eee64a34f..dc9851a06a 100644
--- a/gettext.h
+++ b/gettext.h
@@ -41,8 +41,9 @@ static inline int gettext_width(const char *s)
 }
 #endif
 
+const char *gettext_poison(const char *);
 #ifdef GETTEXT_POISON
-extern int use_gettext_poison(void);
+int use_gettext_poison(void);
 #else
 #define use_gettext_poison() 0
 #endif
@@ -51,14 +52,14 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
 	if (!*msgid)
 		return "";
-	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+	return use_gettext_poison() ? gettext_poison(msgid) : gettext(msgid);
 }
 
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
 const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
 	if (use_gettext_poison())
-		return "# GETTEXT POISON #";
+		return gettext_poison(msgid);
 	return ngettext(msgid, plu, n);
 }
 
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 2ca9fb69d6..1e8440e935 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -29,7 +29,7 @@ set_fake_editor () {
 	*/COMMIT_EDITMSG)
 		test -z "$EXPECT_HEADER_COUNT" ||
 			test "$EXPECT_HEADER_COUNT" = "$(sed -n '1s/^# This is a combination of \(.*\) commits\./\1/p' < "$1")" ||
-			test "# # GETTEXT POISON #" = "$(sed -n '1p' < "$1")" ||
+			test "$EXPECT_HEADER_COUNT" = "$(sed -n '1s/^# Ook ook ook ook ook \(.*\) ook\./\1/p' < "$1")" ||
 			exit
 		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
 		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
-- 
2.19.1.647.g708186aaf9

