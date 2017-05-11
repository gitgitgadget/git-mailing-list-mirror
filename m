Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE622018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932897AbdEKNsR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:63779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932730AbdEKNr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:47:56 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEFIm-1dFO1x34Po-00FQU8; Thu, 11
 May 2017 15:47:53 +0200
Date:   Thu, 11 May 2017 15:47:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/11] PREVIEW: t5510: convert .git/remotes/ test to use a
 regular remote
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <1fd886af939e1fdb9a7e3a250f0b0fae56f716fb.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vcTEd4QXe9KZxiRWfw4eDzyrWQtzkgCGcgll5t2TXXnDHDKo/RP
 19oCIphVvTqqmK+Ns0jks9g7lY54Uov3KABuOq5T08gw+T/IJg8I5nqXWLw9qyyKIUo+Fno
 mDZAGo6+kRvXcCYqOfuq7w6RxFn7i7wIM1okgdh/LNtEhBhyvj5CTuZwTmGAZ8xzZD8Hkrb
 fBYlXSCnyDLv9NNKH0JRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EOQU+ot6He8=:SRwGTWHieOgT2MtHrknv2O
 P7U/Lor2wwSC8DjrFV+pdvQTvRyT/BwGJQQOcBcdeDzR+gfWbYKM5bVStSr1rsw8TLDVbE5JR
 JyeaEwH+/LbdBEdbQo6qqjUV9zvFtUBy1Y/DH7M6IEuuElf558xZrZItOBNMayXx9iIpxtizg
 ARe5X+c96lWJ+s1rTJcAYg1XS6Zpd644cZMGzUgLW2UEPEjLy92hT7Sk2BmIr7+MFeyW4xixV
 WhznBw/VO0R7DgaApiEo5I5Z6Xt48XWdikVt/qCT0xrgFHcng6xJJZiqpGpKkm2e2JLBFcY7F
 VJgyMWL0YkN05T59kMdq1xWLNqHgzPJjWvgSKHFpZO49SEjotz2+YG25ikD5lYVGbB/IYu7cs
 ymhnr6u/Y2P53VzIfhVkzMr1vEIDdV0BS89pS1aGQJsDE2paVXFpOQW6SiPYhS4P/X4SCoU5d
 VZwA2R9Gbt+vry+Sa7lKDQG+bZdu6PpEIfRLVIUjZvRmuf/ktM6yZ7hsRKcuAlv72yeZbwQ3b
 K06qxK3DNP6oTK1SZSQHmx/plE/gQmxQR08pScy1aJDgxewlPh5FMnLstGIm9hCj108L2mMxm
 FfZkap/9fDzWxQVBVx0EvvUCtiQRcY1fSmKfh3iyF5TLRg+zMJ0rKLJS4WS+mSffwqlLkaVSU
 vx7ccqbWuo+ZBdT3ONl9CvK6AUUaKIMlCWh+Eg34dcDCeeQFuYdkqeg4LGBDRk1PIzc2RMD6Q
 ckOwf8+dF2jERMt12znlBBUVIAzhfCuk0bSqCuhfSWHIypalr854KCkmihTBa8UzCtMmxctgL
 HVCnItN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to stop supporting the .git/remotes/ and .git/branches/
feature. In preparation, t5510-fetch is adjusted *not* to verify that
.git/remotes/ works.

As the tests are entangled, we do not simply remove the test repository
with such a remote, but convert it to use a regular remote instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5510-fetch.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 668c54be41e..f51b3360348 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -46,12 +46,10 @@ test_expect_success "clone and setup child repos" '
 		cd three &&
 		git config branch.master.remote two &&
 		git config branch.master.merge refs/heads/one &&
-		mkdir -p .git/remotes &&
-		{
-			echo "URL: ../two/.git/"
-			echo "Pull: refs/heads/master:refs/heads/two"
-			echo "Pull: refs/heads/one:refs/heads/one"
-		} >.git/remotes/two
+		git config remote.two.url ../two/.git/ &&
+		git config remote.two.fetch refs/heads/master:refs/heads/two &&
+		git config --add remote.two.fetch \
+			refs/heads/one:refs/heads/one
 	) &&
 	git clone . bundle &&
 	git clone . seven
-- 
2.12.2.windows.2.800.gede8f145e06


