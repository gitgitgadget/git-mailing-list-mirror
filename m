Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47022070D
	for <e@80x24.org>; Thu,  7 Jul 2016 15:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbcGGPxQ (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 11:53:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:53019 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbcGGPxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 11:53:13 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mdr7l-1aw4bm0giD-00Perr; Thu, 07 Jul 2016 17:52:59
 +0200
Date:	Thu, 7 Jul 2016 17:52:57 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] rebase -i: we allow extra spaces after
 fixup!/squash!
In-Reply-To: <cover.1467906747.git.johannes.schindelin@gmx.de>
Message-ID: <7a3f6dde53593160e8200a7bbec902d8fdfcf6bd.1467906747.git.johannes.schindelin@gmx.de>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <cover.1467906747.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1aQBJ9tZbosBn12XRAZ+hTsjYdlsZ4SEZOpIwWotVF3m7QKE1SJ
 EPf7m6G4nLz8DLGUqvovzE/Z8PfVgA6e5fEsPtgmDyKppc5yhBZD4EhleOvDrsJOpcBj+Pq
 CUy390LceDDzHhPh4+OudXpYgp+pB5P7X1IxC8F/aMtdOnwvDe8Vz71+zXGGaXgXhIfG31r
 wLihheoj7xecuyB7f/qjA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:oea98GtIze0=:mrqMZN2W2C8iR9hk0ODfqJ
 F810L3oPBkQMCr4BOHERITTXwhhVbCz4DRUmxSOFB8E5KuS3GCQDd9j0wQfgnsqZ3DI3whi1N
 WgSOPJKh8hKf8G8MMrl0uqSjab4fPOIP8dUfaxqGqK5q8Ml1kxnNcws5WXQODDnHa24+Dmkbw
 Cgx1NjyZ+Egw1zU/MVGfbbJVgMnEc1dNVzCJw4hU1Yg9/vR7XN/dACVJJfCiyzDtAgWqpnjQJ
 f/OA7EqpoXx+XGaksxFHc7bWqJqEIuaScMfIIxZpSQIa5Cy9yWcNacivNREi5h4a26kUVy7YZ
 RcKrhs7RwmOuscuCKZmSXn2ZWQaUwXeS40pSxrlkGW2T8kbQZ+LcDEuXXyOP5RvCWWcsrMg8A
 km0qLOS+5HYWEWyriGaL+KmWLVrg8hrvTDPI6QwPPFt8cTB1k0TpUyQvks8RGOosUM5M76ywC
 PAK2SlzTD6PpO3yAT+LIrBT/C+F+vDEXO530PRdy1XS0zMCwSx358zRRF/PIxt4wGReH33CD2
 5c3R+9nXtcuDj7BCGuiI8x/m/xINCWRu3d1qsWnc7CGyLHjl6XV7QCoBno5o+lTWW12zvq04x
 SZ1vbeEvvFofKoTDvZJtfyDvnZCOoPq80qerINnUqO/NKIjCM6vAj9uJXX7yiT8cBwhKRkkN/
 if44PV3L6DpMQtxzHB62gwt3MEOP9AF7mYGqJAvCj0lRIOqL0e+jzvDI1531d5L+cra8fTGlt
 aB/w9wZoGDat6+KyTegHRpJsEQmlqOVCGm0O/Z9oylYeMHiVb60Q6MuApDp4Px9ucFae/z1Zv
 NRSoN3w
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This new test case ensures that we handle commit messages that start
with fixup! or squash! followed by more than one space. While we do
not generate such messages when committing with --fixup/--squash, it
is perfectly legal for users to hand-craft their own fixup messages,
and we heed Postel's law by being lenient.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 9b71a49..48346f1 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -295,4 +295,13 @@ test_expect_failure 'autosquash with multiple empty patches' '
 	)
 '
 
+test_expect_success 'extra spaces after fixup!' '
+	base=$(git rev-parse HEAD) &&
+	test_commit to-fixup &&
+	git commit --allow-empty -m "fixup!  to-fixup" &&
+	git rebase -i --autosquash --keep-empty HEAD~2 &&
+	parent=$(git rev-parse HEAD^) &&
+	test $base = $parent
+'
+
 test_done
-- 
2.9.0.278.g1caae67
