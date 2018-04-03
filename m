Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7935F1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeDCQ2b (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:46633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752420AbeDCQ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:28 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MYfX0-1eyUzI3xly-00VOQi; Tue, 03 Apr 2018 18:28:19 +0200
Date:   Tue, 3 Apr 2018 18:28:18 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 05/15] t1300: avoid relying on a bug
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <4c8159bd9d77f7e21052e9c9b453f47b83847885.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:giKSn+xPUavS5bhKWFuxDMMkCQueWQC+TGHpgq8vaOcNzcbnXm+
 xxVViG48kWPZq1ArPFsYf1J1UmSCIIVvfLb7n6bZvoTk2Ne/xYMhTiP7Tr4/Hrq5mPSkVWU
 Wsd5BZpJKHj6AKVWPBGf2BHhclTVn1pbf8t/TeDVBzpJlKqxWLJKKmjJJvz19+2DP39BsJQ
 INZZb4UvM8BaJB2/Yz6Hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pPANpa0lN+I=:b6ugo6lzaVaFAVAaU6qA1A
 BjRfcbf0qYGbDUeZQLWJk179onFuT7Q40K9UM8Q5zXyv9amZborjQQv3TwlUz25Jmid0UVGp6
 5K5qeFOe2CkNqhS/MTwRyXK5khfF5HTw1yfE4FblSSlS8oCPr1TyCM/jIHMValc7fHl80bV1M
 kx2nFH4dCpc7VpeZEIiHpcWskMilLIS94K4DGTUhY8O8LEtyb7C6WA/AkiTCNSG0l2DwMkGbb
 HWVf+GoCZ2E0XSAk7XnZLQhXNzkQfl1gij7PDXhoUKob1wblVYv0/qD/DcVsZAL49MDQErgtY
 xysjOv0fu3t0bXY3aRptohM0NlUqWrq5pat9SSsuTgnZTw/cXctqlhtmOXWCPGUmbCBjplD/Y
 yBKLI3ihgn2C2fGISIHM8zx04fgFd0WsNOdN2u+18ETc7oLHzG4Z5nf+g65gK3OoDg51ZV4Ei
 //ZqxB7uVCQa04AEJuypAz+/RCy4N+5EUuoW0KEaITPMKQZZt4cEioL7Z0qHuV02mMoR3veEg
 h7chIYtz+cUx/8IW/gqg47Y/YYVOOaV1X0B/DzLOwwdJWE0VRhRH95ZOthYtRrdJOo48bp9Ep
 Ein7aOUE5Cc2kY07eiXN5xCylc+NI6JDN3NKFB5LbZsp58lShaTYNULvTAWmMkYSnG424M21H
 +7g6SFHHn4nl+VYCNszN+mqHKXL0VSyjwJ/TLWdBdqFzVhZWT+g1M4E8SUBZClxlsGIBMLmQj
 LSoLpVfIRc+uWcZWp0WAGTqgWHnol+FMqrrEEk/DW3+LqtbRzekvSjmp1Bp2mALIDwKHDeEMC
 09X/7OPy7iNtMZPEI+vg328Ux6YwHicwKwURg/u0en7PzjLbLYv6wgZdpW2+q/IIQLbnFeV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test case 'unset with cont. lines' relied on a bug that is about to
be fixed: it tests *explicitly* that removing the last entry from a
config section leaves an *empty* section behind.

Let's fix this test case not to rely on that behavior, simply by
preventing the section from becoming empty.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index aed12be492f..7c0ee208dea 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -108,6 +108,7 @@ bar = foo
 [beta]
 baz = multiple \
 lines
+foo = bar
 EOF
 
 test_expect_success 'unset with cont. lines' '
@@ -118,6 +119,7 @@ cat > expect <<\EOF
 [alpha]
 bar = foo
 [beta]
+foo = bar
 EOF
 
 test_expect_success 'unset with cont. lines is correct' 'test_cmp expect .git/config'
-- 
2.16.2.windows.1.26.g2cc3565eb4b


