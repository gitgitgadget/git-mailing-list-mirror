Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74FBF2018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932952AbdEKNsU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:50501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756030AbdEKNrt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:47:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MELdk-1dFO0A119E-00FRer; Thu, 11
 May 2017 15:47:38 +0200
Date:   Thu, 11 May 2017 15:47:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/11] git-parse-remote: fix highly misleading man page
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <b26882e61ef466c787b575d3fd60bfeec8a9281a.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QP9/+dzmS46G49FQffdRaLrQ7X3UMVszIafmMwLdCfe0nrwokis
 hNmYhR+4cYZQ7RlPoHGP85lE5ljFztJ7EOgIucj6YAaXwe3byy2Ydkn5rkYiLcvs5Z/f9ei
 Uvxcjbi1XSbcPsmpSbzu9zp/WAZDjxgrEjg6SlnmijDG2MCNHA8kipKINak9jDism63/nl9
 gfgzjBUYVghT9+GldhlLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+U9C3LUt7B4=:/Vz1ZANehU4aYyw2O1vsX4
 TUOPoPrGlxVbaVKtEn+durvryRjhU0ePHwR6Y794a6vEc7zLWM+ojtnHpciqWN4y8P423Pr9j
 TpymgSPUymn4rsb+uTQajGXODvCeybOpY3GfDQ0afkbZSEQ8ehk/Ia/yfP4mduDlMW2mxwEvr
 5GeJkxmBsygP4Q/b7PY/+eGY2qzMDv5IzZC5yi9TW+FNhbG9ixV98P9Rgiu53Jhzj3ETT8CyG
 sBCpmfVMJUCdSC1zXYHiiht5n+7Ap8OC0P2+SZSL6TVvkl3KXqu9iVBvex3Hdu3enM3yeYFvE
 a0ZP9t8lifTFjNeJqebVseLyMD1rXftGcjRVXqbb5LamSu9T3LXyoVvSmHBdhmrGdrcs86wvf
 DpIBeHSqKSIqd3ZIJADySe39DPGCI36Gf8B8tc7TLU2SWKk2Be5MWpo59dm9VoinM1tfE86ds
 oZOqly52pGSGgcUCvmbtoAvW6FkHFR1WkyXkihexPp7TFw275ViLzT6/mo5awphfJ+5SiEGQV
 1mjhat3in6pMfU3NSciXV5BgXIp6z1GHOeZ8pJ9rmmLbmjJcp2vUQchOsDM3jNMP2PK0X84bE
 ocXTbLlgfvzNhSuuJtwWFk7o6FRGpoE1ImpCu1CQBQd/2mFpqTDQqxSgeMJWuWESN1DXGWk4n
 lyrAQU6IFTE8nHfxR4mqTFdQit6iXpAcIIfWbh7O2sRyNNAfC8WgykTzhhQ++/6sQqhu+AD1D
 MsUeBMdICVwWFaFkMuuQRirjj2dM/xaeDgiMrHlVTQLL8AR8w19+6CgnwYXweOiOIdv+pbO6o
 Mj1XZ4e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The man page still talked about the .git/remotes/ directory (which is no
longer in use, as of 75c384efb52 (Do not create $GIT_DIR/remotes/
directory anymore., 2006-12-19)).

Let's just revamp it almost completely to reflect the *purpose* of that
scriptlet, as opposed to its implementation details.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-parse-remote.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index a45ea1ece81..7f865f33898 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -3,7 +3,7 @@ git-parse-remote(1)
 
 NAME
 ----
-git-parse-remote - Routines to help parsing remote repository access parameters
+git-parse-remote - Routines to help parsing remote repository information
 
 
 SYNOPSIS
@@ -14,9 +14,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This script is included in various scripts to supply
-routines to parse files under $GIT_DIR/remotes/ and
-$GIT_DIR/branches/ and configuration variables that are related
-to fetching, pulling and pushing.
+routines to query the remote repository and its branch
+associated with the current branch.
 
 GIT
 ---
-- 
2.12.2.windows.2.800.gede8f145e06


