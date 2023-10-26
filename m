Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA493F4DC
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N11AfmIK"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1859C1B9
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 16:16:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41b406523fcso10644641cf.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698362172; x=1698966972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nboWB7crZiunHNO3kcoSvfLRGW5dnFd7i5AGlZ3T5G0=;
        b=N11AfmIKn8czgiw9eybj91MPkBw4dtDOqRROEohTvaBh/OFswBNK3y8bGNOw357GdO
         XPu30z9LPeYRtwIl6SrSsVvu9U0ScXJZDpx6WkkH6I5TCsrgmioAaQuibltU6WZVZh/n
         jkAl6VQoVWjA+Qi9tcqncaMXqyH824ixTSxqJiytEr7LlhpsMSnmyqzfnLy3ASIu6DaP
         cB/lYgjc4N9g6nPtamQ1H2PYbxYIP/dUhSTD+/fHZSrDRX71/M5pepad1RA/MGo9XlXm
         VlfZrejeWjW3/bl5Og6FfpMdXzim5eOQ14lERwDdy3eAubQ0jo1WILded9YH8JePLt8r
         MQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698362172; x=1698966972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nboWB7crZiunHNO3kcoSvfLRGW5dnFd7i5AGlZ3T5G0=;
        b=GC+W0mL1I7rRjnRghxlIjXSz92+4hcqCaINIghj4bCzK3cCnrN4wwsbMN/qDC3FiJo
         INr0HqJZJNk/h+jJmOc3eIUZ9dnYNShg1QYO5gWF0mkcJVeUjmD/Y1G2oPrg1rlK90Qf
         FapDbdbgS8tttnNcYM7/6iQQ3YdArnT0gehaXPA0G2m5uUOXFhY3l/xepsktF61Ql4q+
         ZbV1u+RZzYYFg2qfa7P04EIsAXAd0liubBIRsDPCtDRxtOWrxcADxZsJ92PltHmAKvlg
         6NxRjOAFObaF0+w2mHv5BpJf/uDguq6B7ydlGVQimHXMLoYZkrq1w2js6M3npXiI/heb
         zjeA==
X-Gm-Message-State: AOJu0YzoV3TVI6njpFLOECnUr32hjqDooWcpkY4Ir3oLCNe+q8D2BsyI
	w+NdQ5tc5rFiMmpqG+MV3c85/B92320=
X-Google-Smtp-Source: AGHT+IGqql5iGcCe/HBcu37P0SFPkvDutC4+8LpAkf4thqyECUJFvUWUaNYGaOseRyEwZjDpqNRLEw==
X-Received: by 2002:a05:622a:547:b0:41c:dbdb:7ff5 with SMTP id m7-20020a05622a054700b0041cdbdb7ff5mr1218998qtx.33.1698362171687;
        Thu, 26 Oct 2023 16:16:11 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id do10-20020a05622a478a00b004181b41e793sm132459qtb.50.2023.10.26.16.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 16:16:11 -0700 (PDT)
From: Liam Beguin <liambeguin@gmail.com>
Date: Thu, 26 Oct 2023 19:16:05 -0400
Subject: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
References: <20231026-pretty-email-domain-v1-0-5d6bfa6615c0@gmail.com>
In-Reply-To: <20231026-pretty-email-domain-v1-0-5d6bfa6615c0@gmail.com>
To: git@vger.kernel.org
Cc: Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698362168; l=5513;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=opGL40SnDup62JHf38SYwT4FAjEWSBkGCGS2aNYnXzo=;
 b=6L2Kphrq9BcctJ5UJWmEI10g0U+GFiFjY7HROgoGElnnFmJrCkbdDw+GWSRnmGfZgYQHQMJ+u
 6uenXp9l9GoBxQvtAlGpFd8D2ObUyI3Gw367uv91MhaaaC6QZp3Apn+
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=

