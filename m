Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092BD200B9
	for <e@80x24.org>; Tue,  8 May 2018 12:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeEHMLb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 8 May 2018 08:11:31 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbeEHML3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 08:11:29 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MV0vp-1eoLYm0UX7-00YNVc; Tue, 08 May 2018 14:11:25 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 6643864A76B;
        Tue,  8 May 2018 12:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uLADU5xqtzsP; Tue,  8 May 2018 14:11:05 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id AD2D7649982;
        Tue,  8 May 2018 14:11:05 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Tue, 8 May 2018 14:11:05 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id CC13D804D2; Tue,  8 May 2018 14:11:04 +0200 (CEST)
Date:   Tue, 8 May 2018 14:11:04 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] gitk: improve handling of submodules in the file list
 panel
Message-ID: <20180508121104.rtsrektxiihvpqtx@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180508-2, 08.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:/bxGbza3H8jubqSUNmKR15M4kc2jg56WqPIQczqb4hOUwE+grfx
 vEul7Xn6kmc3CKu61xao9hM7YLvxJzNOUNpbjzpSliaTaXAbXFYcImZlrKRtS1JuWbVbDum
 S6yB/19vXajBs24wijoy2PhJkM2UHGou96hEz4daZ9ygKRLfAXiQN+w20DrG5QRtllNB79I
 8F+VSgzVgY0JI6DEY6stg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lnzMLfx7+gM=:d3SAvtDuI7WAjjIVjcCHnU
 r1MV/8YQtgAJH2rZXbBRj15F8PZSu3VeEeo2AdIJWGmbrPICHzsDKGdF69FSH3Gpgdoe7Da5M
 LTb0c658TxTfPk2DRM1Gobq58xUu6UjYfpXcxb+GEdFimhGJiLTuyPfCu9G0xTwk1771NETjm
 F+v/S7tPdmgEIkSDOc7hy6vaKhHCs8BLYVZTqtRZtT/Bk4Sino2Errt22FnBsPQlEB13yIpDr
 F5ZC1UNjT86H0INg5JaNQrz8qAFU8/VA1DA8PWgRFOWeVs+SziKxlAvXzmPpnAPByN0+XQrxQ
 XrTkaECrEnkTkLwZyD/kr4/TD4cFu9XtK2iUJeExRDuraWnKLYqDsr/farHktrxR032qkNIN2
 Rp2Ov5ZP0YYy5nUYtqmSReO+vt9QZ1qc/2iRu2hK8BKBmbne4GqNrt4xsy8YlOLjiNW2CzEPO
 BNXwdgE5mn4DZdZDzjBjWcnAGFSgG2sGJUf4w0zYzbWh3DOkJpEpP5cZWgY5Zqo8r6NgkqhuG
 f5W4t0w0uCt2ykfGXAjw/XTUTyg3YP6PlBtFVGYrwAFBJO3vp7AiSbKtHzj1sp2/RtFXZXH2+
 Cf1wi6x2ZcNIkzd4QPQnM5K5jnLT2VeDuxlLY8UwIfWRUjwQMgri/cNWUfLOTZQsUSIxo9D9k
 NqTX6B22yO8r3upqNEMB5HyISWZwHgU6KuXaSP8b4I+O2sM7zcEUM2suMQmnCVzSUF3c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the submodule entries in the file list panel are mostly ignored.
This series attempts to improve the situation by showing part of submodule
history when focusing it in the file list panel and by adding a menu element
to start gitk in the submodule (similar to git gui).

  [1/2]: gitk: show part of submodule log instead of empty pane when listing trees
  [2/2]: gitk: add an option to run gitk on an item in the file list

 gitk | 54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 10 deletions(-)

---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

