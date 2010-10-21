From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that
 require posix
Date: Fri, 22 Oct 2010 00:00:53 +0200
Message-ID: <AANLkTi=ydzrvy6_PbFLpA_qcHzF-8s3xbu3XvU5GnQ_k@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com> <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 <7vbp6vduly.fsf@alter.siamese.dyndns.org> <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
 <20101018163134.GA6343@burratino> <AANLkTik3Di=dcC=CxW+Lou515E2wXq8_OaR99mghC+vF@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, msysgit@googlegroups.com, 
	j6t@kdbg.org, avarab@gmail.com, sunshine@sunshineco.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncCOPdven-DxCt8ILmBBoEn5MdYg@googlegroups.com Fri Oct 22 00:01:46 2010
Return-path: <msysgit+bncCOPdven-DxCt8ILmBBoEn5MdYg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCt8ILmBBoEn5MdYg@googlegroups.com>)
	id 1P93Cf-0006GB-94
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 00:01:41 +0200
Received: by wyi11 with SMTP id 11sf46252wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:mime-version:received
         :reply-to:in-reply-to:references:from:date:message-id:subject:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=betE2PbqZp8XmUdVFFPzfDJhBw37Oj48ck+T1k0154Y=;
        b=1zlXJNADyJ3mYlpkTFan8sUQZmQEgdcUo1bqun/rRvhvsq5GkxMlmx7vf9I0V76jC8
         LTApFCrRU8IvMKGnP1bvTfHFUPV6S9gL/RrTdF0oZT3iQJ6RqErGoUqYmPwd5WOU6ve4
         fz/8RC2YuovsifegZ2kXKuQEUmQQoG+VLB00c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        b=Piw0+KaBFo1kU91hdihwyPPFMm2HgTP4/SCtLBuPbhBSnf10rx1w56umZXKwRbg5cu
         aludfCilB9CvLeJxSUraUd5+uMSkQXB/IMPD/rhdXNKr/0amUX33xC+nVUAKbTKpFmEa
         esflPVvyUSCwsjH4SlQa3aI9OGNz78QXlSJNc=
Received: by 10.216.236.90 with SMTP id v68mr279051weq.7.1287698477053;
        Thu, 21 Oct 2010 15:01:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.130.207 with SMTP id u15ls1012956bks.2.p; Thu, 21 Oct 2010
 15:01:16 -0700 (PDT)
Received: by 10.204.84.16 with SMTP id h16mr85421bkl.15.1287698476018;
        Thu, 21 Oct 2010 15:01:16 -0700 (PDT)
Received: by 10.204.84.16 with SMTP id h16mr85420bkl.15.1287698475970;
        Thu, 21 Oct 2010 15:01:15 -0700 (PDT)
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com [209.85.161.42])
        by gmr-mx.google.com with ESMTP id z17si961037bkb.3.2010.10.21.15.01.14;
        Thu, 21 Oct 2010 15:01:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.161.42 as permitted sender) client-ip=209.85.161.42;
Received: by fxm1 with SMTP id 1so127717fxm.29
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 15:01:14 -0700 (PDT)
Received: by 10.103.233.15 with SMTP id k15mr2150339mur.101.1287698473696;
 Thu, 21 Oct 2010 15:01:13 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Thu, 21 Oct 2010 15:00:53 -0700 (PDT)
In-Reply-To: <AANLkTik3Di=dcC=CxW+Lou515E2wXq8_OaR99mghC+vF@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.161.42 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159577>

