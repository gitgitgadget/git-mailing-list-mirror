Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3F920323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdCRKed (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:34:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36275 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdCRKeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:34:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id x124so6815010wmf.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0Yafzc20o1QNVs8TVRSdwLRdcNByIw3SrNHD37WSjA=;
        b=SmZ5OpriGFvJU0g75DYfqHakZxfe9tZOk0WxaaNz0upUY46GWIMs8p6Q+Di802s993
         GZe3unuDzX7t8yiGgqfjEcLeyNQ21RXhEQLSPCZNoAZ9njzKy6pZ9N/QQ06GqlS64LvY
         iVohGzby8RiseUt6UaRquvCBAvIVbZHvSoZxsAumdCGy6DztrE5MZvKkRtl0ZDCQ/Wyx
         V96UihO0qIs6SfZlac4CC/LoYKykZ5SVJXPGNvuIXgE75kf6ah+tMTSJClQeC5xJHmlZ
         5he5/IqacAtLTUVjaA66W/tiCZnyhBwO5MjOvv7HP8zHJAcCWM/u8g9LWfPcwNUE8jeT
         UrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0Yafzc20o1QNVs8TVRSdwLRdcNByIw3SrNHD37WSjA=;
        b=kR1GuVuG6Apf3Rvn4/tJuirr0WEj374MftPf2R8kXxDELm9xm+hrkStnskdEtnlcQN
         wdn4ZoM596SHfOh8VSp5QRdOepAmgKvJX0RGNtkRnWDh5jlouOZYZqFQF6LBhhjKJn5H
         deHiZ198cDNeEGclyrR7uAK15JzHnGm0vsw3Ruv2tfb1RJE5Fytz653utUOw2TD25Q6z
         URcQibb1gKECvBDyJHjPy2JVe0ulCWQI7oOkSWAGivr7uiesuGHdrXm9ZOJ66V7C/Sqm
         zuX1e9/kfTKGrsfiksu8tFyvFZB7H05F3zuihEb5BErZWFaeFIEAQP1XyDjnNrgFacYB
         mnzQ==
X-Gm-Message-State: AFeK/H1emiW/jmFIK0fUEWtY9EG9Jz+Rj4gvFHmKBry8BrXLpeJVgGDtV6iG+i72R9MLRA==
X-Received: by 10.28.84.18 with SMTP id i18mr2242852wmb.12.1489833214015;
        Sat, 18 Mar 2017 03:33:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j34sm13007928wre.7.2017.03.18.03.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 03:33:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] tag: Change  misleading --list <pattern> documentation
Date:   Sat, 18 Mar 2017 10:32:51 +0000
Message-Id: <20170318103256.27141-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318103256.27141-1-avarab@gmail.com>
References: <20170318103256.27141-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation for --list so that it's described as a
toggle, not as an option that takes a <pattern> as an argument.

Junio initially documented this in b867c7c23a ("git-tag: -l to list
tags (usability).", 2006-02-17), but later Jeff King changed "tag" to
accept multiple patterns in 588d0e834b ("tag: accept multiple patterns
for --list", 2011-06-20).

However, documenting this as "-l <pattern>" was never correct, as
these both worked before Jeff's change:

    git tag -l 'v*'
    git tag 'v*' -l

One would expect an option that was documented like that to only
accept:

    git tag --list
    git tag --list 'v*rc*'

And after Jeff's change, one that took multiple patterns:

    git tag --list 'v*rc*' --list '*2.8*'

But since it's actually a toggle all of these work as well, and
produce identical output to the last example above:

    git tag --list 'v*rc*' '*2.8*'
    git tag --list 'v*rc*' '*2.8*' --list --list --list
    git tag --list 'v*rc*' '*2.8*' --list -l --list -l --list

Now the documentation is more in tune with how the "branch" command
describes its --list option since commit cddd127b9a ("branch:
introduce --list option", 2011-08-28).

Change the test suite to assert that these invocations work for the
cases that weren't already being tested for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 16 +++++++++-------
 t/t7004-tag.sh            | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 525737a5d8..848e8c1b73 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -87,13 +87,15 @@ OPTIONS
 	If no number is given to `-n`, only the first line is printed.
 	If the tag is not annotated, the commit message is displayed instead.
 
--l <pattern>::
---list <pattern>::
-	List tags with names that match the given pattern (or all if no
-	pattern is given).  Running "git tag" without arguments also
-	lists all tags. The pattern is a shell wildcard (i.e., matched
-	using fnmatch(3)).  Multiple patterns may be given; if any of
-	them matches, the tag is shown.
+-l::
+--list::
+	Activate the list mode. `git tag <pattern>` would try to create a
+	tag, use `git tag --list <pattern>` to list matching branches, (or
+	all if no pattern is given).
++
+Running "git tag" without arguments also lists all tags. The pattern
+is a shell wildcard (i.e., matched using fnmatch(3)). Multiple
+patterns may be given; if any of them matches, the tag is shown.
 
 --sort=<key>::
 	Sort based on the key given.  Prefix `-` to sort in
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 74fc82a3c0..d36cd51fe2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -118,6 +118,18 @@ test_expect_success 'listing all tags if one exists should succeed' '
 	git tag
 '
 
+cat >expect <<EOF
+mytag
+EOF
+test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
+	git tag -l -l >actual &&
+	test_cmp expect actual &&
+	git tag --list --list >actual &&
+	test_cmp expect actual &&
+	git tag --list -l --list >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'listing all tags if one exists should output that tag' '
 	test $(git tag -l) = mytag &&
 	test $(git tag) = mytag
@@ -336,6 +348,15 @@ test_expect_success 'tag -l can accept multiple patterns' '
 	test_cmp expect actual
 '
 
+test_expect_success 'tag -l can accept multiple patterns interleaved with -l or --list options' '
+	git tag -l "v1*" "v0*" >actual &&
+	test_cmp expect actual &&
+	git tag -l "v1*" --list "v0*" >actual &&
+	test_cmp expect actual &&
+	git tag -l "v1*" "v0*" -l --list >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'listing tags in column' '
 	COLUMNS=40 git tag -l --column=row >actual &&
 	cat >expected <<\EOF &&
-- 
2.11.0

