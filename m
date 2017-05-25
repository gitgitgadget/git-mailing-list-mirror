Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C92120284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036747AbdEYTrm (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35224 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970184AbdEYTre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so35875887wmc.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v4vNf3aFNOhaqUckIr7fJhC5LtsMGvuaH/zfM5LxgM=;
        b=QHmuQDlZAVqc8u/VNRLf3t0fBCcknwcAPQYlY/IGOCTnpjfkY/WB3ZkCuQ+wOKF7Y7
         jDPr871jIip5cU5i/e1KhsIAtm1Xe6OFCrQ51BjJsSkqct1APpPbMb0Hl8zp1yYTKJjW
         jSNjjfq5PNvW5JSPzVfPivKxGJoQrpA6t0Jbl63yXwaiyYHK+lsThcD3avZkREGBG44Q
         Z5G9a0hzarGF9wnG5oyGqBvMlh3v776BDOcYdx0RuoQVgVKKMBPzH1apkecqwWuKBQqa
         0JLIEurnTTwae68jQ5JnBo2ZZgiVdZiuCk34vTVfwxRCSCDhQJaY7n+L02TnXzOyvpIf
         Y+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v4vNf3aFNOhaqUckIr7fJhC5LtsMGvuaH/zfM5LxgM=;
        b=ZHzLsb4/0McMgxvt3dxkCXEGLlUdHD7IyI0o1oET3RA9sA1ugv1cGKU2KgfXKlwpyy
         lUANCVsmCkoI8MUt7ZI5J3gQ9YlQzTDeGCKTo6zBA67D9bEYmF6rk+vwxUNwBHAapusc
         imikpQGRzp8eUBRA3GgRHUEO0XY9qzSWhtU2KosyzeDq6mhE7J9hebdFt5Rs/0BRYPDk
         xpEXVSMLLH7+EkSyplpz+Hqy/rbT8Yd3wRH071Hh6Pi3FwsLosEd9YVUN/IVTTTrjg+6
         H7dXlZNV/1GmQow5aczv9PblBfcmoN7Nb4gaC8De04DNHwgL32OLdK0xWGCmq0z6Fp6D
         t/jQ==
X-Gm-Message-State: AODbwcC/1ee/13QLUHWvFvHOxyzlvETtVzLEQP1Jm1lbqPE5FanW3tM/
        YccYIANbcztNEw==
X-Received: by 10.28.29.17 with SMTP id d17mr11637652wmd.90.1495741648282;
        Thu, 25 May 2017 12:47:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:27 -0700 (PDT)
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
Subject: [PATCH v4 28/31] pack-objects & index-pack: add test for --threads warning
Date:   Thu, 25 May 2017 19:45:32 +0000
Message-Id: <20170525194535.9324-29-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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

