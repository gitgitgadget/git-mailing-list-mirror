Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670F21F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBHQUU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:20 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39706 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeBHQUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:18 -0500
Received: by mail-wm0-f67.google.com with SMTP id b21so11042502wme.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xWX+qnq4vDLiMtUKHAJuyIW9bWmnPaqNhf+1BKCOUm0=;
        b=aLDnJ6GrY14hMsKJ9T9dVsejU1EM/N8wxF6nW7QjNvlVwonBrYbnQsoLC4FADKn1SA
         CZJqwXObp8eAjFTpkySt9cFbRK5rnSFkCAgnJ2mWVRm3LmbPt638Vf00jVW+6SpaC+ID
         wzWpZc3rTIUHNcGIQzN4wXLlJ4p67En5KkYe7PJXb3CXxGKgIYPgvy+TSnotheLe5cex
         rjLcmkC/aZcl37NG1RruKoFFUi5XlMHSEtcx5H24PlivWuy4xmuC+1b4gd6YJq3RF9aD
         5r36YRf+Qi4vwz4XdsbteM6PpaF4uRdhohruIfLRthZTjJBeg4yylLsF6gy/kfE3fpEC
         Ay9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xWX+qnq4vDLiMtUKHAJuyIW9bWmnPaqNhf+1BKCOUm0=;
        b=FXSE4noJtqx1Ul7w1iHJXrejBo/al72WDnoFERA549tgWvEz/ZX2htolDtXhFvkgJ7
         a7sh2Ajv7YbnEem1L65d1vzKIopy5oetsR+0lTzukQI0GHYP65ng6F6uNndrNf1/a8qI
         jhOga0BaBxKrWfzjW4LCTpOwb4eEe7KuyO4R3L4PVHMP4vngHUgK35McDM0GMgcfNVdK
         BfInEQiIIsXmDeYfGWjvKBg6BO4Js8QEDxjST8reUSzLSUg3HeKcDQNpgHtSAoR80MKs
         4dPaIl/JL1SvCg3XyObAfkkN9V0I41zwRNxfvYa/Zc+wyVOCErkHpI48nSNvQgXrB1gi
         /wkA==
X-Gm-Message-State: APf1xPBoeStGfk1kHS0U03F5LXmdt+sDrUsVz9mCBsqvTy9+Aki+IAxH
        I49EHu2IZ89q86iS0LDkEj/Lzvft
X-Google-Smtp-Source: AH8x225Hb3WoQzqonTfwT9XZWBnvaxlno4UvOeJHJR1ORo9ej4pfbXrCsUyHx50ZuHTWefIfVCRUaA==
X-Received: by 10.28.247.11 with SMTP id v11mr1645461wmh.27.1518106817343;
        Thu, 08 Feb 2018 08:20:17 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:16 -0800 (PST)
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
Subject: [PATCH v2 09/17] fetch tests: double quote a variable for interpolation
Date:   Thu,  8 Feb 2018 16:19:28 +0000
Message-Id: <20180208161936.8196-10-avarab@gmail.com>
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

If the $cmdline variable contains arguments with spaces they won't be
interpolated correctly, since the body of the test is single quoted,
and because test-lib.sh does its own eval().

This will be used in a subsequent commit to pass arguments that need
to be quoted to git-fetch, i.e. a file:// path to fetch, which will
have a space in it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dacdb8759c..88d38e0819 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -578,7 +578,7 @@ test_configured_prune () {
 			set_config_tristate fetch.prune $fetch_prune &&
 			set_config_tristate remote.origin.prune $remote_origin_prune &&
 
-			git fetch $cmdline &&
+			git fetch '"$cmdline"' &&
 			case "$expected_branch" in
 			pruned)
 				test_must_fail git rev-parse --verify refs/remotes/origin/newbranch
-- 
2.15.1.424.g9478a66081

