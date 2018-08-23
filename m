Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301981F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeHXAHv (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:07:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37828 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHXAHv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:07:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so7099203wmc.2
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcSIre1OXnINZMtG8KDVG+2cshOl2bZ8FUyUnfUs1hc=;
        b=RiqSLoDIJuoQOoMuC8EzQ6brgHSgg69r3RnV9EUZh3yDSKI7t04L7U11RtL/QEBHEw
         esX86BN8aY/DcslICTfvYtlE84x+2dwf5X7TiEZh7CjatcaprEsmFyAqVBpZ+PVktHxy
         bTc3bqBfwNUZwEhtJaxUW6nr9mzSG82Z3kGwv5e4oZbxBFn1buDzxSblcZIqFG1cent0
         BxChQMGRSgHt2uTYIxrezZWFAYjhBZtip5pVTV3FI+xzhc8pB16Ax+nigpDweedDhQrk
         RIGhGmSAHjwAnxHZK0/B3yt/qQsJST4x3yuNJ5ZcU2mPdXtHQQeQRUEBiC9bubAfrKip
         Ub6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcSIre1OXnINZMtG8KDVG+2cshOl2bZ8FUyUnfUs1hc=;
        b=DWfowkkxUQB+U9V208zKBjzWwYl5qOFK/652uYNLdlaOAZFjfbN2QYdIjHWA2phmpB
         ynxxXAgwmDxNPN419s2W0DTked0bD9eFg5JF3Qbwzy06MR+y2pxHv9BqRviYnopepFRF
         iZB8icLIPEwBcuFwMx2bkc6D0uy8Buxo9mnJ0Fq+uyZ3POtYWDdlQW2tmoLViz5/qTVr
         uy8/7igNBb7mkKoE7hHS+Rdo6RKyP0lpKyhyuCImlbLvvPsUaNrCkLo7fFDKGUeqUzL7
         upOTS71bg2FIdMP5BbG6OtRfy6tVPB3wgVtCbAI7VelDa4PKVVlWbDUGQsik2bW4Kvds
         oCLA==
X-Gm-Message-State: APzg51C560opjcLrHrDMC5+vQuqIUdxMx+yIlDivplAQhQ9jT/dlDWO4
        GYWzpJ3RZXQmXdtwT5XBlFD/5mPlpcI=
X-Google-Smtp-Source: ANB0Vdbhlsgt1cBwTuDWNHlghzwJTS1rH4NxfJpRXIkeJijTdlbe1uByoB0gpzoy3eyLTruk+IykJg==
X-Received: by 2002:a1c:5e48:: with SMTP id s69-v6mr6067961wmb.19.1535056587938;
        Thu, 23 Aug 2018 13:36:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q16-v6sm3641898wrn.41.2018.08.23.13.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:36:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] tests: use shorter here-docs in chainlint.sed for AIX sed
Date:   Thu, 23 Aug 2018 20:36:02 +0000
Message-Id: <20180823203604.5564-4-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180823152502.3886-2-avarab@gmail.com>
References: <20180823152502.3886-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the portability of chainlint by using shorter here-docs. On
AIX sed will complain about:

    sed: 0602-417 The label :hereslurp is greater than eight
    characters

As noted in [1] there's still a remaining recently introduced
portability issue also introduced in 878f988350 ("t/test-lib: teach
--chain-lint to detect broken &&-chains in subshells", 2018-07-11), so
under AIX the tests must be run with GIT_TEST_CHAIN_LINT=0.

I don't know how to solve the other issue, and this gets us some of
the way to GIT_TEST_CHAIN_LINT=1 working again on AIX.

1. https://public-inbox.org/git/871sapezba.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/chainlint.sed | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 8544df38df..2333705b27 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -97,11 +97,11 @@
 /<<[ 	]*[-\\']*[A-Za-z0-9_]/ {
 	s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
 	s/[ 	]*<<//
-	:hereslurp
+	:hered
 	N
 	/^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
 		s/\n.*$//
-		bhereslurp
+		bhered
 	}
 	s/^<[^>]*>//
 	s/\n.*$//
@@ -283,11 +283,11 @@ bfolded
 :heredoc
 s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
 s/[ 	]*<<//
-:hereslurpsub
+:heredsub
 N
 /^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
 	s/\n.*$//
-	bhereslurpsub
+	bheredsub
 }
 s/^<[^>]*>//
 s/\n.*$//
-- 
2.18.0.865.gffc8e1a3cd6

