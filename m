Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25821F404
	for <e@80x24.org>; Sun, 10 Dec 2017 06:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdLJGxf (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 01:53:35 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37843 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdLJGxe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 01:53:34 -0500
Received: by mail-lf0-f68.google.com with SMTP id a12so15844633lfe.4
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 22:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bDsARmZQ4fVkiuccy9RM2pQdWkNRkf/7h8pS451qKuk=;
        b=ecREXG2G5rga/wWLYhKEVQ3XVTkMGD24W2I0OOIzb8k8PMh0+8QuH3gXd5VZ9lfcyp
         LoiZz358vDYA86r3tmBeHAE8dYuYXzWccTuskcwZGgiDgpzhHg49C3OrEaSeXQRlzanS
         0vhvkNy7Mdiwo/bzdkeKyA1uVUp/5SLl4sBcopI+uWin5XOsIFGbplQJrCtv4Pf7uJiz
         m6Uk+h04dkGjyNxkA+SUbYuxsEsUawZ7CEDgsXQ+F1ND8kWeZDiKlxAnrTYy/sQoQagr
         4JWkYiB8pzZc9aeVJX3AvcqahRzXPit7s/lqFRT/7Dqf5I42Qz7ahNYSU/tiQlv+UnPa
         +Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bDsARmZQ4fVkiuccy9RM2pQdWkNRkf/7h8pS451qKuk=;
        b=Fjfro53nXELBmadc/RiFMxQJZwPg/5e/VgnrpOaIEGndti1Bsm1CrrmTIjHfCKDmW0
         CK5IdenWmWOgUTScHSmYPlXFtjCRuL4f9St0WI1qfmCPQUGlzVkyGZWdHmr/gWZK5KqQ
         JSdmsDyHsULT0RjYkVgmaNqzAUVo4KvIn//rjrc0U/SI/j4GNjFBx7zWMh8j65g6Ka7h
         oKfHux3xn2lykdZrDQgE9G8uOJj+Honcc0Yu18UgKigX6l78YDbsSIiHtKANmwAB7jHw
         my1W6FPP+WplR+Idqk7Grnu/akBTlOt+6tjvyniqSzWfpbQFaEK4ps8aY5j4EWDSXQCh
         5BYQ==
X-Gm-Message-State: AJaThX65AiOJKvQXBDz7uLudWUmR/SbqdLe0AuD5f6wwF//3cFpo8twN
        Q2mJfyO9MWeSFWHfkxKT72ZBgdGv2B4=
X-Google-Smtp-Source: AGs4zMZcI/o1iXjaCXxOTLVTVilUckFXyNhcYBIU8jyTiIu/Xj3o4uVfw2NB565VfD8QTiMXAlJe1A==
X-Received: by 10.46.69.67 with SMTP id s64mr18782148lja.94.1512888812897;
        Sat, 09 Dec 2017 22:53:32 -0800 (PST)
Received: from localhost ([185.65.132.137])
        by smtp.gmail.com with ESMTPSA id q142sm2125549lfe.94.2017.12.09.22.53.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Dec 2017 22:53:32 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/2] t: add tests for pull --verify-signatures
Date:   Sun, 10 Dec 2017 06:53:58 +0000
Message-Id: <20171210065358.8156-2-hji@dyntopia.com>
In-Reply-To: <20171210065358.8156-1-hji@dyntopia.com>
References: <20171209090530.6747-1-hji@dyntopia.com>
 <20171210065358.8156-1-hji@dyntopia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for pull --verify-signatures with untrusted, bad and no
signatures.  Previously the only test for --verify-signatures was to
make sure that pull --rebase --verify-signatures result in a warning
(t5520-pull.sh).

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 t/t5573-pull-verify-signatures.sh | 78 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 t/t5573-pull-verify-signatures.sh

diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
new file mode 100755
index 000000000..8ae331f40
--- /dev/null
+++ b/t/t5573-pull-verify-signatures.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='pull signature verification tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create repositories with signed commits' '
+	echo 1 >a && git add a &&
+	test_tick && git commit -m initial &&
+	git tag initial &&
+
+	git clone . signed &&
+	(
+		cd signed &&
+		echo 2 >b && git add b &&
+		test_tick && git commit -S -m "signed"
+	) &&
+
+	git clone . unsigned &&
+	(
+		cd unsigned &&
+		echo 3 >c && git add c &&
+		test_tick && git commit -m "unsigned"
+	) &&
+
+	git clone . bad &&
+	(
+		cd bad &&
+		echo 4 >d && git add d &&
+		test_tick && git commit -S -m "bad" &&
+		git cat-file commit HEAD >raw &&
+		sed -e "s/bad/forged bad/" raw >forged &&
+		git hash-object -w -t commit forged >forged.commit &&
+		git checkout $(cat forged.commit)
+	) &&
+
+	git clone . untrusted &&
+	(
+		cd untrusted &&
+		echo 5 >e && git add e &&
+		test_tick && git commit -SB7227189 -m "untrusted"
+	)
+'
+
+test_expect_success GPG 'pull unsigned commit with --verify-signatures' '
+	test_must_fail git pull --ff-only --verify-signatures unsigned 2>pullerror &&
+	test_i18ngrep "does not have a GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit with bad signature with --verify-signatures' '
+	test_must_fail git pull --ff-only --verify-signatures bad 2>pullerror &&
+	test_i18ngrep "has a bad GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures' '
+	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
+	test_i18ngrep "has an untrusted GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull signed commit with --verify-signatures' '
+	test_when_finished "git checkout initial" &&
+	git pull --verify-signatures signed >pulloutput &&
+	test_i18ngrep "has a good GPG signature" pulloutput
+'
+
+test_expect_success GPG 'pull commit with bad signature without verification' '
+	test_when_finished "git checkout initial" &&
+	git pull --ff-only bad 2>pullerror
+'
+
+test_expect_success GPG 'pull commit with bad signature with --no-verify-signatures' '
+	test_when_finished "git checkout initial" &&
+	test_config merge.verifySignatures true &&
+	test_config pull.verifySignatures true &&
+	git pull --ff-only --no-verify-signatures bad 2>pullerror
+'
+
+test_done
-- 
2.15.1.356.g13e4cf275

