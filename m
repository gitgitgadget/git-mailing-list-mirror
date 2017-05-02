Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922FA1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdEBQCE (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:53367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdEBQCC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmK3e-1dfCFI46tu-00Zwx1; Tue, 02
 May 2017 18:01:51 +0200
Date:   Tue, 2 May 2017 18:01:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 08/25] status: close file descriptor after reading
 git-rebase-todo
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <6e521e980a282a04ae376363b79bdf5f1e38e313.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Nh2adR1tyPiQvepx6TWL07B1tGCZtMR+6Q9pFsNnUFZi+/CgNH5
 aQYgIssG1fiNyCk9AYjVZ+rHREkoa3js6bi70TOBoKzse7EvWGSgzXxRxnufl5vgiKHabFB
 XfSWPwXWPSQteIPq9znUd1UA1cLLpV0GO3VSyfZah+rMgV86klknY1TKeGZxqxwV+lK4S0q
 JNDEtQCTwWpJyH43X9x1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/+CQeqEgsQw=:uhiEh5o756nfuIa9pq60yq
 H1hjpL6yYYMrbTYJ3l0dJ+B41GNnT4uKl9hzymH2TcsJW6ODjf/nESH+g4oXC3SbASPGMy1GV
 rRp132r4umRyGFzTIoHZTrZnJVgkOAB8hvCBkugDABSQer6/Eq/H38rXbdldLOYDBQClZtaEn
 xKwy9ymlGmyMhGU5xTSfJ/9muimWwORo/g0RDTAG4Yjh3TupOGZrgmI8uIRw0bKxdqwaVMFA9
 mALvhnrHMGjtfZq/j3V0HGRa6uToJRszKqTxr3eyQpaifNCIjrwhfRzmQT61aD8gSj0cCwJqx
 lcn/+mPLlnKDgyn1Sj7wpECS2icvgKo6NLTsPaSSfrtSOEkraI1oWtLbsH2IkZ3TunBy1KIXR
 aVguMJ5Stm54n1RLGnQcjsLOnhjJ+1pJTIZVUp7hr7haQoa0TTja1az3tR3KFmuBUhoHDV9Aj
 XElC1y+/jMnE9rIFiz3jofae7pH8fFlT/4QyuDTz4EAvKhciZqhcppAjve8r3G+VYHys2i9Zm
 K6IWM6EuT/DHhqZ9/+jR9JDCtGdFHBModYCfTEV//CVUvMvkJ8yu9fHwns3xY0G4O+eBlxEML
 Nu8L554mQCyHxbBWnD+XExHePeIz7mB9wGgmGlVFeQVPU5mLWfYEVaiyhrzANZg8GmjMB94GS
 y1hzhMxvrOFRXCvyHwMmHg3jdyzcRwRr4Ox1SaRZixgUlP+BxdWpBKqMzlJd9sSqI+gqdiS3d
 JDpsiWylV4p+6/7u+2eDyPa9lGIpBn5G0UdOgJ1fHmi7iFI/J/kjb2AfSTXUT2wEIicslvw89
 z6AnrjG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wt-status.c b/wt-status.c
index 03754849626..0a6e16dbe0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1168,6 +1168,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		abbrev_sha1_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
+	fclose(f);
 	return 0;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


