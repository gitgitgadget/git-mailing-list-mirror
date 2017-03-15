Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39981202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 13:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbdCONBE (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 09:01:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:64107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbdCONA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 09:00:57 -0400
Received: from [80.150.191.90] by 3capp-gmx-bs66.server.lan (via HTTP); Wed,
 15 Mar 2017 14:00:54 +0100
MIME-Version: 1.0
Message-ID: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66>
From:   "Florian Adamus" <florian-adamus@gmx.de>
To:     git@vger.kernel.org
Subject: Commiting files larger than 4 GB on Windows
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Mar 2017 14:00:54 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K0:lmG/wk0KCoNNZBPLk6xhN7FVCI5nzCSEPo735lIOkE5
 LUHyXsJ/5fPx1kzq26wf52UIWKjkurtC+Ns3o88mWlqzkRqzNd
 /aMf27Pe55RQPPEJOAfmEM9Ga72LYZh9WGjtnIjv25Khb4v/G5
 aC/mrAAXxI4Yw8PCKDnHx1O9vcmqvkSB5nmpUGxlzO8v79GmfH
 8/aR2oeXrjUbdOdqNClzBOAoHUezJHlrVCdhxBlcDhebHQtFJq
 DYfatwZHRF3QStMCe3QiXHWt5lJx5XAHMk9WsF4Vo/ggAnV8W1 QXIrng=
X-UI-Out-Filterresults: notjunk:1;V01:K0:h07/8Y59oJQ=:FX8DJsJksl5Psyd99/IK0c
 AecZMJbkbr/PSU7MC7rG/MH6djpGRSYwXVXudE2BsOHtB/qDwt7d9Xe0hJS7uxeEm6KcEhgH2
 ZWtlorqEFZQkQLQZjKa8dei+tmwQ2D2rV4iluEvPeS9E1mfNZAjyKUR03mjhIb7zZEcxJhyer
 R4b+5IngvrxFTaFSNV8wCQS6/EQbW9sP3SlC/lSNg/KpMJ/kPsyotHJ+4w3VcRP2GylZdNarV
 i2znb+VH1uHiSFLpz5kmwh7/CfiijsyKTtT6mHa3MpN5wQKVG6kgyg2Uqe4FGQENiT6Whhiic
 mmUUiFitjH0LEBbL+ccGuJ7ir2N8YEiPEu69D5iL/Gug5cpOyJbJf6Ci3LGzqTjGDTRY/jaOG
 +ZrPUb/1OOlty+FyBMfTRAT7gMUcs211RDa8/h/WiT2YHFIAg2TudoaPcJ4LvWzshIdM2ONZY
 DC+fBcX9lA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am managing my large files with the git-lfs-extension. Some of them were more than 4GB in size. After deleting one of those files from my working tree and do a normal git checkout I ended up with a somehow crippled file with a size of only 46 MB left.
For testing reasons I tried to commit a 4,3 GB file to my git repository without the LFS extension.
After checking out a different branch and switching back to the branch with the large file, I ended up with the same small file as mentioned before.
I already wrote a bug issues to Git for Windows and I was told that it is a problem with the git source code, which uses unsinged long, where it should use size_t.
For more information on the issue you can check the issue tracker of Git for Windows on github. Issue #1063
Is there a way to fix this problem?
 
best regards
