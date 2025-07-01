Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C8E1E9B1C
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400429; cv=none; b=d/5mSFrGdz/NDrxc9cceE3BTjiIJavnExC6v04MrN9QYWBOtp3B7ZsXOZRNKK2O/PGAcqIxQMpXIBiWmuB7sfcgAiShgDzXO44wxHgHw1RHotGdduOBZeVqS6v7Ptjvubie9SzegKavgAWp0C4w8OMV8xNOqszsnvrHYSAIYrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400429; c=relaxed/simple;
	bh=8d4fX5frWTt5pBZ4Wt+ICb6TaJN3lNaoeer4NMm3fF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Z5m734H49iQvqW9Al2dXGbN0C+xLJ94OmQFkxHhR71LEPvQt72E8x0/HHYSgpLhBQ+yVeSEKCp/rDjiWwaBylOj8ZWgy/R9jXGgFS6PJMvbDPHvJGWMbJUJqRyNxRchIXEzjsbyUg+F5hIWKlMLK4Yy/TNGV6cMK7jRA1Y+Icxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=BHROyXZy; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="BHROyXZy"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id WhCquTNX7ZgItWhCsup1GY; Tue, 01 Jul 2025 21:03:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1751400236; bh=0l0AlTSGf4iuRQ8Lprdno67AWT8FHSm1jAAxt0Uz7dM=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=BHROyXZyg+zXvYqcCf/ATEqsQiq6xZ1lyRrWEm0sTk8EKQFy9mLBE2Vm2ivnWAvdP
	 kaRyKh/2gqwDVbZo+hAvWVxShrk69ciMS3zWsIF0iaZQPW+LrCIYmxlYfvpM7Uz+gm
	 nMAeKIL/Oalb7LK3UOkblFg3RXSr5dXOstLDO+yax/okJ9AglqgegnUKg4fowkDQzG
	 zAO3Z/1sYwqPexJgOkjhBZgqWbpYPIjwmLMRW1uQcaI5NkgVKSJjrAYKp1n6FEY4O6
	 2G/l4cZL2FrH/OzUFbo28+0Xbd3ev9OHbEXx7ifa07UhHDR2BZoPPkvPXuywPq6Zez
	 i2bQchAWwhvFw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NdZF1HD4 c=1 sm=1 tr=0 ts=68643f2c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=EBOSESyhAAAA:8 a=4caNklJbyXdfieOO3jIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
Date: Tue, 1 Jul 2025 21:03:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
To: Renato Botelho <garga@FreeBSD.org>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 GIT Mailing-list <git@vger.kernel.org>
In-Reply-To: <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIhBKUbEOVGKcn4k3ywsVYCNi8A7IBT6rwhuk0v4o770rBu9efh2VV0Hc5ApEj7qd5U35Yq4M2WMIZUSQSMsEXdt2gfUq2M8r8RZ5ScoGCrfjqBd4G8i
 LX4wAahkv2JWgcKgSNIOzaZXsHQ7Dn8C8qqlQ2/elonie0KY/Y+8l0EO7gea+HVgB53MwTo921WRvlSXtT0PDF5uUPvypgTGDu4=



On 01/07/2025 17:05, Renato Botelho wrote:
> On 23/06/25 11:09, Renato Botelho wrote:
>> FreeBSD has a libsysinfo package which contains GNU libc's sysinfo port.   Some users reported git 2.50.0 was failing to build when this port is installed and it happened because configure script detected libsysinfo but -lsysinfo was not added to LDFLAGS, ending up with following error:
>>
>> scalar.o common-main.o libgit.a xdiff/lib.a reftable/libreftable.a libgit.a -lz -pthread
>> ld: error: undefined symbol: sysinfo
>>
>> This patch [1] was added to git port adding a user option to enable/ disable libsysinfo dependency and fix LDFLAGS when it's enabled.
>>
>> I'm not sure about what is best approach for git project in this case.
>>
>> [1] https://github.com/freebsd/freebsd-ports/blob/main/devel/git/files/ patch-configure.ac
> 
> If someone let me know what would be the desired approach here I can work on a patch.  Would you like to make that option conditional as the patch did?  Or detect if OS is FreeBSD and do something different?
> 

Ah, Sorry for the late reply, but I was away ... :)

