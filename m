From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 11/11] mingw: compile git-daemon
Date: Thu, 26 Nov 2009 00:44:20 +0000
Message-ID: <1259196260-3064-12-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-10-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-11-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org, dotzenlabs@gmail.com, Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 3mc8NSwkOB8Er1zthip0lnvvnslthps.jvttz5znp0nvvnslnyv1wz.jvt@listserv.bounces.google.com Thu Nov 26 01:45:32 2009
Return-path: <3mc8NSwkOB8Er1zthip0lnvvnslthps.jvttz5znp0nvvnslnyv1wz.jvt@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSUF-00011L-92
	for gcvm-msysgit@m.gmane.org; Thu, 26 Nov 2009 01:45:31 +0100
Received: by mail-gx0-f190.google.com with SMTP id 6sf9154541gxk.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Nov 2009 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:x-thread-url:x-message-url
         :list-unsubscribe:list-subscribe;
        bh=l0EDOT/fXsIo/3bf4cYpZuCIuEYTtBTQ/e89TlGmzxE=;
        b=olnDG3Du29E42rpQa2lz1jyDXY/f23tfZb5NCRYfxSpIKWiEtW/+Y5fWh7J9rP9coQ
         BprY4Gad1Uq8hOlM07CLVpNkollRu3u+IYo0chuVkcKJ4LIo9MrEjRa+cc3Aq77eZcdE
         uPDYMdD562mgS9ouG2stu7f75e2yY/nPuDmkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:x-thread-url:x-message-url
         :list-unsubscribe:list-subscribe;
        b=fDzdCrKlVngYfzhwr14cyt7foH83+n2uJw96tCqu2KVh8kzRnw4CzzN+C7VtmbmWRD
         KUW8JrVXavbvstti3ZnKdQ3+6gW5NL3yudgfvGVNACZjULmz21XSTh9brIuTfzuPOxyx
         iUxvZ11kcLp8t8wcm1+I/lfzNYkkHVSTnb8Qk=
Received: by 10.91.92.10 with SMTP id u10mr107684agl.31.1259196313919;
        Wed, 25 Nov 2009 16:45:13 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.77.68 with SMTP id f4ls59529ebk.2.p; Wed, 25 Nov 2009 
	16:45:12 -0800 (PST)
Received: by 10.213.99.137 with SMTP id u9mr384103ebn.14.1259196312337;
        Wed, 25 Nov 2009 16:45:12 -0800 (PST)
Received: by 10.213.99.137 with SMTP id u9mr384102ebn.14.1259196312310;
        Wed, 25 Nov 2009 16:45:12 -0800 (PST)
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com [209.85.219.223])
        by gmr-mx.google.com with ESMTP id 12si19186ewy.2.2009.11.25.16.45.11;
        Wed, 25 Nov 2009 16:45:11 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.223 as permitted sender) client-ip=209.85.219.223;
Received: by mail-ew0-f223.google.com with SMTP id 23so306177ewy.24
        for <msysgit@googlegroups.com>; Wed, 25 Nov 2009 16:45:11 -0800 (PST)
Received: by 10.213.0.196 with SMTP id 4mr4975322ebc.41.1259196311226;
        Wed, 25 Nov 2009 16:45:11 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 10sm386248eyz.47.2009.11.25.16.45.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:45:10 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-11-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.223 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/15f3dd983aa85143
X-Message-Url: http://groups.google.com/group/msysgit/msg/df4bba449b4403a1
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133742>

--user and --detach are disabled on Windows due to lack of
fork(), setuid(), setgid(), setsid() and initgroups().

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile       |    6 +++---
 compat/mingw.h |    1 +
 daemon.c       |   19 ++++++++++++++-----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 3b01694..406ca81 100644
--- a/Makefile
+++ b/Makefile
@@ -352,6 +352,7 @@ EXTRA_PROGRAMS =
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
+PROGRAMS += git-daemon$X
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-hash-object$X
 PROGRAMS += git-imap-send$X
@@ -981,6 +982,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	BLK_SHA1 = YesPlease
+	NO_INET_PTON = YesPlease
+	NO_INET_NTOP = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	# We have GCC, so let's make use of those nice options
@@ -1079,9 +1082,6 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
-ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAMS += git-daemon$X
-endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
diff --git a/compat/mingw.h b/compat/mingw.h
index 576b1a1..1b0dd5b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -6,6 +6,7 @@
 
 typedef int pid_t;
 typedef int socklen_t;
+typedef unsigned int gid_t;
 #define hstrerror strerror
 
 #define S_IFLNK    0120000 /* Symbolic link */
diff --git a/daemon.c b/daemon.c
index 130e951..5872ec7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -616,7 +616,7 @@ static struct child {
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(struct async *async, struct sockaddr *addr, int addrlen)
+static void add_child(struct async *async, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child *newborn, **cradle;
 
@@ -679,7 +679,7 @@ int async_execute(int fd, void *data)
 	return ret;
 }
 
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct sockaddr_storage *ss;
 	struct async async = { 0 };
@@ -884,7 +884,7 @@ static int service_loop(int socknum, int *socklist)
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
@@ -916,6 +916,7 @@ static void sanitize_stdfds(void)
 
 static void daemonize(void)
 {
+#ifndef WIN32
 	switch (fork()) {
 		case 0:
 			break;
@@ -930,6 +931,9 @@ static void daemonize(void)
 	close(1);
 	close(2);
 	sanitize_stdfds();
+#else
+	die("--detach is not supported on Windows");
+#endif
 }
 
 static void store_pid(const char *path)
@@ -950,10 +954,12 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
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
@@ -966,7 +972,6 @@ int main(int argc, char **argv)
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct passwd *pass = NULL;
-	struct group *group;
 	gid_t gid = 0;
 	int i;
 
@@ -1110,6 +1115,7 @@ int main(int argc, char **argv)
 		die("--group supplied without --user");
 
 	if (user_name) {
+#ifndef WIN32
 		pass = getpwnam(user_name);
 		if (!pass)
 			die("user not found - %s", user_name);
@@ -1117,12 +1123,15 @@ int main(int argc, char **argv)
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
1.6.5.rc2.7.g4f8d3
