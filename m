Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583971F461
	for <e@80x24.org>; Fri, 21 Jun 2019 15:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFUPwA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 11:52:00 -0400
Received: from avasout04.plus.net ([212.159.14.19]:48749 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfFUPwA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 11:52:00 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id eLpVhNDmaaslVeLpWhlDoI; Fri, 21 Jun 2019 16:51:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1561132318; bh=s6to0engELiHzRfe8AAlVhRuA4Iy0h+kmW5h41Fd4sc=;
        h=To:Cc:From:Subject:Date;
        b=K+nSRA9LQt/TKYvdwRX8K26FMyYee7A7AIQhZge0oMVMP92pdDv/dwpCEW2okGMjb
         B1XOEfVMH58/ShxteYpEKRv6nv9CiQ0oeJk06wjRyAHE8APVbCjt7VJtboHHHuugq3
         TJoyvRdQai0tYLuIkDAludkk3xV5QT1/wQINKPLUEmn8lz1DWatRH977yBvz1q8J2f
         wpfVdp8/WcWsa5hFC5hkw/YutlwtBotAm2+Q8O2mlI5G8aTPUL6z+NXmiphRkJGuZA
         f7MJhsYEkjGwq7q9i0BJhZNNBEJIpKO4jQ4zIRmJieGFZptJ5BvBTJyWuljI08b9S5
         54QtmHXR1MhqQ==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bfsVr9HB c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=z2bj3DhneGdjqsvTAC0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] json-writer: fix a 'hdr-check' warning
Message-ID: <7ba745b9-c693-2815-2fe7-4e49f7fee8e7@ramsayjones.plus.com>
Date:   Fri, 21 Jun 2019 16:51:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGZfhp3djiPUgS8WbQt1kR440Rswgqw2IB6l2L0nIPEWOX/tL2jSD4hMuuZYRjkyH+7ssLPm5saOCLcl8Ti3XWjpNavmqCa48lIbcPuRmll2bpG7IFXA
 9ONFgMkWybUKML5l22t+HPman8HOA5qKckUbtD0QCAhVDYQ/3PwaW1iKNcp1gLh3/SU+Xg7CxP6ijg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/index-dump-in-json' branch, could
you please squash this into the relevant patch (commit 53f1666b3a,
'split-index.c: dump "link" extension as json', 2019-06-19).

Thanks!

ATB,
Ramsay Jones

 json-writer.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/json-writer.h b/json-writer.h
index f778e019a2..29d3dd91e0 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -45,6 +45,7 @@
 #include "strbuf.h"
 
 struct stat_data;
+struct ewah_bitmap;
 
 struct json_writer
 {
-- 
2.22.0
