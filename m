Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09FE01F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeDUKKD (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:10:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:44799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeDUKKC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:10:02 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbPza-1egqUu22B8-00kxSf; Sat, 21
 Apr 2018 12:09:58 +0200
Date:   Sat, 21 Apr 2018 12:09:57 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/4] color: introduce support for colorizing stderr
In-Reply-To: <cover.1524305353.git.johannes.schindelin@gmx.de>
Message-ID: <52e3348f7741cc5cd9b37a116954305cea6d4358.1524305353.git.johannes.schindelin@gmx.de>
References: <cover.1522968472.git.johannes.schindelin@gmx.de> <cover.1524305353.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YqrYcLRpJrLKHcFys2bphY/UAFmuw0l1soW5DVH4v3aQX05VOER
 YyKSmugSIdqxp0VCLSLB3glS0BjHu9yNq+tGV6N0gO4WomxTnh3goGSozm48iSc1JNbSYa8
 2SnKVtMeIXVjEnEwUo7ePs+jJeix07emrmNCG7nNxRH2Z+LCV95F7ZhiBtVtm0TYjl7bAyW
 PaMXGb+15d8VERI1BGYXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d3/DtTiXZsg=:gu4bmD2ZwD2oHIdQEw6qdW
 b3en7leG7zbce2qMb2p1MgRBcNys6LmE6Js0VjpTnSH92mZRjFRlnRAghuBsdPQkIpPz4M+Ga
 bNpqN7337IhjFPXl/6Nm6hy7hll5NrLSKF0i+zBPU0fwHywJl96jTLwEnLfB4T+8uxOHLmLg4
 eKaG/1cOJjYR5uv5/adEnXojZEuLKTi8gNz5liE+rDm5YbvymtLvFAUGQ3jTyf6qGNoB9Xz9T
 ZERuAM/gafAK0ebourQED+s0SRGgtaC2dcNtbqSBEV5d84UHxMSlBlrL6rf7AnO5sIl5Zl2kk
 TzRlEQl1SOhSNaLsQNU+7OerXzOiSvGfGD684QWwYM/Dzh0lj2PfdZy5IOhCCr48tjsajpww0
 UbzUqioOCUVASg45EmDvSVpUXMQI7II/lbbffxSyecapdQGSw5NRnd7klGESd/pbH73J0VVbk
 zG/+9Z+DekKUJTeisDlfXnKibDv6MZRBAOv7+rTILHgCMsaZxdgkmOad6uYKh8vCONuFMhvTb
 usbs4W+0qoi9F3+HwjBdfcEy6a5mK4YhiZzes3n7+FA20M62yoTdGiuJ7WVvM7UfU7j2X1NFf
 wiG5pIHYvBKUB1FhB8JikC6LzLRdbKkLo6ta+UBK0px8m1Pg3PBYJhLoSMNoGwKAFTSTkd5Kp
 sA+RN8aZ3ksu2ETau6ywQ4NtDrL/JVGyvCRGle8NE52+vwBN5RrDp7cO/NxZxIKIrVh0VjDZX
 8cMpDMsItty3rsao4YahKbJvz6g92IJfkDG4YaZw8F1Pxb2uFAbGAHUuhTuK8YqLTL1gPqSnl
 uFRS/Y9qy/R5rg5PVUJ1QXRtAE/QIr6fP9aaVnWbD5LqFkFTjc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far, we only ever asked whether stdout wants to be colorful. In the
upcoming patches, we will want to make push errors more prominent, which
are printed to stderr, though.

So let's refactor the want_color() function into a want_color_fd()
function (which expects to be called with fd == 1 or fd == 2 for stdout
and stderr, respectively), and then define the macro `want_color()` to
use the want_color_fd() function.

And then also add a macro `want_color_stderr()`, for convenience and
for documentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.c | 20 +++++++++++---------
 color.h |  4 +++-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/color.c b/color.c
index f277e72e4ce..c6c6c4f580f 100644
--- a/color.c
+++ b/color.c
@@ -319,18 +319,20 @@ int git_config_colorbool(const char *var, const char *value)
 	return GIT_COLOR_AUTO;
 }
 
-static int check_auto_color(void)
+static int check_auto_color(int fd)
 {
-	if (color_stdout_is_tty < 0)
-		color_stdout_is_tty = isatty(1);
-	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
+	static int color_stderr_is_tty = -1;
+	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
+	if (*is_tty_p < 0)
+		*is_tty_p = isatty(fd);
+	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
 		if (!is_terminal_dumb())
 			return 1;
 	}
 	return 0;
 }
 
-int want_color(int var)
+int want_color_fd(int fd, int var)
 {
 	/*
 	 * NEEDSWORK: This function is sometimes used from multiple threads, and
@@ -339,15 +341,15 @@ int want_color(int var)
 	 * is listed in .tsan-suppressions for the time being.
 	 */
 
-	static int want_auto = -1;
+	static int want_auto[3] = { -1, -1, -1 };
 
 	if (var < 0)
 		var = git_use_color_default;
 
 	if (var == GIT_COLOR_AUTO) {
-		if (want_auto < 0)
-			want_auto = check_auto_color();
-		return want_auto;
+		if (want_auto[fd] < 0)
+			want_auto[fd] = check_auto_color(fd);
+		return want_auto[fd];
 	}
 	return var;
 }
diff --git a/color.h b/color.h
index cd0bcedd084..5b744e1bc68 100644
--- a/color.h
+++ b/color.h
@@ -88,7 +88,9 @@ int git_config_colorbool(const char *var, const char *value);
  * Return a boolean whether to use color, where the argument 'var' is
  * one of GIT_COLOR_UNKNOWN, GIT_COLOR_NEVER, GIT_COLOR_ALWAYS, GIT_COLOR_AUTO.
  */
-int want_color(int var);
+int want_color_fd(int fd, int var);
+#define want_color(colorbool) want_color_fd(1, (colorbool))
+#define want_color_stderr(colorbool) want_color_fd(2, (colorbool))
 
 /*
  * Translate a Git color from 'value' into a string that the terminal can
-- 
2.17.0.windows.1.15.gaa56ade3205


