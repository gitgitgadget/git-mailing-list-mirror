From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH v4 00/15] Build Git with MSVC
Date: Wed, 16 Sep 2009 10:20:16 +0200
Message-ID: <cover.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:13 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplH-0004m7-Se
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:12 +0200
Received: by mail-yx0-f137.google.com with SMTP id 1so8796964yxe.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=UAH0F2D890Y9VXOoRzJCbQgKEa3Lqmc7lBjJjVl2TcY=;
        b=Z9WVmJsZHwoMvAOtWb0DhPdUf0BPkvOtCu5ETh/LCRn+ob0L9YzJjwlTZuAJkqnc5m
         Ds02kzZ5hWEzuzL8aLr0G7lRVXGN1Sgk+gUxfqJs4Z3iVplKhWUx7H6wAcqyyuDqS/QQ
         MqgZfBjIyZ3xGrBSZzXA5ZGeluI6QD9usP2DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=IKBaDASGuoN/n/TooTL1VC0HJpSLtbTkt9CPH5KObZ4sGZpwgUMegBOhaBJgYBOv18
         hwehMvmS+kaSUObnNz866Q92bmtbBL1iIpcDGNknutOFCGzM+pgY2aVVk7qDXnDLAjQk
         8FV/hN9JPR+nBijg4mB3o5syx/DirpTCo2jhs=
Received: by 10.101.131.33 with SMTP id i33mr1928412ann.26.1253089265638;
        Wed, 16 Sep 2009 01:21:05 -0700 (PDT)
Received: by 10.176.13.37 with SMTP id 37gr7035yqm.0;
	Wed, 16 Sep 2009 01:20:52 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.9.6 with SMTP id 6mr1425466ebi.29.1253089249979; Wed, 16 Sep 2009 01:20:49 -0700 (PDT)
Received: by 10.210.9.6 with SMTP id 6mr1425465ebi.29.1253089249946; Wed, 16 Sep 2009 01:20:49 -0700 (PDT)
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com [209.85.219.214]) by gmr-mx.google.com with ESMTP id 16si1671113ewy.3.2009.09.16.01.20.48; Wed, 16 Sep 2009 01:20:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.214 as permitted sender) client-ip=209.85.219.214;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.214 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy10 with SMTP id 10so4937143ewy.13 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer; bh=Sz681D4OMORUGk5hfuQ6lzTAmCcW79oSxOAQe0kCAzE=; b=lZaHQRE+muf5WdYnU5qNGBCz3zZOq/Rshk9U7hOdoYGeqA+biRGnEnh6VDLgE6B3bQ ZCAGK273UGSfpYhjho2g/hAo8H+/HK4PpNbpdNPFbCxS82OvCSEJVHMcLWy/+d/jJ8Uf BfI80qAQ1r9IHUeazQcTaKIoN70lSOOJ7hl7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer; b=a1MVldARyO6kXgKKO4Wqd8hEUhSflHZRD3bdnAWIiXxVtJPF+EAZ9N6BMWJKohxj2x BeKj0bEsi+QonWMHzCrn40VmWxXnQnc+go06ORzRXafn/QvZr2n/vzmkQKX5r7EYw692 qjTZSAlMGhM8VxD2aRcx9wxSpQdbbAD8nO8Rk=
Received: by 10.210.101.7 with SMTP id y7mr9553056ebb.99.1253089248822; Wed, 16 Sep 2009 01:20:48 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.20.46 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:20:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128619>


=== V4 2009.09.16 ===

1) Removed the _fmode extern, and if(std*) statements, as pointed out
   by Alexey Borzenkov.
2) Renumbered the points in the compat/vcbuild/README (affects 2
   patches), as pointed out by Thiago Farina.
3) Added flag to lib command to invoke the Link Time Code Generation
   to avoid warnings about restarting the libifier with this option.
4) Added a patch to the end of the series, which tags the GIT_VERSION
   with ".MSVC", to ease debugging/problem solving on Windows, when we
   start getting reports from both MSysGit and MSVCGit people.
   NOTE: If people are OK with this patch, it should probably be
   squashed into patch 12. If not, just skip it.

The overall difference between v4 and v3 of this series is rather small
but since it touches several patches due to context (thus conflicts
appear), I push out a new version of the whole serie.

v3 to v4 diff:
diff --git a/Makefile b/Makefile
index 761cef1..2c20922 100644
--- a/Makefile
+++ b/Makefile
@@ -878,6 +878,7 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 endif
 ifdef MSVC
+	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	NO_PREAD = YesPlease
 	NO_OPENSSL = YesPlease
@@ -923,6 +924,7 @@ ifdef MSVC
 ifndef DEBUG
 	BASIC_CFLAGS += -GL -Os -MT
 	BASIC_LDFLAGS += -LTCG
+	AR += -LTCG
 else
 	BASIC_CFLAGS += -Zi -MTd
 endif
