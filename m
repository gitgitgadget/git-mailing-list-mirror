From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 12/14] Add MSVC to Makefile
Date: Tue, 15 Sep 2009 15:44:15 +0200
Message-ID: <9fc49662e1ec00388adb3d50c41d20561ed58939.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com> <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com> <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com> <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com> <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com> <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com> <606db5a89cc49818fa225312a3bb6dbda18867a6.1253021728.git.mstorm
 o@gmail.com> <65347d022ba857d57d3c081f28b239b9b665c587.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:25 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLS-0007Ah-Ns
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:22 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so11219966ywh.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=UWNQLWGfIJTCKvuBGFPdqMReHJUi+cSBlP6mBCziUb0=;
        b=hgrFZUO37gQD9xFSD/DMglwR+xsyHdSU5/LkUSE4dxpFHKKRqpsa16ztQ3WIZtSEt8
         XO9XjatWLk0CBKhChkJqUQtl9zf6qJTVMh4IpHqCpD/0jTHADc1BYLfX2gYkfWepNKd5
         WimMDDDrxVVck/FF5gUeICsLZ1bmOv7Zq7Smc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ooThWm92J410Ku+2yJWYDTDdt2PgQuc++Dhr/PPp5Bd66vn+/5MbanNOS6MH+fpxjJ
         1qZnrzOp9l9k4Hk9d8oz4jZ3wST/9UKwyMlmArigBl7wRs3TzoBe7rri3Ajob5rzDh3Z
         /5gWbSlDzJ7dWQh0wE+GR9PTcB9srcnFLqSFw=
Received: by 10.150.19.3 with SMTP id 3mr2233244ybs.32.1253022309484;
        Tue, 15 Sep 2009 06:45:09 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7019yqh.0;
	Tue, 15 Sep 2009 06:44:56 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.132.10 with SMTP id j10mr1168436ebn.3.1253022294927; Tue, 15 Sep 2009 06:44:54 -0700 (PDT)
Received: by 10.211.132.10 with SMTP id j10mr1168435ebn.3.1253022294873; Tue, 15 Sep 2009 06:44:54 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149]) by gmr-mx.google.com with ESMTP id 14si1549752ewy.5.2009.09.15.06.44.53; Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.149 as permitted sender) client-ip=74.125.78.149;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.149 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-1920.google.com with SMTP id 5so713906eyb.10 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=eu1TtrhrIEMWFSnrsDhe9dQPK65THgcjfS5IM31pogU=; b=fwVlfbOOX+xhoaZ/HClIzKdtUa4xw8c/U2EXhCZlbQnSSkETgf1VpBhZWYd9qS/weg 3IkHx7YVd0+vgceeMD/ZAUOmbMUylfO8r550QU6pk0sEHbEnOAxyONGaO66ULmdOLk2k golPVb77SHz6VF4/LK3Vje8N0xz9aFEzfmFi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=qevmKEXUbmRD6X/0YkH8gTmxQa7v2PNG5c15E0TlZWMfGCIMGhRJXHIIknYT3UEE9N DFoWv6vdRGjHZr60Bwp/e1SvU2VRbO3HHcYpr1XiZBvntKrnKqlAi0jf6H9TcJVBWyBD eGeF9T4nFo2XX8HW/Sp5lr4AxKkf1Qm7Fe1uo=
Received: by 10.211.161.16 with SMTP id n16mr8645826ebo.20.1253022293751; Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.52 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <65347d022ba857d57d3c081f28b239b9b665c587.1253021728.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128555>


Enable MSVC builds with GNU Make by simply calling
    make MSVC=1
(Debug build possible by adding DEBUG=1 as well)

Two scripts, clink.pl and lib.pl, are used to convert certain GCC
specific command line options into something MSVC understands.
By building for MSVC with GNU Make, we can ensure that the MSVC
port always follows the latest code, and does not lag behind due
to unmaintained NMake Makefile or IDE projects.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 Makefile                        |   54 ++++++++++++++++++++++++++++++++++++++-
 compat/vcbuild/scripts/clink.pl |   48 ++++++++++++++++++++++++++++++++++
 compat/vcbuild/scripts/lib.pl   |   26 ++++++++++++++++++
 3 files changed, 127 insertions(+), 1 deletions(-)
 create mode 100644 compat/vcbuild/scripts/clink.pl
 create mode 100644 compat/vcbuild/scripts/lib.pl

