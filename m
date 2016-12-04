Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B046F203C1
	for <e@80x24.org>; Sun,  4 Dec 2016 20:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbcLDUqD (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 15:46:03 -0500
Received: from avasout06.plus.net ([212.159.14.18]:38056 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbcLDUqC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 15:46:02 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id Fwlz1u0080srQBz01wm1DW; Sun, 04 Dec 2016 20:46:01 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=gfiFGqvwUDkGb-jDjZsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Message-ID: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
Date:   Sun, 4 Dec 2016 20:45:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

I recently noticed that:

    $ make >pout 2>&1
    $ ./git version
    git version 2.11.0.286.g109e8a9
    $ git describe
    v2.11.0-286-g109e8a99d
    $

... for non-release builds, the commit part of the version
string was still using an --abbrev=7.

I don't know that it actually matters too much (since it will
show as many as necessary, thus the RFC), but it caused me to
look twice. ;-)

ATB,
Ramsay Jones

 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 520d6e66e..05601f753 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -12,7 +12,7 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d ${GIT_DIR:-.git} -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
+	VN=$(git describe --match "v[0-9]*" --abbrev=9 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
-- 
2.11.0
