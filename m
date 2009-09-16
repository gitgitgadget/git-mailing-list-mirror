From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 12/15] Add MSVC to Makefile
Date: Wed, 16 Sep 2009 10:20:28 +0200
Message-ID: <49b1712beea2ac9eb00c61c8d92c035a7c412d69.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com> <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com> <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com> <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com> <489a0e7c6c41985a5208e85e9b24900c97dcacdb.1253088099.git.mstormo@gmail.com> <38f180f3899d1f7a6acc8cf8c65f5f0ffb61699a.1253088099.git.mstorm
 o@gmail.com> <e9ffbe6e71d7f27c4ee5d31f59f860827c5a2f94.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:39 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplW-0004m7-6u
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:26 +0200
Received: by mail-yx0-f137.google.com with SMTP id 1so8796964yxe.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=+bb2M/WTqYct7Kn0CP1ujIv02Mp4Beb10yPkNU8sbdE=;
        b=EYxf2alcu+3fjcgKSDrFic82kSXvmNRXnrsVzuTmL6AtBXIeUBtyxPtsYRRiJrr+4L
         F9mubklgPdtOk8yQiziu+dsL8zHRZGkFWzs2hvGVNKwDb6fbaQi2i4qObf/tIBJCja0M
         ooxJQQ4z/6SKG5fRDp7WiIuQwq2a8sxQBA6h4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=q4v5TztCg5BNnKB6TRj5AjJHcPPbTnBgXlX9wAPy+vtb/zA7RWV70nCJfwoGCauX9x
         6GwdeMK+v/xZ0NLR2lDCyu4Mle9Mnr9F/eb2i0zhRnAOX8EjVQ7y7YV72GlW6UzccfuB
         txPinrHVIgCsjpkVtCusa3Zl1Tk9ofMGXz1XY=
Received: by 10.101.127.6 with SMTP id e6mr1934199ann.20.1253089279957;
        Wed, 16 Sep 2009 01:21:19 -0700 (PDT)
Received: by 10.177.112.39 with SMTP id p39gr7047yqm.0;
	Wed, 16 Sep 2009 01:21:10 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.96.23 with SMTP id t23mr239839ebb.12.1253089268593; Wed, 16 Sep 2009 01:21:08 -0700 (PDT)
Received: by 10.210.96.23 with SMTP id t23mr239838ebb.12.1253089268562; Wed, 16 Sep 2009 01:21:08 -0700 (PDT)
Received: from mail-ew0-f228.google.com (mail-ew0-f228.google.com [209.85.219.228]) by gmr-mx.google.com with ESMTP id 14si1702981ewy.1.2009.09.16.01.21.07; Wed, 16 Sep 2009 01:21:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.228 as permitted sender) client-ip=209.85.219.228;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.228 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f228.google.com with SMTP id 28so922981ewy.28 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=5RthGAOVa/RZdoiubMq11JP8R/OUmPOc31X27XNLMno=; b=d5rYRywlrRIKfjbU+8qgB6Esc8Qba/SCjnapCeB9dK/ur7OuLEfqVMlqNsd2G9hhUP Uz8uz18OViAxxmj+1LuQwJplM9R1QeLcse7wBux8tSfLQOlq4ZpUImGGx+WBv5auDDlX dyXhbVP8/a+HDXLCC6RjG7H3c+Y03iost177E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=SpGbj5wVburVrILU31dJGvfyL5I6HAZbkeB8Aw2ZRlQiO3GTvKjL6z2D6BW/Sabtwt lK1dJBJg5k7OBlE/BkuyZreSZd2HUkioHeAhvBxZrszxQf+yTHr9rK4N4jYq/YppC95W 846Y0Qp6/Sm1m4GtUsuwuZ0YXcQbiMTF/o7GA=
Received: by 10.211.146.9 with SMTP id y9mr1859112ebn.94.1253089267232; Wed, 16 Sep 2009 01:21:07 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.21.05 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:21:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <e9ffbe6e71d7f27c4ee5d31f59f860827c5a2f94.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128631>


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
 Makefile                        |   55 ++++++++++++++++++++++++++++++++++++++-
 compat/vcbuild/scripts/clink.pl |   48 ++++++++++++++++++++++++++++++++++
 compat/vcbuild/scripts/lib.pl   |   26 ++++++++++++++++++
 3 files changed, 128 insertions(+), 1 deletions(-)
 create mode 100644 compat/vcbuild/scripts/clink.pl
 create mode 100644 compat/vcbuild/scripts/lib.pl

diff --git a/Makefile b/Makefile
index bde2acd..aa918eb 100644
--- a/Makefile
+++ b/Makefile
@@ -877,6 +877,58 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
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
+	AR += -LTCG
+else
+	BASIC_CFLAGS += -Zi -MTd
+endif
+	X = .exe
+else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -925,6 +977,7 @@ else
 	NO_PTHREADS = YesPlease
 endif
 endif
+endif
 
 -include config.mak.autogen
 -include config.mak
@@ -1327,7 +1380,7 @@ strip: $(PROGRAMS) git$X
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
