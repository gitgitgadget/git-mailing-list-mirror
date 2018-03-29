Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31E61F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeC2PS7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:18:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:49845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbeC2PS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:18:58 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAVV-1fEZra3a7d-00MNZN; Thu, 29
 Mar 2018 17:18:48 +0200
Date:   Thu, 29 Mar 2018 17:18:45 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 3/9] t1300: avoid relying on a bug
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <385674162d2853f6aea153d9d30482034d9fa3df.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MavxHxPwwn1T5MVQhbwWJ+cP6hEemjTvOrpHNgA51ix/tldSKjT
 tPDDLvc4fl8VJMdvllk39/42DMht/ck1WxYXi9OlMCBpZpiJl+cOUxMCpF0+9q7uu47Ol1s
 fJXFsm6nTo372FQ0+uk4TdkbTNujmQk71emmCF5qzluQsVsYZtPCTXmvUcYEnSEH4ch5rSI
 GpqBkFYTd7y8C3xCQ4bMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:551JzqB1UYA=:73X8GntlzoZ5seKxVtGsrh
 of3mDzwEcELcP9RFuyu+bCGOzVPTwXcMWYpO721y+rnzrsWnRmOmv3OEB4d8JI1Rryuswc41M
 K6lAaXd9Go3HzycL2RtkNaIOlWlclinbxJTVAwRJmXpbO/5xqlAUz9f2sWQTYRS2wn5dsDGIl
 OBuo30Os4mpP2UHzHKWdvbB3CNR1B6rSfSmrzkr79faNZI2a4Qj36aSMgDQuJG6LJ/Bl1JzhH
 wg1LbvBOoqD0MD3iHTlk8zW7bB0D/T5pxu/zCDxwrriBhYKKs+L39WXOA/3UV/Y8zo0BpB9OD
 jGw+tOcGOdCehXln/jPN/UuHtFwGcD4KJhDoo+bRX+EfqWN3HId9RW1BT4/JCpyFyKtwZlgAZ
 iSFpTFjbw16mafAM9A9iWGCPQAc8F4Pbd3subLJHX9v9GrftwxjTevnoFiUcPkzhSFRPJnJIQ
 jHh5qW3oJTlRRPFMikLobHnSOSXbaAgG/NnfIbytorbT8XC59Z2OnYGMcXajsIpKXK4d9n5Qm
 gjdqrVfQX9TZcg/GP9ka0/0D70maBK/1eBUD0qpwNn54H9rdHcJKiakG1NkIGkViSL64A31W5
 E1rAsFiQQB7Z6DooX3OnbQ7s3lRL/7D7AdforklAGK5qp+aoim6UFTw9hFRpZyECWVIPK57ha
 X/kiNW6eevDu8synla83UDot5+HrCcwMdIWqexTMqf9pUe2tCpI+o4MAk2sLi6OTP7ZLTDWxf
 c+kq8kst6bBsqphltsCQtwLQ/OS4AozBXRzhIK4xYlrN0PzgFz0OZLDatEDmbRB81ID1/MhPo
 wWe6y+pHDxoA0qpXNrazuB3D5c1/qPtwDwXDmP1S+IbRndu/A3sjyMIWmK03KTAueRgzsvE
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
index 4f8e6f5fde3..1ece7bad05f 100755
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


