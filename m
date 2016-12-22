Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC121FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759721AbcLVRJ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 12:09:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:63411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762052AbcLVRJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 12:09:27 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCxfb-1cTlv124fr-009fva; Thu, 22
 Dec 2016 18:09:20 +0100
Date:   Thu, 22 Dec 2016 18:09:18 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Alan Davies <alan.n.davies@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 2/3] mingw: fix colourization on Cygwin pseudo terminals
In-Reply-To: <cover.1482426497.git.johannes.schindelin@gmx.de>
Message-ID: <796e3c4b5bda1170bfbb690a73dab5442b9c77e4.1482426497.git.johannes.schindelin@gmx.de>
References: <cover.1482342791.git.johannes.schindelin@gmx.de> <cover.1482426497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xr5xsh8PAXxDyH4srXE2SpWmT/4AYEnt7b4oSuLiZxyujqCIQ22
 IpsdTmVhPTHsePzwghqqaV1ZxkX7FUQljpdgcahNUKZvJTPdwbmCBMq6gVmy55RwgDFHno/
 6RJBH2AomxMKz3wcKj2fblA9f+Tmmvm0A0w77G9DuLNloU4UQVzA/N3JvUMFii8AAH/zonb
 bZmO6NaFcCJBx+SNp2SSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vCVVifByDxY=:44zIRSEpN9uhIDXG9Jia+L
 buzl5kZGSjYLrl9cEp4yGm8RlHVo6cSTmQE8b7ZNXk4OB7F1aI+25aR4pOd21q8v7n7m68yy6
 +TyA6T1CaLUrcVrAYuED2atRenmqcp/+hevJqso5WRovsG2vWLyqA+OFeCDAKm0bucr/+bTdK
 DdNr4uCalyBxSDpNiqQiDdnEgSow+KnHnnKdvMQSGpPLDlFNuDO6Bo/QBNhw9RWs6OirZ4yR3
 X8HPvNFuMwzhxZC45WzAUTt68JeKteUlJtwsBoJN6isrsbdqhtxVdb/haBzMCgV0CU03SJ9dV
 MY985WUskDFpKQGE1pJSrzVZ+/x4Z0YixyV12SZd7jaSs0O/n64pP1zme13aKyI3TiAtqybms
 S3wrDduGiyiJRnKHgJpOFJ0db7HCLkUoJk+gjH3dsA0ZIiSLqjRWTYkoNwkGSJppME0JbGWqw
 J+P0CITznMPUtM6++IimyNIAa0acvtaTcYRmnDco4CeinOnVWrCbTjizxcSAchUkcQ5yQ3zhM
 s6dpU+8GASss8B21JJ0LSCiUE9J+20jr1b6Mu2jBzEn3csqB9R9XcRgSQaQOaYHOOHiW3evKp
 eNrALv1curPNxaGsmp4c7eRU+LRPmqxXeKGLuROumZIkSTbd4lSWfacZdJVBsSLVFAUQ7f86T
 O+KJRxm0h3mdPvLJcUuUxhBI+2pDfB2FG3uLyzVA2753T9wF1e555XXXMGJYVqnXNkzGAWoqC
 eC0r81JDJcqxrbMheEjmGZfGb+OUDXZcHBwGDTHx2GxyUS4PMnYCuk/FYBrLeXEDgBTpx9gsS
 Yq+/nLeQvdTNXuxTAdGixJ/OlsDJgYnhFkh2O7ILDUrROjeFbW/gE5TAJSJ7mkV3ziOHABHZu
 RwcM0TDePE4QccXCne8cpI7scRKvjQxam9Z7wJGDM2UlKWWNH1/Ee//2QuMfBvTL+n8PUCsAD
 /SgEn787GRKgvGirYcMQnSVwYhVkfFxJoPYCytFMcw20Arze+XKJk82cdZ6SVWn6ZEGmR3pof
 ZGNUrIkG7pTwuSa42maDwWSgBXAlmM0rmRoOhB7YY8taCv0lu/JfgOZ2YCkUOgIqvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alan Davies <alan.n.davies@gmail.com>

Git only colours the output and uses pagination if isatty() returns 1.
MSYS2 and Cygwin emulate pseudo terminals via named pipes, meaning that
isatty() returns 0.

f7f90e0f4f (mingw: make isatty() recognize MSYS2's pseudo terminals
(/dev/pty*), 2016-04-27) fixed this for MSYS2 terminals, but not for
Cygwin.

The named pipes that Cygwin and MSYS2 use are very similar. MSYS2 PTY pipes
are called 'msys-*-pty*' and Cygwin uses 'cygwin-*-pty*'. This commit
modifies the existing check to allow both MSYS2 and Cygwin PTY pipes to be
identified as TTYs.

Note that pagination is still broken when running Git for Windows from
within Cygwin, as MSYS2's less.exe is spawned (and does not like to
interact with Cygwin's PTY).

This partially fixes https://github.com/git-for-windows/git/issues/267

Signed-off-by: Alan Davies <alan.n.davies@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 590d61cb1b..fa37695fca 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -562,8 +562,12 @@ static void detect_msys_tty(int fd)
 	name = nameinfo->Name.Buffer;
 	name[nameinfo->Name.Length] = 0;
 
-	/* check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX') */
-	if (!wcsstr(name, L"msys-") || !wcsstr(name, L"-pty"))
+	/*
+	 * Check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX')
+	 * or a cygwin pty pipe ('cygwin-XXXX-ptyN-XX')
+	 */
+	if ((!wcsstr(name, L"msys-") && !wcsstr(name, L"cygwin-")) ||
+			!wcsstr(name, L"-pty"))
 		return;
 
 	/* init ioinfo size if we haven't done so */
-- 
2.11.0.rc3.windows.1


