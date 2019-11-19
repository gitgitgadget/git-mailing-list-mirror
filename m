Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A011F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKSAVc (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:32 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:40864 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:32 -0500
Received: by mail-pl1-f179.google.com with SMTP id e3so10718793plt.7
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ry3zCFWg3jwqcvR4oGYIQO57NS+bZWGf3I2u0FiwZkI=;
        b=USNnnL/MDdJP3WYHFuwmbPLmpAnB8V+4LSJJyI3TBhjwQisFSGLDlTxWOu5V7DHOYF
         GJEk8pTkPOtxQOhuvW7nWup8yX1+ivzcK9Rr+3g+C7cU16UAAEhY8PHCVWVL2ZFIjYu4
         kmo9pMzKw0+n6/vWErThaFtjrqApI2L8siv3vMeQ3Mkm8ZyIK4XFRYmSvddRls8R8Jix
         RoER6kxqW5Tb6DMP0E2wZlU0qUxwds3d6ybhVcyyvc7GnB2Ikbx7LxnoY/sX5GVJsart
         sBm60vP5akX5VZ1D/9TsRwXLQv6dwbq2eRfMP0+eI5WeBL0FzjKbZpTuS4a9s5fSnUyw
         pCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ry3zCFWg3jwqcvR4oGYIQO57NS+bZWGf3I2u0FiwZkI=;
        b=o59aO8is4XMJmPBH1WO7ALtLudhVkdtSS1zxNzRcFjk3RLiZgUq1EkY9OK70JbixU2
         BgryI9/OzTbYGqqmG6SH5v6fJSYAYT1zl3a2coi2qz67xqAv3QXw5sUqBnPMWOXsoa0g
         bSZeb6C/jWIULMFb8Hy6OwCrEtOZyUVVqBS/2nk/5hp4Wea6KG8Re5e7icz2zEBRhbTm
         cXRqWwwlSUMhV9Ub48ZZ+Lvmc7mYtL7eKJwt2DUCC505deRw5fZ0Kt7rZ0BFl2ZHzVCL
         P5607aq4ipiJMtgiyy01Frihvlp7U42LjzmpmvkJrxUhtfUxEnDx1aqrCQH37OHteQHM
         7IYw==
X-Gm-Message-State: APjAAAXc7PbQ88m5q1OaKEKOE0ubu1tqnYbynsgDbTKugIxQcuKjPvt4
        /jL4kgnQ7kbt2cg4oBbqWPoX/sbd
X-Google-Smtp-Source: APXvYqxfdC64avEkdy1W/5uXP/tpODOofS1/LqTTLZ3HF+icwPTrtueZ4AXNwxDFz3bj4JzUxu0v0w==
X-Received: by 2002:a17:90a:3522:: with SMTP id q31mr2394230pjb.18.1574122890672;
        Mon, 18 Nov 2019 16:21:30 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id l10sm166066pjw.6.2019.11.18.16.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:29 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 08/11] pretty: provide short date format
Message-ID: <9d4dfcc11542a31432d19c4607eb616869e6089e.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Add the placeholders %as and %cs to format author date and committer
date, respectively, without the time part, like --date=short does, i.e.
like YYYY-MM-DD.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-formats.txt | 2 ++
 pretty.c                         | 3 +++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 4cefa64eeb..11979301ff 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -172,6 +172,7 @@ The placeholders are:
 '%at':: author date, UNIX timestamp
 '%ai':: author date, ISO 8601-like format
 '%aI':: author date, strict ISO 8601 format
+'%as':: author date, short format (`YYYY-MM-DD`)
 '%cn':: committer name
 '%cN':: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -187,6 +188,7 @@ The placeholders are:
 '%ct':: committer date, UNIX timestamp
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
+'%cs':: committer date, short format (`YYYY-MM-DD`)
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
 '%S':: ref name given on the command line by which the commit was reached
diff --git a/pretty.c b/pretty.c
index 4d633f14fa..4d7f5e9aab 100644
--- a/pretty.c
+++ b/pretty.c
@@ -738,6 +738,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'I':	/* date, ISO 8601 strict */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
+	case 's':
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
+		return placeholder_len;
 	}
 
 skip:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 0335b428b1..da9cacffea 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -533,6 +533,12 @@ test_expect_success 'ISO and ISO-strict date formats display the same values' '
 	test_cmp expected actual
 '
 
+test_expect_success 'short date' '
+	git log --format=%ad%n%cd --date=short >expected &&
+	git log --format=%as%n%cs >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 test_expect_success 'set up log decoration tests' '
 	head1=$(git rev-parse --verify HEAD~0) &&
-- 
2.24.0.420.g9ac4901264

