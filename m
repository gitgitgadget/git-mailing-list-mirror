Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAA820958
	for <e@80x24.org>; Sun, 26 Mar 2017 12:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdCZMR1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 08:17:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35789 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdCZMR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 08:17:26 -0400
Received: by mail-wr0-f194.google.com with SMTP id p52so1962857wrc.2
        for <git@vger.kernel.org>; Sun, 26 Mar 2017 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tONvAOWkmtyvqQQItHbmHA64HryYXtfTxhNO3U0xxIc=;
        b=nY7I2C+18/tD/O4iB8W6nk6OuFLeDBUtWt983medINGFjqu/SX/JVCO+lYUh2uOw9Y
         ETIurLol78UvMiT1dwYj9NHmgAjamgBPvbDkJrmekqzkiw1WluWR5kFS6HCyp+wP6rWs
         TyoKGYR3Te69ceSWE4GrKfflWzrLQ4cNM6pm+8whgxmOT414dZlOlLKlgNZhCxt8AUnF
         ze1HN/AEyIjLa6w02DJhRYDw73Rk+IbcBBG2sdN2p37errMxSZMKi6hk6+lR0eFqE6ge
         PKnWHc+gjlEzNI6K03AeD6B+DZaao9MMdZoY9YcJ4eVJpe9FzjZQ7Llqe8kN5wlYmgCe
         2Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tONvAOWkmtyvqQQItHbmHA64HryYXtfTxhNO3U0xxIc=;
        b=tfJw4CUCe7q1Jj3dG+Slx84t4DE6Fu/huBFMv8eMY2YLfvtDIgzLpButTg+pZnZ9w3
         idCumNnETzpBivSLLuTYXbApuH8IEOZDIkc+BUB03UqJ/Nm2CM+BPy3OMpzPyv/sG5l2
         8CDQygp0Rz2U+xxmQ0np+KL0z/RFn3vyucE/GFSv4h5VVeV3GRuwYJWPML4eEq6sRZ0m
         +7J4R3G6bOW8437x/VsSzWcjCQLkyGcBtd8AdJJEAR82iGIGlWmxLrEoe/FtXETL5KI+
         PHTKtnCcZ0LmbGfdA65KNQKrmRoZvj37jOKi7gER419SdXJlEfh0jSMHKck34BsB3i19
         ZFWQ==
X-Gm-Message-State: AFeK/H0obw0yh57Y9eF85sCMqkgQsIswOmHZR5/V/lcxM1mj/m4VT2VBZ4MuPjp6dD5RJQ==
X-Received: by 10.28.111.151 with SMTP id c23mr5483053wmi.17.1490530629060;
        Sun, 26 Mar 2017 05:17:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 134sm10167638wmj.6.2017.03.26.05.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 05:17:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] rev-parse: match ^{<type>} case-insensitively
Date:   Sun, 26 Mar 2017 12:16:54 +0000
Message-Id: <20170326121654.22035-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326121654.22035-1-avarab@gmail.com>
References: <20170326121654.22035-1-avarab@gmail.com>
In-Reply-To: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
References: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the revision parsing logic to match ^{commit}, ^{tree}, ^{blob}
etc. case-insensitively.

Before this change supplying anything except the lower-case forms
emits an "unknown revision or path not in the working tree"
error. This change makes upper-case & mixed-case versions equivalent
to the lower-case versions.

The rationale for this change is the same as for making @{upstream}
and related suffixes case-insensitive in "rev-parse: match
@{upstream}, @{u} and @{push} case-insensitively", but unlike those
suffixes this change introduces the potential confusion of accepting
TREE or BLOB here, but not as an argument to e.g. "cat-file -t <type>"
or "hash-object -t <type>".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/revisions.txt |  5 +++++
 git-compat-util.h           |  1 +
 sha1_name.c                 | 10 +++++-----
 strbuf.c                    |  9 +++++++++
 t/t1450-fsck.sh             |  7 +++++++
 t/t1511-rev-parse-caret.sh  | 13 +++++++++++++
 6 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 5fe90e411d..136e26c05d 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -162,6 +162,11 @@ it does not have to be dereferenced even once to get to an object.
 +
 'rev{caret}\{tag\}' can be used to ensure that 'rev' identifies an
 existing tag object.