Hmm, I can think of several approaches we could take, but I can't test any
of them (since I don't have access to a FreeBSD system).

- it would not be difficult to add a 'library-check' to the configure.ac
  file, so that '-lsysinfo' would be added to the link. (We would also
  have to make a similar change to meson.build). However, I don't think
  this is the right solution; I'm guessing that the compat sysinfo library
  is implemented in terms of sysctl() anyway, so ...

- we could simply change the order of the preprocessor conditionals in
  'builtin/gc.c' L530-541 so that the 'HAVE_SYSINFO' block comes after
  the 'HAVE_BSD_SYSCTL' block. (BTW, I assume that the HW_ symbols are
  defined whenever the 'sysinfo compat library' is installed; i.e. old
  versions of FreeBSD which don't define them are also too old to support
  the compat library).

- we could suppress the setting of HAVE_SYSINFO if HAVE_BSD_SYSCTL has
  been defined (in both configure.ac and meson.build).

I very quickly knocked up a patch to do the last option above (I moved
the setting of HAVE_SYSINFO down the file rather that HAVE_BSD_SYSCTL
up. I guess it doesn't matter, but I gave it *no* thought!).

The patch is below. (I didn't write a commit message ;) ).

Does this work for you?

ATB,
Ramsay Jones

---- >8 ----
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date: Tue, 1 Jul 2025 20:33:44 +0100
Subject: [PATCH] build: fix FreeBSD sysinfo build failure

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 configure.ac | 61 ++++++++++++++++++++++++++++++----------------------
 meson.build  | 10 +++++----
 2 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/configure.ac b/configure.ac
index f6caab919a..bf710ac91a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1067,32 +1067,6 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 
-#
-# Define HAVE_SYSINFO=YesPlease if sysinfo is available.
-#
-AC_DEFUN([HAVE_SYSINFO_SRC], [
-AC_LANG_PROGRAM([[
-#include <stdint.h>
-#include <sys/sysinfo.h>
-]], [[
-struct sysinfo si;
-uint64_t t = 0;
-if (!sysinfo(&si)) {
-	t = si.totalram;
-	if (si.mem_unit > 1)
-		t *= (uint64_t)si.mem_unit;
-}
-return t;
-]])])
-
-AC_MSG_CHECKING([for sysinfo])
-AC_COMPILE_IFELSE([HAVE_SYSINFO_SRC],
-	[AC_MSG_RESULT([yes])
-	HAVE_SYSINFO=YesPlease],
-	[AC_MSG_RESULT([no])
-	HAVE_SYSINFO=])
-GIT_CONF_SUBST([HAVE_SYSINFO])
-
 #
 # Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
 GIT_CHECK_FUNC(clock_gettime,
@@ -1221,6 +1195,41 @@ AC_COMPILE_IFELSE([BSD_SYSCTL_SRC],
 	HAVE_BSD_SYSCTL=])
 GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
 
+#
+# Define HAVE_SYSINFO=YesPlease if sysinfo is available.
+#
+
+HAVE_SYSINFO=
+# on a *BSD system, sysctl() takes precedence over the
+# sysinfo() compatibility library (if installed).
+
+if test -z "$HAVE_BSD_SYSCTL"; then
+
+  AC_DEFUN([HAVE_SYSINFO_SRC], [
+  AC_LANG_PROGRAM([[
+  #include <stdint.h>
+  #include <sys/sysinfo.h>
+  ]], [[
+  struct sysinfo si;
+  uint64_t t = 0;
+  if (!sysinfo(&si)) {
+	t = si.totalram;
+	if (si.mem_unit > 1)
+		t *= (uint64_t)si.mem_unit;
+  }
+  return t;
+  ]])])
+
+  AC_MSG_CHECKING([for sysinfo])
+  AC_COMPILE_IFELSE([HAVE_SYSINFO_SRC],
+	[AC_MSG_RESULT([yes])
+	HAVE_SYSINFO=YesPlease],
+	[AC_MSG_RESULT([no])
+	HAVE_SYSINFO=])
+  GIT_CONF_SUBST([HAVE_SYSINFO])
+
+fi
+
 ## Other checks.
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
diff --git a/meson.build b/meson.build
index 7fea4a34d6..355cad730c 100644
--- a/meson.build
+++ b/meson.build
@@ -1331,10 +1331,6 @@ if host_machine.system() != 'windows'
   endif
 endif
 
-if compiler.has_member('struct sysinfo', 'totalram', prefix: '#include <sys/sysinfo.h>')
-  libgit_c_args += '-DHAVE_SYSINFO'
-endif
-
 if compiler.has_member('struct stat', 'st_mtimespec.tv_nsec', prefix: '#include <sys/stat.h>')
   libgit_c_args += '-DUSE_ST_TIMESPEC'
 elif not compiler.has_member('struct stat', 'st_mtim.tv_nsec', prefix: '#include <sys/stat.h>')
@@ -1449,6 +1445,12 @@ if compiler.has_header('sys/sysctl.h')
   endif
 endif
 
+if not has_bsd_sysctl
+  if compiler.has_member('struct sysinfo', 'totalram', prefix: '#include <sys/sysinfo.h>')
+    libgit_c_args += '-DHAVE_SYSINFO'
+  endif
+endif
+
 if not meson.is_cross_build() and compiler.run('''
   #include <stdio.h>
 
-- 
2.50.0


