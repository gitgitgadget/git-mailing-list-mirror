Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AB620281
	for <e@80x24.org>; Thu,  5 Oct 2017 12:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdJEMTy (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 08:19:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:58487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbdJEMTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 08:19:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI8iw-1e0dtT1Gec-003wn0; Thu, 05
 Oct 2017 14:19:49 +0200
Date:   Thu, 5 Oct 2017 14:19:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] for-each-ref: test :remotename and :remoteref
In-Reply-To: <cover.1507205895.git.johannes.schindelin@gmx.de>
Message-ID: <36f7929801fdb95953a2b2575a0461ae270ea530.1507205895.git.johannes.schindelin@gmx.de>
References: <cover.1506952571.git.johannes.schindelin@gmx.de> <cover.1507205895.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p7i1htjHk4tvvQBTZA1VpSU/MyzilPuPJ8uAfZMTqDvQErjChP9
 ObSNToQjjXcGY9y0XGBeZhdbUd/Pxzl6ngXp/Y1wht72bLmJavG4hQw/65CD0yYtkAfYJa4
 zz6ifFt4LmD+Eqg6bkjCbavaxhiz7KweMfA0iYreKqQv8Jvg8orXhmEhDAiDjrl3A3g0izr
 rUVNw/JaTXH929odQGPuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X0ATvIjCNHE=:UtjixNZztT6xgc+LaHgIZ1
 ox8JGKGAsOXlfgCdBj0+2IwL/6pCs6nIf8b3RhYcZ2V0mvCyM0YJ6n0CTkDo5XiwCZJv43RCr
 JUGCID9zqSkrLsqM8KYCK/QP9fb5ZyozXIJuhakgyGWTO4LnjWoLSzboBfk5vSkCRD9AKDHa4
 CjmT250GDZgSCj5c2bustr1UOuP5oeQ5rZG+dZeI5R4VhvQ0HEYzICb+9OtRVjS2s5l+qmDwb
 jGWW0eXY18H2vueBp5YWEB0qu0iQyEatGctVKrENgxed2D4ivKZNGmCWh4CG9su9TNgH83/rW
 CI1aMxpzNb1far9BSKMD7LIfD2Q5JqKROat+Z+S7Sg8Dj3Tw7MIF4/4ejy0vBUjTnCufBPRB0
 7PJDD6bZGHQb0jzUxsUc9NO8GgvYdniCrpp/sk/EsCAK5YeRjsTXiPhCK9+M5IJ4B/ta0WNy2
 f7fSvgs8ZzvZgFQEIu+7dyXHIE527DpeQIXR6gEqLHGDJR5DPKahyBmGgHkHLSO3N1bKoFAlD
 INhAIDBbkCJGvmVvUANESP+WiLJ63+hhXJYhHEYuQirUSE7GnMSiKfqgEs4ge5cnA7++myVPa
 h1Ny4+Ium7K/GEHTAINA1vAsFzHq6keYnVShWKmydAVlCtFX/Hk3oD/VmvR/50/OYX2Zab11y
 8usXblby97QnyJcNjYEl/a7PYmrCCrGned0XfCRqE9VBONJfXfYQXcz+p6/azEKVbgFUD51vV
 mW8Q2xULFmAj6rdKVWXJYI3D9alr2CldY3GoBVvG8VV+Y9H/Eo81fXl8l/CZjIC3A8YV2LyMy
 JTt9JC00iNXAGnaUmd2+EQr7IknNBu900WBaEs2PO6FZ7P+CJ0=
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
index 2274a4b7331..d9eb2be0256 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -675,4 +675,36 @@ test_expect_success 'Verify usage of %(symref:rstrip) atom' '
 	test_cmp expected actual
 '
 
+test_expect_success ':remotename and :remoteref' '
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
+			"%(upstream:remotename)=from" \
+			"%(upstream:remoteref)=refs/heads/stable" \
+			"%(push)=refs/remotes/to/pushed/master" \
+			"%(push:remotename)=to" \
+			"%(push:remoteref)=refs/heads/pushed/master"
+		do
+			echo "${pair#*=}" >expect &&
+			git for-each-ref --format="${pair%=*}" \
+				refs/heads/master >actual &&
+			test_cmp expect actual
+		done &&
+		git branch push-simple &&
+		git config branch.push-simple.pushRemote from &&
+		actual="$(git for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from, = "$actual"
+	)
+'
+
 test_done
-- 
2.14.2.windows.1.2.gdc85205db4d
