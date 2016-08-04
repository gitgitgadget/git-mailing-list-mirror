Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 859D920450
	for <e@80x24.org>; Thu,  4 Aug 2016 15:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746AbcHDPEn (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 11:04:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:57230 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977AbcHDPEa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 11:04:30 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdYSM-1amwfM1Mgc-00ihKQ; Thu, 04 Aug 2016 16:54:38
 +0200
Date:	Thu, 4 Aug 2016 16:54:35 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH] t5533: make it pass on case-sensitive filesystems
Message-ID: <93e1fb21d1d24c5b751e2d9d25d9220704bae5aa.1470322425.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BdKwB/Bkbx9UQz7eALpFCx0nNOcL0IrJ4jZuv+LEUbvHtNcVYu/
 wWGo0ifIHIoCUoJqjsD/b4wD14hI9rSB5D1d03ZaxL2KvjaJOP03CPBOzYDvueBWbc6EHxT
 T8QasKyxd0WGll6RNWE8S5qinoIcUEcfjPBsTXUUO4koEvvkEGY7thDorEWIJBdM6Pe7ESA
 MRnoiDFt96TvdUn/AUAow==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:8i7qrT/tNGA=:3Zc779++AiFVBLdlqOdOeK
 OFNO5PzMk1Zy8uGZpYglKE30SRS8/AwBEdMUkHJmLJtl5gf3oiI04qZR7fiyW0/iJiWb8OjQD
 exrBsYJ8IeQ9XeTtjci0rGbvYMcykFXnSaJ8N961jdv1WvM9OdZ+ZUckQfpz1tGYasvcmnHTZ
 bEJrWiF8hKTO7f9KxvCidy58wkkk1Dcsc9BQ9OydIhYkrE79gW7XRq685G5/VRVCS7tA0lHJn
 3F4gJ81u/KFzJGp2zb2hGVDocbarhj2BzxXNWo0kFdx5xIJrEcjHmcA2uDd2DGtkBbri051e9
 tVRWZin0M25FOZo3GjV+vfKSpK3TS4RYITfqQPVGA8uaRxmhRzHf3yLIICJ3KUoKh91PWW+9K
 oA3n3qNGbA9nxR95BwZhHjF3J+xQxCsYi/L2KH3Trerndi2yTG9rIOlpnv99tIiOZauz5A7Cv
 IZgGznhup8WGgYsPlAbAMCRXqSvMXcYZjdnp1VmktJJrm8Q6Aic9VNs4ShWnUGmLyyUKPn1dE
 A7Iw071MM60LEOEMnCM3dmswge76egpFzrbqM9l0K851E8Zg42L5v3u54hBGwzG7id6hV0wkJ
 DIrbPbyHnA5Cm5kD5eqsAmphi07nMijRnLhxFDN2JAn+5EecEwpsqFojBDy2ftPht23zZYr7S
 drkk2AHAM4CHgvVykbeWIIg3RxKeyPXu6fw77OpjVMVklFZzf7GjvngxrwRGv0pmK2bSKsWNY
 ToKVl4vLRYMRvkOj+lVip1csDHCDkJg25ogszRlTt7TcJCHb4QS+Qon/Pbr87gvl/mkgRaC3s
 j8VE5iI
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The newly-added test case wants to commit a file "c.t" (note the lower
case) when a previous test case already committed a file "C.t". This
confuses Git to the point that it thinks "c.t" was not staged when "git
add c.t" was called.

Simply make the naming of the test commits consistent with the previous
test cases: use upper-case, and advance in the alphabet.

This came up in local work to rebase the Windows-specific patches to the
current `next` branch. An identical fix was suggested by John Keeping.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/t5533-case-insensitive-v1
Fetch-It-Via: git fetch https://github.com/dscho/git t5533-case-insensitive-v1
 t/t5533-push-cas.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 09899af..a2c9e74 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -220,7 +220,7 @@ test_expect_success 'new branch already exists' '
 	(
 		cd src &&
 		git checkout -b branch master &&
-		test_commit c
+		test_commit F
 	) &&
 	(
 		cd dst &&
-- 
2.9.0.281.g286a8d9

base-commit: 9813b109b4ec6630220e5f3d8aff275e23cba59e
