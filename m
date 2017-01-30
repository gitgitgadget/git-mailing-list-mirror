Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7C81FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 12:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbdA3Ml1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 07:41:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:50483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753027AbdA3MlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 07:41:09 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFR2O-1ckDxX0iMm-00EQgN; Mon, 30
 Jan 2017 13:40:59 +0100
Date:   Mon, 30 Jan 2017 13:40:58 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] help: improve is_executable() on Windows
In-Reply-To: <c1c6ccae4e60608259809914e8ff3d3d5e1ead5a.1485524999.git.johannes.schindelin@gmx.de>
Message-ID: <4b93fe44ff9020ed80e4fd93a24a6ffa647e7678.1485780050.git.johannes.schindelin@gmx.de>
References: <c1c6ccae4e60608259809914e8ff3d3d5e1ead5a.1485524999.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pHEhzAFkP3OalnJPXtEtfPwuT7pymwDr/2yXX6D56jn9B7bVoCA
 Mjz/pxIpslm5cutai69DXRuQgKXavyBe7bU3hVnbpS5/iWn07eG/9cr9pFIckqMwcy5vy+q
 x2ATqH3W/OsqptGN9BwTXQRDEstJMrEyYzk2m4KA9k1zeInNXb0igXNf9nSBqYcd3gkjkzR
 Pv3V8gzjYQjaL1UR0Qu2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Cl0DlDx+QY=:VjnXTDNU170QZQB3FpkxA/
 6+CntJGj5IdKPIIa82vJdmlPbssPXsSvBuQmfgHZNnQMpzB9/Ye8RXIUrkDUfCEEpXIs+ioT+
 +QD7E1Prt4CYxheqm0ghRqiPRo5LLq6FzZFandxz1Efm/Px4jsSmpcf0QIgT+SXox9m9EIij+
 qSV8ynVTifCX+We6IipHkdndDm5S6p+MqQErtzWwgdjip1f+2PUdZ6VF+7OxkQ5FyrJPohigE
 whlVPL75JDdiEeyPGiYHa0CheboGuDrTYT4IxVy8SkrE6PeMEhPudLHeapdEUCFbdgm+sy9A/
 R7VQ7HRK+xj76KyAG8SdpUjQP63uRKUkt5F9019BeeEQF4Yek3Nz/aLul08fFeiZDiWbV9+Hz
 LRYGATiHCKEtvNmZ7+NlTAHYXbmw07docmGc/nmakDTzF93LT8AhSyYEIBB35qFmGoHz7LK4J
 YbvUXcE0mu7l+4sOJveM+nhNXKYPPxhYg9iuPQNBk1HqjMUSm9ITIkLU31ep3RTpmqPEd0myO
 nKpHa/DuPplONZyyMAwrFYdj9KsiJKAnEOfnqU4qarR9shciHtMMPIXIKvafvup9qnrQBOhev
 J5iaKVGW9pgFkrP5IUYIzIGg6WYAgIHI1myGIuGtStvLRgFmF5T9kUZLg+CQ6sGInnUm6uA5u
 lRX6yX/pJgo8w5AJ6hUO8Miyz7bIe2vZY9WMva6Z2b9vVKwff5rP716wvvkoB3p7tAtFtrouk
 lc7uRocRbGOz2Ud9GnFCOKKafhb+0lSktsyuOHB6i5X+9BOxaBVYI4CDclvBNNyQ8ngrs+m9M
 tC9PY7xZHJmB4UkiAQ/cHmv1PnBXlXIx8ISJal4Poe01Ss957RcLPARed9KEZoyr0Ed44WJo3
 xOwSLHUUTKBxG0y6lErAkLOUR1vus7gSA+hh7PLM9vNH6DzVRyuUh9j+Sl+HAYQpOGRYJhGSN
 pxfsrt/2E9Q4oIuhChKz+KW+46eFwfUWVaov64eLc+NFlGBRHTIuo/oOp8NGwBcAJ+w36lnp7
 fnwvEVU8cuvWit9fmNwa938uK8yNxyVzWtl84PDcfTi6op8CgmujcRF8rE6s6gFYTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heiko Voigt <hvoigt@hvoigt.net>

