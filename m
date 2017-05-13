Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7C920188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758664AbdEMXQF (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:05 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35283 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758554AbdEMXQC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:02 -0400
Received: by mail-qk0-f195.google.com with SMTP id k74so12530750qke.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmihBrR25yjJ9cBZFRZ9c6DvXOqVaSnUA2EgeXZtnVc=;
        b=r848maOTYzOgP0chs4X8U4aYjfg/cwct+GgZVSSS0H+1N7Snm2RS8RvYkvVR9y9rp3
         6WKw9Qpp+ulnzDNvoYigRg9A7NO5CvQg3MMbnvZnf3thv41iu+QR2KDYcu8PB6vdhlTZ
         IEy2A359NxvacwikY8YLA/uCmjg7QxZorsR6Iy8NGuh0s6K9qxQRDD4XwyYiEUp44cgI
         AG9SLrrjtcSxKKUTLa8l8hs0Yxm6QNmpw71MPtsgtyssWHdz6GqCIPjDEKGGDccizrnI
         0f6X5AZESSVX8exUm4qhx73kCZjSPIwy+ri42tfB8mUFEs95yn6/8lMg8RAPjS4kvUhX
         S/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmihBrR25yjJ9cBZFRZ9c6DvXOqVaSnUA2EgeXZtnVc=;
        b=HOuHumuZN2t8X5JsyEiDLbpcHvK5SZumptupAvOtzJJv+dMfIP6wfdme789qAXdsSN
         zqGyq5sVDKalDAM81M5ZwDfpx5ShuGae07qwiA3ptA3/aZIryxXlZ4dxAypZq2zqaJet
         P+cd/Vxij9IjFMO2qmlDMOyu6rpIRuXwXE2iFLcCd5ay6xz/7B3vBJ8xv6F707vH7gHi
         fcacpHbWNkZwNX/5R4uB3M5xB8B8QazXuDVYbIJx0LN/++gv2qvHVNu6TjYmffJkdkXz
         ysvn2dplgBgqDnfkzLCEDr9WsEJgZtU0JXTF4bOiqNih2zb6tqa83Xld8oi+f3IXlJYN
         IaqA==
X-Gm-Message-State: AODbwcA+6Tbp5zfHcmfF4YZRVphwL7iAkYilWtBBsoPZrH5C6PAH22oX
        aB1P2cbzko8UZA==
X-Received: by 10.55.53.210 with SMTP id c201mr9454411qka.301.1494717361104;
        Sat, 13 May 2017 16:16:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:00 -0700 (PDT)
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
Subject: [PATCH v2 08/29] grep: add tests for --threads=N and grep.threads
Date:   Sat, 13 May 2017 23:14:48 +0000
Message-Id: <20170513231509.7834-9-avarab@gmail.com>
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

A later patch introduces a PTHREADS test prerequisite which is true
under NO_PTHREADS=UnfortunatelyYes, but even under NO_PTHREADS it's
fine to test --threads=N, we'll just ignore it and not use
threading. So these tests also make sense under that mode to assert
that --threads=N without pthreads still returns expected results.

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