diff --git a/compat/mingw.h b/compat/mingw.h
index 544b576..5b5258b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -229,20 +229,17 @@ void free_environ(char **env);
 
 /*
  * A replacement of main() that ensures that argv[0] has a path
+ * and that default fmode and std(in|out|err) are in binary mode
  */
 
-extern int _fmode;
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(); \
 int main(int argc, const char **argv) \
 { \
 	_fmode = _O_BINARY; \
-	if (stdin) \
-		_setmode(_fileno(stdin), _O_BINARY); \
-	if (stdout) \
-		_setmode(_fileno(stdout), _O_BINARY); \
-	if (stderr) \
-		_setmode(_fileno(stderr), _O_BINARY); \
+	_setmode(_fileno(stdin), _O_BINARY); \
+	_setmode(_fileno(stdout), _O_BINARY); \
+	_setmode(_fileno(stderr), _O_BINARY); \
 	argv[0] = xstrdup(_pgmptr); \
 	return mingw_main(argc, argv); \
 } \
diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index e64f7e5..df8a657 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -29,11 +29,11 @@ The Steps of Build Git with VS2008
    executables, since Git might need to run scripts which are part of
    the git operations.
 
-4. Inside Git's directory run the command:
+3. Inside Git's directory run the command:
        make common-cmds.h
    to generate the common-cmds.h file needed to compile git.
 
-5. Then either build Git with the GNU Make Makefile in the Git projects
+4. Then either build Git with the GNU Make Makefile in the Git projects
    root
        make MSVC=1
    or generate Visual Studio solution/projects (.sln/.vcproj) with the
-- 
EOD

=== V3 2009.09.15 ===

1) Reworded patch 01: s/Microsoft Visual C++/MSVC/
2) Nuked patch 02
3) Merged patch 03 into path 08
4) Rewrote patch 06 to set _fmode instead for both MinGW and MSVC
5) Fix patch 07 to use __stdcall for thread functions instead of WINAPI
6) Rewrote patch 14 to rather use a define to _chsize
7) Fix patch 15 to use "-o $@" instead of "-o git.o"

Think that's it..

=== V2 2009.09.14 ===

Here's a second roll of the series for supporting compilation of Git
using Visual C++ (MSVC). (Sorry for the long delay on a followup, time
is in short supply these days)

There's no guarantee that the compiled result will work as well as the
current MinGW compile, or at all. However, I think it's important to
get the Git repo to a compilable state with MSVC as quickly as
possible, to further enable contributions from the Windows developers
which we are sorely lacking at the moment.
I hope that a repo which compiles successfully with the tools they are
accustomed to (also a very good debugger) will entice them to send more
patches.

In addition to this series, I have also setup a repo with binaries of
the required libs to compile Git with MSVC. Only 32bit versions for now.
So, the developer can choose to either use that, or Frank's source code
repo to build Git with MSVC. You'll find the binary repo here:
    http://repo.or.cz/w/msvcgit.git

Note that the binaries will still require the msysgit environment for
execution, due to the non-binary components of Git. (Scripts, gitk,
git-gui, etc). You'll find that repo here:
    http://repo.or.cz/w/msysgit.git

1) Rebased ontop on current git.git 'next'.
2) Fixed code and commit msgs based on the previous feedback.
   Let me know if I forgot anything!
3) Added a proper Makefile patch for MSVC support.
   You now compile with 'make MSVC=1'.
4) Added perl scripts (contrib) which uses GNU Make output to generate
   MSVC IDE (.sln & .vcproj) projects and QMake projects, and picking
   up the project settings from the Makefile, so it's all in one place.
5) Added necessary patches to make things compile ontop of current
   'next'.

=== V1 2009.08.21 ===
So, Frank Li started this series, and I took it upon my self to help
out a bit; cleaning, reorganizing, rebasing the series. Hopefully
we're now a bit closer to including the series into mainline..

Here's a summary of what has happend:
1) This series is rebased ontop of git.git 'next', which needed an
   extra patch to avoid a non-constant array creation, which
   mscv doesn't like.
2) I've polished (tied to anyways) the commit messages a bit.
3) I've applied much of the feedback provided to the first round of
   the patches.
4) I've split, merged and reordered some of the patches, so things
   that belong together are in the same commits, and in a order of
   'importance'
5) I've removed the
       #define func _func
   stuff, as it's not needed and Microsoft cannot really kill the
   compatibility functions anyways. So, adding the define
       _CRT_NONSTDC_NO_DEPRECATE
   will kill the warnings seen without the defines above.
6) ..probably much more as well, but I forget..

Note: I did not sign off on the last two commits, which involve the
adding of the vcproj files, since I don't agree on adding them as is.
We need a Makefile way of compiling primarily, and second, a script
to generate the vcproj, as already discussed. But the commits are
included for completeness, at to let others compile and play with it.

I've kept the original author as is, and just signed the patches..
Thanks for watching, now bring on the comments!

Frank Li (6):
  Avoid declaration after statement
  Change regerror() declaration from K&R style to ANSI C (C89)
  Fix __stdcall placement and function prototype
  Test for WIN32 instead of __MINGW32_
  Add MinGW header files to build git with MSVC
  Add platform files for MSVC porting

