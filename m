Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3282220281
	for <e@80x24.org>; Mon,  2 Oct 2017 13:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdJBN56 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 09:57:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:56820 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbdJBN55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 09:57:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6P5z-1d5qHa2eol-00yMTT; Mon, 02
 Oct 2017 15:57:53 +0200
Date:   Mon, 2 Oct 2017 15:57:52 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] for-each-ref: test :remote-name and :remote-ref
In-Reply-To: <cover.1506952571.git.johannes.schindelin@gmx.de>
Message-ID: <2d67e8e061c268ef996845e43b065630dc0330ad.1506952571.git.johannes.schindelin@gmx.de>
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pfr2ZQINAWhXseK9D608t64tdxjM3Hvnz5nM6HXAYafN6bfRA4x
 BRrrIcqO14ZTEdVLTfg4W79JV/CrbbUsxdGH5fFmTsf0D1QI7b99TiHt4K5vH9B19XsVvEI
 U51ijuMPe5d33lrTQW/Y7TsYlHRPH+lW/C2BGXsxDhChTer+hUdUKozRd9eO6/o9kSpINDI
 p2ywtrLSPwKye63GdADVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CW9DZFaM4lU=:tSwcas8h4RxelK0jhEnlCE
 If9SKapxIjCNN8iMkJPkNQ45ejC3emuu0/DVjcs9NrvK22PihKuB4My5J5TwBL3gjOCmV1VhX
 QMX7BYUB27S/8vmmxTAa/ekwRUsx+SAZFYNjvZG+ByhTBAyW68SEgRjhVa5ILcJVJIjB+y+br
 GM2ov0EKjHVHcZrKGsqm81HJp4WbC9gJ4gNMa3/zmXW+oh8NwzZC5f6zJnbyQyZWq4n1+KW/T
 R35J4nbStXyYck8t5zDHqG6OO3JIIZrXyRVd13sy2u+SO5F8EErvyYCZHv0t1sGCM1x5SCXNF
 VRdWWT/DYL+URy919nmsZoj8FVgmQOwMLF9Dqg77gLmlHjRU5x93PAgVUodzXyQndOydLMIRj
 aGjZv8DVDTs3IGuN3/GqibANM11CZYjxOx9FnfCfp4gs9TvZpzRu3PxmK9/LMvBMgdUSznL8F
 UTf09eI+99ykL24E8TPUwTuSF3c8oAdnSahe1nqElYg5GlZm08iREGMCUiUx7CRlTDoTE7ObX
 kgNm81cC0W0C6KlAERAZBNqRm7jGouU/918ckYMy4r1NrnRnCJ6K1Bf7EUyGFM/si+De5gJix
 mky6CNk4m1itrtCao259p8Y6kjF6vjQLI90d2YYIa+7OFR23WW/RtpNdIfUcK8I1WoX33nrO1
 HQlPCvxwNRWKmGgasHZjp5QL31YdTYbR16fX38W9X5pNsVHbn56kmZmqVZ+sTHZh0shZZalEF
 FTDGs5/Vip7u61fKDk6ysjzSxtnq4zLIikiJ4QtouC9ex2X25Q0cS5Vv93xIr876EtV7Yej0b
 rGwPxm70gJy/aGaxX61/qkmXg7uTbyWXmytGPh93EN1vyKBFvQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This not only prevents regressions, but also serves as documentation
what this new feature is expected to do.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6300-for-each-ref.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2274a4b7331..edc73dd79aa 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -675,4 +675,36 @@ test_expect_success 'Verify usage of %(symref:rstrip) atom' '
 	test_cmp expected actual
 '
 
+test_expect_success ':remote-name and :remote-ref' '
+	git init remote-tests &&
+	(
+		cd remote-tests &&
+		test_commit initial &&
+		git remote add from fifth.coffee:blub &&
+		git config branch.master.remote from &&
+		git config branch.master.merge refs/heads/stable &&
+		git remote add to southridge.audio:repo &&
+		git config remote.to.push "refs/heads/*:refs/heads/pushed/*" &&
+		git config branch.master.pushRemote to &&
+		for pair in "%(upstream)=refs/remotes/from/stable" \
+			"%(upstream:remote-name)=from" \
+			"%(upstream:remote-ref)=refs/heads/stable" \
+			"%(push)=refs/remotes/to/pushed/master" \
+			"%(push:remote-name)=to" \
+			"%(push:remote-ref)=refs/heads/pushed/master"
+		do
+			echo "${pair#*=}" >expect &&
+			git for-each-ref --format="${pair%=*}" \
+				refs/heads/master >actual &&
+			test_cmp expect actual
+		done &&
+		git branch push-simple &&
+		git config branch.push-simple.pushRemote from &&
+		actual="$(git for-each-ref \
+			--format="%(push:remote-name),%(push:remote-ref)" \
+			refs/heads/push-simple)" &&
+		test from, = "$actual"
+	)
+'
+
 test_done
-- 
2.14.2.windows.1
