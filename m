Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C761FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbdFHTxv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:53:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:60216 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbdFHTxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:53:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN1C4-1dCSrR0Hv6-006hBr; Thu, 08
 Jun 2017 21:53:45 +0200
Date:   Thu, 8 Jun 2017 21:53:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] t1308: relax the test verifying that empty alias
 values are disallowed
In-Reply-To: <cover.1496951503.git.johannes.schindelin@gmx.de>
Message-ID: <b9e212d508e9103037da2070cc0aaed530ea7473.1496951503.git.johannes.schindelin@gmx.de>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NRBRl/rno8wHYNf41opWvxq3XpWyb+fhymmZi9wXG1KqQG1f83E
 yV6Ult3AKP2Y15qck5q9Ml5+fC0XRv+vRypOx+oNjzprkRAAP9Vvw5n21p93zlwz22mQ6UZ
 dnzeXCYrResrHKhJ3pLclt2Vy83D2D0aRH69TU54ZGNLWJONJJcoIQccvpROdKtviR3hofA
 i2H1khoS9Z/PYp29aE3+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jPjtsArji58=:bN2GzhXHC9N9YnEiD9LpTl
 vAAdLkr9VBaIrnLcKolicTlfpuHIAns2okSMFBkqRSgrgD5L5hxtClCGsEgv7DKdo7ltfIVtm
 1sAu4rUhm+CLrhtsYQA/NPiR39Gda9A8yMjj+01MgjsFyn9QxQFgW0IVhTjKmdqOl5UG3Vf5t
 BG8e7sR8S4golyrmneHZiHHp4z96q47nVHo9YPhs2NpGcZLVTjP3/lYztC2ak0ui02LznLPQh
 YYCzfyEsxBZluRP25uaFJ5gR/XBcrQvsQn4nhMmZE5LXI+0WCPnglpALFruFbUQ2uE6gGx28/
 bO1hMqIojJM4HIyLLsz4tIn5gCtylojHEwf1EsQN4+rDtE/BL/uFFWz+Iw+VdwPgauY59Hdr7
 y4iOrFcU5Tf+32KiqnO8NtjUgKymyYe8OU/zthSgEWcQ493+G65zSliPf6ZPAQtpcdvpEI1aB
 6B2M9GN4nwANbD8HGnA4cfGmJSe31Y43iencZhu238BtR/w1bJatu9huyUU00THrKYrBOR4Cn
 pN0VQTEBdEOSz3yWK7UZE5Ty1xL9HuhBffkc0vbkKUzgl/4lBPNW/1RdDG/H/WQ+4HshDZs0m
 VAnnZdN5jdNVkRxxpIlcPPVdtZnzLBFBquBp2JFqARBaRJhRIoxVYPA8ipiRlY/zC4voflEFb
 PnERwjvGtr5ClKuONsQmMEntitPMbScEBV/yLD2M0/2UsuYaCKbLi9GEb1iYTeDiUoWwt7J2B
 ZU9KhYO2nLRk8mvNqafayLumYCAlkCwDYxIOsCvJ5Q8ntcLqTF+Z/QRgcd+LSBmeTxdpypHi8
 vZXM6E+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to change the way aliases are expanded, to use the early
config machinery.

This machinery reports errors in a slightly different manner than the
cached config machinery.

Let's not get hung up by the precise wording of the message mentioning
the lin number. It is really sufficient to verify that all the relevant
information is given to the user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1308-config-set.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index ff50960ccae..69a0aa56d6d 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -215,7 +215,9 @@ test_expect_success 'check line errors for malformed values' '
 		br
 	EOF
 	test_expect_code 128 git br 2>result &&
-	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
+	test_i18ngrep "missing value for .alias\.br" result &&
+	test_i18ngrep "fatal: .*\.git/config" result &&
+	test_i18ngrep "fatal: .*line 2" result
 '
 
 test_expect_success 'error on modifying repo config without repo' '
-- 
2.13.0.windows.1.460.g13f583bedb5