On Thu, Oct 21, 2010 at 11:16 PM, Erik Faye-Lund <kusmabite@gmail.com> wrot=
e:
> On Mon, Oct 18, 2010 at 6:31 PM, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
>> Just to throw an idea out: you can also do something like
>>
>> #ifndef NO_POSIX_GOODIES
>> struct credentials {
>> };
>> #else
>> struct credentials {
>> =A0 =A0 =A0 =A0struct passwd *pass;
>> =A0 =A0 =A0 =A0gid_t gid;
>> }
>> #endif
>>
>> and pass a pointer to credentials around.
>>
>
> Yes, but that structure still needs to be filled somehow. I'm not sure
> how this solves anything, really. Isn't it essentially another way of
> wrapping an ifdef around the parameters inside main() (at least when
> I've inlined serve() into main())?
>
>> #ifndef HAVE_POSIX_GOODIES
>> static int drop_privileges(...)
>> {
>> =A0 =A0 =A0 =A0return error("--user and --group not supported on this pl=
atform");
>> }
>> #endif
>> static int drop_privileges(...)
>> {
>> =A0 =A0 =A0 =A0...
>> =A0 =A0 =A0 =A0do
>> =A0 =A0 =A0 =A0something
>> =A0 =A0 =A0 =A0...
>> }
>> #endif
>>
>> would make serve() look like
>>
>> static int serve(...)
>> {
>> =A0 =A0 =A0 =A0int socknum, *socklist;
>>
>> =A0 =A0 =A0 =A0... setup socket ...
>>
>> =A0 =A0 =A0 =A0if (want to drop privileges) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (drop_privileges(...))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0return service_loop(socknum, socklist);
>> }
>>
>> which should be quite readable even to a person only interested in the
>> !HAVE_POSIX_GOODIES case imho. =A0With some code rearrangement it could
>> be made nicer. =A0Now compare:
>>
>> static int serve(...)
>> {
>> =A0 =A0 =A0 =A0int socknum, *socklist;
>>
>> =A0 =A0 =A0 =A0... setup socket ...
>>
>> #ifdef HAVE_POSIX_GOODIES
>> =A0 =A0 =A0 =A0...
>> =A0 =A0 =A0 =A0do
>> =A0 =A0 =A0 =A0things
>> =A0 =A0 =A0 =A0...
>> #endif
>>
>> =A0 =A0 =A0 =A0return service_loop(socknum, socklist);
>> }
>>
>> Just my two cents. =A0Sorry I do not have something more substantive to
>> say.
>>
>
> You're leaving out the troublesome part, namely the glue between "if
> (user_name)" in main(), and the "want to drop privileges"-stuff in
> serve().
>
> I could do a "struct credentials *cred =3D NULL;" =A0in main(), and assig=
n
> that inside "if (user_name)". But that'd leave a warning about
> unreachable code in drop_privileges(), no?
>

OK, I did another stab at this, and this is the best I could come up
with right now, what do you think?

diff --git a/Makefile b/Makefile
index 46034bf..53986b1 100644
--- a/Makefile
+++ b/Makefile
@@ -401,6 +401,7 @@ EXTRA_PROGRAMS =3D
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS +=3D $(EXTRA_PROGRAMS)

+PROGRAM_OBJS +=3D daemon.o
 PROGRAM_OBJS +=3D fast-import.o
 PROGRAM_OBJS +=3D imap-send.o
 PROGRAM_OBJS +=3D shell.o
@@ -1066,7 +1067,6 @@ ifeq ($(uname_S),Windows)
 	NO_SVN_TESTS =3D YesPlease
 	NO_PERL_MAKEMAKER =3D YesPlease
 	RUNTIME_PREFIX =3D YesPlease
-	NO_POSIX_ONLY_PROGRAMS =3D YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
 	NO_NSEC =3D YesPlease
 	USE_WIN32_MMAP =3D YesPlease
@@ -1077,6 +1077,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL =3D YesPlease
 	NO_PYTHON =3D YesPlease
 	BLK_SHA1 =3D YesPlease
+	NO_POSIX_GOODIES =3D UnfortunatelyYes
 	NATIVE_CRLF =3D YesPlease

 	CC =3D compat/vcbuild/scripts/clink.pl
@@ -1119,7 +1120,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS =3D YesPlease
 	NO_PERL_MAKEMAKER =3D YesPlease
 	RUNTIME_PREFIX =3D YesPlease
-	NO_POSIX_ONLY_PROGRAMS =3D YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
 	NO_NSEC =3D YesPlease
 	USE_WIN32_MMAP =3D YesPlease
@@ -1130,6 +1130,9 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PYTHON =3D YesPlease
 	BLK_SHA1 =3D YesPlease
 	ETAGS_TARGET =3D ETAGS
+	NO_INET_PTON =3D YesPlease
+	NO_INET_NTOP =3D YesPlease
+	NO_POSIX_GOODIES =3D UnfortunatelyYes
 	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat
-Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
 	COMPAT_OBJS +=3D compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o=
 \
@@ -1249,9 +1252,6 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS +=3D -lz

-ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAM_OBJS +=3D daemon.o
-endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL =3D -lssl
 	ifdef OPENSSLDIR
@@ -1419,6 +1419,10 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS +=3D -DNO_DEFLATE_BOUND
 endif

+ifdef NO_POSIX_GOODIES
+	BASIC_CFLAGS +=3D -DNO_POSIX_GOODIES
+endif
+
 ifdef BLK_SHA1
 	SHA1_HEADER =3D "block-sha1/sha1.h"
 	LIB_OBJS +=3D block-sha1/sha1.o
diff --git a/daemon.c b/daemon.c
index b7f3874..20ae9b4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -26,7 +26,9 @@ static const char daemon_usage[] =3D
 "           [--reuseaddr] [--pid-file=3Dfile]\n"
 "           [--[enable|disable|allow-override|forbid-override]=3Dservice]\=
n"
 "           [--inetd | [--listen=3Dhost_or_ipaddr] [--port=3Dn]\n"
+#ifndef NO_POSIX_GOODIES
 "                      [--detach] [--user=3Duser [--group=3Dgroup]]\n"
+#endif
 "           [directory...]";

 /* List of acceptable pathname prefixes */
@@ -938,6 +940,33 @@ static void sanitize_stdfds(void)
 		close(fd);
 }

+#ifdef NO_POSIX_GOODIES
+
+struct credentials;
+static void drop_privileges(struct credentials *cred)
+{
+	/* nothing */
+}
+
+static void daemonize(void)
+{
+	die("--detach not supported on this platform");
+}
+
+#else
+
+struct credentials {
+	struct passwd *pass;
+	gid_t gid;
+};
+
+static void drop_privileges(struct credentials *cred)
+{
+	if (cred && initgroups(cred->pass->pw_name, cred->gid) ||
+	    setgid (cred->gid) || setuid(cred->pass->pw_uid))
+		die("cannot drop privileges");
+}
+
 static void daemonize(void)
 {
 	switch (fork()) {
@@ -955,6 +984,7 @@ static void daemonize(void)
 	close(2);
 	sanitize_stdfds();
 }
+#endif

 static void store_pid(const char *path)
 {
@@ -965,7 +995,7 @@ static void store_pid(const char *path)
 		die_errno("failed to write pid file '%s'", path);
 }

-static int serve(struct string_list *listen_addr, int listen_port,
struct passwd *pass, gid_t gid)
+static int serve(struct string_list *listen_addr, int listen_port,
struct credentials *cred)
 {
 	struct socketlist socklist =3D { NULL, 0, 0 };

@@ -974,10 +1004,7 @@ static int serve(struct string_list
*listen_addr, int listen_port, struct passwd
 		die("unable to allocate any listen sockets on port %u",
 		    listen_port);

-	if (pass && gid &&
-	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
-	     setuid(pass->pw_uid)))
-		die("cannot drop privileges");
+	drop_privileges(cred);

 	return service_loop(&socklist);
 }
@@ -989,9 +1016,7 @@ int main(int argc, char **argv)
 	int serve_mode =3D 0, inetd_mode =3D 0;
 	const char *pid_file =3D NULL, *user_name =3D NULL, *group_name =3D NULL;
 	int detach =3D 0;
-	struct passwd *pass =3D NULL;
-	struct group *group;
-	gid_t gid =3D 0;
+	struct credentials *cred =3D NULL;
 	int i;

 	git_extract_argv0_path(argv[0]);
@@ -1079,6 +1104,7 @@ int main(int argc, char **argv)
 			pid_file =3D arg + 11;
 			continue;
 		}
+#ifndef NO_POSIX_GOODIES
 		if (!strcmp(arg, "--detach")) {
 			detach =3D 1;
 			log_syslog =3D 1;
@@ -1092,6 +1118,12 @@ int main(int argc, char **argv)
 			group_name =3D arg + 8;
 			continue;
 		}
+#else
+		/* avoid warnings */
+		(void)user_name;
+		(void)group_name;
+		(void)detach;
+#endif
 		if (!prefixcmp(arg, "--enable=3D")) {
 			enable_service(arg + 9, 1);
 			continue;
@@ -1126,32 +1158,37 @@ int main(int argc, char **argv)
 		/* avoid splitting a message in the middle */
 		setvbuf(stderr, NULL, _IOFBF, 4096);

-	if (inetd_mode && (detach || group_name || user_name))
-		die("--detach, --user and --group are incompatible with --inetd");
-
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen=3D and --port=3D are incompatible with --inetd");
 	else if (listen_port =3D=3D 0)
 		listen_port =3D DEFAULT_GIT_PORT;

+#ifndef NO_POSIX_GOODIES
+	if (inetd_mode && (detach || group_name || user_name))
+		die("--detach, --user and --group are incompatible with --inetd");
+
 	if (group_name && !user_name)
 		die("--group supplied without --user");

 	if (user_name) {
-		pass =3D getpwnam(user_name);
-		if (!pass)
+		struct credentials c;
+		cred =3D &c;
+
+		c->pass =3D getpwnam(user_name);
+		if (!c->pass)
 			die("user not found - %s", user_name);

 		if (!group_name)
-			gid =3D pass->pw_gid;
+			c->gid =3D pass->pw_gid;
 		else {
-			group =3D getgrnam(group_name);
+			struct group *group =3D getgrnam(group_name);
 			if (!group)
 				die("group not found - %s", group_name);

-			gid =3D group->gr_gid;
+			c->gid =3D group->gr_gid;
 		}
 	}
+#endif

 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");
@@ -1185,5 +1222,5 @@ int main(int argc, char **argv)
 	cld_argv[argc] =3D "--serve";
 	cld_argv[argc+1] =3D NULL;

-	return serve(&listen_addr, listen_port, pass, gid);
+	return serve(&listen_addr, listen_port, cred);
 }
