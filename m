Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6804B1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 11:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbdHULxe (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 07:53:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50869 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdHULxd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 07:53:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20170821115331euoutp02d37413dbc9ff80da2e9331497a191cc2~c2k_rwzca1181311813euoutp02L
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 11:53:31 +0000 (GMT)
Received: from eusmges1.samsung.com (unknown [203.254.199.239]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20170821115330eucas1p2a0a390086c6193f4b2b22894a490c296~c2k99rknq1568115681eucas1p2U;
        Mon, 21 Aug 2017 11:53:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1.samsung.com  (EUCPMTA) with SMTP id 63.1A.12576.AB9CA995; Mon, 21
        Aug 2017 12:53:30 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20170821115329eucas1p1c550891b502863669ca351de028f2b80~c2k9Q_2VX0485604856eucas1p1q;
        Mon, 21 Aug 2017 11:53:29 +0000 (GMT)
X-AuditID: cbfec7ef-f79ee6d000003120-b0-599ac9ba264a
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.A8.20118.9B9CA995; Mon, 21
        Aug 2017 12:53:29 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from localhost ([106.116.147.110]) by eusync4.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0OV100932AD59800@eusync4.samsung.com>; Mon, 21 Aug 2017 12:53:29
        +0100 (BST)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] git-gui: Prevent double UTF-8 conversion
Date:   Mon, 21 Aug 2017 13:53:13 +0200
Message-id: <20170821115313.11879-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.11.0
Organization: Samsung R&D Institute Poland
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7djPc7q7Ts6KNNj4WNii60o3k8XNQysY
        HZg8+rasYvT4vEkugCmKyyYlNSezLLVI3y6BK+P0+5ksBQfYK5bMucTewNjM1sXIySEhYCKx
        9vxlRghbTOLCvfVAcS4OIYFljBIrJr1ignA+M0r0f57DDNPReOwlK1zV8fb/7CAJXgFBiR+T
        77F0MXJwMAvISxy5lA0SZhbQlNi6ez1YiZDAF0aJvutgm9kEHCX6l55gBbFFBMQl3h6fyQ5R
        by8xcdZ/sBphAUuJk5e3g9ksAqoSa28vZYRYZS2xcV071NXyErvaLoLN4RfQkljTdJ0F5DYJ
        getsEo03f7KC3CMhICux6QDU/S4SZ/dNgvpeWOLV8S3sELaMxOXJ3VC9/YwSh+d/h0pMYZRY
        vNABwraW+LNqIhvEoXwSk7ZNZ4aYzyvR0SYEUeIh0bmhE2qXo8TnWcfAQSIkECsxu41pAqP8
        LKTAmoUIrFlIgbWAkXkVo0hqaXFuemqxoV5xYm5xaV66XnJ+7iZGYOSf/nf8/Q7Gp80hhxgF
        OBiVeHhv5M+KFGJNLCuuzD3EKMHBrCTCe3APUIg3JbGyKrUoP76oNCe1+BCjNAeLkjivbVRb
        pJBAemJJanZqakFqEUyWiYNTqoHRWM/yZUH2HNGi7V1FTxf5qjrrBV+d8urAppBXnlU5/lHf
        u9TMezdzCTQpB1X2uwkyCF71bDW/lLQvPHB1d+lXhrRiTZNvb74/7r2zbMmsDz+WNVrwxB5+
        sovtwc3mC/+Exe1Ytkost1QTfSc2d9rip0aeOvfF+pfOK1nks7ZIVsZDZR/jfWslluKMREMt
        5qLiRABm7X2l+AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xa7o7T86KNNh/39Ci60o3k8XNQysY
        HZg8+rasYvT4vEkugCnKzSYjNTEltUghNS85PyUzL91WKTTETddCSSEvMTfVVilC1zckSEmh
        LDGnFMgzMkADDs4B7sFK+nYJbhmn389kKTjAXrFkziX2BsZmti5GTg4JAROJxmMvWSFsMYkL
        99YDxbk4hASWMEp0310NVsQrICjxY/I9li5GDg5mAXmJI5eyQcLMAuoSk+YtYoao/8Yosf13
        G1g9m4CjRP/SE2BDRQTEJd4en8kO0WAvMXHWf7AaYQFLiZOXt4PZLAKqEmtvL2WE2GUtsXFd
        OyPEQfISu9ougs3hF9CSWNN0nWUCI/8sJCfNQjhpFpKTFjAyr2IUSS0tzk3PLTbSK07MLS7N
        S9dLzs/dxAgM+G3Hfm7Zwdj1LvgQowAHoxIP7438WZFCrIllxZW5hxglOJiVRHgP7gEK8aYk
        VlalFuXHF5XmpBYfYjQFunUis5Rocj4wGvNK4g1NDM0tDY2MLSzMjYyUxHnVLzdFCgmkJ5ak
        ZqemFqQWwfQxcXBKNTBeY/zU5e/lkHTRbspjiamp3L1/L0fanWxTNC+Z9EMy8ERRSrfnDJkU
        sf5Pl9ib/63eatv/juOn2/e1rrEtzaad8rM0OGRa/nutejR5rkR94IF9i+w3FZ9nj2rezR1z
        IFTuiqOQQkjA3E7Fzy3iL95FvLcyaQ6L2j7PsHD+WtnsrphVt7UCuZRYijMSDbWYi4oTAWN/
        a3SOAgAA
X-MTR:  20000000000000000@CPGS
X-CMS-MailID: 20170821115329eucas1p1c550891b502863669ca351de028f2b80
X-Msg-Generator: CA
X-Sender-IP: 182.198.249.180
X-Local-Sender: =?UTF-8?B?THVrYXN6IFN0ZWxtYWNoG1NSUE9MLVN5c3RlbSAoVFApGw==?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG1NlbmlvciBTb2Z0d2FyZSBFbmdpbmVlcg==?=
X-Global-Sender: =?UTF-8?B?THVrYXN6IFN0ZWxtYWNoG1NSUE9MLVN5c3RlbSAoVFApG1Nh?=
        =?UTF-8?B?bXN1bmcgRWxlY3Ryb25pY3MbU2VuaW9yIFNvZnR3YXJlIEVuZ2luZWVy?=
X-Sender-Code: =?UTF-8?B?QzEwG0VIURtDMTBDRDAyQ0QwMjczOTY=?=
CMS-TYPE: 201P
X-CMS-RootMailID: 20170821115329eucas1p1c550891b502863669ca351de028f2b80
X-RootMTR: 20170821115329eucas1p1c550891b502863669ca351de028f2b80
References: <CGME20170821115329eucas1p1c550891b502863669ca351de028f2b80@eucas1p1.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With encoding on the file descriptor set to "binary" Tcl (8.6 in my case)
does double conversion which breaks e.g. author name in amended commits.

For example "\305\201ukasz" (as written by git cat-file) becomes
"\303\205\302\201ukasz".

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 git-gui/lib/commit.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 83620b7cb..bcb6499a0 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -26,7 +26,7 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 	set parents [list]
 	if {[catch {
 			set fd [git_read cat-file commit $curHEAD]
-			fconfigure $fd -encoding binary -translation lf
+			fconfigure $fd -encoding utf-8 -translation lf
 			# By default commits are assumed to be in utf-8
 			set enc utf-8
 			while {[gets $fd line] > 0} {
-- 
2.11.0

