Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13AF01F461
	for <e@80x24.org>; Fri, 17 May 2019 19:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfEQT4S (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:56:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39032 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfEQT4R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:56:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id w8so8324015wrl.6
        for <git@vger.kernel.org>; Fri, 17 May 2019 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IdOJRNUeTfSUL1GotIAxz5SgA2St4jwxPNLzKx1ZKpc=;
        b=EYpj4m5Ca2pdtcEGe0p7fSnW76WPmhmX+CJp8xuzQGgIbX4yseZ8LTCLh6zGJ5Bl8m
         aZ3LGcWfmBD9nBjtsmmC1++P94mQsPY80sjuTJbHRjpGvaqkvGnntcbq95v5ELD2L536
         8NR+WwO6nJHoB0kNgwGgLaoj8dpJ4eY2cLnsRCEz7gMQS9OH93e+I/C9q0kLe1JDLlZJ
         v9jiCAFp0YrhfOWxhiP3ifYNcryxi9w8A+n3V5DhlSjpqVG+ghrCsO6f5wKh2ne173zz
         cEa8N87jr+3NX1bIuaQx8UlNLA3fVOV+ArBagUedm+lOKC+ikcRqumJr187oR8byrkjk
         lByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdOJRNUeTfSUL1GotIAxz5SgA2St4jwxPNLzKx1ZKpc=;
        b=jzVJujOQqIh7lD2sNQplDDCVOp7ETh7g6Bxa6DmJffl9+4NqKJ+gi1vpnDRaG+DNbl
         TYWxXuqqduoHaHO6jDGpUcIhawusbloOIiWGGRl/hlSGT5I+kvtVwSwTikX3wmDlpZtP
         2WLJbWDVl9HajgnhKJFapmV3fDYd//IZi+Cvb4xigD8HlBDjh8wHHualt0N00SFoVACZ
         Ec9/giJ0oJyZCWW+weFhT5A7qbSOq4qi5eBkfv7u0B1YEzxlMwlZLK1G6naExwchf4GT
         fO3o9zRgmqsP+VTBtmCo9EBm7S9Xs7bGRW/rSwnEz9lg7AzOR3LdzDs6astZl9BtWQwx
         eNpw==
X-Gm-Message-State: APjAAAXwY9P58FoqB1UqiwEsoBn6P80sRQRDzq2zOxkAxxe3mESG+RvZ
        K+Is9rBeYgUevSbOiWEmco7FhXjgdGg=
X-Google-Smtp-Source: APXvYqy5SvRbCzDLjjmdtbu749s6In5wMM1QNaqnoh7/x0OhQ/7TT9tqrngLNrm+hvo1MbwtwEpraw==
X-Received: by 2002:adf:fc44:: with SMTP id e4mr3580824wrs.243.1558122975722;
        Fri, 17 May 2019 12:56:15 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r2sm18691149wrr.65.2019.05.17.12.56.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 12:56:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stephen Boyd <swboyd@chromium.org>, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] send-email: remove cargo-culted multi-patch pattern in tests
Date:   Fri, 17 May 2019 21:55:41 +0200
Message-Id: <20190517195545.29729-2-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.259.g3cce4bfedb
In-Reply-To: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
References: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change test code added in f434c083a0 ("send-email: add --no-cc,
--no-to, and --no-bcc", 2010-03-07) which blindly copied a pattern
from an earlier test added in 32ae83194b ("add a test for
git-send-email for non-threaded mails", 2009-06-12) where the
"$patches" variable was supplied more than once.

As it turns out we didn't need more than one "$patches" for the test
added in 32ae83194b either. The only tests that actually needed this
sort of invocation were the tests added in 54aae5e1a0 ("t9001:
send-email interation with --in-reply-to and --chain-reply-to",
2010-10-19).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9001-send-email.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1b18201ce2..13de44686b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1204,7 +1204,7 @@ test_expect_success $PREREQ 'no in-reply-to and no threading' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--no-thread \
-		$patches $patches >stdout &&
+		$patches >stdout &&
 	! grep "In-Reply-To: " stdout
 '
 
@@ -1224,7 +1224,7 @@ test_expect_success $PREREQ 'sendemail.to works' '
 	git send-email \
 		--dry-run \
 		--from="Example <nobody@example.com>" \
-		$patches $patches >stdout &&
+		$patches >stdout &&
 	grep "To: Somebody <somebody@ex.com>" stdout
 '
 
@@ -1234,7 +1234,7 @@ test_expect_success $PREREQ '--no-to overrides sendemail.to' '
 		--from="Example <nobody@example.com>" \
 		--no-to \
 		--to=nobody@example.com \
-		$patches $patches >stdout &&
+		$patches >stdout &&
 	grep "To: nobody@example.com" stdout &&
 	! grep "To: Somebody <somebody@ex.com>" stdout
 '
@@ -1245,7 +1245,7 @@ test_expect_success $PREREQ 'sendemail.cc works' '
 		--dry-run \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		$patches $patches >stdout &&
+		$patches >stdout &&
 	grep "Cc: Somebody <somebody@ex.com>" stdout
 '
 
@@ -1256,7 +1256,7 @@ test_expect_success $PREREQ '--no-cc overrides sendemail.cc' '
 		--no-cc \
 		--cc=bodies@example.com \
 		--to=nobody@example.com \
-		$patches $patches >stdout &&
+		$patches >stdout &&
 	grep "Cc: bodies@example.com" stdout &&
 	! grep "Cc: Somebody <somebody@ex.com>" stdout
 '
@@ -1268,7 +1268,7 @@ test_expect_success $PREREQ 'sendemail.bcc works' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--smtp-server relay.example.com \
-		$patches $patches >stdout &&
+		$patches >stdout &&
 	grep "RCPT TO:<other@ex.com>" stdout
 '
 
@@ -1280,7 +1280,7 @@ test_expect_success $PREREQ '--no-bcc overrides sendemail.bcc' '
 		--bcc=bodies@example.com \
 		--to=nobody@example.com \
 		--smtp-server relay.example.com \
-		$patches $patches >stdout &&
+		$patches >stdout &&
 	grep "RCPT TO:<bodies@example.com>" stdout &&
 	! grep "RCPT TO:<other@ex.com>" stdout
 '
-- 
2.21.0.1020.gf2820cf01a

