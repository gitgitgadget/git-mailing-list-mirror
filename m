Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E7D1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbeHMWGr (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:06:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeHMWGq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so15186735wrt.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6U28EgmeALske6/l86D5iTyS6zP/4QMaN0HG1kOVhI=;
        b=NyoELKH8/z65VgAAkisLbt+M6CByeAdhIxBVlwOFjCKFuSDe28hMmaRGeactgaoreq
         8Fz27k5RQ9+Q+jABajqAtBwDVP2F1esYkwrSrvYoacbXmEbL/jltB3dL0jt7/PONC5Mu
         hv7+kqAgpLGep/pQH2kViEMsEVWllQlSMR2VEvfyr6IjR3QCOUg3L0fpHpl9pRirmaPv
         MT6fLNvRlj3dK5imYvBhJbZEX1h6rM8v4cBW1+8iXT1IZwpLZStA7qhtb+yWmMEGrhI0
         zmlqRVTf/2/W9m3so1Q3lGJpBAnAzhwZu1Cqd1nCYZNaaxSOVpYf30ChJncTq+URTjhW
         8nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6U28EgmeALske6/l86D5iTyS6zP/4QMaN0HG1kOVhI=;
        b=pbR/8QnN0UxVBWYp8IeXqByJbcN7EVpMrauV3Whj0aCMmLBTNytjanWomAukMG3T10
         +EvC/HPA4GJ+1NHdzbXus2z3H/vbzo76YYa0UkbMwnuA9/O/l2Uha0OiOvOGurR8yNmh
         f+MV/4/ZM2GszVI+PR0+k2MV6MVG4hkns3moVtSJULCqDuNPp0R4q42JFCIF4450Rh3C
         AnhyRUf+py83/uZ6vVHpQ6eTY8KMjXalfvebbrENM4CC0qHSY6okA6B0RrVC01pdWLhH
         lFOkb4iBkuSLe+TULd4T7WNKhiyN9mDEH9Ih9oUPvLnu+tb9AHoE73XuFz6gjIIFAgbq
         76aw==
X-Gm-Message-State: AOUpUlHmOTzuvWafNWhT00B94WjqXUFl/06YuodyksKeDez3WtTiPpkK
        +XBpj/f9S35GnIFW5w1vyX9ro41F
X-Google-Smtp-Source: AA+uWPznCUtjhVt9XK7jQC/PEGLzujGLDt6zJTSnhbtdhXKsgLdVX+kSbSAzgIV6IZt8BuyIyUJk9w==
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr11608476wro.279.1534188190892;
        Mon, 13 Aug 2018 12:23:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34929545wma.17.2018.08.13.12.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:23:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/7] push tests: add more testing for forced tag pushing
Date:   Mon, 13 Aug 2018 19:22:46 +0000
Message-Id: <20180813192249.27585-5-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731130718.25222-1-avarab@gmail.com>
References: <20180731130718.25222-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the tests added in dbfeddb12e ("push: require force for refs
under refs/tags/", 2012-11-29) to assert that the same behavior
applies various other combinations of command-line option and
refspecs.

Supplying either "+" in refspec or "--force" is sufficient to clobber
the reference. With --no-force we still pay attention to "+" in the
refspec, and vice-versa with clobbering kicking in if there's no "+"
in the refspec but "+" is given.

This is consistent with how refspecs work for branches, where either
"+" or "--force" will enable clobbering, with neither taking priority
over the other.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index fbc44273d9..c7b0d2ba00 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -965,7 +965,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
-test_expect_success 'push requires --force to update lightweight tag' '
+test_expect_success 'force pushing required to update lightweight tag' '
 	mk_test testrepo heads/master &&
 	mk_child testrepo child1 &&
 	mk_child testrepo child2 &&
@@ -981,7 +981,25 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		git push --force ../child2 testTag &&
 		git tag -f testTag HEAD~ &&
 		test_must_fail git push ../child2 testTag &&
-		git push --force ../child2 testTag
+		git push --force ../child2 testTag &&
+
+		# Clobbering without + in refspec needs --force
+		git tag -f testTag &&
+		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
+		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
+
+		# Clobbering with + in refspec does not need --force
+		git tag -f testTag HEAD~ &&
+		git push ../child2 "+refs/tags/*:refs/tags/*" &&
+
+		# Clobbering with --no-force still obeys + in refspec
+		git tag -f testTag &&
+		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
+
+		# Clobbering with/without --force and "tag <name>" format
+		git tag -f testTag HEAD~ &&
+		test_must_fail git push ../child2 tag testTag &&
+		git push --force ../child2 tag testTag
 	)
 '
 
-- 
2.18.0.345.g5c9ce644c3

