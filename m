Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFF720441
	for <e@80x24.org>; Mon, 16 Jan 2017 20:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdAPUCQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 15:02:16 -0500
Received: from mout.gmx.com ([74.208.4.200]:62665 "EHLO mout.gmx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbdAPUCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 15:02:14 -0500
Received: from fli4l.lan.fli4l ([84.191.194.209]) by mail.gmx.com (mrgmxus001
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0M4WdO-1cdLGP2yfE-00yiTx; Mon, 16
 Jan 2017 20:56:58 +0100
Received: from mahler.lan.fli4l ([192.168.1.1]:53692 helo=kuhls.lan.fli4l)
        by fli4l.lan.fli4l with esmtp (Exim 4.88)
        (envelope-from <bernd.kuhls@writeme.com>)
        id 1cTDOg-0006jn-Pi; Mon, 16 Jan 2017 20:56:55 +0100
From:   Bernd Kuhls <bernd.kuhls@writeme.com>
To:     git@vger.kernel.org
Cc:     Bernd Kuhls <bernd.kuhls@writeme.com>
Subject: [PATCH 1/2] configure.ac: fix old iconv check
Date:   Mon, 16 Jan 2017 20:56:37 +0100
Message-Id: <20170116195638.3713-1-bernd.kuhls@writeme.com>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K0:j7j+nTddAkBmIS5f/aaTQH97EMPQXx3D+HLbpMRopzEQYB6OU6X
 AOPNQggOND6Wb8fE8CG40eZhirebga/d/MOHKKoPO/Nhee5OU3byPvSdk/DPGbAYsdAaJgc
 S2OZc/+52bQk4DBU4wAZx0p7tuo7x2bIX4D13QvcMZHO1Sf3te7GVcxTYQyXqzwu7jgTUVG
 iF4je4D8nxLOIeyhVWULQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QdeoxF45I4Y=:5IRqXKphHvqiVxWiC9c6IU
 WHsZN4wY7WchKrl2F6IgaTWdmyUcnkyR10bap7rSyLgHI7PzHTUx4IJpoAHM6SF68QetdV8p3
 olWRsH45sKyF+5NbQxyRZlVi1a9G7DCLE2h4OQdm/Hiu9hmIfHVsqi60VtMrHFHRFoeWaE+la
 Ri0VnAv1f92uBmixvi5uKeji5H08ESKMiZN4Jh1RvyW01uOJkOJ1CTVV67jozKaAqkhowP7Ow
 M3vZOi8c1O0URzIg9wIMeFsS9K8ySCWTAZzXkfqVistM+rGTgGTrUSO+RA38H0Uyxkl/YgX18
 PpIsHe0KW+Acf8XJa/Mrey9eBKTaXkZ+LY//0s7yXCVG8DXIQA1PB96+Ya1rgSmOhEirHZG4K
 TApsHQDYFwa/QmOP4ZGLL555B3uzeihKFT8DEMfiLb3t5Wac7WN0vrBAzV69jJbK0E6ecC/R9
 4CCTwtdCECOmRR0CTi9Ixo/zj9kyeEc6JBES5MMbxtEEzYPZ82XFxwgA2bUOiOTtkic7w4ZfG
 qb2Wgs1xgA7huEwFQMisEJQKIsbakdb77RidNwnnPksFfkheLhGAlP8jocnfPB9atLOBGitV7
 6D4ePFvv9AdfDeS0G0iei+ehek0r2R6laNSHhGoRsNRKmc/YFa7+dgPfckeeylJKX4pXY8c5O
 YahNarKGpfJk2tJvlLI5OH7hw56qVjNrsH21uTaYPRe3LuKw+E34uA7ZrbKpDcr0aic0v3hyu
 En+/uCbTd73P6k80ocTLCEOtnmte3Y29JFK0DG4zFWTr3HQrlyJW0wqCWyo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to
https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Running-the-Compiler.html
the parameter syntax of AC_COMPILE_IFELSE is

(input, [action-if-true], [action-if-false])

Displaying "no" when the test was positive and enabling support for old
iconv implementations by OLD_ICONV=UnfortunatelyYes when the test fails
it obviously wrong. This patch switches the actions to fix the problem.

Signed-off-by: Bernd Kuhls <bernd.kuhls@writeme.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0b15f04b1..63e71a472 100644
--- a/configure.ac
+++ b/configure.ac
@@ -759,9 +759,9 @@ GIT_STASH_FLAGS($ICONVDIR)
 
 AC_MSG_CHECKING([for old iconv()])
 AC_COMPILE_IFELSE([OLDICONVTEST_SRC],
-	[AC_MSG_RESULT([no])],
 	[AC_MSG_RESULT([yes])
-	OLD_ICONV=UnfortunatelyYes])
+	OLD_ICONV=UnfortunatelyYes],
+	[AC_MSG_RESULT([no])])
 
 GIT_UNSTASH_FLAGS($ICONVDIR)
 
-- 
2.11.0

