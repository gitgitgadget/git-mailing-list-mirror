Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A381F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 16:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbdAYQ6v (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 11:58:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:60209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbdAYQ6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 11:58:51 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfkUs-1c8et73mfa-00pNDN; Wed, 25
 Jan 2017 17:58:44 +0100
Date:   Wed, 25 Jan 2017 17:58:42 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mingw: allow hooks to be .exe files
Message-ID: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0nj0qoS8YDyjtwEOZN1gibVu/h6AayX6l8xVZnrYVIgLT8kfVob
 z8FzrWVuAUDPsozXwt8XGEp+vO+i7yx1ZblTkUZwOlJzh9BW27h0G6S4UU5njwBPWNXXYVl
 jcukZalRt2t3JTgQ/HP/3a/hnJFCflBU+UEz30WywUlP02IcjQS59zi95WF7nfTIEj8NP7W
 c+QDNY2pBwMnuLs7m4Njw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R8en85Kugxw=:N2Tbo05fVGcguXHpF6woqt
 TXHtQ9du7GUPQUO6Tsg01FtKa99Rf4+DlGqgGEwJ2xra/4eftsMEDm7JuVPjUVV+/aYkEKWBT
 o/+30U6BpUvLxI5ZELDEcCt1oC5Vg73MLkrtARbwKk43kt5WAtohdfqmh4OD9wtegmL+AUhAI
 MluXGSRr322OjwZu+osTvsGpisZM5pswMqYMqMTtvuHDPdF/BNUEJpGVl7yN1OeRWBW94OyES
 SA+KORq+omMFtvQRqRP4TXMLJk7eiAjfQ1phavMbB3iUCjhdzjiFk2PVnGkcYipTB8RX8k3Nd
 Ksums/fiFcmtGFGBubOv9U9rj7UlMGCpfkpt+H/Ul0LEPvn2pgE9w8P5bPobxqJkym2L6akdl
 SxRj/YW0veG1eBWIm7vw5G1Owvdk2EAVhqAPmj8mQbbmiXAd0VkQtT0OtA07O+Iym/906VqiI
 uDO4tFf5XUrTAMw+MLA/c//7Nz4RIu4xOL/LoFuuM/DS2n1V1/jzT3WJTyw0Zgi7VbXZ3MgGP
 a+wULpihC+GuVZeoK/d1O2EIYkQeA3xFrjG4ZYporSUP4gct6WxS3ATCfud1qC1h9XqAp/5B/
 RqdmOiU7xHCPA0PWEv8MDEtsboHk87mpMvvFDPchpuGNlY65XO8uI8GEiiM83KxWCwpns15UD
 h/e5p/EJzA1l/gN1yu4WEnSw9j2RqTRkR6fCjFDPz9L3f6Ec/XHBF2Uo13jnbdDvztX+ZE8J8
 pHpEe15MO+hHKmJWopoGPQaystLzPqbUBobS1MmfG7f9Ov1nC6Eevzomj+OpX/fQ9auSQZrLC
 YGNsQ0i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change is necessary to allow the files in .git/hooks/ to optionally
have the file extension `.exe` on Windows, as the file names are
hardcoded otherwise.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/exe-as-hook-v1
Fetch-It-Via: git fetch https://github.com/dscho/git exe-as-hook-v1

 run-command.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 73bfba7ef9..45229ef052 100644
--- a/run-command.c
+++ b/run-command.c
@@ -871,8 +871,14 @@ const char *find_hook(const char *name)
 
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
-	if (access(path.buf, X_OK) < 0)
+	if (access(path.buf, X_OK) < 0) {
+#ifdef STRIP_EXTENSION
+		strbuf_addstr(&path, ".exe");
+		if (access(path.buf, X_OK) >= 0)
+			return path.buf;
+#endif
 		return NULL;
+	}
 	return path.buf;
 }
 

base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
-- 
2.11.1.windows.prerelease.2.3.g7f3eb74