Many reports use the email domain to keep track of organizations
contributing to projects.
Add support for formatting the domain-part of a contributor's address so
that this can be done using git itself, with something like:

	git shortlog -sn --group=format:%aA v2.41.0..v2.42.0

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/pretty-formats.txt |  6 ++++++
 pretty.c                         | 13 ++++++++++++-
 t/t4203-mailmap.sh               | 28 ++++++++++++++++++++++++++++
 t/t6006-rev-list-format.sh       |  6 ++++--
 4 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index a22f6fceecdd..72102a681c3a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -195,6 +195,9 @@ The placeholders are:
 '%al':: author email local-part (the part before the '@' sign)
 '%aL':: author email local-part (see '%al') respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%aa':: author email domain-part (the part after the '@' sign)
+'%aA':: author email domain-part (see '%al') respecting .mailmap, see
+	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%ad':: author date (format respects --date= option)
 '%aD':: author date, RFC2822 style
 '%ar':: author date, relative
@@ -213,6 +216,9 @@ The placeholders are:
 '%cl':: committer email local-part (the part before the '@' sign)
 '%cL':: committer email local-part (see '%cl') respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%ca':: committer email domain-part (the part before the '@' sign)
+'%cA':: committer email domain-part (see '%cl') respecting .mailmap, see
+	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%cd':: committer date (format respects --date= option)
 '%cD':: committer date, RFC2822 style
 '%cr':: committer date, relative
diff --git a/pretty.c b/pretty.c
index cf964b060cd1..4f5d081589ea 100644
--- a/pretty.c
+++ b/pretty.c
@@ -791,7 +791,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	mail = s.mail_begin;
 	maillen = s.mail_end - s.mail_begin;
 
-	if (part == 'N' || part == 'E' || part == 'L') /* mailmap lookup */
+	if (part == 'N' || part == 'E' || part == 'L' || part == 'A') /* mailmap lookup */
 		mailmap_name(&mail, &maillen, &name, &namelen);
 	if (part == 'n' || part == 'N') {	/* name */
 		strbuf_add(sb, name, namelen);
@@ -808,6 +808,17 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		strbuf_add(sb, mail, maillen);
 		return placeholder_len;
 	}
+	if (part == 'a' || part == 'A') {	/* domain-part */
+		const char *at = memchr(mail, '@', maillen);
+		if (at) {
+			at += 1;
+			maillen -= at - mail;
+			strbuf_add(sb, at, maillen);
+		} else {
+			strbuf_add(sb, mail, maillen);
+		}
+		return placeholder_len;
+	}
 
 	if (!s.date_begin)
 		goto skip;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 2016132f5161..35bf7bb05bea 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -624,6 +624,34 @@ test_expect_success 'Log output (local-part email address)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Log output (domain-part email address)' '
+	cat >expect <<-EOF &&
+	Author email cto@coompany.xx has domain-part coompany.xx
+	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
+
+	Author email me@company.xx has domain-part company.xx
+	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
+
+	Author email me@company.xx has domain-part company.xx
+	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
+
+	Author email nick2@company.xx has domain-part company.xx
+	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
+
+	Author email bugs@company.xx has domain-part company.xx
+	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
+
+	Author email bugs@company.xx has domain-part company.xx
+	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
+
+	Author email author@example.com has domain-part example.com
+	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
+	EOF
+
+	git log --pretty=format:"Author email %ae has domain-part %aa%nCommitter email %ce has domain-part %ca%n" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Log output with --use-mailmap' '
 	test_config mailmap.file complex.map &&
 
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 573eb97a0f7f..34c686becf2d 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -163,11 +163,12 @@ commit $head1
 EOF
 
 # we don't test relative here
-test_format author %an%n%ae%n%al%n%ad%n%aD%n%at <<EOF
+test_format author %an%n%ae%n%al%aa%n%ad%n%aD%n%at <<EOF
 commit $head2
 $GIT_AUTHOR_NAME
 $GIT_AUTHOR_EMAIL
 $TEST_AUTHOR_LOCALNAME
+$TEST_AUTHOR_DOMAIN
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
@@ -180,11 +181,12 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
 
-test_format committer %cn%n%ce%n%cl%n%cd%n%cD%n%ct <<EOF
+test_format committer %cn%n%ce%n%cl%ca%n%cd%n%cD%n%ct <<EOF
 commit $head2
 $GIT_COMMITTER_NAME
 $GIT_COMMITTER_EMAIL
 $TEST_COMMITTER_LOCALNAME
+$TEST_COMMITTER_DOMAIN
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993

-- 
2.39.0

