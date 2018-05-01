Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA97215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeEASlP (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:41:15 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37285 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756495AbeEASlA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:41:00 -0400
Received: by mail-wm0-f52.google.com with SMTP id l1so20379592wmb.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kmD7MXxBCcVHXpa3214z3qUcEA1ETIFMyrBx0VmYYdc=;
        b=LCR5JI1NNbCniAGCqNZR7eb4JMowQ0s0Kayd3U74bDnNItfscTf3c/zxHZ+2xGCgL6
         InSiGSlutuyls9kVFRoq9t5DcAFetvQ4cQW3rHQx2fvfw/Ger9KpftPzosqpqXjVpVLd
         vxIWvVWoxJPfUeNMweGqQ3CCwjGjEbpSDl3nVothgSDQMJBBaXjsTuuRjFMLnDteNtR4
         V5YvX/b0qi0lMGsMyY4HQZl6/M+rpNljIdmPkHhYPrrh366geO2dzHlhZYkJ3JDoRBV8
         qDHX9Aaxowaaptlvt/xbV85UC6vd+0BzdaXgNvEhyOKd1qNzjLPo1Ah9LZIMT9dSsFpK
         InwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kmD7MXxBCcVHXpa3214z3qUcEA1ETIFMyrBx0VmYYdc=;
        b=VStviD+qI0s8HMpcNgfLzOX1AI5IDsCyH7pxaXTks7CCXdzCwJQSy9fNh7sfUYiEcy
         5Q3f8gTRnz4YZxDEwS8io8T81YxgnIje/vp4R3KIJr0xY4tgXjoZMJvgbSw/G7qhRu+j
         JTmEhfBBaq7S12i2i0icHupC0dI0PHQaJwraE2lpqU6JPBYWKkRj8uDXKHr7YMS/U1nl
         OnR6dRbjd1QUWVAkqAUbW16d2m99YmpWxMo9iCbByI2Ljel9tnO0hR0BJnpg8v2VUrb6
         XJ1F+oGhTbra1lpAR0Frc727gF9n8DPOtkJwvei4NU6lslyiqZoRXveQY+QTnKdCqh5u
         l1OQ==
X-Gm-Message-State: ALQs6tCpHkCxQEd95EGbIClHBxTXfqdXGJPIdMVSxRBVQFDPwXp2Jodp
        XDZ/1hJ4hU1rOXd4YZ7ina00/7VV
X-Google-Smtp-Source: AB8JxZrP5CJUaAmwa/ekAB1magOHs8Hd7UDBHgDRzXIGS/PB3hs35JvvXH06paYdeRxnGAwbH8cmSg==
X-Received: by 10.28.145.196 with SMTP id t187mr9785138wmd.19.1525200058722;
        Tue, 01 May 2018 11:40:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/12] get_short_oid: document & warn if we ignore the type selector
Date:   Tue,  1 May 2018 18:40:16 +0000
Message-Id: <20180501184016.15061-13-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The SHA1 prefix 06fa currently matches no blobs in git.git. When
disambiguating short SHA1s we've been quietly ignoring the user's type
selector as a fallback mechanism, this was intentionally added in
1ffa26c461 ("get_short_sha1: list ambiguous objects on error",
2016-09-26).

I think that behavior makes sense, it's not very useful to just show
nothing because a preference has been expressed via core.disambiguate,
but it's bad that we're quietly doing this. The user might thing that
we just didn't understand what e.g 06fa^{blob} meant.

Now we'll instead print a warning if no objects of the requested type
were found:

    $ git rev-parse 06fa^{blob}
    error: short SHA1 06fa is ambiguous
    hint: The candidates are:
    [... no blobs listed ...]
    warning: Your hint (via core.disambiguate or peel syntax) was ignored, we fell
    back to showing all object types since no object of the requested type
    matched the provide short SHA1 06fa

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt            |  4 ++++
 sha1-name.c                         | 11 ++++++++++-
 t/t1512-rev-parse-disambiguation.sh |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 14a3d57e77..e14f2c0492 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -922,6 +922,10 @@ Is set to `none` by default to show all object types. Can also be
 tags), `tree` (peel: `$sha1^{tree}`), `treeish` (everything except
 blobs, peel syntax: `$sha1:`), `blob` (peel: `$sha1^{blob}`) or `tag`
 (peel: `$sha1^{tag}`). The peel syntax will override any config value.
++
+If no objects of the selected type exist the disambiguation will fall
+back to `none` and print a warning indicating no objects of the
+selected type could be found for that prefix.
 
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
diff --git a/sha1-name.c b/sha1-name.c
index 1d2a74a29c..9789764a38 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -447,6 +447,7 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
+		int ignored_hint = 0;
 
 		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
 
@@ -456,8 +457,10 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 		 * that case, we still want to show them, so disable the hint
 		 * function entirely.
 		 */
-		if (!ds.ambiguous)
+		if (!ds.ambiguous) {
 			ds.fn = NULL;
+			ignored_hint = 1;
+		}
 
 		advise(_("The candidates are:"));
 		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
@@ -466,6 +469,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
 		oid_array_clear(&collect);
+
+		if (ignored_hint) {
+			warning(_("Your hint (via core.disambiguate or peel syntax) was ignored, we fell\n"
+				  "back to showing all object types since no object of the requested type\n"
+				  "matched the provide short SHA1 %s"), ds.hex_pfx);
+		}
 	}
 
 	return status;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index b17973a266..940f323ee9 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -359,7 +359,10 @@ test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
 	echo 872 | git hash-object --stdin -w &&
 	test_must_fail git rev-parse ee3d^{commit} 2>stderr &&
 	grep ^hint: stderr >hints &&
-	test_line_count = 3 hints
+	test_line_count = 3 hints &&
+	grep ^warning stderr >warnings &&
+	grep -q "Your hint.*was ignored" warnings &&
+	grep -q "the provide short SHA1 ee3d" stderr
 '
 
 test_expect_success 'core.disambiguate config can prefer types' '
-- 
2.17.0.290.gded63e768a

