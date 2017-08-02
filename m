Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F2320899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbdHBTla (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:41:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36798 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdHBTl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:41:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id d40so155710wma.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+J7JO7GfitCmYXxKQlFvR8d2Xxj2IDLjIG3FV8v9xY=;
        b=Y4TRQkoRMhNofnbkCVslgBRQUlq+yNrajimjp3VlnXx7BNad8nbzRcQO/3aCxPba1a
         lud42KzMWzMaI2SAesTm32yr8+Rw4Zy9iIDKaTmR4VL7zp0d5br/ct9h08QpvgmReNFl
         nM37kA+60WkjzslSVWnA/38Dfr+OkTZtnr58HUYQ2mCN5plXE7oVVAm6X2LM+uAxX+z4
         GcSarAx5O41Sp2gds24JFYTiYGAnCx+6awUNE34JflccOfZmr/cahRSyMLh7jRInVbrV
         ElpH+Fc9vbH2nNG3id5qyr131nkQsOwcdjMwhKsVHBfAZnujjihjjc13K4Z+HjxLty/Q
         +21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+J7JO7GfitCmYXxKQlFvR8d2Xxj2IDLjIG3FV8v9xY=;
        b=IKGasc+0PUT/k96+zycBtIe3KXi+euPcaXOz5/sNyBP9Hk0uUp3nLlpqh7zlVjjpG6
         nMRXJgje+wEEv8LE3/YtdgY+4iEO/LcsMbwkqhwyFl8PqqOvnNhcAZXZUSjcjDsDqpJO
         H9PCCuAHoe20Qz/PiEb2CQ4YE33dOikO5cbF/oJQhgAMSt62DsY3VAjLH+1KuPqXNEvl
         fW3wfaz2/PxSj3Z2nRuiG/LWvWGfxmnli8Kb3pfCtcwd+2l6+wFlpd/1mQ9spE0xc5Dy
         IQqvXO1odxTGeuhzcOVOZguVVhMvA1F0/C9HcqNM/8gzPELANfj1N+Gzbnfh/xWLdvtb
         9BYg==
X-Gm-Message-State: AIVw111mTXJjJjvcAvCWpcha9RAynwTLvTtB3IDOhq8ZDCfYWhKLsoI4
        zmY7a3HGHHSCUWtn
X-Received: by 10.28.69.197 with SMTP id l66mr4186222wmi.140.1501702884589;
        Wed, 02 Aug 2017 12:41:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id t13sm103576wra.22.2017.08.02.12.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:41:23 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 6/7] tag: change default of `pager.tag` to "on"
Date:   Wed,  2 Aug 2017 21:40:54 +0200
Message-Id: <8225436bd8c8eb4af3370867596789ae75729f8d.1501701129.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.12.ge2d9c4613
In-Reply-To: <cover.1501701128.git.martin.agren@gmail.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch taught `git tag` to only respect `pager.tag` in
list-mode. That patch left the default value of `pager.tag` at "off".

After that patch, it makes sense to let the default value be "on"
instead, since it will help with listing many tags, but will not hurt
users of `git tag -a` as it would have before. Make that change. Update
documentation and tests.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-tag.txt |  2 +-
 t/t7006-pager.sh          | 28 ++++++++++++++--------------
 builtin/tag.c             |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 875d135e0..d97aad343 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -206,7 +206,7 @@ it in the repository configuration as follows:
 -------------------------------------
 
 `pager.tag` is only respected when listing tags, i.e., when `-l` is
-used or implied.
+used or implied. The default is to use a pager.
 See linkgit:git-config[1].
 
 DISCUSSION
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 570b2f252..afa03f3b6 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -134,16 +134,16 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	}
 '
 
-test_expect_success TTY 'git tag -l defaults to not paging' '
+test_expect_success TTY 'git tag -l defaults to paging' '
 	rm -f paginated.out &&
 	test_terminal git tag -l &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -l respects pager.tag' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag tag -l &&
-	test -e paginated.out
+	test_terminal git -c pager.tag=false tag -l &&
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -l respects --no-pager' '
@@ -152,32 +152,32 @@ test_expect_success TTY 'git tag -l respects --no-pager' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git tag with no args defaults to not paging' '
+test_expect_success TTY 'git tag with no args defaults to paging' '
 	# no args implies -l so this should page like -l
 	rm -f paginated.out &&
 	test_terminal git tag &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git tag with no args respects pager.tag' '
 	# no args implies -l so this should page like -l
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag tag &&
-	test -e paginated.out
+	test_terminal git -c pager.tag=false tag &&
+	! test -e paginated.out
 '
 
-test_expect_success TTY 'git tag --contains defaults to not paging' '
+test_expect_success TTY 'git tag --contains defaults to paging' '
 	# --contains implies -l so this should page like -l
 	rm -f paginated.out &&
 	test_terminal git tag --contains &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git tag --contains respects pager.tag' '
 	# --contains implies -l so this should page like -l
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag tag --contains &&
-	test -e paginated.out
+	test_terminal git -c pager.tag=false tag --contains &&
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -a defaults to not paging' '
@@ -210,8 +210,8 @@ test_expect_failure TTY 'git tag as alias ignores pager.tag with -a' '
 
 test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag -c alias.t=tag t -l &&
-	test -e paginated.out
+	test_terminal git -c pager.tag=false -c alias.t=tag t -l &&
+	! test -e paginated.out
 '
 
 # A colored commit log will begin with an appropriate ANSI escape
diff --git a/builtin/tag.c b/builtin/tag.c
index 5ad1af252..ea83df5e1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -462,7 +462,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 
 	if (cmdmode == 'l')
-		setup_auto_pager("tag", 0);
+		setup_auto_pager("tag", 1);
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
-- 
2.14.0.rc1.12.ge2d9c4613

