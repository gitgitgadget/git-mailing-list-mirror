Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E35E20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932131AbdDPWV0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35186 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbdDPWVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id l44so18459369wrc.2
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PuvPDhwrvZrMAOKxmKJAIc0P6L8Av1YtzTFCb4LCK38=;
        b=htfQ3bqE52cS71Nz5+fRohhBk+agjzcH9+EzEg3coWBMj803Di2JFbx37ILSlk/BJB
         9nnowuRbZtSkmAVr2t5dtbCmAmWOPYwVYHg4ucwI05OQ3gCUUmaz18+Gxt3TRZf/rD42
         BKvIlQ9HMvDOd441SRXrE8+jaG3x6TNDLmKJkt6TkHGgKmw7UFDt2OVONEdNOBWZtamz
         uhDQn7+1Bk4QAAaKxI/ZPQzmuMytJKDCGpQMLo2Y3OqDQoPEQsetBmYJMiG5+28J1HNp
         u+/SuHHox9xs+j1sE4Aafg3xvif2XKsv95lNfd47JDKYOfHrSJJptchx/sqiuFidSSCy
         LGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PuvPDhwrvZrMAOKxmKJAIc0P6L8Av1YtzTFCb4LCK38=;
        b=t9lQL4VT9toRLBYyR50sgJ1UY/32WPWWA93D36LFaSnHI0b6+H/vJu87eL/OpNO538
         uPCTIt3guNPyyqtw6PRNHH/n0/vOsfqzQgTVHqs4KgOzpGxCsIGywwmAXp/tMTFRa+ep
         hCaJmJfrX0jKU1x5cmGqOD66dZ3gyoP78nYIjg1WmGPAb0f60nVmKSUNbkvGGHeCa2fr
         VreHf/0q7gHTlFyVdoaNFWUyBMWqPILgqNbs9ia7usE4juKWQWCr/yzsEAwABlm3ZvRN
         gayMBzKzxzhAcvkeqibTedZwhtVsx1soWd+HfDUOdj3iXoq+wR4/m7BH50adnIFQJAnn
         xnIg==
X-Gm-Message-State: AN3rC/4Ie7rYP56c5WtG4CBh2AV6N4pMSP/wLt5z4Iyj4/WFM5Mj0K2C
        UxcU9ljxAq2ncw==
X-Received: by 10.223.171.182 with SMTP id s51mr2730096wrc.181.1492381283664;
        Sun, 16 Apr 2017 15:21:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:22 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] grep: add tests for --threads=N and grep.threads
Date:   Sun, 16 Apr 2017 22:20:56 +0000
Message-Id: <20170416222102.2320-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170416222102.2320-1-avarab@gmail.com>
References: <20170416222102.2320-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for when --threads=N is supplied on the command-line or when
grep.threads is supplied in the configuration.

When the threading support was made run-time configurable in commit
89f09dd34e ("grep: add --threads=<num> option and grep.threads
configuration", 2015-12-15) no tests were added for it.

In developing a change to grep I was able to make '--threads=1 <pat>`
segfault, while the test suite still passed. This change fixes that
blind spot in the tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index cee42097b0..4523ca926b 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -771,6 +771,22 @@ test_expect_success 'grep -W with userdiff' '
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

