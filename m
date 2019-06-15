Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35AB1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 18:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfFOSmm (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 14:42:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36828 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfFOSml (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 14:42:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so5795009wrs.3
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CR6y2b1qfNdnLTZ5r1QbIo5DiwjbIfaII8gZMySWzc=;
        b=sWiTCTgIrKph6lbz6Mi/tMSFxJm3HBXqF0qpBzwQiYuzOElCrzN1AFYtclt3yivLRC
         sD2U1Sfe8jbo4HArBWO2+ryyZHeixwdF9hqJFFUAJ/Hn4HseAZ11qSIHwvMyAvdfVy99
         CqNU6FA6pemVVaBdbe9ESSifVNbIrIt4BdninUuWQuQly255Inax0uqxHIpVlQABg7Xv
         fR5wFkR9TrWq3ePy3yFw0TndauN/KLQ3V9gnAWuYLhKOR/iU6/xegA0kaQQdNXMofeSo
         JBHcLQfVDzPo6IB5y4AtFLqdNM044BNSteQamEaAYl2IdQQM/2zJm53f7DvIJRhsu6WT
         9M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5CR6y2b1qfNdnLTZ5r1QbIo5DiwjbIfaII8gZMySWzc=;
        b=UeG7vAe/h7KuxzNXFCFPMIEMWJfHfgazukM7XWFJwjYqeF0ow/QlGtLlwVrOJK7bBh
         IJyQuhb5YRcDo9SEpHyH9C2f/PW/bsiqwcCvih4URRsA8TT/x8oznPmfgqMzQ45QW2sI
         fDH+FGZ5Rnp/0Qhh2sj776x4roHCHOZ8Vu+wgHCaU58pxvD6qyrcpHqj3BN5d/8LCkRv
         IeeQoqtdRQPiY5uNd+N5IGHUXftEUFB4HtkL9u5Y4xIRaFsdTcj2bhQZd+QtAMKIrKYI
         FVC6BtlyeKrVBzZQ7uw8WmpzvcZ/JI7pktwpAkpOLEhaOIaUmxRDinvSpfdoEQ/wB7CM
         qCmg==
X-Gm-Message-State: APjAAAUUTMSNPQCL9CTjfgqJu+8xhvkk32bxyebEM2/Ly1j9iS5wtD04
        GbBUjbiCrvTug7SmNDzsfmG4bq1jIYM=
X-Google-Smtp-Source: APXvYqwd4fUUPeMOhZszhg5gSlslMQgKbmNFI9WNwDXG1Mc8AY+ij36ZsN04sA5oN1bgXiJozXkVpQ==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr10137753wrs.289.1560624159372;
        Sat, 15 Jun 2019 11:42:39 -0700 (PDT)
Received: from localhost.localdomain (cpc91214-cmbg18-2-0-cust207.5-4.cable.virginm.net. [81.102.75.208])
        by smtp.gmail.com with ESMTPSA id f197sm9402016wme.39.2019.06.15.11.42.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 15 Jun 2019 11:42:38 -0700 (PDT)
From:   michael@platin.gs
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Michael Platings <michael@platin.gs>
Subject: [PATCH] Use an intermediate file between between git blame and sed to avoid git blame's exit code being hidden.
Date:   Sat, 15 Jun 2019 19:40:39 +0100
Message-Id: <20190615184039.3711-1-michael@platin.gs>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <Re: [PATCH v8 7/9] blame: add a fingerprint heuristic to match ignored lines>
References: <Re: [PATCH v8 7/9] blame: add a fingerprint heuristic to match ignored lines>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

---
 t/t8014-blame-ignore-fuzzy.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 1ff59624e9..13f3313710 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -332,7 +332,9 @@ test_expect_success setup '
 for i in $(test_seq 2 $last_test); do
 	eval title="\$title$i"
 	test_expect_success "$title" \
-	"git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
+	"git blame -M9 --ignore-rev $IGNOREME $i >output &&
+	sed -e \"$pick_author\" <output >actual &&
+	test_cmp expected$i actual"
 done
 
 # This invoked a null pointer dereference when the chunk callback was called
@@ -357,7 +359,8 @@ test_expect_success 'Diff chunks with no suspects' '
 
 	test_write_lines 1 1 >expected &&
 
-	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pick_author" >actual &&
+	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file >output &&
+	sed -e "$pick_author" <output >actual &&
 
 	test_cmp expected actual
 	'
@@ -387,7 +390,8 @@ test_expect_success 'position matching' '
 
 	test_write_lines 1 1 2 2 >expected &&
 
-	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 | sed -e "$pick_author" >actual &&
+	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 >output &&
+	sed -e "$pick_author" <output >actual &&
 
 	test_cmp expected actual
 	'
@@ -424,7 +428,8 @@ test_expect_success 'preserve order' '
 
 	test_write_lines 1 2 3 >expected &&
 
-	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 | sed -e "$pick_author" >actual &&
+	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 >output &&
+	sed -e "$pick_author" <output >actual &&
 
 	test_cmp expected actual
 	'
-- 
2.21.0

