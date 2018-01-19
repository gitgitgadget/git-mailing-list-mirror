Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FD91FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932833AbeASABJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:09 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44913 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932753AbeASABB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:01:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so221133wme.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OSTZqggGIXeMr43ZWLSzV4vuV7hN+2LJ809bSUfqc3w=;
        b=HmyRDMyrauoWeOtxkgebk5N0anBLmsxrCN5H9fG8xAoXRRgc8yPvuqmlL8k9VghH76
         Fsas5bykH5IjRDP9ULMYFJZn8W2wTacBzBxpUjtqE5RaB11iFCpo2sJ7WP4KTL0fAWCW
         wCv5p9sJ38wnuiKg+5bRFrTn5QFdvntI3E/2dCr+srde+FauUhrsCmIZSezszDY7XjgK
         kTAd2wYeNNEXR93tO3ZvRUnypgRygWjXymRcVenjiOYkW61y/aCvDOLGVlPWbaBK9jTJ
         Dj1HO4V8IRqOfLM0XG58fAnt5pyL9s/YKpdEjsk1wCRGqd+ZB04NRYn6ddHAlp7B6gzo
         6YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OSTZqggGIXeMr43ZWLSzV4vuV7hN+2LJ809bSUfqc3w=;
        b=LQ02XJV9iEPSH6ZQOC0fJciAnsYrUa8k/JhWRaaXXZ+iS6sUed49IkBVcIuxZj6Mzr
         m5k8Y75TJZOsdn2pslYsJHpufT3QWoedm/bIytylT7BZT/001gENdxnvYOASgROkltcT
         A5fHNPBkzUVq0Hh8DCUdGOvrdeJpeIjmFxc2waEuWvbnbDfJEoIM7JDfFzRhQ3FKJGcV
         o7fYoDFLN4ZT4nDB4S1/VSD17Xks6DPZ/kfrCHhC1wo7dnqMDYKXTjMxGsB46KBSJBib
         b7TblIprcGhXCdwvYj3vi1brIMmEe+8e259Bpls1519fuMdiC6AZ4chXVAF1w8HKR0Zs
         vmYA==
X-Gm-Message-State: AKwxytd7r10epIZQCYC0yGHyeqYIlGMcLIJpRYkvY6fOhpfNPrI+LZYZ
        B89Dj2WLEr1aieiQB6h+aKl0Q+3X
X-Google-Smtp-Source: ACJfBovjK60gJJtVeX9PBAO8fZijww2MIDO4x4Sv6b7Oxh75a3OGAr7UBx2kb4pAn8Tgz7NnqAr3oQ==
X-Received: by 10.28.58.208 with SMTP id h199mr2797806wma.79.1516320059806;
        Thu, 18 Jan 2018 16:00:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:00:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/11] fetch tests: test --prune and refspec interaction
Date:   Fri, 19 Jan 2018 00:00:21 +0000
Message-Id: <20180119000027.28898-6-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the interaction between explicitly provided refspecs
and fetch.prune.

There's no point in adding this boilerplate to every combination of
unset/false/true, it's instructive and sufficient to show that no
matter if the variable is unset, false or true the refspec on the
command-line overrides any configuration variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 542eb53a99..576c2598c9 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -609,6 +609,10 @@ test_configured_prune () {
 test_configured_prune unset unset kept   kept   ""
 test_configured_prune unset unset kept   kept   "--no-prune"
 test_configured_prune unset unset pruned kept   "--prune"
+test_configured_prune unset unset kept   pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*'"
+test_configured_prune unset unset pruned pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
 test_configured_prune false unset kept   kept   ""
 test_configured_prune false unset kept   kept   "--no-prune"
@@ -625,6 +629,10 @@ test_configured_prune unset false pruned kept   "--prune"
 test_configured_prune false false kept   kept   ""
 test_configured_prune false false kept   kept   "--no-prune"
 test_configured_prune false false pruned kept   "--prune"
+test_configured_prune false false kept   pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*'"
+test_configured_prune false false pruned pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
 test_configured_prune true  false kept   kept   ""
 test_configured_prune true  false pruned kept   "--prune"
@@ -641,6 +649,10 @@ test_configured_prune false true  pruned kept   "--prune"
 test_configured_prune true  true  pruned kept   ""
 test_configured_prune true  true  pruned kept   "--prune"
 test_configured_prune true  true  kept   kept   "--no-prune"
+test_configured_prune true  true  kept   pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*'"
+test_configured_prune true  true  pruned pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

