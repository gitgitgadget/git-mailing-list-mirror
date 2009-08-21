From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 08/14] Test for WIN32 instead of __MINGW32_
Date: Fri, 21 Aug 2009 15:30:40 +0200
Message-ID: <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUE9-00012X-FZ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbZHUNbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbZHUNbQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:16 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:32856 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbZHUNbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:12 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so637034ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=NACTj4XpxyrCDbA0sGMQxibEgVKHFmsdTzk7BsHb7LM=;
        b=PEwP8QTKcc4g9U0GAulYiAtnd6kjebDngKPD0hF8ArZsAF4oA7l3PM7xyOEQDrsb7O
         agKbenHrg+RBP4cKs02n6mNABwhX6o8kb37HmqWgd6jLfLEDS+w300T1P25S12OsHjj1
         /lVEiYInc8Ut9hNM7unMzd3bezp1BdYyairYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=saFtT8xGSGqmw7Ra7CyJFmdo7PKpPgWii/hp6dny18HawgPFb++53iHl7OKHkVR5iO
         vKBtWprt+ccAaO0prisf8G/N2n17NZTmq4cZl7ZSgj9t1LBvL3p/TUl+sf3sEcfMK9bw
         RKrDOOdy4Jm0nCwRN0MFKGkNCSPYY9UO+uOac=
Received: by 10.211.137.14 with SMTP id p14mr1170708ebn.70.1250861473500;
        Fri, 21 Aug 2009 06:31:13 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.12
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126721>

From: Frank Li <lznuaa@gmail.com>

The code which is conditional on MinGW32 is actually conditional on Windows.
Use the WIN32 symbol, which is defined by the MINGW32 and MSVC environments,
but not by Cygwin.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 help.c        |    2 +-
 pager.c       |    4 ++--
 run-command.c |    8 ++++----
 run-command.h |    2 +-
 setup.c       |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/help.c b/help.c
index fd51b8e..e8db31f 100644
--- a/help.c
+++ b/help.c
@@ -126,7 +126,7 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#ifdef __MINGW32__
+#ifdef WIN32
 {	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
diff --git a/pager.c b/pager.c
index 4921843..37d1948 100644
--- a/pager.c
+++ b/pager.c
@@ -9,7 +9,7 @@
 
 static int spawned_pager;
 
-#ifndef __MINGW32__
+#ifndef WIN32
 static void pager_preexec(void)
 {
 	/*
@@ -70,7 +70,7 @@ void setup_pager(void)
 	pager_argv[2] = pager;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-#ifndef __MINGW32__
+#ifndef WIN32
 	pager_process.preexec_cb = pager_preexec;
 #endif
 	if (start_command(&pager_process))
diff --git a/run-command.c b/run-command.c
index 98232e9..2c6da42 100644
--- a/run-command.c
+++ b/run-command.c
@@ -75,7 +75,7 @@ fail_pipe:
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
-#ifndef __MINGW32__
+#ifndef WIN32
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
@@ -318,7 +318,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
-#ifdef __MINGW32__
+#ifdef WIN32
 static unsigned WINAPI run_thread(void *data)
 {
 	struct async *async = data;
@@ -334,7 +334,7 @@ int start_async(struct async *async)
 		return error("cannot create pipe: %s", strerror(errno));
 	async->out = pipe_out[0];
 
-#ifndef __MINGW32__
+#ifndef WIN32
 	/* Flush stdio before fork() to avoid cloning buffers */
 	fflush(NULL);
 
@@ -363,7 +363,7 @@ int start_async(struct async *async)
 
 int finish_async(struct async *async)
 {
-#ifndef __MINGW32__
+#ifndef WIN32
 	int ret = wait_or_whine(async->pid, "child process", 0);
 #else
 	DWORD ret = 0;
diff --git a/run-command.h b/run-command.h
index 0c00b25..fb34209 100644
--- a/run-command.h
+++ b/run-command.h
@@ -70,7 +70,7 @@ struct async {
 	int (*proc)(int fd, void *data);
 	void *data;
 	int out;	/* caller reads from here and closes it */
-#ifndef __MINGW32__
+#ifndef WIN32
 	pid_t pid;
 #else
 	HANDLE tid;
diff --git a/setup.c b/setup.c
index e3781b6..029371e 100644
--- a/setup.c
+++ b/setup.c
@@ -41,7 +41,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
-#ifndef __MINGW32__
+#ifndef WIN32
 	if (!pfx || !*pfx || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
-- 
1.6.3.msysgit.0.18.gef407