Marius Storm-Olsen (9):
  Add define guards to compat/win32.h
  Set _O_BINARY as default fmode for both MinGW and MSVC
  Add empty header files for MSVC port
  Make usage of windows.h lean and mean
  Define strncasecmp and ftruncate for MSVC
  Add MSVC to Makefile
  Add README for MSVC build
  Add scripts to generate projects for other buildsystems (MSVC vcproj,
    QMake)
  Tag GIT_VERSION when Git is built with MSVC

 .gitignore                                |   11 +
 Makefile                                  |   56 +++-
 compat/mingw.c                            |   20 +-
 compat/mingw.h                            |    7 +
 compat/msvc.c                             |   35 ++
 compat/msvc.h                             |   50 +++
 compat/regex/regex.c                      |    7 +-
 compat/snprintf.c                         |   10 +-
 compat/vcbuild/README                     |   50 +++
 compat/vcbuild/include/alloca.h           |    1 +
 compat/vcbuild/include/arpa/inet.h        |    1 +
 compat/vcbuild/include/dirent.h           |  128 ++++++
 compat/vcbuild/include/grp.h              |    1 +
 compat/vcbuild/include/inttypes.h         |    1 +
 compat/vcbuild/include/netdb.h            |    1 +
 compat/vcbuild/include/netinet/in.h       |    1 +
 compat/vcbuild/include/netinet/tcp.h      |    1 +
 compat/vcbuild/include/pwd.h              |    1 +
 compat/vcbuild/include/sys/ioctl.h        |    1 +
 compat/vcbuild/include/sys/param.h        |    1 +
 compat/vcbuild/include/sys/poll.h         |    1 +
 compat/vcbuild/include/sys/select.h       |    1 +
 compat/vcbuild/include/sys/socket.h       |    1 +
 compat/vcbuild/include/sys/time.h         |    1 +
 compat/vcbuild/include/sys/utime.h        |   34 ++
 compat/vcbuild/include/sys/wait.h         |    1 +
 compat/vcbuild/include/unistd.h           |   92 ++++
 compat/vcbuild/include/utime.h            |    1 +
 compat/vcbuild/scripts/clink.pl           |   48 +++
 compat/vcbuild/scripts/lib.pl             |   26 ++
 compat/win32.h                            |    7 +
 compat/winansi.c                          |    1 -
 contrib/buildsystems/Generators.pm        |   42 ++
 contrib/buildsystems/Generators/QMake.pm  |  189 +++++++++
 contrib/buildsystems/Generators/Vcproj.pm |  639 +++++++++++++++++++++++++++++
 contrib/buildsystems/engine.pl            |  353 ++++++++++++++++
 contrib/buildsystems/generate             |   29 ++
 contrib/buildsystems/parse.pl             |  228 ++++++++++
 git-compat-util.h                         |    9 +
 help.c                                    |    5 +-
 pager.c                                   |    4 +-
 run-command.c                             |   12 +-
 run-command.h                             |    2 +-
 setup.c                                   |    2 +-
 thread-utils.c                            |    5 +-
 45 files changed, 2084 insertions(+), 33 deletions(-)
 create mode 100644 compat/msvc.c
 create mode 100644 compat/msvc.h
 create mode 100644 compat/vcbuild/README
 create mode 100644 compat/vcbuild/include/alloca.h
 create mode 100644 compat/vcbuild/include/arpa/inet.h
 create mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/vcbuild/include/grp.h
 create mode 100644 compat/vcbuild/include/inttypes.h
 create mode 100644 compat/vcbuild/include/netdb.h
 create mode 100644 compat/vcbuild/include/netinet/in.h
 create mode 100644 compat/vcbuild/include/netinet/tcp.h
 create mode 100644 compat/vcbuild/include/pwd.h
 create mode 100644 compat/vcbuild/include/sys/ioctl.h
 create mode 100644 compat/vcbuild/include/sys/param.h
 create mode 100644 compat/vcbuild/include/sys/poll.h
 create mode 100644 compat/vcbuild/include/sys/select.h
 create mode 100644 compat/vcbuild/include/sys/socket.h
 create mode 100644 compat/vcbuild/include/sys/time.h
 create mode 100644 compat/vcbuild/include/sys/utime.h
 create mode 100644 compat/vcbuild/include/sys/wait.h
 create mode 100644 compat/vcbuild/include/unistd.h
 create mode 100644 compat/vcbuild/include/utime.h
 create mode 100644 compat/vcbuild/scripts/clink.pl
 create mode 100644 compat/vcbuild/scripts/lib.pl
 create mode 100644 contrib/buildsystems/Generators.pm
 create mode 100644 contrib/buildsystems/Generators/QMake.pm
 create mode 100644 contrib/buildsystems/Generators/Vcproj.pm
 create mode 100644 contrib/buildsystems/engine.pl
 create mode 100644 contrib/buildsystems/generate
 create mode 100644 contrib/buildsystems/parse.pl
