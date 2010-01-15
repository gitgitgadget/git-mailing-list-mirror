From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 11/14] mingw: compile git-daemon
Date: Fri, 15 Jan 2010 22:30:30 +0100
Message-ID: <1263591033-4992-12-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 3zt5QSwkOB0kv53xlmt4przzrwpxltw.nzxx393rt4rzzrwpr2z503.nzx@listserv.bounces.google.com Fri Jan 15 22:32:17 2010
Return-path: <3zt5QSwkOB0kv53xlmt4przzrwpxltw.nzxx393rt4rzzrwpr2z503.nzx@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtmC-00061S-DY
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 22:32:16 +0100
Received: by yxe1 with SMTP id 1sf1972493yxe.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 13:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=CYX9HJc61neC7fyxmYKlXVFJhilhPEtV1vqwVH+oCB8=;
        b=NRL2M64/mjktwoKRgTvoa6xvDykCxBlhWRt0LAh0d1xJ9NMKPJ3BtLfAfcZLc0Xfoh
         NnEUagqbvJQKken07CTWgd6mxgbH6ig0lr1iMcjl5IInx3kDOTUaw77aGXSXz2ip0bnk
         NLvEw9VXSzlvss6t6U4Tsi5N6l6m96GuR+BQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=3AHwZQy19iGT70LucYL45+aGucSdEcJXYH9wsHyJRGMEHHQ1Mbf4XB2tZMDTD73TMv
         vX1jf36sqC41enviKFR8I3M9jsYcWvLVdTaSNLddDwR7hrnJvwwntmCsWGSGdbOQUAB0
         mAqbvjbAkfiwnaUck7btWj0NkUjO1RiRNsB1w=
Received: by 10.101.142.34 with SMTP id u34mr220087ann.39.1263591118991;
        Fri, 15 Jan 2010 13:31:58 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.60.1 with SMTP id n1ls305075ebh.3.p; Fri, 15 Jan 2010 
	13:31:56 -0800 (PST)
Received: by 10.213.100.7 with SMTP id w7mr433433ebn.2.1263591116622;
        Fri, 15 Jan 2010 13:31:56 -0800 (PST)
Received: by 10.213.100.7 with SMTP id w7mr433432ebn.2.1263591116598;
        Fri, 15 Jan 2010 13:31:56 -0800 (PST)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
        by gmr-mx.google.com with ESMTP id 17si34470ewy.11.2010.01.15.13.31.55;
        Fri, 15 Jan 2010 13:31:55 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.150 as permitted sender) client-ip=74.125.78.150;
Received: by ey-out-1920.google.com with SMTP id 26so71389eyw.46
        for <msysgit@googlegroups.com>; Fri, 15 Jan 2010 13:31:55 -0800 (PST)
Received: by 10.213.0.213 with SMTP id 21mr203563ebc.57.1263591115449;
        Fri, 15 Jan 2010 13:31:55 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 15sm1812075ewy.8.2010.01.15.13.31.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:55 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 74.125.78.150 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/bb1bf18c2289f978
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137130>

--user and --detach are disabled on Windows due to lack of
fork(), setuid(), setgid(), setsid() and initgroups().

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile       |    8 +++-----
 compat/mingw.h |    1 +
 daemon.c       |   19 ++++++++++++++-----
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index d81b392..cb6c36d 100644
--- a/Makefile
+++ b/Makefile
@@ -390,6 +390,7 @@ EXTRA_PROGRAMS =
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
+PROGRAMS += git-daemon$X
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-hash-object$X
 PROGRAMS += git-imap-send$X
@@ -986,7 +987,6 @@ ifeq ($(uname_S),Windows)
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
-	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
@@ -1037,7 +1037,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
-	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
@@ -1047,6 +1046,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	BLK_SHA1 = YesPlease
 	NO_PYTHON = YesPlease
+	NO_INET_PTON = YesPlease
+	NO_INET_NTOP = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
@@ -1141,9 +1142,6 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
-ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAMS += git-daemon$X
-endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
diff --git a/compat/mingw.h b/compat/mingw.h
index e72c2ee..173bec5 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -7,6 +7,7 @@
 
 typedef int pid_t;
 typedef int socklen_t;
+typedef unsigned int gid_t;
 #define hstrerror strerror
 
 #define S_IFLNK    0120000 /* Symbolic link */
diff --git a/daemon.c b/daemon.c
index fc2c150..cdf5c72 100644
--- a/daemon.c
+++ b/daemon.c
@@ -589,7 +589,7 @@ static struct child {
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(struct child_process *cld, struct sockaddr *addr, int addrlen)
+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child *newborn, **cradle;
 
@@ -646,7 +646,7 @@ static void check_dead_children(void)
 }
 
 char **cld_argv;
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = { 0 };
 
@@ -847,7 +847,7 @@ static int service_loop(int socknum, int *socklist)
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
@@ -879,6 +879,7 @@ static void sanitize_stdfds(void)
 
 static void daemonize(void)
 {
+#ifndef WIN32
 	switch (fork()) {
 		case 0:
 			break;
@@ -893,6 +894,9 @@ static void daemonize(void)
 	close(1);
 	close(2);
 	sanitize_stdfds();
+#else
+	die("--detach is not supported on Windows");
+#endif
 }
 
 static void store_pid(const char *path)
@@ -913,10 +917,12 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
 		die("unable to allocate any listen sockets on host %s port %u",
 		    listen_addr, listen_port);
 
+#ifndef WIN32
 	if (pass && gid &&
 	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
 	     setuid(pass->pw_uid)))
 		die("cannot drop privileges");
+#endif
 
 	return service_loop(socknum, socklist);
 }
@@ -929,7 +935,6 @@ int main(int argc, char **argv)
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct passwd *pass = NULL;
-	struct group *group;
 	gid_t gid = 0;
 	int i;
 
@@ -1078,6 +1083,7 @@ int main(int argc, char **argv)
 		die("--group supplied without --user");
 
 	if (user_name) {
+#ifndef WIN32
 		pass = getpwnam(user_name);
 		if (!pass)
 			die("user not found - %s", user_name);
@@ -1085,12 +1091,15 @@ int main(int argc, char **argv)
 		if (!group_name)
 			gid = pass->pw_gid;
 		else {
-			group = getgrnam(group_name);
+			struct group *group = getgrnam(group_name);
 			if (!group)
 				die("group not found - %s", group_name);
 
 			gid = group->gr_gid;
 		}
+#else
+		die("--user is not supported on Windows");
+#endif
 	}
 
 	if (strict_paths && (!ok_paths || !*ok_paths))
-- 
1.6.6.211.g26720
