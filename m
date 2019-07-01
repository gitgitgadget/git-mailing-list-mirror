Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC0B1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfGAVVR (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56147 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so872903wmj.5
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eXnMdLmuMsCvL2a+Rs3FbD+F0m7k0TY93UGAJ8b4tjo=;
        b=VLstUddyi1x2sHCke0f5lzzUURH+cnJpprdwUhOf0WqkXXuSX9dNb9cLbMtUyvDNBP
         m8McpECvsel/9JubjITJR3u2RT8mtNbthrcj7JZVSWV+dDvwQTKEJj2xLMgj4+xWpUQj
         e7r64gOl5tGQTGcKk2hpuT39qO7GHAmQfIYfAH16MPY6S8+BrYIYij9i5HED83HNkTK8
         XRIvibq0bhSn/2qjXZx4xR4unjxmSjI/VgPK4nhaJtPyGgm49FMPIW6UIpFj86aa9C97
         XOLjkiKxd//n4BzlE2ZeqoePJO9eCycLQAsBHydhUoIu7PJ7agLyOjUDSDottPt9rQPK
         E5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXnMdLmuMsCvL2a+Rs3FbD+F0m7k0TY93UGAJ8b4tjo=;
        b=I5JLDopDwR0pH3wyapm7oAg3FVonovy/kfGDF0MJrA3BQi/JhBFj1gpZQ7ZQNxbZ2V
         pjewgt+aV3MbC2z7HXDn3dUOXWgVQ+LnPAZy8qGwD9MK7BxXTm7OuBavKlmnmuKyiHmm
         CvY7C1qj039UG+iG/2F7qHWl7KGR6VNgFY8lUgA9rDoOqbbu+vfOfzmgXHH4syylsYgV
         FbzbpgohqN4fcf5QIvirclLjqEIHfDxChpVSZhG+FSlpU5wDmOpXOXrrazMKI4TgwkMV
         Y2WfzBcCPla7bmwVkym6GCd0bPOvhpXtzXmpeuG5IAlZN/qo/c2zeBRtHLtVXIVWBItM
         TXaQ==
X-Gm-Message-State: APjAAAX/3T1CnylyRiJzFIWzEyXq1O7oWFmL8Hol2jGS+xVD+R040OtQ
        DDZWimZQ0dAdnmYgv3C+ZZhYb3P7TE0=
X-Google-Smtp-Source: APXvYqxGDApdQV7oYE4kRdnh1pebIH4DQsTmSojL+UAck67+W7PxPO2Z/1rUUE+NmpP6FYPEVdlqDw==
X-Received: by 2002:a1c:c289:: with SMTP id s131mr646718wmf.115.1562016074068;
        Mon, 01 Jul 2019 14:21:14 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/10] t4210: skip more command-line encoding tests on MinGW
Date:   Mon,  1 Jul 2019 23:20:53 +0200
Message-Id: <20190701212100.27850-4-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190627233912.7117-1-avarab@gmail.com>
References: <20190627233912.7117-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 5212f91deb ("t4210: skip command-line encoding tests on mingw",
2014-07-17) the positive tests in this file were skipped. That left
the negative tests that don't produce a match.

An upcoming change to migrate the "fixed" backend of grep to PCRE v2
will cause these "log" commands to produce an error instead on
MinGW. This is because the command-line on that platform implicitly
has its encoding changed before being passed to git. See [1].

1. https://public-inbox.org/git/nycvar.QRO.7.76.6.1907011515150.44@tvgsbejvaqbjf.bet/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4210-log-i18n.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 515bcb7ce1..6e61f57f09 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -51,7 +51,7 @@ test_expect_success !MINGW 'log --grep does not find non-reencoded values (utf8)
 	test_must_be_empty actual
 '
 
-test_expect_success 'log --grep does not find non-reencoded values (latin1)' '
+test_expect_success !MINGW 'log --grep does not find non-reencoded values (latin1)' '
 	git log --encoding=ISO-8859-1 --format=%s --grep=$utf8_e >actual &&
 	test_must_be_empty actual
 '
@@ -70,7 +70,7 @@ do
 	then
 	    force_regex=.*
 	fi
-	test_expect_success GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
+	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
 		cat >expect <<-\EOF &&
 		latin1
 		utf8
@@ -79,12 +79,12 @@ do
 		test_cmp expect actual
 	"
 
-	test_expect_success GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
+	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
 		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$utf8_e\" >actual &&
 		test_must_be_empty actual
 	"
 
-	test_expect_success GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
+	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
 		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
 		test_must_be_empty actual
 	"
-- 
2.22.0.455.g172b71a6c5

