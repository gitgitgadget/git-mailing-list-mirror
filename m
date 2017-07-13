Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0AF2035A
	for <e@80x24.org>; Thu, 13 Jul 2017 07:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdGMHBB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 03:01:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36468 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdGMHBB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 03:01:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so3115663wmh.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 00:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qVGrJretOFUhfWG4JAs10ArW4/xWpyMv6GaHuRRontI=;
        b=celAFKYW4DoXjh/hcJddswHhY0FSutldd+ZARCCCmrJTa2P69T3cn4saPX5GkRMKg3
         DZHwwavL5fuWIch3z9u+o5mEQI6ByrYVVOFwkW9+Y0lZSBo//QhMtrfQirsvbL/jDiTg
         dnCjdhZKF7iyPrSGLn5uqdTwuE73eAQzrs1BdPvBLrw3kKWRE/ztH15q0C89pJGmkSI5
         JscZZm8FzWvrym+ttZ3Qf4aw2vW9QzdHIqD8Ek9lNP58Cy5H+hrurdy8HoK+gET9slrJ
         AG4dDaAdgNiV2lVoNdQLqCPWif4HAXixln3u+0hZNf6orxpF2DDZKROg5KFLA8V4Fhhc
         Tkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=qVGrJretOFUhfWG4JAs10ArW4/xWpyMv6GaHuRRontI=;
        b=Z4KIJ1Ut340nKzrhgJJZOWRv38lCtr00R8CPJtyUf6IB5Xa6Domd7Ubm8Rd6BU+o5e
         v++ZPT74NxP0xO6p9+r5NGAyqddWRauh6tNPc3kJgE6sUNxhUpbrlJxO5/pEfKJPBYJe
         9uCHmt+x45IACol9ufrR7EGaBuCxXqG9ylYA+SYy12k3CNOr5EV1P5ZAtqdrMP+kxAfR
         YJX6uqO6ph0RUu8x2S7xfjHfUtysp9/69/su5tWNzNAbtdndaljJkZrRkBd8kcrrJxrO
         NvWlSQsG42z4dL8HwAChUNODOLUUiZ0OOaWIcqnPPalqVFI7DATFUXpjyCVHZtcM/4dU
         IgMw==
X-Gm-Message-State: AIVw112VysTQrliEqj0Cv+YfZGXkQPDJUHxJA+0Sl8mW6ZQp0yFmeol+
        m2GN942zuKsHKw==
X-Received: by 10.28.7.211 with SMTP id 202mr777910wmh.113.1499929259579;
        Thu, 13 Jul 2017 00:00:59 -0700 (PDT)
Received: from berenguela.telefonica.net (152.red-95-120-155.dynamicip.rima-tde.net. [95.120.155.152])
        by smtp.gmail.com with ESMTPSA id r200sm4049927wmd.20.2017.07.13.00.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 00:00:58 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH 1/3] git-p4: git-p4 tests with p4 triggers
Date:   Thu, 13 Jul 2017 09:00:33 +0200
Message-Id: <20170713070035.12731-1-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqr2xl1suy.fsf@gitster.mtv.corp.google.com>
References: <xmqqr2xl1suy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some p4 triggers in the server side generate some warnings when
executed. Unfortunately those messages are mixed with the output of
p4 commands. A few git-p4 commands don't expect extra messages or output
lines and may fail with verbose triggers.
New tests added are known to be broken.

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 t/t9831-git-p4-triggers.sh | 103 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 t/t9831-git-p4-triggers.sh

diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
new file mode 100755
index 000000000..28cafe469
--- /dev/null
+++ b/t/t9831-git-p4-triggers.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='git p4 with server triggers'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "change 1"
+		echo file2 >file2 &&
+		p4 add file2 &&
+		p4 submit -d "change 2"
+	)
+'
+
+test_expect_failure 'clone with extra info lines from verbose p4 trigger' '
+	test_when_finished cleanup_git &&
+	(
+		p4 triggers -i <<-EOF
+		Triggers: p4triggertest-command command pre-user-change "echo verbose trigger"
+		EOF
+	) &&
+	(
+		p4 change -o |  grep -s "verbose trigger"
+	) &&
+	git p4 clone --dest="$git" //depot/@all &&
+	(
+		p4 triggers -i <<-EOF
+		Triggers:
+		EOF
+	)
+'
+
+test_expect_failure 'import with extra info lines from verbose p4 trigger' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		echo file3 >file3 &&
+		p4 add file3 &&
+		p4 submit -d "change 3"
+	) &&
+	(
+		p4 triggers -i <<-EOF
+		Triggers: p4triggertest-command command pre-user-describe "echo verbose trigger"
+		EOF
+	) &&
+	(
+		p4 describe 1 |  grep -s "verbose trigger"
+	) &&
+	git p4 clone --dest="$git" //depot/@all &&
+	(
+		cd "$git" &&
+		git p4 sync
+	)&&
+	(
+		p4 triggers -i <<-EOF
+		Triggers:
+		EOF
+	)
+'
+
+test_expect_failure 'submit description with extra info lines from verbose p4 change trigger' '
+	test_when_finished cleanup_git &&
+	(
+		p4 triggers -i <<-EOF
+		Triggers: p4triggertest-command command pre-user-change "echo verbose trigger"
+		EOF
+	) &&
+	(
+		p4 change -o |  grep -s "verbose trigger"
+	) &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		echo file4 >file4 &&
+		git add file4 &&
+		git commit -m file4 &&
+		git p4 submit
+	) &&
+	(
+		p4 triggers -i <<-EOF
+		Triggers:
+		EOF
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file file4
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.11.0

