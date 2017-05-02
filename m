Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4AF1F790
	for <e@80x24.org>; Tue,  2 May 2017 12:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdEBMah (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:30:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:56555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdEBMag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:30:36 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBBl-1dp0ZG2SDV-00jXMX; Tue, 02
 May 2017 14:30:31 +0200
Date:   Tue, 2 May 2017 14:30:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] git-new-workdir: mark script as LF-only
In-Reply-To: <cover.1493728172.git.johannes.schindelin@gmx.de>
Message-ID: <c11f7f4f29d156250dd3c3df3af29b0f3bde2b87.1493728172.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VdvDKgYUN6ZFheeB6fGZB6Swn+9BJscMgxZ7RD+iAJojmPffAA4
 9lv2aS80vkQGCVexVYBj+OveVNtnebfVVYEuXUB77WOO83bM8/nhsTWRtlvyo9nQaCa9Y7X
 hZl7YNyNFy2PW8X32ffhwHV+AXIDo9avIQ0o6i/cw1VB+32ZXUO8qNyfJYxALYxzH/cWALf
 a/TTbTmACSiJPt5XrV3mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5110lfJpx+I=:XypoXt+7VzhDNx5FxZANwh
 Mo9ZKRtYzXxm840tcuRt6SkTOd0RzKOZtxpc8v1mYY56TjVmBnEwaYro3rm9zI52X/BVzLki7
 actEdMu4jSCVDC+l4b/yxoCLN4p5qtgn8HAIEe30kHDxAV8z3W1S8YRpmLWIYObs1UzFWgtfi
 9bcR2MTYsAjOm7XT+kPWcl9ZQm4EeqxxbaPrGst5tD2QemhMvLp40BOlTxZ0UQPg0NhEqneqJ
 LLI24vd+eTlKc63qPzhDBUU+dvh2qLTj7P4sfbLJth9hqfYOrzylz2mV6zqXpTDlyJVJ/5PD4
 ux3Kp+5M3Yi39v69XHrs/LVdRgAMOe6ttlRCnk5sh8fWSBnnwVas1o6jVLL7bRjhIJjA1sqXg
 RXSrjzATLWMLLHOrTzQms/NoxGcj6C//gYOjhTduH8AJ1k8jNUL2pZpu0USoUYQPDflfz5uhx
 2HntfZpwz5Zng5rlhX+kuxQdcHsjfEgDnghn8B4voeDU7LElGiR19zQprC/lrhjv/DjO9/zd1
 0/hSijhYN+tNmffGfaiWPycfaRymtGMbL9LQo1EYQvMc5jHGaPyvMocJSByMF+JBuEoDaBs4b
 Wx6lat+bXsi3gbJq60ZACkzTatRSZRiz27y4qz5MAQqiapAVXJuI9MvYaljLmm40FuUtxzzTw
 qAOYnoCsosTyWweLa4zrDcT92bKmmob3n/vEy0genBcQAlP/R9KSAJh3Bebwo7yJzwk1FfNb4
 GY9FtYYnp101cmygNl6mvnLaHP8ChKAchKcL07KUvqiTyhlsIG7zaVcxbvans+eX513skwk7J
 gFDCiVT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bash does not handle scripts with CR/LF line endings correctly, therefore
they *have* to be forced to LF-only line endings.

Funnily enough, this fixes t3000-ls-files-others and
t1021-rerere-in-workdir when git.git was checked out with
core.autocrlf=true, as these test still use git-new-workdir (once `git
worktree` is no longer marked as experimental, both scripts probably
want to be ported to using that command instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/workdir/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 contrib/workdir/.gitattributes

diff --git a/contrib/workdir/.gitattributes b/contrib/workdir/.gitattributes
new file mode 100644
index 00000000000..1f78c5d1bd3
--- /dev/null
+++ b/contrib/workdir/.gitattributes
@@ -0,0 +1 @@
+/git-new-workdir eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


