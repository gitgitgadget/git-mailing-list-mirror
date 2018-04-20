Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F0F1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeDTW1F (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:27:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:51243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752743AbeDTW1E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:27:04 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Las1k-1eh9IJ2Ahc-00kPPY; Sat, 21
 Apr 2018 00:26:59 +0200
Date:   Sat, 21 Apr 2018 00:26:43 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 10/11] technical/shallow: describe why shallow cannot use
 replace refs
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <b391791dceff0589c49e798a5257fea66e9f0101.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v5eT8bNFO+lne5hEon689IAp4GFkZd4y04HZ4YYBx3d7aEljTFw
 KoeJYc/P/E6I0z8ZVBJNX7n2TK1yGjUdBJDhGYy8vkD3dXG8S3ESaJXDaVK6znNseZOlOF5
 QYZGtkQ9pRSCvI9KPUSGbu/Rv5Rh41kxziVBaXlvoIxHfgxbQyFLbzLOMrpiZJIz3GfGRRO
 GCFnUoDTH0chSJKspIkYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yrCNawoXwYc=:6jlwsQwfhKQ5CUaKJWReom
 rj3Pa8zyyJnI6ecTUCgV4uY8coxMfkAcHB3qhvsXNRqQziF2vkQ6i4/Tr+GfCMI2QRIek5POi
 d7GCtKcJ+1CYUewReCgnQnrKnDmFgHRc0SCfaVwOYYKzIFhdV9/7isRBGLsg5xndcQQah+P/8
 DuLSDgh2qIkMeydNgbTjJ8gMH5gLMDhFq5OtoKc25TogjM6RehRh8jNF8QuGhYDXZLm62aZTE
 WCZzPOhxMr0TAaX2IASspxzCPq2AKh0L2lNNFfkclS0ZWE2nGfrrVYSzUVLmoP9AzQLkV1OAa
 H5PH/NHIDWIlBVZLJh/Jg6sHE79i2Lagyb4YZmax0D46frUE7DUA+Kezam3oHhkTkV5imgYT9
 1gmeHZgK7fEPpIiPPEhNyuyNmIxLjRN6XO0chXCqp3TD4VXJvCAiDS3DWWbxaHCfJpw5sDDEC
 PNXuYz7hvcGE0v7vwUo/hA/IQY1IGQBg04DcytnPyYFslJqa66eVlm9Zp/5XU5i1LRhzAmDhU
 XqWQPwSeKvMHZvaYD8Zx2KUrDcYr1talGaus2VklS37XwXPFEV7jzda72q2t5R4mGfptpf1u0
 Bvauu1nuw+o104/jbdnr5YkUP60ed4YuyyRF01Fw65Mf+IpOcHKQiO5fCm00D38gORBnRgH13
 xcKfIgla/mM15HE3XEoynyk1fnARFRl2/7mN+BWtsA2OT2NhYZFybmMPCCC4Js6veBzzkOde4
 eZ5xtWshN+zsy5x7biZ24+lS+YqzzfXdWAsvZZVRHmo4N+iofE1/n/pMJyZb/EXBP+qRR/1Ho
 duzF5vEXJgzmfp5fbHTGP0Wk7VQRDUR6PvSzzqbByl884M9bkY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is tempting to do away with commit_graft altogether (in the long
haul), now that grafts are deprecated.

However, the shallow feature needs a couple of things that the replace
refs cannot fulfill. Let's point that out in the documentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index b3ff23c25f6..cb79181c2bb 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -25,6 +25,13 @@ Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
 to discern from user provided grafts.
 
+Note that the shallow feature could not be changed easily to
+use replace refs: a commit containing a `mergetag` is not allowed
+to be replaced, not even by a root commit. Such a commit can be
+made shallow, though. Also, having a `shallow` file explicitly
+listing all the commits made shallow makes it a *lot* easier to
+do shallow-specific things such as to deepen the history.
+
 Since fsck-objects relies on the library to read the objects,
 it honours shallow commits automatically.
 
-- 
2.17.0.windows.1.15.gaa56ade3205