diff --git a/Makefile b/Makefile
index bde2acd..761cef1 100644
--- a/Makefile
+++ b/Makefile
@@ -877,6 +877,57 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
 	COMPAT_OBJS += compat/cygwin.o
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 endif
+ifdef MSVC
+	pathsep = ;
+	NO_PREAD = YesPlease
+	NO_OPENSSL = YesPlease
+	NO_LIBGEN_H = YesPlease
+	NO_SYMLINK_HEAD = YesPlease
+	NO_IPV6 = YesPlease
+	NO_SETENV = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MEMMEM = YesPlease
+	# NEEDS_LIBICONV = YesPlease
+	NO_ICONV = YesPlease
+	NO_C99_FORMAT = YesPlease
+	NO_STRTOUMAX = YesPlease
+	NO_STRTOULL = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
+	SNPRINTF_RETURNS_BOGUS = YesPlease
+	NO_SVN_TESTS = YesPlease
+	NO_PERL_MAKEMAKER = YesPlease
+	RUNTIME_PREFIX = YesPlease
+	NO_POSIX_ONLY_PROGRAMS = YesPlease
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	NO_NSEC = YesPlease
+	USE_WIN32_MMAP = YesPlease
+	# USE_NED_ALLOCATOR = YesPlease
+	UNRELIABLE_FSTAT = UnfortunatelyYes
+	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
+	NO_REGEX = YesPlease
+	NO_CURL = YesPlease
+	NO_PTHREADS = YesPlease
+
+	CC = compat/vcbuild/scripts/clink.pl
+	AR = compat/vcbuild/scripts/lib.pl
+	CFLAGS =
+	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32-D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
+	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
+	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
+	lib =
+ifndef DEBUG
+	BASIC_CFLAGS += -GL -Os -MT
+	BASIC_LDFLAGS += -LTCG
+else
+	BASIC_CFLAGS += -Zi -MTd
+endif
+	X = .exe
+else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -925,6 +976,7 @@ else
 	NO_PTHREADS = YesPlease
 endif
 endif
+endif
 
 -include config.mak.autogen
 -include config.mak
@@ -1327,7 +1379,7 @@ strip: $(PROGRAMS) git$X
 git.o: git.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-		$(ALL_CFLAGS) -c $(filter %.c,$^)
+		$(ALL_CFLAGS) -o $@ -c $(filter %.c,$^)
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
new file mode 100644
index 0000000..0ffd59f
--- /dev/null
+++ b/compat/vcbuild/scripts/clink.pl
@@ -0,0 +1,48 @@
+#!/usr/bin/perl -w
+######################################################################
+# Compiles or links files
+#
+# This is a wrapper to facilitate the compilation of Git with MSVC
+# using GNU Make as the build system. So, instead of manipulating the
+# Makefile into something nasty, just to support non-space arguments
+# etc, we use this wrapper to fix the command line options
+#
+# Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
+######################################################################
+use strict;
+my @args = ();
+my @cflags = ();
+my $is_linking = 0;
+while (@ARGV) {
+	my $arg = shift @ARGV;
+	if ("$arg" =~ /^-[DIMGO]/) {
+		push(@cflags, $arg);
+	} elsif ("$arg" eq "-o") {
+		my $file_out = shift @ARGV;
+		if ("$file_out" =~ /exe$/) {
+			$is_linking = 1;
+			push(@args, "-OUT:$file_out");
+		} else {
+			push(@args, "-Fo$file_out");
+		}
+	} elsif ("$arg" eq "-lz") {
+		push(@args, "zlib.lib");
+	} elsif ("$arg" eq "-liconv") {
+		push(@args, "iconv.lib");
+	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
+		$arg =~ s/^-L/-LIBPATH:/;
+		push(@args, $arg);
+	} elsif ("$arg" =~ /^-R/) {
+		# eat
+	} else {
+		push(@args, $arg);
+	}
+}
+if ($is_linking) {
+	unshift(@args, "link.exe");
+} else {
+	unshift(@args, "cl.exe");
+	push(@args, @cflags);
+}
+#printf("**** @args\n");
+exit system(@args);
diff --git a/compat/vcbuild/scripts/lib.pl b/compat/vcbuild/scripts/lib.pl
new file mode 100644
index 0000000..68f6644
--- /dev/null
+++ b/compat/vcbuild/scripts/lib.pl
@@ -0,0 +1,26 @@
+#!/usr/bin/perl -w
+######################################################################
+# Libifies files on Windows
+#
+# This is a wrapper to facilitate the compilation of Git with MSVC
+# using GNU Make as the build system. So, instead of manipulating the
+# Makefile into something nasty, just to support non-space arguments
+# etc, we use this wrapper to fix the command line options
+#
+# Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
+######################################################################
+use strict;
+my @args = ();
+while (@ARGV) {
+	my $arg = shift @ARGV;
+	if ("$arg" eq "rcs") {
+		# Consume the rcs option
+	} elsif ("$arg" =~ /\.a$/) {
+		push(@args, "-OUT:$arg");
+	} else {
+		push(@args, $arg);
+	}
+}
+unshift(@args, "lib.exe");
+# printf("**** @args\n");
+exit system(@args);
-- 
1.6.2.1.418.g33d56.dirty
