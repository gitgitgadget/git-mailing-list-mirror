From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 14/14] daemon: report connection from 
	root-process
Date: Fri, 15 Jan 2010 22:30:33 +0100
Message-ID: <1263591033-4992-15-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 34d5QSwkOB1wEOMG45CN8AIIAF8G4CF.6IGGMSMACNAIIAF8ALIOJM.6IG@listserv.bounces.google.com Fri Jan 15 22:32:42 2010
Return-path: <34d5QSwkOB1wEOMG45CN8AIIAF8G4CF.6IGGMSMACNAIIAF8ALIOJM.6IG@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtmU-0005Wh-0z
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 22:32:34 +0100
Received: by mail-gx0-f190.google.com with SMTP id 6sf2155544gxk.13
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 13:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=F4gKtaTJ+0NTEasKrjwTiIAFzHji93LLWUxvWICZMeM=;
        b=5A+N0rjBY0giivlEG5Ep8D5nviZ91/ZNt1aGOJ+Fg+JZygie6GD6+gdxawkzfZCc8d
         e6f36mAH9+4FH2DrZY+tQQ1yzV5muArETV78JuA9OtcKyFceFAuOfKC0J1W4DejLGqtO
         orh1g8SNVhS2DAym21GF++gibhy2Qtj0/NSDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=YFEhW4EawoH6VUFmXldFgT9+VODD6mR95rfsUQ77HmS0UXYXYhmkyxWkIsi8aKG4iU
         0k0SbUaowbUYFjpish6h7fNwNceQStbhMjAAqzpvQs2fU+5FXY32qFnI9Tm1+X9WnZgd
         pJXLsxMloxBaPOBAnYzsYSHe/0/qa/mcD5gUE=
Received: by 10.101.6.11 with SMTP id j11mr221930ani.30.1263591137308;
        Fri, 15 Jan 2010 13:32:17 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.62.209 with SMTP id y17ls59262ebh.1.p; Fri, 15 Jan 2010 
	13:32:15 -0800 (PST)
Received: by 10.213.106.210 with SMTP id y18mr160552ebo.5.1263591135316;
        Fri, 15 Jan 2010 13:32:15 -0800 (PST)
Received: by 10.213.106.210 with SMTP id y18mr160551ebo.5.1263591135295;
        Fri, 15 Jan 2010 13:32:15 -0800 (PST)
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com [209.85.219.209])
        by gmr-mx.google.com with ESMTP id 11si173546ewy.13.2010.01.15.13.32.14;
        Fri, 15 Jan 2010 13:32:14 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.209 as permitted sender) client-ip=209.85.219.209;
Received: by mail-ew0-f209.google.com with SMTP id 1so126663ewy.8
        for <msysgit@googlegroups.com>; Fri, 15 Jan 2010 13:32:14 -0800 (PST)
Received: by 10.213.110.210 with SMTP id o18mr2973579ebp.13.1263591133178;
        Fri, 15 Jan 2010 13:32:13 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 13sm1808824ewy.5.2010.01.15.13.32.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:32:12 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.209 as permitted 
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
X-Message-Url: http://groups.google.com/group/msysgit/msg/f6e8cd76dc7907df
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137133>

Report incoming connections from the process that
accept() the connection instead of the handling
process.

This enables "Connection from"-reporting on
Windows, where getpeername(0, ...) consistently
fails.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   70 +++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/daemon.c b/daemon.c
index 95cf299..3423ffa 100644
--- a/daemon.c
+++ b/daemon.c
@@ -493,33 +493,6 @@ static int execute(int fd[2], struct sockaddr *addr)
 	static char line[1000];
 	int pktlen, len, i;
 
-	if (addr) {
-		char addrbuf[256] = "";
-		int port = -1;
-
-		if (addr->sa_family == AF_INET) {
-			struct sockaddr_in *sin_addr = (void *) addr;
-			inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-			port = ntohs(sin_addr->sin_port);
-#ifndef NO_IPV6
-		} else if (addr && addr->sa_family == AF_INET6) {
-			struct sockaddr_in6 *sin6_addr = (void *) addr;
-
-			char *buf = addrbuf;
-			*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
-			inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
-			strcat(buf, "]");
-
-			port = ntohs(sin6_addr->sin6_port);
-#endif
-		}
-		loginfo("Connection from %s:%d", addrbuf, port);
-		setenv("REMOTE_ADDR", addrbuf, 1);
-	}
-	else {
-		unsetenv("REMOTE_ADDR");
-	}
-
 	alarm(init_timeout ? init_timeout : timeout);
 	pktlen = packet_read_line(fd[0], line, sizeof(line));
 	alarm(0);
@@ -645,10 +618,35 @@ static void check_dead_children(void)
 			cradle = &blanket->next;
 }
 
+static char *get_addrstr(int *port, struct sockaddr *addr)
+{
+	static char addrbuf[256] = "";
+	if (addr->sa_family == AF_INET) {
+		struct sockaddr_in *sin_addr = (void *) addr;
+		inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
+		*port = ntohs(sin_addr->sin_port);
+#ifndef NO_IPV6
+	} else if (addr && addr->sa_family == AF_INET6) {
+		struct sockaddr_in6 *sin6_addr = (void *) addr;
+
+		char *buf = addrbuf;
+		*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
+		strcat(buf, "]");
+
+		*port = ntohs(sin6_addr->sin6_port);
+#endif
+	}
+	return addrbuf;
+}
+
 char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = { 0 };
+	char *addrstr, envbuf[300] = "REMOTE_ADDR=";
+	char *env[] = { envbuf, NULL };
+	int port = -1;
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
@@ -661,14 +659,21 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		}
 	}
 
+	addrstr = get_addrstr(&port, addr);
+	strcat(envbuf, addrstr);
+
+	cld.env = (const char **)env;
 	cld.argv = (const char **)cld_argv;
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
 	if (start_command(&cld))
 		logerror("unable to fork");
-	else
+	else {
+		loginfo("[%"PRIuMAX"] Connection from %s:%d",
+		    (uintmax_t)cld.pid, addrstr, port);
 		add_child(&cld, addr, addrlen);
+	}
 	close(incoming);
 }
 
@@ -1115,8 +1120,13 @@ int main(int argc, char **argv)
 		if (inetd_mode && !freopen("/dev/null", "w", stderr))
 			die_errno("failed to redirect stderr to /dev/null");
 
-		if (getpeername(0, peer, &slen))
-			peer = NULL;
+		if (!getpeername(0, peer, &slen)) {
+			int port = -1;
+			char *addrstr = get_addrstr(&port, peer);
+			setenv("REMOTE_ADDR", addrstr, 1);
+			loginfo("[%"PRIuMAX"] Connection from %s:%d",
+			    (uintmax_t)getpid(), addrstr, port);
+		}
 
 		return execute(fd, peer);
 	}
-- 
1.6.6.211.g26720
