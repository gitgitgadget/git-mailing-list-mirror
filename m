Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7D01F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbeBUSwK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:52:10 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33959 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932251AbeBUSwB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:52:01 -0500
Received: by mail-wr0-f196.google.com with SMTP id m5so7390032wrg.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sMqorm5Jj+lZBlMVSRbKlyf41aYcED+/FktoMIE0nc=;
        b=TUWpyxnEJToIR1fWZplPfn3MoIt3sq94h8CKJxjPwBVXlaG1EZXI7OOjZ92DojlNgS
         YWYpLpfb+Xh8wRNSWAVZ05oMiJAlSpCUVft01Oi3zw2M+tdRDJoVLHfofmdMyHTbEO0B
         aMXAdUHlcgim445ju7kh9BmloQFSshwz5J5gjCEIJl7oxUUuLgwdehtyWMiV5eCNBUbz
         WIGDTW4dpXC5Jzc05NfomUQF70iKdcg2J/7bw6OhkWwm5D+AOOfy0xkPNflCCw3oUbAS
         cE8pdZp2af5kJZs75f1ETLqn+IeJNJUTkRzriU0P4fanHiAdcmjYRLiVNDaWyxrEfWqg
         aS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sMqorm5Jj+lZBlMVSRbKlyf41aYcED+/FktoMIE0nc=;
        b=X+z7508GDZeC6m2Sufiru1TCDQyGMMMzuZclciuwC8PPMar8eI0QimoFmi6A5WG/Bc
         biQwoRC7G4DjS3QVvLY1p2HKmMuq6KhoFxd2IeOpouhep04ZBTpTvvwr48Q0kJ32gv0f
         owAD93wIvoTPNlTkVlMM8PKjkqqBOugg8Nf25uMdBcK6Bw4Vdkpc2miA5cpwlyDgZwrN
         uehXh4nNp7hsHV3lFUdz8URWta1KAN/ORNuVuoVpuq5iRDgaMvyZ/TxVRaRvufk4mCI9
         hK2OMork4S2qOweKWBNIQRxQ9s9dObim/YtMmrdv4WqNYw34zjXl9VK3YAgrSsYdeUR8
         9JYw==
X-Gm-Message-State: APf1xPDfCheUu6fCZJsTpAeIS5a3aqRClyPLhRaXme1YNb5i+3D9SmEq
        6CQHZLhJl7yApa9Ehxqcl2DjpX0G
X-Google-Smtp-Source: AH8x227amYQVlR/UMZaHb4kL4hF/aZZPhpJ+mwx8du0PNclck192dBjhsvc8W8UJgp84LasfJFqnrw==
X-Received: by 10.223.208.196 with SMTP id z4mr3784999wrh.104.1519239120180;
        Wed, 21 Feb 2018 10:52:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 128sm5224964wmi.20.2018.02.21.10.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Feb 2018 10:51:59 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] config: change default of `pager.config` to "on"
Date:   Wed, 21 Feb 2018 19:51:44 +0100
Message-Id: <bb68a11f51024980e513c1f001b5759a35829ff1.1519238410.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519238410.git.martin.agren@gmail.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com> <cover.1519238410.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to ff1e72483 (tag: change default of `pager.tag` to
"on", 2017-08-02) and is safe now that we do not consider `pager.config`
at all when we are not listing or getting configuration. This change
will help with listing large configurations, but will not hurt users of
`git config --edit` as it would have before the previous commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt |  1 +
 t/t7006-pager.sh             | 12 ++++++------
 builtin/config.c             |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 249090ac84..e09ed5d7d5 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -237,6 +237,7 @@ CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
 using `--list` or any of the `--get-*` which may return multiple results.
+The default is to use a pager.
 
 [[FILES]]
 FILES
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 95bd26f0b2..7541ba5edb 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -267,23 +267,23 @@ test_expect_success TTY 'git config --get ignores pager.config' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git config --get-urlmatch defaults to not paging' '
+test_expect_success TTY 'git config --get-urlmatch defaults to paging' '
 	rm -f paginated.out &&
 	test_terminal git -c http."https://foo.com/".bar=foo \
 			  config --get-urlmatch http https://foo.com &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git config --get-all respects pager.config' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.config config --get-all foo.bar &&
-	test -e paginated.out
+	test_terminal git -c pager.config=false config --get-all foo.bar &&
+	! test -e paginated.out
 '
 
-test_expect_success TTY 'git config --list defaults to not paging' '
+test_expect_success TTY 'git config --list defaults to paging' '
 	rm -f paginated.out &&
 	test_terminal git config --list &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 
diff --git a/builtin/config.c b/builtin/config.c
index a732d9b56c..01169dd628 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -602,7 +602,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (actions & PAGING_ACTIONS)
-		setup_auto_pager("config", 0);
+		setup_auto_pager("config", 1);
 
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
-- 
2.16.2.246.ga4ee44448f

