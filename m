Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100691F461
	for <e@80x24.org>; Fri, 21 Jun 2019 10:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfFUKSd (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:18:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUKSc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:18:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so5983130wrl.11
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugShOYf8Li5vms2a7LuBZrSltUjtVP/P1t4CWD/xlWY=;
        b=ivYQF+9Cl8uK/87RPhCmRUwDvgua00cCZEMS8FSaT0EOt+GQxhJ289GeL/Q2lVVkbT
         MxJ72PEwrPV5m5X14bInDfC+p5kFiFMqtUoqwuTNGRGlFIKLMh/5PQAWMIClwvOXVDPk
         QxwP60/k8kHSSqzJMywBR+rRiiH0apc/48nKn68L3dWEq22N4quR0B8WnhXtP9wZ80RX
         RN0fwTKCMK0Y1F5VG0jVTApPGJKgeOTAGet7VO1NItHBgIfOuH27JMM4RpRgZdCFIGkU
         Yx89pZK5uJcVtQy4u2WkC/otxWZKtxACOep4w5Gh2dpW2KWX1wsp+qFvd8Ff+DwfywQ1
         vqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugShOYf8Li5vms2a7LuBZrSltUjtVP/P1t4CWD/xlWY=;
        b=tV6hNsuTRcHaYAmRqvTS+ztHR1QIgQi93+TQd89eSVoiqS4RPwS99N42BVUsgWXINA
         4cupYQZxT/PX6q4jTNeybRG7iADjqy+m4Ig0ZqqHtY1t2cHW1P+gp9PK3+4UacgGNwjb
         Tp/LkS7CwjAZKuNsY5kc7FXrF9YwtERyicSQ1I8eBBYiiceTYE+OzREk8CDrLQGN0e7Z
         LJv4k8EBF9yr9Jfgv5JHV4OrEZgNoWjLkP8QzoUK1A9hPwzsBpqxxCvznM2+gtmzVowT
         b7HzWQU1OOvHV8sht22x9F9ONHck1Mi19+tq9ghV5B8DvQuEZxP4EfahECOu1pSnikgV
         EdwA==
X-Gm-Message-State: APjAAAWP3W5EtBRN0IkhKFztMog5WYnmjWg3oW5YL6qJxyIj5eb6LP4h
        VNi8E/sQRa2Kpb39HiQapAOs8Qovp4s=
X-Google-Smtp-Source: APXvYqyKZO8j1HEOWk0X1AuwvW60Uc1dpIJC+2ttmuwlyCdjTTP3Nb5ZOrK7JrORbHm4eDpr3DzVMg==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr18335437wru.195.1561112310313;
        Fri, 21 Jun 2019 03:18:30 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y184sm1878193wmg.14.2019.06.21.03.18.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:18:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/8] t6040 test: stop using global "script" variable
Date:   Fri, 21 Jun 2019 12:18:08 +0200
Message-Id: <20190621101812.27300-5-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190620210915.11297-1-avarab@gmail.com>
References: <20190620210915.11297-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change test code added in c0234b2ef6 ("stat_tracking_info(): clear
object flags used during counting", 2008-07-03) to stop using the
"script" variable also used for lazy prerequisites in
test-lib-functions.sh.

Since this test uses test_i18ncmp and expects to use its own "script"
variable twice it implicitly depends on the C_LOCALE_OUTPUT
prerequisite not being a lazy prerequisite. A follow-up change will
make it a lazy prerequisite, so we must remove this landmine before
inadvertently stepping on it as we make that change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6040-tracking-info.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 716283b274..970b25a289 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -38,7 +38,7 @@ test_expect_success setup '
 	advance h
 '
 
-script='s/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
+t6040_script='s/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
 cat >expect <<\EOF
 b1 [ahead 1, behind 1] d
 b2 [ahead 1, behind 1] d
@@ -53,7 +53,7 @@ test_expect_success 'branch -v' '
 		cd test &&
 		git branch -v
 	) |
-	sed -n -e "$script" >actual &&
+	sed -n -e "$t6040_script" >actual &&
 	test_i18ncmp expect actual
 '
 
@@ -71,7 +71,7 @@ test_expect_success 'branch -vv' '
 		cd test &&
 		git branch -vv
 	) |
-	sed -n -e "$script" >actual &&
+	sed -n -e "$t6040_script" >actual &&
 	test_i18ncmp expect actual
 '
 
-- 
2.22.0.455.g172b71a6c5

