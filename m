Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F3C1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755110AbdEKJTP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33752 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755080AbdEKJTN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so5502402wmh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQCPawmvniuH3n6dgvsgej9OWWq+kVHMcUGEChQMM6I=;
        b=gZHCPGDYEB+DJaf9Vsw5y53VBWY4x54WtdGmIwFP2g4yc592npGXXOQL1VtBLB9qtt
         03EaMriVACaOPgPdVZuChDB0ptXMPLIww0Y9xOuxX8rUlhZ2GQzSUAueAWJ0csqDHBTl
         FcLJZPkaWqrhdmVN91aR+LLhOh1FOSF1XjeMKzFeidSWozmxxduzx46BcJ7Iyv9p+vNa
         CahlaBBo/IfcC5lIaqfvvN8F0NNqRP3dmmJ3u9BYhESkD+X4sO/jSbxclbY/pTvIx9YB
         OTcFETd75AOxyjIattNC0WgcxO2VulTm+MXqXORjvdotbBdg7ZAxZU8eFfQR/COngNQe
         iJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQCPawmvniuH3n6dgvsgej9OWWq+kVHMcUGEChQMM6I=;
        b=mRqUlaXqozZg70L90yXRne47cws2Dx9FQAJ8kXTfMNjxt8NZthn05K4WM58/fNEJQg
         nHBMTWIEqcugNwlXMGKtAeh+mYubi7LO8TcS6TDqM+LnaVusOPURRUDqGkPNpXgnwYhw
         KIYuuQh1tC5eVzdd0NInJQsmAQ7imzDLFCxlMErX6sh7N/hgM2XiMJTZg3V7aLqRpVdM
         X0ew6ptxDtYmSPI1rhkPMMYJ3Ithy8oJpRlbz98IZ+ErE7l8Z2hop8m16YuroOPrNcGz
         PhMeZRmhP6J1lZKHqNR2Jg56debjK1rV9ksUBzwEjXVkkA1ng3g5e1eXCzMIdouEjzCX
         mNNg==
X-Gm-Message-State: AODbwcD3PXwmn3l3L8R0uy+0NX4mX+6zLeqZ1FPbXkpCd7w1nEiw5Gf/
        cRNiFMzPWgkSXQ==
X-Received: by 10.80.173.4 with SMTP id y4mr49901edc.16.1494494352252;
        Thu, 11 May 2017 02:19:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:11 -0700 (PDT)
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
Subject: [PATCH 08/29] grep: add tests for --threads=N and grep.threads
Date:   Thu, 11 May 2017 09:18:08 +0000
Message-Id: <20170511091829.5634-9-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for --threads=N being supplied on the command-line, or when
grep.threads=N being supplied in the configuration.

When the threading support was made run-time configurable in commit
89f09dd34e ("grep: add --threads=<num> option and grep.threads
configuration", 2015-12-15) no tests were added for it.

In developing a change to the grep code I was able to make
'--threads=1 <pat>` segfault, while the test suite still passed. This
change fixes that blind spot in the tests.

In addition to asserting that asking for N threads shouldn't segfault,
test that the grep output given any N is the same.

The choice to test only 1..10 as opposed to 1..8 or 1..16 or whatever
is arbitrary. Testing 1..1024 works locally for me (but gets
noticeably slower as more threads are spawned). Given the structure of
the code there's no reason to test an arbitrary number of threads,
only 0, 1 and >=2 are special modes of operation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index daa906b9b0..561709ef6a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -775,6 +775,22 @@ test_expect_success 'grep -W with userdiff' '
 	test_cmp expected actual
 '
 
+for threads in $(test_seq 0 10)
+do
+	test_expect_success "grep --threads=$threads & -c grep.threads=$threads" "
+		git grep --threads=$threads . >actual.$threads &&
+		if test $threads -ge 1
+		then
+			test_cmp actual.\$(($threads - 1)) actual.$threads
+		fi &&
+		git -c grep.threads=$threads grep . >actual.$threads &&
+		if test $threads -ge 1
+		then
+			test_cmp actual.\$(($threads - 1)) actual.$threads
+		fi
+	"
+done
+
 test_expect_success 'grep from a subdirectory to search wider area (1)' '
 	mkdir -p s &&
 	(
-- 
2.11.0

