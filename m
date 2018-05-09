Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A771F42E
	for <e@80x24.org>; Wed,  9 May 2018 11:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeEILA4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 07:00:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933941AbeEILAz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 07:00:55 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0M31zr-1eQBgz0MIJ-00ss3o; Wed, 09 May 2018 13:00:50 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id D4FDB64A699;
        Wed,  9 May 2018 11:00:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lKdEBmgYh0kl; Wed,  9 May 2018 13:00:31 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 6076B64A6CB;
        Wed,  9 May 2018 13:00:31 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 13:00:31 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 156D7804D2; Wed,  9 May 2018 13:00:31 +0200 (CEST)
Date:   Wed, 9 May 2018 13:00:31 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/2] gitk: improve handling of submodules in the file list
 panel
Message-ID: <20180509110031.wg32inxpbb4w52nc@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:gomzfiyzIOnmRnAi70FuGshCHkKHgBiKTahFnbQvp8yrCKti750
 ezJoOii9Rp5pFZzvJmWmnPQ3rcg2NeLeoWyIJBrQHoTxUlQBlArWR64lMgAqeVlitPr8zHS
 w4WSi/ocNH9GZ/vhUhLz8DbpPfvygV2MU7AZ8Dw0T+0LnBFogAzlhTFR2prV5G+COxjwG1F
 HgwI87Kker0zil7/XRdQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:72Z+/pWBYKI=:k3irpn0wigGLzR3pQpkRPD
 iZyzL7BibsjMWIa3UZdA49JocDGoV6B82raFOckZbHBwBxJVKdhT5OE8B9NoXSMN3sCHMXyRE
 XlxXgQyG/Ru05bqdjJ6j55VwoOyWgL/71iRXve/f2P5alTO0NEsW65dN7kgLYE8TqaCK45YO9
 myG5daMTFwCOi2RkY1anWAijMWDmP5+7Jcktij8EWz+P4BJtARWdah3iyOIyqGukvTQX6MMp2
 hkrKnTaz5slAyuD3MZ9TVkgfNfWz/dS7tj6g+AUgOCrJQOpOVNr9w7F/jE2feiwN5M+NgXyu5
 IhwUWJIfS4F+7i1OiZwwqhOoAGAmt3HpQWLFG2Cm3mMHQ/aN/DgqoMEB9Gp2WSBPVDvLbCadm
 0NB+T6bUYEeI3qVIwhjJuegYALIctwIut/uYP8VzREjGjmMqAOnSPTEYqayiRvEWkzkBBtRL3
 IxwlMHfDXeHkSDsnfIGyg/LutnTLcK/9r5FcAr8ccW99UPR8qenQCbe07KobqJuB2mo8XTyRb
 48QuMCYnepBt3e3wJi15cJdOcdcn9U9FMpMNvaCce/RFAS5VHUlHywT68j2lCXA3u+9kZBInp
 fSJqoEuW4t2Llj0LIYnJNgzFyDTcxgtkFGPGTZTOFiDAFGmpM3zo9hWQLA00lwt5MbQOexDiV
 D86DtTrPmqwkPf3fJSEGedyqrDGLOA79M3FNXA7XMNgZ/j0T9rU7Jp08N/fgqTYvQMq8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the submodule entries in the file list panel are mostly ignored.
This series attempts to improve the situation by showing part of submodule
history when focusing it in the file list panel and by adding a menu element
to start gitk in the submodule (similar to git gui).

Alex Riesen (2):
  gitk: show part of submodule log instead of empty pane when listing trees
  gitk: add an option to run gitk on an item in the file list

 gitk | 56 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 10 deletions(-)

-- 
2.17.0.593.g2029711e64

---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

