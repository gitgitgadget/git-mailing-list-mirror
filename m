Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439B51F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759303AbeD0Vjo (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:39:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:47949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759082AbeD0Vjm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:39:42 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lq9Ma-1ehDz70Msa-00dn10; Fri, 27 Apr 2018 23:39:37 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 03/11] replace: avoid using die() to indicate a bug
Date:   Fri, 27 Apr 2018 23:39:36 +0200
Message-Id: <05642a8fb58086c9cc638fec1b4e61ffa8cc7506.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:Awvk839e8w0VASI3jfExUuaGJsEOld4HyAdbkttTouzZ0+9qGzA
 kWpouRYAEH4GF0MKjR0Dk1MLeS2ndHb6Bi9+AQh6Qu1psYUokY79WG0KGnQ+Qs2oFwF9TRS
 Zv/Y2+mb8J3dltNastJy0Proo2H0plFiJ+bTYruee2qY1B9gkvXS4uiGnTT6Qx7Y/JKpCUg
 IJSo4zLh1ZtBBlvxxHVZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cq5MOR1iNkE=:jH0aq1vf8dWYi9dKJ0JMun
 cWpoVCO1mJTDEfGqqFIA4JimVfhiSjbgym9J64QhZ74itgmoz3XgjizcDf/WVD6jja4s79EYJ
 LstLWgDult6E4aEqnxCji2ItraHIfY2fk0yl4yv44fOeW4iJ3uRUsK4O2nMpsbBN/pXsqHVOJ
 O4deUwxAZq7Ep3yKaOjyoU7LUEqzbwProIMzwjRnT04Nwo90nj1VpZxbmUJzoySxkoiN4AnXr
 tbsjAo/shtUc+Kw+82Wq76e8y+7QF5rgowDWJI/orrjlGFAOS0q+G8OtfxgmTKaBZmtwvo2r8
 t3nWu9iT5eyRQ4lyi2F9E6womNtwh/rTpOSkYi4W4MAORx+CN56miru5Afmjul1shsh4AU9sg
 l9QTu9p1yaCmEn9fKoD4Xoc3gtOQTiGvFskQ6JQTmRWeHgUi43EuDgEh/WzMkj1m9IVxwZvyi
 POCsg/BZ07Q1B8hzNoPZWF0TXIepln36XLUlb/2JAMh6EcVPMvUP/Z+tJ6fvhzTZmOerlcUjd
 iIfh+rIxwehpHPG2vNvI+kUyr0JaCsxCW0a0zbC0qbkjNCp4/G5Pce76jvK5Os03QdSlyydOg
 Gx3CZ9l3YrsYtpimmX6FN1hVPMHS6uaPZEtBf3Gm2IyumZaSyC/d4m5ual4P2J5bFv+5tQPqj
 cNWm9pG59MQIpAdnSuq7uxmhBTITJWax47jcfEWtD8/P0N9U0t28joHbUmSykeLpM7oeZ+5C4
 Jmk13jz5+o4oSM1+rc7Rnbm/18FRpXst0xzgaoG+EfmrQ3RYC15H4XQWwYbDl4VjQqBUqyaDK
 gxxEkWz
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


