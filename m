From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 06/14] Test for WIN32 instead of __MINGW32_
Date: Tue, 15 Sep 2009 15:44:09 +0200
Message-ID: <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com> <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:08 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYL8-0007Ah-QC
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:02 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so11219966ywh.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=woV6ent/TYMASVckQKPflsAidV1jKW689q/n5ws7wL4=;
        b=IjQapv3PRcLwcuVgM/9wYJykdKizdUgVprrlJMkMNqDgOPyVv+6zJKpumJ4fBjkfGk
         KpiCzL7f5thfx6UibgcVKV0wSff3UftXD+JZDlgKbiIX2i6lAscrCIXaCTK987ZG1rj7
         qZBkl9q/aplaLV+A5pInh91NGs0te6vRSm1LY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=yJhFsdKLHw002PG3wJLKCnYuyzKX5+GJYHtAOVUAeJFIAOKX3uxJh81pTSdzmBSfpn
         +qCHBugHnxBJS3UVgP81MX9ptCusYxe2kQ+3/ETGlo+JLEuDr3MVYYa4TuFIUdfjYQOE
         Jwn5svpYZf8d1Ew4uK6eQrxChWMiKteTn4x4o=
Received: by 10.101.67.1 with SMTP id u1mr1747139ank.10.1253022294467;
        Tue, 15 Sep 2009 06:44:54 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7013yqh.0;
	Tue, 15 Sep 2009 06:44:48 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.147.7 with SMTP id z7mr1491202ebn.7.1253022286502; Tue, 15 Sep 2009 06:44:46 -0700 (PDT)
Received: by 10.211.147.7 with SMTP id z7mr1491201ebn.7.1253022286484; Tue, 15 Sep 2009 06:44:46 -0700 (PDT)
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com [209.85.219.214]) by gmr-mx.google.com with ESMTP id 13si1528274ewy.2.2009.09.15.06.44.45; Tue, 15 Sep 2009 06:44:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.214 as permitted sender) client-ip=209.85.219.214;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.214 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f214.google.com with SMTP id 10so4006682ewy.37 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=jj+tMsfMZr8AB5YLiMJwVEP9yFot8CsVYYR2zxxqDFk=; b=GnT3MMWk6P9shyuF82WatqDYebIeVcPIhBeXa9fYLckYuTxCGBzFt8lT5YbU5+hJxU AwBFjIcm5ojTDN780BlHclvgQpq7oH2HfjPGwuQQU7Bqq7620gSA2A1s90ee1zWU3286 YDD+yLmi8SluTZR/iSrYbA3ZiOakUL2wkdvLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=QBSYoGUZC0PzXj4iOLaaTN4M+zA+Sfu7fd/5PsRODaMtfNGiDNagA5NHBrHjVLIK6b Iq3GZ8rBjFQ8ikDwrB/sJMLLHz7S/rsSvVJkhFOs2gwzLCpjcez2lqkxUYUCwVa6G2nn yEyBvDOLVtKX8GiOq6XB4NQ1zIl8gpDPNQsYM=
Received: by 10.216.21.2 with SMTP id q2mr1293388weq.78.1253022285074; Tue, 15 Sep 2009 06:44:45 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.43 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128549>


From: Frank Li <lznuaa@gmail.com>

The code which is conditional on MinGW32 is actually conditional on Windows.
Use the WIN32 symbol, which is defined by the MINGW32 and MSVC environments,
but not by Cygwin.

Define SNPRINTF_SIZE_CORR=1 for MSVC too, as its vsnprintf function does
not add NUL at the end of the buffer if the result fits the buffer size
exactly.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/snprintf.c |   10 ++++++----
 help.c            |    2 +-
 pager.c           |    4 ++--
 run-command.c     |    8 ++++----
 run-command.h     |    2 +-
 setup.c           |    2 +-
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index 4d07087..e1e0e75 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -2,12 +2,14 @@
 
 /*
  * The size parameter specifies the available space, i.e. includes
- * the trailing NUL byte; but Windows's vsnprintf expects the
- * number of characters to write, and does not necessarily write the
- * trailing NUL.
+ * the trailing NUL byte; but Windows's vsnprintf uses the entire
+ * buffer and avoids the trailing NUL, should the buffer be exactly
+ * big enough for the result. Defining SNPRINTF_SIZE_CORR to 1 will
+ * therefore remove 1 byte from the reported buffer size, so we
+ * always have room for a trailing NUL byte.
  */
 #ifndef SNPRINTF_SIZE_CORR
-#if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4
+#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
 #define SNPRINTF_SIZE_CORR 1
 #else
 #define SNPRINTF_SIZE_CORR 0
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
index f416d38..86facec 100644
--- a/pager.c
+++ b/pager.c
@@ -9,7 +9,7 @@
 
 static int spawned_pager;
 
-#ifndef __MINGW32__
+#ifndef WIN32
 static void pager_preexec(void)
 {
 	/*
@@ -72,7 +72,7 @@ void setup_pager(void)
 		static const char *env[] = { "LESS=FRSX", NULL };
 		pager_process.env = env;
 	}
-#ifndef __MINGW32__
+#ifndef WIN32
 	pager_process.preexec_cb = pager_preexec;
 #endif
 	if (start_command(&pager_process))
diff --git a/run-command.c b/run-command.c
index bb76750..cf2d8f7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -75,7 +75,7 @@ fail_pipe:
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
-#ifndef __MINGW32__
+#ifndef WIN32
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
@@ -315,7 +315,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
-#ifdef __MINGW32__
+#ifdef WIN32
 static unsigned __stdcall run_thread(void *data)
 {
 	struct async *async = data;
@@ -331,7 +331,7 @@ int start_async(struct async *async)
 		return error("cannot create pipe: %s", strerror(errno));
 	async->out = pipe_out[0];
 
-#ifndef __MINGW32__
+#ifndef WIN32
 	/* Flush stdio before fork() to avoid cloning buffers */
 	fflush(NULL);
 
@@ -360,7 +360,7 @@ int start_async(struct async *async)
 
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
1.6.2.1.418.g33d56.dirty
