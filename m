Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34BAF1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 12:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbdAZMV6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 07:21:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:64262 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752455AbdAZMV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 07:21:57 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpKKr-1c2dQm1RDB-00fEyY; Thu, 26
 Jan 2017 13:21:49 +0100
Date:   Thu, 26 Jan 2017 13:21:47 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] mingw: allow hooks to be .exe files
In-Reply-To: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de>
Message-ID: <9a27b90e771d4c97dc580d344e161d7cf8d632ce.1485433248.git.johannes.schindelin@gmx.de>
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BSxoobAFMaDwYs4CoXqOsB7mFIFsx2Cgc9XsA0HhOCu5uWdULQ2
 JYlLNxd2FBiBj5iiQuPFUCeZN5oc/Zm4Dx6kTs2B2XoK313zO0zy31hSkjhLFMKsfGf8YBv
 gTRJM3AQK5y26Dp8ggdwVGUDE8i1QfW3Gp2bQc4FG9QXvXr7zhGw8tT1TuZzCPe1jfFJgko
 YN3e1S2OPot9jkF2kpipg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QJQUY+MuKAw=:kL3RfS5edHDdZZTeMo/LVo
 bRL5sp6OcYGqjcSSkibdfaFz4FyfcMw2HZytK+9luEbZJLblgkg4u/83AzQinF/TL6UsT0mAC
 kUfnAWArpQGTb0VurPFbu8196umWFwwjgeEdhhgL7iws+WyGpb6DdkihR4KIPwlxfO8Ts6ijk
 f6Enq1yOj8ysfFHtLImnvHA0v4DHZRsB9waVpdDZqbwX8BesgI8ws3VLEMmYdjU7BYxEKb1hP
 sTqt2mBkaG+ALQN2i3k/Lt3+XJrnYcGMul7cioOCIekaWUoREyc18qb7y2i7GSxRQ7l/LCjoa
 XSRj6DYvrnbbqacT9mkfaZ86aIFw5ZlfzLbitq+UotRceJFSWpFZwafHFDxNo7z75XZx/y4Fo
 YLw9n6+EffhV6ejxeFHbtK1Qrb612Go1gMZknNMmT2OV3I+xYVYao6gl+kNwNG17RazEZpnjD
 BKXKu+1i7aOCj60nfyLDhqhG6O6ByVSgfPRsXiiGHpu8DeOYoCFHQmei49NsoUkdTTgShu7pJ
 QkKDFAQ0LN9TTf1P10sshqvug8Yxc9HZxyhu4DRo60Qqh/ny5oNihPP5DjOnsCzzX6PVdbAaz
 xCYfNbne9cIjqmexg44T9pNsEZZUxMJ0MaFfylHp7E08qQJ18HGexUCVlZr9CgwDRXtVkmzny
 4zJVjUqzK2p6bXhmurveJXxuTEzSyzNtnh/UG872Nz51lNfaFTMjdz2yEn7U4EyZrRituN7Ki
 1TALAKA3qgr4aGM/zdkIFeN15PzYbM7CqHhvXgM1S1DePE99iYDpb07Sz8Gicn4w6urKjYwj0
 vaSWocl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This change is necessary to allow the files in .git/hooks/ to optionally
have the file extension `.exe` on Windows, as the file names are
hardcoded otherwise.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/exe-as-hook-v2
Fetch-It-Via: git fetch https://github.com/dscho/git exe-as-hook-v2
Interdiff vs v1:

 diff --git a/run-command.c b/run-command.c
 index 45229ef052..5227f78aea 100644
 --- a/run-command.c
 +++ b/run-command.c
 @@ -873,7 +873,7 @@ const char *find_hook(const char *name)
  	strbuf_git_path(&path, "hooks/%s", name);
  	if (access(path.buf, X_OK) < 0) {
  #ifdef STRIP_EXTENSION
 -		strbuf_addstr(&path, ".exe");
 +		strbuf_addstr(&path, STRIP_EXTENSION);
  		if (access(path.buf, X_OK) >= 0)
  			return path.buf;
  #endif


 run-command.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 73bfba7ef9..5227f78aea 100644
--- a/run-command.c
+++ b/run-command.c
@@ -871,8 +871,14 @@ const char *find_hook(const char *name)
 
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
-	if (access(path.buf, X_OK) < 0)
+	if (access(path.buf, X_OK) < 0) {
+#ifdef STRIP_EXTENSION
+		strbuf_addstr(&path, STRIP_EXTENSION);
+		if (access(path.buf, X_OK) >= 0)
+			return path.buf;
+#endif
 		return NULL;
+	}
 	return path.buf;
 }
 

base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
-- 
2.11.1.windows.prerelease.2.9.g3014b57
