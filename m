Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D581F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 13:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbdAYNEq (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 08:04:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:55416 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdAYNEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 08:04:45 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQQzk-1cvieo0rZU-00TnBV; Wed, 25
 Jan 2017 14:04:38 +0100
Date:   Wed, 25 Jan 2017 14:04:36 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] fixup! worktree move: new command
Message-ID: <4f4ae057cd4d72d5b945a856deacd921fb5e7977.1485349447.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GNTZUDd7Vwz4EnwDjpLG3z9pHwXIS+knhn1lamMMnu+TI25s5CQ
 /YJCaY5uBqT/VrZ+TexB5mgKo7oUFvc+S8BDFWYnDZLyyEMXnapBUeT4F9Np0HtYn173quC
 IdmREwcc4MESsRUtXftgBDMl68JVY2Fg16EHsuJp3k96UVHdjr1OesJrlJ+Lz0mquV1MN18
 N6JtdJG0PX+zZi3AQxi5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QzXNhYUtNVw=:QHcfDjsXZXsRMJP2SeqivM
 A0I3ZA827TYDaVb9Wx3XWk6Xw2BXdq83JTBiANw741ipY4YZtJWR9HazwE9RqfemX1XBwU0T7
 b1D1yHszz7Khm5d9A6PMSXfHeHJJ5P9ggJLGfKGoLiITBMZayCBAi3q+ViRmwcRsWpps0HsTx
 xlSJL3UnQN3IfMifb4hTNt2crEN8dr5gSJgPHhB9LQfxqz/dpZkPu7VKarNfwyqGsHuSjifD8
 sfsW/XZUSF0vM+B/kx/CjC3yjp/WosdqWenndrpFEi9bYiS6qPu65T0AUNcpVxWaq+PVCoOLd
 QXlqj9tytWo/y1y2a5yH+FGc/80aru0StRPH4NkQfD20+FhGqD1rAlKZPelesexjCvuIOqdxV
 Gy91kO4OsLViB909AhAnyMW8A/b3zNDnvwufGNa/QOnM9JVxe3MXyJpbupGcR6JIK5ISwlZLf
 OHxZHM/ovFUarayon+XT1/D0E1UVPc96lqBoePU55ovK88kYrTyMiO5vVPBiySRFfGOjTCZJT
 UMwMMcmvBR84137d+IejqKItuIRF0P/TokDKgQzGFPNgvv6KOBFX6/PL+5m+DiNwBZ9lSEFfO
 oBenutyvI2HVlVE2uU+6Rhkr8hCc/2dOU5cUaxQ3Zgsctd0yPnKWFJjRQW6fdp2iFybvwAi02
 WXSnlKnwHeDRtIkN5yhGpwZD/4TjPD/VCsW/RqaND0GtgH8L04A3K9BUzoJ4bTtSryBxFDaC9
 2FIts9DJZUvHVkmhes0X/LfO+a5Cm45ajW1NF0u282V8D1mUTSvID0Khi/zPpXcSAAMHshJEq
 5dfgkte
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is required for the test to pass on Windows, where $TRASH_DIRECTORY
is a POSIX path, while Git works with Windows paths instead. Using
`$(pwd)` is the common workaround: it reports a Windows path (while `$PWD`
would report the POSIX equivalent which, however, would only be understood
by shell and Perl scripts).

Duy, if you re-roll the `worktree-move` patch series, would you terribly
mind squashing this in?

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Based-On: pu at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git pu
Published-As: https://github.com/dscho/git/releases/tag/nd/worktree-move-fixup-v1
Fetch-It-Via: git fetch https://github.com/dscho/git nd/worktree-move-fixup-v1

 t/t2028-worktree-move.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 084acc6c6d..b3105eaaed 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -71,13 +71,14 @@ test_expect_success 'move locked worktree' '
 '
 
 test_expect_success 'move worktree' '
+	toplevel="$(pwd)" &&
 	git worktree move source destination &&
 	test_path_is_missing source &&
 	git worktree list --porcelain | grep "^worktree" >actual &&
 	cat <<-EOF >expected &&
-	worktree $TRASH_DIRECTORY
-	worktree $TRASH_DIRECTORY/destination
-	worktree $TRASH_DIRECTORY/elsewhere
+	worktree $toplevel
+	worktree $toplevel/destination
+	worktree $toplevel/elsewhere
 	EOF
 	test_cmp expected actual &&
 	git -C destination log --format=%s >actual2 &&

base-commit: 8ef3497bf10296c74058e87d9c5b93372cad5137
-- 
2.11.0.windows.3.498.g86d49cc
