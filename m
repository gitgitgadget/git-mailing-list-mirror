Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214401F406
	for <e@80x24.org>; Tue, 12 Dec 2017 14:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbdLLMrb (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 07:47:31 -0500
Received: from avasout01.plus.net ([84.93.230.227]:37343 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbdLLMr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 07:47:28 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id Ojy1evsoqJjiPOjy2eFeXz; Tue, 12 Dec 2017 12:47:26 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=O6ZJhF1W c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=rHGwIfiBvDF-lKYF0EcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: allow NO_DC_SHA1_SUBMODULE to be set in config.mak
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com>
Date:   Tue, 12 Dec 2017 12:47:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOu3RCGZz4v6d6DYndSxAaH2RCm+aiOXnnfz3LicAnL5FpvPW7qY37OPffcExX5kBjaqkDz7M93vlg80sQkxvw6VWe2WUG9GNpQpp3YYLx2rI3LqDfKC
 IlCXqeiA3kQh3gvLF+xM4pOtjIIUYTTY4r3jMoBMwB98n0tWh7VBiGwFpXsKZ/efyp8YuTZLPVAjRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

Could you please add (or squash) this on top of the 'ab/sha1dc-build'
branch, so that I can build with NO_DC_SHA1_SUBMODULE=NoThanks in my
config.mak.

[If I were to get a vote, I would vote no to the submodule. ;-) ]

Thanks!

ATB,
Ramsay Jones

 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 929b49b04..91bbb0ed8 100644
--- a/Makefile
+++ b/Makefile
@@ -1042,6 +1042,10 @@ EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
+include config.mak.uname
+-include config.mak.autogen
+-include config.mak
+
 ifndef NO_DC_SHA1_SUBMODULE
 	ifndef DC_SHA1_EXTERNAL
 		ifneq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
@@ -1053,10 +1057,6 @@ whatever reason define NO_DC_SHA1_SUBMODULE=NoThanks)
 	endif
 endif
 
-include config.mak.uname
--include config.mak.autogen
--include config.mak
-
 ifdef DEVELOPER
 CFLAGS += $(DEVELOPER_CFLAGS)
 endif
-- 
2.15.0