On Windows, executables need to have the file extension `.exe`, or they
are not executables. Hence, to support scripts, Git for Windows also
looks for a she-bang line by opening the file in question, and executing
it via the specified script interpreter.

To figure out whether files in the `PATH` are executable, `git help` has
code that imitates this behavior. With one exception: it *always* opens
the files and looks for a she-bang line *or* an `MZ` tell-tale
(nevermind that files with the magic `MZ` but without file extension
`.exe` would still not be executable).

Opening this many files leads to performance problems that are even more
serious when a virus scanner is running. Therefore, let's change the
code to look for the file extension `.exe` early, and avoid opening the
file altogether if we already know that it is executable.

See the following measurements (in seconds) as an example, where we
execute a simple program that simply lists the directory contents and
calls open() on every listed file:

With virus scanner running (coldcache):

$ ./a.exe /libexec/git-core/
before open (git-add.exe): 0.000000
after open (git-add.exe): 0.412873
before open (git-annotate.exe): 0.000175
after open (git-annotate.exe): 0.397925
before open (git-apply.exe): 0.000243
after open (git-apply.exe): 0.399996
before open (git-archive.exe): 0.000147
after open (git-archive.exe): 0.397783
before open (git-bisect--helper.exe): 0.000160
after open (git-bisect--helper.exe): 0.397700
before open (git-blame.exe): 0.000160
after open (git-blame.exe): 0.399136
...

With virus scanner running (hotcache):

$ ./a.exe /libexec/git-core/
before open (git-add.exe): 0.000000
after open (git-add.exe): 0.000325
before open (git-annotate.exe): 0.000229
after open (git-annotate.exe): 0.000177
before open (git-apply.exe): 0.000167
after open (git-apply.exe): 0.000150
before open (git-archive.exe): 0.000154
after open (git-archive.exe): 0.000156
before open (git-bisect--helper.exe): 0.000132
after open (git-bisect--helper.exe): 0.000180
before open (git-blame.exe): 0.000718
after open (git-blame.exe): 0.000724
...

With this patch I get:

$ time git help git
Launching default browser to display HTML ...

real    0m8.723s
user    0m0.000s
sys     0m0.000s

and without

$ time git help git
Launching default browser to display HTML ...

real    1m37.734s
user    0m0.000s
sys     0m0.031s

both tests with cold cache and giving the machine some time to settle
down after restart.

[jes: adjusted the commit message]

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/help-is-exe-v2
Fetch-It-Via: git fetch https://github.com/dscho/git help-is-exe-v2

 help.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 53e2a67e00..bc6cd19cf3 100644
--- a/help.c
+++ b/help.c
@@ -105,7 +105,22 @@ static int is_executable(const char *name)
 		return 0;
 
 #if defined(GIT_WINDOWS_NATIVE)
-{	/* cannot trust the executable bit, peek into the file instead */
+	/*
+	 * On Windows there is no executable bit. The file extension
+	 * indicates whether it can be run as an executable, and Git
+	 * has special-handling to detect scripts and launch them
+	 * through the indicated script interpreter. We test for the
+	 * file extension first because virus scanners may make
+	 * it quite expensive to open many files.
+	 */
+	if (ends_with(name, ".exe"))
+		return S_IXUSR;
+
+{
+	/*
+	 * Now that we know it does not have an executable extension,
+	 * peek into the file instead.
+	 */
 	char buf[3] = { 0 };
 	int n;
 	int fd = open(name, O_RDONLY);
@@ -113,8 +128,8 @@ static int is_executable(const char *name)
 	if (fd >= 0) {
 		n = read(fd, buf, 2);
 		if (n == 2)
-			/* DOS executables start with "MZ" */
-			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
+			/* look for a she-bang */
+			if (!strcmp(buf, "#!"))
 				st.st_mode |= S_IXUSR;
 		close(fd);
 	}

base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
-- 
2.11.1.windows.prerelease.2.9.g3014b57
