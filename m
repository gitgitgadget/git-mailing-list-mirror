Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9AF1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 12:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbcIIM2q (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 08:28:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:60588 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbcIIM2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 08:28:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MSuMn-1bax2K24UX-00RnLi; Fri, 09 Sep 2016 14:28:25
 +0200
Date:   Fri, 9 Sep 2016 14:28:24 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: respect commit.gpgsign again
Message-ID: <550e7de5e08e53b5893e1ce021bffee468adfc9d.1473424091.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0FnWOun8TLl85GgsExuuUxESiIJ1JAFUbfP1klAj99Mt79wF1mK
 NknFMXx96kvIF6h5vps5OHDzgrWwo6809/HZlkO+3eNRtXx+MY22lfj3/T8EN3kBKnp2fpO
 jJ1lNg7h1GJ8YGEwIHjqV3h1GcPiG5/urNcV55S5j9Sx7AkQIBe9c0TJiWeMaQDU52HrnBv
 Bz5voB+PdOymkFhCcJR4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P4ai/SoUgvY=:epshiz8B1m9qmd0Ge4N4I0
 TfObvV7FMIOtSWiLRjl7Ruf5okAPU/xw/I8WJFBk2Ee/1CfrhSvMKyC1iprAxJwHltuhV91ZI
 q65pborQUEJnt0cFnRu0Mj03yIH1hySdeByqd71HbfX2qG7pPTyjVXcpumcLyCSuh2UG4Jtmr
 xHfqjSRMPZH6G26FJhQmKzJ4esyDMdAk5kadasOzRyaoI/Kf41t36vkSC4fBPmTWmHPlCPVKj
 vRm4titz283XJJs5MBC2tX8bXoJ2tP3HOlNF8khNayLhpcP5H5L6g/zPndTUp1YoqlXE3hUIm
 Ag/Hgd8MKRnAMiOtgaFHmq9efQ+7kA6osBpjFRrr+QuIJXCBPz/FZvgI+91/sKmIHMAfZGE7a
 ubDYbZIc6AwemPrGJj0mObZevtPZ8UwqcvFs+gJJeCK3htEEZGW3WlQh/GmqCYLw/ktjyDpPd
 izO4+EFNpDRVdNVuGZiAu7Cg3nmISy2dqgrw8/G7CzIWM+psLCzmvIvVt+raURsIr9VWBF8jE
 gJTefEYT6VfHCM/J+P3hpwVj0sXW8t9ORiXvlqYZMcGAcIi2H2Xp4PUII+jx0BCgNVXkUmc5M
 rYBPzSThJfBYuBww5LoUu5yGSy40fZhJzK+EewLMNABYmGL4WP0R5i2oZFPLhicPJsls3aPFm
 XF8GrQYb/eYrFqDwEyog87fDDsSmzCGCOjVOQ8SabUqPQkMI3Zlp7V+ud7X46lw/mrO/0cR5G
 HsTwDI8cJQw+NqUz/fN30tg7PI86+jKdZVI/+kP8J4JdVscS8OcAzWD4h6D6dPiQNzMA4KLzv
 dFEiNK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of v2.9.0, `git commit-tree` no longer heeds the `commit.gpgsign`
config setting. This broke committing in Git GUI.

This fixes https://github.com/git-for-windows/git/issues/850

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/git-gui-gpgsign-v1
Fetch-It-Via: git fetch https://github.com/dscho/git git-gui-gpgsign-v1

 git-gui/lib/commit.tcl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 864b687..01d2cc2 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -369,6 +369,9 @@ A rescan will be automatically started now.
 	# -- Create the commit.
 	#
 	set cmd [list commit-tree $tree_id]
+	if {[is_config_true commit.gpgsign]} {
+		lappend cmd -S
+	}
 	foreach p [concat $PARENT $MERGE_HEAD] {
 		lappend cmd -p $p
 	}
-- 
2.10.0.windows.1.10.g803177d

base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
