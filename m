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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC391F462
	for <e@80x24.org>; Wed, 19 Jun 2019 23:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfFSXbC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 19:31:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56115 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbfFSXbB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 19:31:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so1120184wmj.5
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNlwNqzb2uqwts4IqSXDpS9jIjO0Dc9DfjH1LrnRNVg=;
        b=tLOzfb1qzYXOTS8QJflYRbqhCAjnWDacI4pLhYiJqb28x/5Hdhn+93pH0t/ad/6BOb
         NFFE19YA38aRZvbkU0RDs4xvF258eD8gMLwfNrH8xKZttbkb8kCUpvZEJudTSy6OqAg2
         9FAs9HBMWVHY2vrCtI2BF/gBDJjc06ezeYY8X91GPuKVTDSO80ebF411f+bTEbMgXH0Q
         kjmtHu4N6+HyxEQPTTDOS9Ocdq+gUG+qw2xKYt6+7pAg4l4p0OVmmQMv84Q/NRIiEx3F
         CPmtbx00bpZ5AlWqpCZvRUwQ7cLAyUaQ7v8QdR79P2SVEK9tth5/8NE+kgF84stw+Pr+
         I0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNlwNqzb2uqwts4IqSXDpS9jIjO0Dc9DfjH1LrnRNVg=;
        b=V6gsILHpyvCwbQfA0G7Sh6bxrIn7I4lIzSh9slpMyXO0LASe6ZuLDmYqpZLLjZAaJz
         /DeMuZQsHSJRsKLXDpj9NMFv04VNgj6Qcv+e8cqPajpUZUOtNM/Y01fdNT+mufRMU+ED
         rY51rlSpWpeKCTeNiAW8hUL4LjF/3AIH99ttrz1OvnD6A0PnjlnBCIaCnQHJYBRLZHyu
         EfItKZm818CBdRzF5NhyXy/wal/+3+2sFw6oJ1vWX4SXk3C9al0a08rwO86zgpjcUZ1y
         syOFsQOPIcDiyDQQpKAkGMulf72xUsG6dvSGZZXfnIt23NiL+M9lttrK45xoaQqATdWy
         PW7Q==
X-Gm-Message-State: APjAAAWTv1nUfwiqDbdbmhWOYwj879h3irTKRgoEDzFgXpLzpEGocoiB
        MmiGL3uimuwV+REOB6ab8YIXjswjwFk=
X-Google-Smtp-Source: APXvYqww1NjcaspSWDvAcqYf1mZL0nO7HqPXgd+0KkLaPeJL95fW/NdvUoc+qES4kBe70u22RMOF8w==
X-Received: by 2002:a1c:a709:: with SMTP id q9mr9699784wme.22.1560987058393;
        Wed, 19 Jun 2019 16:30:58 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6sm17964958wrx.85.2019.06.19.16.30.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 16:30:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] t6040 test: stop using global "script" variable
Date:   Thu, 20 Jun 2019 01:30:42 +0200
Message-Id: <20190619233046.27503-3-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244
In-Reply-To: <87imt18a2r.fsf@evledraar.gmail.com>
References: <87imt18a2r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change test code added in c0234b2ef6 ("stat_tracking_info(): clear
object flags used during counting", 2008-07-03) to stop using the
"script" variable also used for lazy prerequisites in
test-lib-functions.sh.

Since this test uses test_i18ncmp and expects to use its own "script"
variable twice it implicitly depends on the C_LOCALE_OUTPUT
prerequisite not being a lazy prerequisite. A follow-up change will
make it a lazy prerequisite, so we must remove this landmine before
inadvertently stepping on it as we make that change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6040-tracking-info.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 716283b274..970b25a289 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -38,7 +38,7 @@ test_expect_success setup '
 	advance h
 '
 
-script='s/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
+t6040_script='s/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
 cat >expect <<\EOF
 b1 [ahead 1, behind 1] d
 b2 [ahead 1, behind 1] d
@@ -53,7 +53,7 @@ test_expect_success 'branch -v' '
 		cd test &&
 		git branch -v
 	) |
-	sed -n -e "$script" >actual &&
+	sed -n -e "$t6040_script" >actual &&
 	test_i18ncmp expect actual
 '
 
@@ -71,7 +71,7 @@ test_expect_success 'branch -vv' '
 		cd test &&
 		git branch -vv
 	) |
-	sed -n -e "$script" >actual &&
+	sed -n -e "$t6040_script" >actual &&
 	test_i18ncmp expect actual
 '
 
-- 
2.22.0.rc1.257.g3120a18244

