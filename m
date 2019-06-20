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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4DB1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfFTVJf (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:09:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37939 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfFTVJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:09:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so4435069wrs.5
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugShOYf8Li5vms2a7LuBZrSltUjtVP/P1t4CWD/xlWY=;
        b=qZcbuupzXzdGDXBK5EqIlVgwElenOWajEmyJBGYoE0SapJe4+7E75LP+NVRnHT5Uoa
         +uz3EhVIXRJE2/dsFaEPo+N18LasprnkwxTO7QVg9xgAFf9odU/t4cKy8s+/df6Ztw9p
         4xfNCi3fywXby8/4Niek3RKMKj48nBQkgVF1EEI+zijVW0MfNByhLGM0xKz1sjOgtwY4
         5gNLwILHqrG7AqYBLbTHxe8lyT9/ruCO1ud+lQKrgWlD0leAG1c/asjKai4c3TSD7Yzk
         skcsuM6z5fi0kFgkbJdBBlcz9trWe9+RqFrSB3tnUJReQrrS88w6NpuyuXoe1z9IiUCo
         CVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugShOYf8Li5vms2a7LuBZrSltUjtVP/P1t4CWD/xlWY=;
        b=hwVMsRi6pQIVYyUN5oiv7sR/7L1D5u8S+Y5hboQ0LEBOZe6yE1Gckt9rM0SHidCg5h
         iuz4YKEZpVu2iffd1mxmfYXtzAZ+lWmx0Wo4y+C35kn7tXKmKpCY5XCtmgkDghNNJQii
         WeH5jXXOtsfrU4tCl1+IDr+DRiD/xhDrThpkWpR2gsmv70SvQmUWG+Xr93m7fqDDy10v
         XxL8YlshHm12Eok8Z0dYiVQ+hP4w4NV5SROtIPPOYw2Kq2jZjn4fILsKL/34JaVO54wN
         lVAMPFUVwkj9g1a/o72g4ryhnC6GP3bO8al8B0YwsOkHMwncL4oX+I76p2mUa/jjF4YB
         DXzQ==
X-Gm-Message-State: APjAAAUcJFMyUdSPpTNJG79klDOvTk+6bKxU7/Wd6VjxK1NYSgz3Urd7
        zGB1G1MSEzP5ftsFvP7R82nqZ4q+vVU=
X-Google-Smtp-Source: APXvYqy/99ift8F2x4Z1P67JirVrEC+90kzh2uOF1nD5rXIEszsYHWXUw8kKUgBv1Gjm8Av/5ZcM3w==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr19931143wrp.147.1561064971451;
        Thu, 20 Jun 2019 14:09:31 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm1295781wre.73.2019.06.20.14.09.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:09:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] t6040 test: stop using global "script" variable
Date:   Thu, 20 Jun 2019 23:09:11 +0200
Message-Id: <20190620210915.11297-5-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com>
References: <20190619233046.27503-1-avarab@gmail.com>
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

