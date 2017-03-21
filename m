Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5022095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757347AbdCUNBL (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35330 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757160AbdCUNAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so2789206wmb.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2eKqF9ezegZh4sYSNlQiLzoQZGjRLSyBR8F/Ct3tleI=;
        b=G4JnFkzyJYmGsNASeH5HGXqguRAyad2XGWBhx+IEZ3R3rSVlqsFnqJ0fxl0CkLVugP
         ER5Ldj+eIxkewxwSmE7QeFuRTOKecmkKRRKgf43F8epLBH0PWmqqkJV2bP9SfbOIfXZ0
         EBfu/Z5IF+uAHeT84sj+3naw4B9y/VPfbbFuIakberKu150GnJQtDodioxNzVzJiOu7x
         ubukEt9NWKPv55mNOu74uTAXv2claAN6FoaNZ7nUlf2COmQsc0k192QZXb9qiB9utf8x
         uWaXwativzs+ZvDknv8Yc84ObMCH0uwGx0EUqME3s+3d0j0zzfs2Q+WRNlvS9ADwlAGw
         wBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eKqF9ezegZh4sYSNlQiLzoQZGjRLSyBR8F/Ct3tleI=;
        b=HXV2461ZeGTP0GSKV1wBUG1hRt7TiczxMRH97bx0Sw4lmwAkYIZTq1JH+3n+lJJOsI
         /WxALx0x6lsdSwQgbS3ox242tkScRqCjDXT27pTBMnv5bLeA98UE5I0c0TnANtjt666x
         5IOYs+hve38C4s3p3a8d8QEqIIgpeDWrrL2jEm7nSHrIGgW+E0svnxT5pWMuDH5As12p
         ukUo+Re8dex2VKfFXbjyBrHq7fNCWB8PO78U84/w1vQtonrJ3JluIwXj8KbxvMuA8JsO
         MMAHT2yaCL27u8h5FH3swKa4A6dDpzeBZslFuK4VUgM3nOZeYY05QV/2j5K7odDIU/72
         H7hw==
X-Gm-Message-State: AFeK/H1DzuTrK6fC8ehwK6rpIuNw5ozae+5Wjd/UKQ+DIV5fWzfVz8aZyxxTObB8vSu1OA==
X-Received: by 10.28.141.143 with SMTP id p137mr2799205wmd.62.1490101233535;
        Tue, 21 Mar 2017 06:00:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/16] tag: change misleading --list <pattern> documentation
Date:   Tue, 21 Mar 2017 12:58:55 +0000
Message-Id: <20170321125901.10652-11-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
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
index 448fdf3743..d534c57156 100644
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
index 958c77ab86..1de7185be0 100755
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

