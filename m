Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271091F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbeAWWOC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:14:02 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35238 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbeAWWN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:13:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so4895860wme.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=20WVKSy8nZbWDdNMnTQAaK/DS31nfEirl8V/hE95pqE=;
        b=L20xvpQrGvZZco/lQmF5/61gG2QrlQHWnJxL/8egep3JVUmey81pt7813+8ea5OWe+
         VZ7+db7CG66K+87HOm4hTx1bd47jbXgPkrA+FPdc+/ZVr7hwVPZAPWntEzQuef3J9Nig
         Du7ZUBzUOZN4LroUO4TnwyFDico37nhzWu3mrlAOeBscWcb9pMMdB0w6hliXx7yJsGMx
         spTKHfQ316A37f4wOB4MXCXWBxUaQ7oTPkuxEKqIqII9pvfsSaxxWRiyGjSFEheitKA8
         IHxUO3noGzGuEnx3H4bN23jLrJIUeoVSAEMmv7MqltXWqGZwZoCYnhUUUw1P3ZtoJraa
         Cmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=20WVKSy8nZbWDdNMnTQAaK/DS31nfEirl8V/hE95pqE=;
        b=sC91S4ANCAxgyoriB1VJmoGWcWwvluQZzuEt0ddKgej4hb063n8r/qrngwSRwyaWdQ
         rTEk77yhvrG986Kz8TMQgm1RAjuBuMedikBi6wzjMVrdH+0x/S3ZPpnKpr5vVZ4zGoK1
         aRhC4NJ23RgSx1wfPW4VWJiUygv7XE9ztk84Zn8kK3mG75Ow7HeM7jEe1zuUUjjN7DqZ
         GTDpdFNsqWSUPjvzq8onZo7qGikJREARfOLR0V21SwfUg0+oLU8F0vZqhsdVgGVKmCGk
         YzLGDZhPvqG5whM0QnbVzPAonEo7bq7Asj/u65Wis/ehTMmtwK5pSqWtHTe44dBcAMsG
         UNTQ==
X-Gm-Message-State: AKwxytc8nx6ALIK5+A00A8K1vSD6LEozFVln5TuTO/ChwuTDDfxPP/xT
        f6i9K/nZMBpXv+BJ4ZOPg+165y+Y
X-Google-Smtp-Source: AH8x2241gNqylwe3d7zj5nPO9r+sjyqcFRZbPYQENZbmNCcJMmTW+BkcZnYdgrwWi1ZqE2APnCHnfQ==
X-Received: by 10.80.220.141 with SMTP id r13mr21112358edk.120.1516745637631;
        Tue, 23 Jan 2018 14:13:57 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:13:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/11] fetch tests: test --prune and refspec interaction
Date:   Tue, 23 Jan 2018 22:13:21 +0000
Message-Id: <20180123221326.28495-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
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
index fad65bd885..e5e88ee474 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -609,6 +609,10 @@ test_configured_prune () {
 test_configured_prune unset unset kept   kept   ""
 test_configured_prune unset unset kept   kept   "--no-prune"
 test_configured_prune unset unset pruned kept   "--prune"
+test_configured_prune unset unset kept   pruned \
+	"--prune origin +refs/tags/*:refs/tags/*"
+test_configured_prune unset unset pruned pruned \
+	"--prune origin +refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_configured_prune false unset kept   kept   ""
 test_configured_prune false unset kept   kept   "--no-prune"
@@ -625,6 +629,10 @@ test_configured_prune unset false pruned kept   "--prune"
 test_configured_prune false false kept   kept   ""
 test_configured_prune false false kept   kept   "--no-prune"
 test_configured_prune false false pruned kept   "--prune"
+test_configured_prune false false kept   pruned \
+	"--prune origin +refs/tags/*:refs/tags/*"
+test_configured_prune false false pruned pruned \
+	"--prune origin +refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_configured_prune true  false kept   kept   ""
 test_configured_prune true  false pruned kept   "--prune"
@@ -641,6 +649,10 @@ test_configured_prune false true  pruned kept   "--prune"
 test_configured_prune true  true  pruned kept   ""
 test_configured_prune true  true  pruned kept   "--prune"
 test_configured_prune true  true  kept   kept   "--no-prune"
+test_configured_prune true  true  kept   pruned \
+	"--prune origin +refs/tags/*:refs/tags/*"
+test_configured_prune true  true  pruned pruned \
+	"--prune origin +refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

