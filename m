Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD061F462
	for <e@80x24.org>; Sun, 16 Jun 2019 20:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFPUqH (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 16:46:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54679 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfFPUqH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 16:46:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so7160765wme.4
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xW+whJRstDmZ/Qy0R2dMPsQwoYuxAJnL592MJLYlYk=;
        b=WLbn0apIOFrY79bM6UMq6QzjFp8zzeUFhrEwjMn65c/ooTjBPSc9amedu/eOQPhc1u
         TTFb/LesnBy6pdhLSOppWgvuevxDyu0Hxn0RCx4PqpU6zIohyJhp+icxRdsGigMz63t8
         k4wtxm6IDUoIQDxph5w/6h8aZKYxKy6blGTIjuR1oeA8aBu41Wf98fVChuuwSst3iSli
         rFGxoO/ZJukLp9TsnyyJWZSkH6zA+i8uiMQKe8DyJDXHb8N+EOcQHNB3BXxcfC4PUx1W
         t4NGUN8oDkzt48awlsqasBOOQiq5YqSiQz6TsFOXNTNW52vLl6Y9P7O2EtQYdhxKo5Sb
         5T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6xW+whJRstDmZ/Qy0R2dMPsQwoYuxAJnL592MJLYlYk=;
        b=CTPTMI5fZpYjYUE1D5swg7GldZIBOncr3YbNydC/eqOy0pb+bOpMcCQ1ieqFX2rnSq
         HYRk44DaDgG+zyJsTALuvRkSPPLe12kT7XWsZtwRluNCt1bTHiN2EDmG1EzODrUD8uuD
         ybDsZCqwaSEgFfsn7GWqLqAdKa81t9sMz17GF6+pFumgse2DpY54GdOTKlHBvmaewJoQ
         5XDjl0Y4XNUPfGy7UIIFZXnzGVEltLMuwfBt5Zja6CCVdYHZafKrtHZE7+VhXTNW7ZCs
         aezLGoDjDKY3F493WdTliG97n27Vx3uoGdItc1lMwyW6c62gQHAVrMd8zOR3jMJu3hjy
         UAYw==
X-Gm-Message-State: APjAAAUvj5wJpIAYlGZIqiZvhSLGQu+PzKFt9Z9d2bTWFHrxPvS/npAd
        lqNRU748wQY3+6Ccrny8HrgZ0/ClX3A=
X-Google-Smtp-Source: APXvYqziKLqv6D29/ajKMDkWfjeP6KOUfXaN07L3Ua/u9YeAh2wpwd4kiOG898BP573dXNU2eqV5OQ==
X-Received: by 2002:a1c:c255:: with SMTP id s82mr16891624wmf.6.1560717964838;
        Sun, 16 Jun 2019 13:46:04 -0700 (PDT)
Received: from localhost.localdomain (cpc91214-cmbg18-2-0-cust207.5-4.cable.virginm.net. [81.102.75.208])
        by smtp.gmail.com with ESMTPSA id j189sm19704928wmb.48.2019.06.16.13.46.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Jun 2019 13:46:04 -0700 (PDT)
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
Subject: [PATCH] t8014: avoid git command in upstream pipe
Date:   Sun, 16 Jun 2019 21:44:41 +0100
Message-Id: <20190616204441.5400-1-michael@platin.gs>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613151756.GA31952@szeder.dev>
References: <20190613151756.GA31952@szeder.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

Use an intermediate file between between git blame and sed to avoid
git blame's exit code being hidden.

Signed-off-by: Michael Platings <michael@platin.gs>
---
 t/t8014-blame-ignore-fuzzy.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 1ff59624e9..6f1a94caef 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -332,7 +332,9 @@ test_expect_success setup '
 for i in $(test_seq 2 $last_test); do
 	eval title="\$title$i"
 	test_expect_success "$title" \
-	"git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
+	"git blame -M9 --ignore-rev $IGNOREME $i >output &&
+	sed -e \"$pick_author\" output >actual &&
+	test_cmp expected$i actual"
 done
 
 # This invoked a null pointer dereference when the chunk callback was called
@@ -357,7 +359,8 @@ test_expect_success 'Diff chunks with no suspects' '
 
 	test_write_lines 1 1 >expected &&
 
-	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pick_author" >actual &&
+	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file >output &&
+	sed -e "$pick_author" output >actual &&
 
 	test_cmp expected actual
 	'
@@ -387,7 +390,8 @@ test_expect_success 'position matching' '
 
 	test_write_lines 1 1 2 2 >expected &&
 
-	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 | sed -e "$pick_author" >actual &&
+	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 >output &&
+	sed -e "$pick_author" output >actual &&
 
 	test_cmp expected actual
 	'
@@ -424,7 +428,8 @@ test_expect_success 'preserve order' '
 
 	test_write_lines 1 2 3 >expected &&
 
-	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 | sed -e "$pick_author" >actual &&
+	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 >output &&
+	sed -e "$pick_author" output >actual &&
 
 	test_cmp expected actual
 	'
-- 
2.21.0

