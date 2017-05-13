Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85EFB20188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758765AbdEMXRZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:25 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32934 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757412AbdEMXRX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:23 -0400
Received: by mail-qk0-f194.google.com with SMTP id o85so12528541qkh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxD1BBkl9JIlbm47I9lFASISQxJNSO0mhqGHNTEMVcw=;
        b=cwt0qBensYDJq9LPO3xr/3xvNkuS4wlOAceWNw01ZINjs7a5oSjWNmxPYiiSGSroC5
         XCoutQke6POLBW39pY0NqeARiI64e85dVP9Wmr0657J3N19i7UHoT9L/gZiO2RaWdim2
         NWygmaj+nlK4KZnSidkdzDbYG9F3NUlCrv+IllItV2xD1tTN6FycSAMxYIyu7cZn6bzd
         jCWY307sUmZtfx90H3fUo1tOJYKmjFYOGaf9B8aL4vNEai/tL8ZlDSjDM5O3ba3XlY+s
         VXOqf8Qn74Mhr0mp5jmZRp2l0iYx7EYClPJoKjM7Xzv6S1CvWcqjJHJmKmOLPkU3AqmP
         huMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxD1BBkl9JIlbm47I9lFASISQxJNSO0mhqGHNTEMVcw=;
        b=MpgDPgqAHfgmkmFhQxAdUBvSNYuJNNx+na1SbfpJAGDf00FNV0gvxDa3cQG1hUdrKw
         tGQcnJuOHRrQqhnhjBRvrbcDU9f4BzBsACE+L2H2gUDTgr9E1FrQMAzDJNEWm8Q56e6L
         pqFraO2NNJX0DAtvx6yGr33TyOjJHpxxyuhYyXO47YfsnJrON7BB6+4snQNwyVB49PVV
         YAU6k631FxzIMDKbr3X1HLyMbMqWgG9l8K8yNBzNp1tFwD0TM7IN70o+Ey4BR74ZGm7u
         rb87C5pqwGJeJ9aB2R/UfcxUbVzkEBq/I5o1LsuzPIn7kSjLJ7BpxgP5Fq9JFJMpOcOz
         qgHA==
X-Gm-Message-State: AODbwcCXmv5YgaMAQSHnEwRxxOcpus3/I8S5mO501i0Xzl6SSrNpBaDN
        Ze6AX/hA6Z8PIg==
X-Received: by 10.55.189.66 with SMTP id n63mr10341427qkf.89.1494717442448;
        Sat, 13 May 2017 16:17:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:17:21 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 26/29] pack-objects & index-pack: add test for --threads warning
Date:   Sat, 13 May 2017 23:15:06 +0000
Message-Id: <20170513231509.7834-27-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
 t/t5300-pack-object.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 43a672c345..1629fa80b0 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -421,6 +421,40 @@ test_expect_success 'index-pack <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
+	test_must_fail git index-pack --threads=2 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring --threads=2" err &&
+	test_must_fail git -c pack.threads=2 index-pack 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring pack.threads" err &&
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
+	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
+	cat err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep -F "no threads support, ignoring --threads" err &&
+	grep -F "no threads support, ignoring pack.threads" err &&
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
2.11.0