++
+The {caret}{<type>} part is matched case-insensitively. So
+e.g. '{caret}\{commit\}' can be equivalently specified as
+'{caret}\{COMMIT\}', '{caret}\{Commit\}' etc., '{caret}\{tree\}' as
+'{caret}\{TREE\}' and so forth.
 
 '<rev>{caret}{}', e.g. 'v0.99.8{caret}{}'::
   A suffix '{caret}' followed by an empty brace pair
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..4a03934ef3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -448,6 +448,7 @@ extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
 extern int starts_with(const char *str, const char *prefix);
+extern int starts_with_icase(const char *str, const char *prefix);
 
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
diff --git a/sha1_name.c b/sha1_name.c
index 2deb9bfdf6..107246bd2d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -821,15 +821,15 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 		return -1;
 
 	sp++; /* beginning of type name, or closing brace for empty */
-	if (starts_with(sp, "commit}"))
+	if (starts_with_icase(sp, "commit}"))
 		expected_type = OBJ_COMMIT;
-	else if (starts_with(sp, "tag}"))
+	else if (starts_with_icase(sp, "tag}"))
 		expected_type = OBJ_TAG;
-	else if (starts_with(sp, "tree}"))
+	else if (starts_with_icase(sp, "tree}"))
 		expected_type = OBJ_TREE;
-	else if (starts_with(sp, "blob}"))
+	else if (starts_with_icase(sp, "blob}"))
 		expected_type = OBJ_BLOB;
-	else if (starts_with(sp, "object}"))
+	else if (starts_with_icase(sp, "object}"))
 		expected_type = OBJ_ANY;
 	else if (sp[0] == '}')
 		expected_type = OBJ_NONE;
diff --git a/strbuf.c b/strbuf.c
index ace58e7367..7d4a59bca6 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,6 +11,15 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int starts_with_icase(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 1;
+		else if (tolower(*str) != tolower(*prefix))
+			return 0;
+}
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 33a51c9a67..b6c1989671 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -505,6 +505,13 @@ test_expect_success 'fsck notices missing tagged object' '
 	test_must_fail git -C missing fsck
 '
 
+test_expect_success 'fsck notices missing tagged object with case insensitive {blob}' '
+	create_repo_missing tag^{BLOB} &&
+	test_must_fail git -C missing fsck &&
+	create_repo_missing tag^{BloB} &&
+	test_must_fail git -C missing fsck
+'
+
 test_expect_success 'fsck notices ref pointing to missing commit' '
 	create_repo_missing HEAD &&
 	test_must_fail git -C missing fsck
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e0a49a651f..56750f99c6 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -48,6 +48,10 @@ test_expect_success 'ref^{commit}' '
 	git rev-parse ref >expected &&
 	git rev-parse ref^{commit} >actual &&
 	test_cmp expected actual &&
+	git rev-parse ref^{COMMIT} >actual &&
+	test_cmp expected actual &&
+	git rev-parse ref^{CoMMiT} >actual &&
+	test_cmp expected actual &&
 	git rev-parse commit-tag^{commit} >actual &&
 	test_cmp expected actual &&
 	test_must_fail git rev-parse tree-tag^{commit} &&
@@ -58,6 +62,10 @@ test_expect_success 'ref^{tree}' '
 	echo $TREE_SHA1 >expected &&
 	git rev-parse ref^{tree} >actual &&
 	test_cmp expected actual &&
+	git rev-parse ref^{TREE} >actual &&
+	test_cmp expected actual &&
+	git rev-parse ref^{TrEe} >actual &&
+	test_cmp expected actual &&
 	git rev-parse commit-tag^{tree} >actual &&
 	test_cmp expected actual &&
 	git rev-parse tree-tag^{tree} >actual &&
@@ -67,8 +75,13 @@ test_expect_success 'ref^{tree}' '
 
 test_expect_success 'ref^{tag}' '
 	test_must_fail git rev-parse HEAD^{tag} &&
+	test_must_fail git rev-parse HEAD^{TAG} &&
 	git rev-parse commit-tag >expected &&
 	git rev-parse commit-tag^{tag} >actual &&
+	test_cmp expected actual &&
+	git rev-parse commit-tag^{TAG} >actual &&
+	test_cmp expected actual &&
+	git rev-parse commit-tag^{Tag} >actual &&
 	test_cmp expected actual
 '
 
-- 
2.11.0

