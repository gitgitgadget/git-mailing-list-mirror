Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1D451F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeBHQVG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:21:06 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42256 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeBHQUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:17 -0500
Received: by mail-wr0-f196.google.com with SMTP id 41so5296922wrc.9
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H2ky4/zyJdp/1HOFHBkgk1fnsJrt6y6l6cHnKMNfxtk=;
        b=ZO4WrWk4Q7Wu8piCVn8Zz55dmNsPePxZP5nIKmNekfcP599sAx4+rL1cZU3rv0wu+z
         WpOSaWoPOlJ2fA0q/uwwVC5VYRrhua9vTB8pDCKz03LsVMAccNET8/9K+2/nn2Vr9BES
         V8FkI5GgW9LKSnYyHwVPsBHmbFTmS1zIfT9b4zWi0M9+Id0rAcxUE3W8mZFzolRGmBsW
         WH7IlYoL0I5YyEc592x0hlRHC2dKK6zm30xWYIufcj2bYgATxiNmCwZKYJVt6tcOwnkf
         YzSS/ZhGJKmOHsuOKBt9n3JJY2rU4HcNeOC9UCKB5I4XPrAcn6wAbWS7+jXSo+BTK/Z3
         6dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H2ky4/zyJdp/1HOFHBkgk1fnsJrt6y6l6cHnKMNfxtk=;
        b=SIDHBqls2ioPf1Ys+T6y0S6haJCGR3rpnV5RASDy7P3rU6aSmbC6GafWs1LQbChoRY
         /sTk+1uBL1hp8rV+Qf0Pz+J8EMVCJXjrlnrzN1W6GrF5T14E+AFlZoqn6zfZIW/0XK/i
         dUngwk5hbPD2ZlRy3Dw3OSgjkKDWpS0RO73n3KAyRg++b0JHGwC4xnO4Pl3Z+ECSZckI
         YAgrZBLI83FrRfuSKHzW3gS3okzZqkYfCiVqbfKEhs24M1hA3xnUjsvsztikBW8sKn3f
         2a4l2K+FJfeQO7EvoKZgDzbPCKZMwYP7Ax+BsdMGjN4BarkMQgrPC0dtREOs4dSBem6W
         LRFg==
X-Gm-Message-State: APf1xPCYkYHoSZD67MpdTxDj5yOgfI115u9UQTx2+D/jeLUUo3Nvl9mk
        Gdc1XMxFOkqXXAU6nO9MuliugCnP
X-Google-Smtp-Source: AH8x226+KhHvyWLx0NNmUlZtKbQTpDB7EAHB8arNh3iRNxKuzdlkidTj7dq899iToZqOg4lr7zTP+A==
X-Received: by 10.223.170.221 with SMTP id i29mr1359199wrc.270.1518106815692;
        Thu, 08 Feb 2018 08:20:15 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/17] fetch tests: test --prune and refspec interaction
Date:   Thu,  8 Feb 2018 16:19:27 +0000
Message-Id: <20180208161936.8196-9-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
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
index fad65bd885..dacdb8759c 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -609,6 +609,10 @@ test_configured_prune () {
 test_configured_prune unset unset kept   kept   ""
 test_configured_prune unset unset kept   kept   "--no-prune"
 test_configured_prune unset unset pruned kept   "--prune"
+test_configured_prune unset unset kept   pruned \
+	"--prune origin refs/tags/*:refs/tags/*"
+test_configured_prune unset unset pruned pruned \
+	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_configured_prune false unset kept   kept   ""
 test_configured_prune false unset kept   kept   "--no-prune"
@@ -625,6 +629,10 @@ test_configured_prune unset false pruned kept   "--prune"
 test_configured_prune false false kept   kept   ""
 test_configured_prune false false kept   kept   "--no-prune"
 test_configured_prune false false pruned kept   "--prune"
+test_configured_prune false false kept   pruned \
+	"--prune origin refs/tags/*:refs/tags/*"
+test_configured_prune false false pruned pruned \
+	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_configured_prune true  false kept   kept   ""
 test_configured_prune true  false pruned kept   "--prune"
@@ -641,6 +649,10 @@ test_configured_prune false true  pruned kept   "--prune"
 test_configured_prune true  true  pruned kept   ""
 test_configured_prune true  true  pruned kept   "--prune"
 test_configured_prune true  true  kept   kept   "--no-prune"
+test_configured_prune true  true  kept   pruned \
+	"--prune origin refs/tags/*:refs/tags/*"
+test_configured_prune true  true  pruned pruned \
+	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

