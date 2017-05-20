Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6A1A201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756549AbdETVoT (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:44:19 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36668 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756529AbdETVn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id v42so5741810wrc.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v4vNf3aFNOhaqUckIr7fJhC5LtsMGvuaH/zfM5LxgM=;
        b=G5nwq/tgDaHNvWQx5NDEdKC5yjjTRqBCKZR8XdXZg481NJ7VQZXOAmJKMT+br8FOCf
         jYfV8dubfHHa7GtfIB0CgyIdQ98/CUXv3+y2XSmrFz/ryK+djwdVI+Z0jIPU8wxJDsm+
         Lp0ZltrqXCDtv0Z3zM27zgafFcPwBXO9gawCDErIqVlzdGL3HbL2wqUFlG8IqV7tuxtT
         J5ANl2sYSAomb2OsS6MsWRumsqbI1RBC55BZK1cJ3xP4HmHlch2jDyfJGPo+R4lsWtBN
         Z6pN1v3Yx0bEKopfb2om4CB+wl2bmOTAIvT+DhMANrCgoNNq3GTRwBOizII/CYwx8Myn
         2EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v4vNf3aFNOhaqUckIr7fJhC5LtsMGvuaH/zfM5LxgM=;
        b=YyaTwY2lwR7kkwoN96Yxt/dEI9camr8ZEOi/WKOQtXEobHK8NFA+shBEbu21wp5oW/
         T7jZm/mk+fYLkYSe9q6nCph96M6bF49gE/vZSkbE1ZMWBMnZDauw/P4dKya86sDah77l
         Hj3alpA4P221yyMr9V20IGZKWgij0lvB7TCI/TP4WoGp0ZSzm0CpFSDYOXxprWxFUtYP
         sfaW3iloLrBpB0aReTx7Vut6aHDq8V0rhdrG41IwH0w//G9oIN9FOzqm3nxw1+Vz3USz
         CopmPmXYm0/whUuUsIq7IJdfmwRWMk6qaK5cgFWqxeMox6BS2SnHUjQgpLNVr/PfEQoQ
         ALqA==
X-Gm-Message-State: AODbwcC9wVg3FlGGy3R2uax3+Xh/zbDABPb1Kcg3pVK5KSIvosX4c8y5
        h4iTXZBC1Gy3bA==
X-Received: by 10.223.179.199 with SMTP id x7mr7626042wrd.72.1495316638320;
        Sat, 20 May 2017 14:43:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 27/30] pack-objects & index-pack: add test for --threads warning
Date:   Sat, 20 May 2017 21:42:30 +0000
Message-Id: <20170520214233.7183-28-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the warning that's emitted when --threads or
pack.threads is provided under NO_PTHREADS=YesPlease. This uses the
new PTHREADS prerequisite.

The assertion for C_LOCALE_OUTPUT in the latter test is currently
redundant, since unlike index-pack the pack-objects warnings aren't
i18n'd. However they might be changed to be i18n'd in the future, and
there's no harm in future-proofing the test.

There's an existing bug in the implementation of pack-objects which
this test currently tests for as-is. Details about the bug & the fix
are included in a follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5300-pack-object.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 43a672c345..6ed23ee1d2 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -421,6 +421,42 @@ test_expect_success 'index-pack <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
+	test_must_fail git index-pack --threads=2 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring --threads=2" err &&
+
+	test_must_fail git -c pack.threads=2 index-pack 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring pack.threads" err &&
+
+	test_must_fail git -c pack.threads=2 index-pack --threads=4 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep -F "no threads support, ignoring --threads=4" err &&
+	grep -F "no threads support, ignoring pack.threads" err
+'
+
+test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
+	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring --threads" err &&
+
+	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
+	grep ^warning: err >warnings &&
+	test_must_fail test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring pack.threads" err &&
+
+	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep -F "no threads support, ignoring --threads" err &&
+	grep -F "no threads support, ignoring pack.threads" err
+'
+
 #
 # WARNING!
 #
-- 
2.13.0.303.g4ebf302169

