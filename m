Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833921F424
	for <e@80x24.org>; Mon, 25 Dec 2017 00:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdLYA3H (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 19:29:07 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33464 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdLYA3B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 19:29:01 -0500
Received: by mail-wr0-f194.google.com with SMTP id v21so21468426wrc.0
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 16:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7HmH0TMcpRt4CIevBk65iPw1X7A9/u4oggg87H5nspc=;
        b=dWpf+08mU1b1rTgLJBHhyl4EjsPIhgFqFVMsO8+iwvQbqEIzdCrTkW2dhgBdqTycLV
         cKZzzrXs67uK+aZdq8Csj8ZziMKbdCVWWLrVgQEN06gMNg+ctmwCo2J4BzKHEc1t78KP
         9gFKTNm/zBG7jHV9raPpIF0HOS7HtiSQ5VogALktr1CzAa3+o/kZSwX37rzbthgQzRtJ
         6sBev9U4ySKzz8/niyGnmxncHHgsxtN/pnWafJrmzbvEqKPFJfgIY8o7fOHCXPVFB28S
         x6pD3/JY1KqObcK+gIYgTjcPZNx9MH/wLOBxAAiRZ7ChDPHAZU+9cPScgHaE0ry//RQC
         sflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7HmH0TMcpRt4CIevBk65iPw1X7A9/u4oggg87H5nspc=;
        b=nRnLY8V0cKWmGlcNYevynRBINsvEVyo+/v3ucMW7T8+6beTKOa8n2EJAcHi+eWLC4a
         fxq7Z3AYNSeaJpxURxjQ0W7nHKEvtVkYAq3tvxFwKmJfPrX2+bVpZACeV6AfwEb5I81k
         e10OzBQCsd8PtC0raZGjmr8pVM/qXxQRe06ezqpM7C7qlqF9F0OFL1WN799uG/FCyFRO
         7edWqfX9iKAYk8CjmnITZJTmgvkHjsarB8YB4QPbfRNICsm0xH2VsD65sB/A6t2Pv2TZ
         XHJb9X3nKbs37Z0ydxAVs3Ce6caXApjja/K+6UZsLbE4e9qK4BwVb/U1azdr/8x02EyH
         9bnA==
X-Gm-Message-State: AKGB3mKOHIZntgYoy72boZem8y6p+q2dUgJDqabCO4S6Hfr7zq96BmY2
        Qe9Xuxn9DHZu+ZI4gaewa/ZAeBlX
X-Google-Smtp-Source: ACJfBosJwh7gAeFJOeW6memnNmqXx5XF0XIb0ighBcI3poX3RDQUwiO8cmigittnovqrNvAkOIOTag==
X-Received: by 10.223.160.129 with SMTP id m1mr126798wrm.126.1514161739906;
        Sun, 24 Dec 2017 16:28:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i65sm52923574wme.20.2017.12.24.16.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Dec 2017 16:28:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] wildmatch test: use a paranoia pattern from nul_match()
Date:   Mon, 25 Dec 2017 00:28:32 +0000
Message-Id: <20171225002835.29005-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
In-Reply-To: <20171223213012.1962-1-avarab@gmail.com>
References: <20171223213012.1962-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a pattern from the nul_match() function in t7008-grep-binary.sh to
make sure that we don't just fall through to the "else" if there's an
unknown parameter.

This is something I added in commit 77f6f4406f ("grep: add a test
helper function for less verbose -f \0 tests", 2017-05-20) to grep
tests, which were modeled on these wildmatch tests, and I'm now
porting back to the original wildmatch tests.

I am not using the "say '...'; exit 1" pattern from t0000-basic.sh
because if I fail I want to run the rest of the tests (unless under
-i), and doing this makes sure we do that and don't exit right away
without fully reporting our errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 19ea64bba9..9691d8eda3 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -10,10 +10,13 @@ match() {
 		test_expect_success "wildmatch: match '$3' '$4'" "
 			test-wildmatch wildmatch '$3' '$4'
 		"
-	else
+	elif test "$1" = 0
+	then
 		test_expect_success "wildmatch: no match '$3' '$4'" "
 			! test-wildmatch wildmatch '$3' '$4'
 		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
 	fi
 }
 
@@ -23,10 +26,13 @@ imatch() {
 		test_expect_success "iwildmatch: match '$2' '$3'" "
 			test-wildmatch iwildmatch '$2' '$3'
 		"
-	else
+	elif test "$1" = 0
+	then
 		test_expect_success "iwildmatch: no match '$2' '$3'" "
 			! test-wildmatch iwildmatch '$2' '$3'
 		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
 	fi
 }
 
@@ -36,10 +42,13 @@ pathmatch() {
 		test_expect_success "pathmatch: match '$2' '$3'" "
 			test-wildmatch pathmatch '$2' '$3'
 		"
-	else
+	elif test "$1" = 0
+	then
 		test_expect_success "pathmatch: no match '$2' '$3'" "
 			! test-wildmatch pathmatch '$2' '$3'
 		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
 	fi
 }
 
-- 
2.15.1.424.g9478a66081

