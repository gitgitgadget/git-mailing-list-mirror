Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BAF1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeDYJyU (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:41631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeDYJyM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:12 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LpPg1-1ehyir1YTF-00fF2s; Wed, 25 Apr 2018 11:54:08 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 03/11] replace: avoid using die() to indicate a bug
Date:   Wed, 25 Apr 2018 11:54:06 +0200
Message-Id: <05642a8fb58086c9cc638fec1b4e61ffa8cc7506.1524650029.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:zEpwr8j/y9yqXXIwe69Ong/Khiw/1zV9KNjZN9+Zefw2JTKnI0s
 RH0hHJnBdWDJS0dKUk6OPSM4Dpt3siyUR00SSPAhhM6kfNogAG8TrC3h1CwTPuy4PykIdtA
 VE4F2qEVuImMdJfS+hVt9+PL/UWD3U8JrlkpZiSUtdwJEwzm+ihXeUcz1kPXZmPOSjBzneH
 VhWPziqKFUTkNJrSustAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iBInIhki0mA=:RWC7inAq/RXYDkQFOoFH03
 GmzhRHfe/CNiSAz+q0lCYTLZgpTJ644hJzpV5oaofemCNAyNl0h6chUMS4SVsngIhin6mlmP0
 vZ90qY1BHr3aFjjz+5Oh8F3nSczf5n0HxSB3sn9URUHKTywEPKAduAPjM+D2EqVN93f00j6C3
 +bXzkjNXcZyxKSZVFkqMgec9enOO3CJ4YBEWofPP+sL92Akqqhdqd3/ROCvnXOKtudhoPF6m9
 1g7qjoiC+rRtVtnsoSDWFQfHb+l/OWv4iNEJ6CMgm9DdcpFGziB8nRjIW4PmiNpkj6eLM2zgP
 Iozj+NY77pJsYEmwVLOIJJlqV2kh0e6sqIJN7hrCSDrADM+OzcV/PY9d8SvDWBRbNtREE68EW
 7fcsqltdCfVbLuKun3g9j8Qt/8F5daZ9H9JmCiqLZf4UM2hh7iJ85sy8pdBnBBxc7tWsE7Q5e
 js+I972rWyYvPE3vcdIirlu1QfbV8O+UObe96cQu2OD49vmWrxSxmzh1+f2H5TDFoZPc7Bavo
 gRGuVSwFA/JzrfIIOpE36sPizcfaXti41Kk+k5V9AC+eI/5w0CFWcctvh+c9sFlctRrqzKPvU
 32NBhYVw2i03fcuoVZadTvHHHKuzEsimc8DmChv2GHqOGHfukkXtutjvv2jEp5CklM+p9nTBY
 PCLD4jXVRWLoCuLLomaBh3E1+adEtzxsL/1ca28CALyizMzYwS0TI11knCbi7odH4N2jxMTPh
 T1PEcAhUnAtem42j77eeIaBoe5om1Hc4a4jEEbre2rA31jQQHF9qoruXEasSake9N0FYIUKlq
 maRPBz+k86oWrQGLY/lftcGvoQBX3eYE1fH1rsKVZnJdrqaI9AnIKAut0992eQg/xaVGL5T
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have the BUG() macro for that purpose.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 245d3f4164e..e345a5a0f1c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -501,6 +501,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		return list_replace_refs(argv[0], format);
 
 	default:
-		die("BUG: invalid cmdmode %d", (int)cmdmode);
+		BUG("invalid cmdmode %d", (int)cmdmode);
 	}
 }
-- 
2.17.0.windows.1.33.gfcbb1fa0445


