Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD85F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCMTDe (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 15:03:34 -0400
Received: from avasout01.plus.net ([84.93.230.227]:33927 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCMTDd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 15:03:33 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 499zhNXgJbKva49A0h6vbk; Wed, 13 Mar 2019 19:03:32 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cdb8UELM c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=eVXt83DFeUQSiPulQS8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] promisor-remote.h: fix a 'hdr-check' warning
Message-ID: <88fdcc85-559a-7213-2da8-d4e641ce979a@ramsayjones.plus.com>
Date:   Wed, 13 Mar 2019 19:03:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOPppeI6oF03ovekKzsAkfGEoPbdFmmM3rvyGtM0zorU8yU5uwjIJFYL8kv/Tp9/SwOY1/WcnfP2PmN6YYBk4L6ATL3epWtPRBKNdfikDA3F+dL7Fjdg
 6KiHb3rJsasniu62RA97O5GwOHfJ0BTweXM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christian,

If you need to re-roll your 'cc/multi-promisor' branch, could you
please squash this into the relevant patch (commit 9e8a7cf4be
("promisor-remote: implement promisor_remote_get_direct()", 2019-03-12)).

Also, I note that the promisor_remote_new() function is not called
outside of 'promisor-remote.c' and so could be a file-local symbol.
Are there any plans for future calls to this function (outside of
this file)? If not, could you please mark this function as static
and remove the extern declaration.

Thanks!

ATB,
Ramsay Jones

 promisor-remote.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/promisor-remote.h b/promisor-remote.h
index f0d609a3f5..d90df11996 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -1,6 +1,8 @@
 #ifndef PROMISOR_REMOTE_H
 #define PROMISOR_REMOTE_H
 
+struct object_id;
+
 /*
  * Promisor remote linked list
  *
-- 
2.21.0
