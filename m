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
	by dcvr.yhbt.net (Postfix) with ESMTP id F18EC1F461
	for <e@80x24.org>; Fri, 17 May 2019 19:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfEQT4V (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:56:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46606 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfEQT4U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:56:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so8270240wrr.13
        for <git@vger.kernel.org>; Fri, 17 May 2019 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30YV0O5IEl6ChPhFaeRzXz6N8Cu7ncdCTl2LiDP7Qa8=;
        b=hmDDKm67KJiyYAgBq/fcVTDb0fSLn4Uvm5As6ItOKoUcp9Xr7tjEN/dJ3TqKh09w0Z
         zy3YXH/3T3pnhTkJpTSWqlKeTcFT0rFGezF95tmmUWVmit9qKDDJHkoZQYt9lxdeOu7B
         t94gUwWUmDK3bcBpKLp3jdQVnwazeRnqzbJsr2az+JziwNfm3EEJaLSYdqucb1KBlexM
         mPpkXj3BcxmwzKi64Ds0LnagIlP2yshUNA+RY/e9JlQccNpivc/K7S/YZh1Ri2/nLOJz
         xkJs0yVFiGThkVPWOfkD30QlcPyVXuUhdSuRL7mX24oIvmn4hK8eXUn9P8yTxxnkDkbj
         iHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30YV0O5IEl6ChPhFaeRzXz6N8Cu7ncdCTl2LiDP7Qa8=;
        b=Mx4/JESFBjQJ5z2hs2diecPv7Z7yzwa9RRUrwUYYZWXipExh9kF/CQfKVTLFrKu5gM
         et43BxwAH4XDToub/vwvSFuf43mCo+CAcw7Uw8AaOCyedrfXaS6FfMih9B/bPDTS1hTB
         dnfkeid26uvbJgCSqFg5OkfdrNXm1ErA6lW2yrEod+sZK4kpM05md3+rcrnrqxA647dq
         wEnT0mvo3xPn7cUeKMYVhzL+9BBYyR1xfpXM92en1DaKmaFQZTC7dD2hJ71ZiYg9Byw6
         y1hpzctt6/hg0lngx5QKViHvVOHUekUNbMSmYPuPYM7DR4VplANp8AHGpKG+fY7ThZB0
         GhOw==
X-Gm-Message-State: APjAAAUyXMxLhbskLo91rXYL6zjZN7/OPnBOKtP+VymW5/Vi4+U5berp
        dieimJ8B3Z9iHj+8PJEjSJH3zVl8VF4=
X-Google-Smtp-Source: APXvYqzPQBzz5gdnAJ2hqw+r4YS1DkQBstL8W7XmiUlq/PiNt4bua/UOIWYvZvxsFvPmyYoZq9Cecg==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr6751413wrn.43.1558122977878;
        Fri, 17 May 2019 12:56:17 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r2sm18691149wrr.65.2019.05.17.12.56.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 12:56:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stephen Boyd <swboyd@chromium.org>, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] send-email: fix broken transferEncoding tests
Date:   Fri, 17 May 2019 21:55:42 +0200
Message-Id: <20190517195545.29729-3-avarab@gmail.com>
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

I fixed a bug that had broken the reading of sendmail.transferEncoding
in 3494dfd3ee ("send-email: do defaults -> config -> getopt in that
order", 2019-05-09), but the test I added in that commit did nothing
to assert the bug had been fixed.

That issue originates in 8d81408435 ("git-send-email: add
--transfer-encoding option", 2014-11-25) which first added the
"sendemail.transferencoding=8bit".

That test has never done anything meaningful. It tested that the
"--transfer-encoding=8bit" option would turn on the 8bit
Transfer-Encoding, but that was the default at the time (and now). As
checking out 8d81408435 and editing the test to remove that option
will reveal, supplying it never did anything.

So when I copied it thinking it would work in 3494dfd3ee I copied a
previously broken test, although I was making sure it did the right
thing via da-hoc debugger inspection, so the bug was fixed.

So fix the test I added in 3494dfd3ee, as well as the long-standing
test added in 8d81408435. To test if we're actually setting the
Transfer-Encoding let's set it to 7bit, not 8bit, as 7bit will error
out on "email-using-8bit".

This means that we can remove the "sendemail.transferencoding=7bit
fails on 8bit data" test, since it was redundant, we now have other
tests that assert that that'll fail.

While I'm at it convert "git config <key> <value>" in the test setup
to just "-c <key>=<value>" on the command-line. Then we don't need to
cleanup after these tests, and there's no sense in asserting where
config values come from in these tests, we can take that as a given.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9001-send-email.sh | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 13de44686b..61d484d1a6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1437,10 +1437,10 @@ test_expect_success $PREREQ 'setup expect' '
 	EOF
 '
 
-test_expect_success $PREREQ 'sendemail.transferencoding=7bit fails on 8bit data' '
+test_expect_success $PREREQ '--transfer-encoding overrides sendemail.transferEncoding' '
 	clean_fake_sendmail &&
-	git config sendemail.transferEncoding 7bit &&
-	test_must_fail git send-email \
+	test_must_fail git -c sendemail.transferEncoding=8bit \
+		send-email \
 		--transfer-encoding=7bit \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
@@ -1449,11 +1449,10 @@ test_expect_success $PREREQ 'sendemail.transferencoding=7bit fails on 8bit data'
 	test -z "$(ls msgtxt*)"
 '
 
-test_expect_success $PREREQ '--transfer-encoding overrides sendemail.transferEncoding' '
+test_expect_success $PREREQ 'sendemail.transferEncoding via config' '
 	clean_fake_sendmail &&
-	git config sendemail.transferEncoding 8bit &&
-	test_must_fail git send-email \
-		--transfer-encoding=7bit \
+	test_must_fail git -c sendemail.transferEncoding=7bit \
+		send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
@@ -1461,27 +1460,15 @@ test_expect_success $PREREQ '--transfer-encoding overrides sendemail.transferEnc
 	test -z "$(ls msgtxt*)"
 '
 
-test_expect_success $PREREQ 'sendemail.transferencoding=8bit via config' '
+test_expect_success $PREREQ 'sendemail.transferEncoding via cli' '
 	clean_fake_sendmail &&
-	git -c sendemail.transferencoding=8bit send-email \
-		--smtp-server="$(pwd)/fake.sendmail" \
-		email-using-8bit \
-		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
-	sed '1,/^$/d' email-using-8bit >expected &&
-	test_cmp expected actual
-'
-
-test_expect_success $PREREQ 'sendemail.transferencoding=8bit via cli' '
-	clean_fake_sendmail &&
-	git send-email \
-		--transfer-encoding=8bit \
+	test_must_fail git send-email \
+		--transfer-encoding=7bit \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
-	sed '1,/^$/d' email-using-8bit >expected &&
-	test_cmp expected actual
+	grep "cannot send message as 7bit" errors &&
+	test -z "$(ls msgtxt*)"
 '
 
 test_expect_success $PREREQ 'setup expect' '
-- 
2.21.0.1020.gf2820cf01a

