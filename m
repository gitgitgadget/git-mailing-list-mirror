Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC1321841
	for <e@80x24.org>; Wed,  2 May 2018 09:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeEBJiu (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 05:38:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:34379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeEBJiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 05:38:46 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M2ojS-1eOaVc3DqI-00shOR; Wed, 02 May 2018 11:38:38 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] run-command: use BUG() to report bugs, not die()
Date:   Wed,  2 May 2018 11:38:31 +0200
Message-Id: <91ddc7ed5ce0279c5d48bbed595d932d985465c4.1525253892.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525253892.git.johannes.schindelin@gmx.de>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net> <cover.1525253892.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QOgjaGQ8BWWTi9a5YkyncG4zTpFt5nco1zP8nzoG1IVN4Ghw9ek
 e3lbss/E7gTNBvGrDoggu55tok40Eu+L+gK2P0EkRu+PgkIyetvXE8zxogEV8koMmjjmg2N
 0BFTp5J1gH6wFul5j5S/hluMdpAYL0OLuUAlZ3djTtFvLZl5hPdjmmZG6cN4F/JGQw1/kHj
 nBT0t1aCElwY9Xy38DC4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bIhdS8EVEkc=:DnjRfs1BHQUShCRBLauWql
 LuJ6/jDNm1CGjGW4HLAkEwU1biTfG5hNgo4R7w0pYuVaDWLWvZDMOx2HdOJOxR5eZ8XFiMjjr
 hBuEJulPSK6Hl64/41l67PrUOOB6vuN7j8cWC3IS5j+NjgY//uxckNTUzZJIBw1CSIhBUVj7M
 92MOea+IcPsRiMPL6o4/HVVDPm1kbgYDxWRpWwefuNJwevRY99h78XZvz5FtKaFgF0Iyi1NMB
 Nu9xMNQoUCOtJZL5VFy4in9NItGai42Y5DUy6o7zt2Lz/Kvc1Vi172nM67lyIZoidPsceRVeZ
 XIHj2PHvhpKrS6gYkuoBtUROSHKDYiIrkKIUCZMlu57bDtZjQCzBUrVnZ3zvPF+sTX9oT2uP5
 9fUKjdwbBt6zXgN/vgQoLZJYb4WUr7poVCeJuppCtMXjq8T4NIZycwGGwfTtgomrHl95JEyeM
 MvBa3c3CAO/vk1sm++Y8CJrZPUhEAAf/2Zuxzolb8I7EYZMFOjP6CjwJ5HG1s353mjD++Sqvj
 eyYmfak9HJmw318P4Z/XSIVfqAe2ndNKzOjcp/Nz3VRhmbExesVw2eCaY0BVMz1P2ix7XVBQJ
 fLoOcZB9dMPWFKgfki+czLFKWfTgbUJM1XfQYOHZUXiB1Ybqq8D3008WHWHkxTIseuBb0GGee
 4soScHAmBX2HLqjp9KSqIOzIP14vYIg4O+8TXsgc/kyIYZ5ilJzoq67UN9Mp6D9pwqjaHCxqV
 lFKvpfPW4ZtbwJv8GzxtTkfgoMPyT0UTauEH3CDbHxTWZYsGYn4rh122Jx7ZhjZxgj16qqJyv
 ugBi5EY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The slightly misleading name die_bug() of the function intended to
report a bug is actually called always, and only reports a bug if the
passed-in parameter `err` is non-zero.

It uses die_errno() to report the bug, to helpfully include the error
message corresponding to `err`.

However, as these messages indicate bugs, we really should use BUG().
And as BUG() is a macro to be able to report the exact file and line
number, we need to convert die_bug() to a macro instead of only
replacing the die_errno() by a call to BUG().

While at it, use a name more indicative of the purpose: CHECK_BUG().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index 12c94c1dbe5..0ad6f135d5a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -471,15 +471,12 @@ struct atfork_state {
 	sigset_t old;
 };
 
-#ifndef NO_PTHREADS
-static void bug_die(int err, const char *msg)
-{
-	if (err) {
-		errno = err;
-		die_errno("BUG: %s", msg);
-	}
-}
-#endif
+#define CHECK_BUG(err, msg) \
+	do { \
+		int e = (err); \
+		if (e) \
+			BUG("%s: %s", msg, strerror(e)); \
+	} while(0)
 
 static void atfork_prepare(struct atfork_state *as)
 {
@@ -491,9 +488,9 @@ static void atfork_prepare(struct atfork_state *as)
 	if (sigprocmask(SIG_SETMASK, &all, &as->old))
 		die_errno("sigprocmask");
 #else
-	bug_die(pthread_sigmask(SIG_SETMASK, &all, &as->old),
+	CHECK_BUG(pthread_sigmask(SIG_SETMASK, &all, &as->old),
 		"blocking all signals");
-	bug_die(pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &as->cs),
+	CHECK_BUG(pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &as->cs),
 		"disabling cancellation");
 #endif
 }
@@ -504,9 +501,9 @@ static void atfork_parent(struct atfork_state *as)
 	if (sigprocmask(SIG_SETMASK, &as->old, NULL))
 		die_errno("sigprocmask");
 #else
-	bug_die(pthread_setcancelstate(as->cs, NULL),
+	CHECK_BUG(pthread_setcancelstate(as->cs, NULL),
 		"re-enabling cancellation");
-	bug_die(pthread_sigmask(SIG_SETMASK, &as->old, NULL),
+	CHECK_BUG(pthread_sigmask(SIG_SETMASK, &as->old, NULL),
 		"restoring signal mask");
 #endif
 }
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


