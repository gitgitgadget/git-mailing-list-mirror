Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CE37FF63
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708540; cv=none; b=p8b/r1cHFY1bCXmIzb02+rybHc63bxvibZc46K/G/YAcpztKb3ee6QyPmg0MXpFncfAdaw90wohq3OxE6IW6XXzv4csOh+RWtiTmSZZIbSbyhFGLzI5uXbHdoEilI2ljF0NcyyOV/nnlYZSMWXqfvjQEUNyoLK1q9dY05EUXS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708540; c=relaxed/simple;
	bh=rH49nZteaqWDENZLQRaxoidmXajpp9YQiJbr/SXhGXM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BXuQYfTkuDvT4EZgYwr6w3eLOh+5Kx5oRoa01Jj17Otn/yU+xidui2RcFSbCDbGltOQJAQnVal48dDvPf/0MH0BvDK7D+qt0k32VggUmeFKBYCr7eAcU43hTH8L3AWQZvmJfSzYeoYg4LaqyYip/PFMDcBCm2ArCCAe6nIDlUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jljmKnbN; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jljmKnbN"
Received: from [10.0.2.15] ([195.99.11.174])
	by smtp with ESMTPA
	id iG1PwG91bkMb1iG1QwGpyP; Fri, 10 Jul 2026 19:32:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1783708346; bh=koT4wjMGlATgdPGvOzz9B+2q4mOEvZawc04SwxJrxT0=;
	h=Date:To:Cc:From:Subject;
	b=jljmKnbN074h3XpMeyWM2xLIwjWLOgoXD3r/3rAK9gp7zYZSOGVMxc1c+G57uTUDT
	 3FNATGKwsnGb1+lJlhm71xI1nX5X3AoIY5Zs7L7YaQpWQeSRlcd5MCVchcUphARYdb
	 bcQwdxiSum41m1RRk1u6vfd+cpwfyV5d8GL2YBFllKQXrqQagA30TQZRVhD/7kXVPy
	 3gMKndxyD0gXMkWcXoZjQEnF1GR9N1Ivjb5cUXjLNAGJYrVPXV4q5Rr08IqueavCsD
	 Q7pFJVNIAqioXK7kMbAB0KEJlkLDLlGBUpkUJRQ5jqmpgOWCpn0v9N87mGJLAyB+5r
	 voXWODpA4jFZg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AMGJABRe c=1 sm=1 tr=0 ts=6a513aba
 a=rWEfxJwGD0TuYe46u5FB7A==:117 a=rWEfxJwGD0TuYe46u5FB7A==:17
 a=IkcTkHD0fZMA:10 a=uSHI5plBiy8_ffmiS38A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <f65466c9-bede-472e-ad57-e72a5289be27@ramsayjones.plus.com>
Date: Fri, 10 Jul 2026 19:32:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Johannes Sixt <j6t@kdbg.org>, Adam Dinwoodie <git@dinwoodie.org>,
 =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: cygwin v2.55.0 test failures
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfI/RxqlFjHqSWHOCMAVMOaygCspo6tbyOMkY6WLpa1fYTPA4Qv7wbcP8eo4+uWd8lNlUe2fTUnddkL1kGbLwjYjxiuNn1Qa1qWcf6i4zv1wVnDuD3T5k
 aYVjfgZIrG1shXu0j/JnmzStLmz6nj/x3d1eE7kWFhoihvOQ0acVAezg2R0LZIxDDpIiRuatsIEF0Aaa6WbBNqS/vswkBfnvUO4=


Sorry for being a bit tardy, but I was somewhat unwell and, as a result,
AFK for some weeks during the last part of the v2.55.0 cycle. So, I'm
still catching up. As part of that, I found that the cygwin test-suite
fails for v2.55.0, like so:

  $ tail -13 test-out-2-55-rel
  Test Summary Report
  -------------------
  unit-tests/bin/unit-tests.exe                    (Wstat: 256 (exited 1) Tests: 249 Failed: 1)
    Failed test:  242
    Non-zero exit status: 1
  t9904-url-parse.sh                               (Wstat: 256 (exited 1) Tests: 53 Failed: 4)
    Failed tests:  39, 42-43, 47
    Non-zero exit status: 1
  Files=1047, Tests=32848, 4584 wallclock secs (29.05 usr 85.59 sys + 9679.08 cusr 14883.94 csys = 24677.67 CPU)
  Result: FAIL
  make[1]: *** [Makefile:78: prove] Error 1
  make[1]: Leaving directory '/home/ramsay/git/t'
  make: *** [Makefile:3381: test] Error 2
  $ 

Unsurprisingly, the -rc0, -rc1 and -rc2 builds show the same failures.

After a quick squint, the reason for the failure looked familiar ... ;)
Indeed, I have been aware of the reason for this failure since v2.23.1
at the end of 2019. For those who don't instantly recognize it, this was
one of a series of security releases, which mainly affected GfW. From
the release Notes:

  Git v2.23.1 Release Notes
  =========================
  
  This release merges up the fixes that appear in v2.14.6, v2.15.4,
  v2.17.3, v2.20.2 and in v2.21.1, addressing the security issues
  CVE-2019-1348, CVE-2019-1349, CVE-2019-1350, CVE-2019-1351,
  CVE-2019-1352, CVE-2019-1353, CVE-2019-1354, CVE-2019-1387, and
  CVE-2019-19604; see the release notes for those versions for details.

For example, the test-suite for v2.25.0-rc0 looks like:

  $ tail -17 test-out/test-out-2-25-rc0
  Test Summary Report
  -------------------
  t5500-fetch-pack.sh                              (Wstat: 256 Tests: 369 Failed: 12)
    Failed tests:  142, 145, 161-162, 239, 242, 258-259, 336
                  339, 355-356
    Non-zero exit status: 1
  t5580-clone-push-unc.sh                          (Wstat: 256 Tests: 6 Failed: 1)
    Failed test:  4
    Non-zero exit status: 1
  t5601-clone.sh                                   (Wstat: 256 Tests: 104 Failed: 4)
    Failed tests:  62-64, 66
    Non-zero exit status: 1
  Files=890, Tests=21098, 16304 wallclock secs ( 0.48 usr  0.73 sys + 2374.33 cusr 7438.69 csys = 9814.24 CPU)
  Result: FAIL
  make[1]: *** [Makefile:52: prove] Error 1
  make[1]: Leaving directory '/home/ramsay/git/t'
  make: *** [Makefile:2754: test] Error 2
  $ 

[t5580-clone-push-unc.sh was later renamed to t5580-unc-paths.sh]

From about that time, I had hacked up a 'fix' for cygwin, but hadn't decided
how to proceed with an actual patch. :)

So, I cherry-picked the 'fix' onto 'master' (then on v2.55.0 release). I was
a little surprised it went without problem, given how much 'git-compat-util.h'
has changed, but it just required a 'slide' from line 203 back to line 153.
This patch is equivalent to the 'git-compat-util.h' only part of the patch
given below.

This fixed up the current test failures (unit-tests and t9904-url-parse.sh).

Note that Patrick wanted to have a clean test-suite run on cygwin, so in
commit 5f8af25ff9 ("t5500, t5601: skip tests which exercise paths with '[::1]'
on Cygwin", 2024-10-16), he suppressed the test failures in t5500 and t5601.
(that was about the time of the v2.48.0 release).

The changes to tests t5500 and t5601, in the patch given below, essentially
reverts Patrick's commit 5f8af25ff9. This fixes all of the tests in t5601 and
ten of the twelve failures in t5500. (I don't recall what happened to t5580,
the single failure - the push test - was fixed somewhere between v2.43.0 and
v2.44.0-rc0).

As luck would have it, I left a note to myself about the remaining two
failure cases. This leads to the remaining hunk, to connect.c, in the patch
below; ie. the removal of a conditional (which should only fire for GfW and
cygwin). The '#ifdef DUMMY/#endif' should probably be replaced with an
'#ifdef GIT_WINDOWS_NATIVE/#endif' so that GfW is not affected. (Having said
that, I suspect that even GfW should drop it ['somebody was smoking something
exotic'], but I have no way to test it, so ...).

With this final hunk, this patch results in a clean test-suite run. :)

So, what does this mean? Well, I should probably not leave it another five
years, or thereabouts, before actually sending a real patch (series) to fix
this up properly! ;)

But what is properly? The 'fix' works, but the problem was principally caused
by cygwin being a bit schizophrenic about the 'pathname utilities' and its
support for POSIX only paths, WIN32 only paths or both.

For example, f82a97eb91 ("mingw: handle `subst`-ed "DOS drives"", 2019-09-06)
notes in the commit message:

    Note: `[::1]:repo` is a valid URL, but not a valid path on Windows.
    As `[` is now considered a valid drive letter, we need to be very
    careful to avoid misinterpreting such a string as valid local path in
    `url_is_local_not_ssh()`. To do that, we use the just-introduced
    function `is_valid_path()` (which will label the string as invalid file
    name because of the colon characters).
    
    This fixes CVE-2019-1351.

Note that part of the fix involves a cygwin specific 'is_valid_path()' which
would otherwise be defined, like Linux, as simply '1' in git-compat-util.h.
I was a bit surprised that an IPv6 address was not parsed at a higher level
and take priority over an (possible) '[' drive letter, rather than being a
side-effect of calling an 'is_valid_path()' helper function. ;)

The 'is_valid_path()' was also part of the security fixes to check for some
'illegal' win32 paths which included those ending in spaces or periods or
for names such as AUX, COM1, LPTn, NUL, PRN, CONIN$, etc,. I know that some
of these paths are valid in cygwin (eg. those ending in spaces or periods)
so the win32 version of that function cannot be used without change. (this
could lead to one part of git allowing you to use said paths and other
parts not)! Note that some of the CVEs may actually still apply to cygwin.
I didn't check.

Also, note that I replaced the win32 version of the 'offset_1st_component()'
function. I can't quite remember why I did that, but I think the fact that
the win32 version doesn't ensure that the 'path' consists of both the <server>
and <share> component before returning the offset. (ie make sure that the
'path' consists of "//<server>/<share>/" at the very least and return one,
for '/', otherwise).

Personally, I would be quite happy to rip out all win32 path handling and
only support POSIX paths (I have been using cygwin since about 1996 and
have only ever used win32 paths when testing git ... that is the whole
point of cygwin! :) ), but I already know that that is a no-go. (there is
always somebody that complains when you suggest it).

So, for now anyway, it seems that I need to tidy up the patch and move in
the opposite direction to e.g. commit 1cadad6f65 ("git clone <url> 
C:\cygwin\home\USER\repo' is working (again)", 2018-12-15).

Part of the reason for vacillating on the correct way forward with this
patch, was because I have often thought that I should use the cygwin API
to cater to both POSIX and win32 paths. For example, we could possibly use
the 'cygwin_conv_path()' function to do the path conversion (somewhat
similar to the macos pre-composed-utf8 stuff, minus the directory reading).
However, I think that would open a different can of worms, including some
potential memory leaks. So, not exactly a slam dunk.

[I also had a note-to-self about 'mixed / and \ urls' in the config file
which is exposed by these same tests. So, another patch may be needed?]

Anyway, something to think about. Hmm, I suspect it would be best to just
tidy up this patch first. ;)

Just FYI. Thanks!

ATB,
Ramsay Jones


----- >8 -----
Subject: [PATCH] cygwin: fix up IPv6 scp urls

---
 connect.c             |  2 ++
 git-compat-util.h     | 39 +++++++++++++++++++++++++++++++++++++++
 t/t5500-fetch-pack.sh | 14 ++++----------
 t/t5601-clone.sh      | 11 ++---------
 4 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/connect.c b/connect.c
index 47e39d2a73..6f5715e938 100644
--- a/connect.c
+++ b/connect.c
@@ -1088,10 +1088,12 @@ static enum url_scheme parse_connect_url(const char *url_orig, char **ret_host,
 
 	if (scheme == URL_SCHEME_LOCAL)
 		path = end;
+#ifdef DUMMY
 	else if (scheme == URL_SCHEME_FILE && *host != '/' &&
 		 !has_dos_drive_prefix(host) &&
 		 offset_1st_component(host - 2) > 1)
 		path = host - 2; /* include the leading "//" */
+#endif
 	else if (scheme == URL_SCHEME_FILE && has_dos_drive_prefix(end))
 		path = end; /* "file://$(pwd)" may be "file://C:/projects/repo" */
 	else
diff --git a/git-compat-util.h b/git-compat-util.h
index 8809776407..645ff96048 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -153,6 +153,45 @@ static inline int is_xplatform_dir_sep(int c)
 
 #if defined(__CYGWIN__)
 #include "compat/win32/path-utils.h"
+
+static inline int is_valid_cygwin_path(const char *path)
+{
+	if (path && strlen(path) > 2 &&
+	    path[0] == '[' && path[1] == ':' &&
+	    strchr(&path[2], ':'))
+		return 0;
+	return 1;
+}
+
+#define is_valid_path(path) is_valid_cygwin_path(path)
+
+static inline int cygwin_offset_1st_component(const char *path)
+{
+	int ret = 0;
+
+	/* C: prefix */
+	if ((ret = has_dos_drive_prefix(path)))
+		return ret;
+
+	/* //server/share/ prefix */
+	if (is_dir_sep(path[0]) && is_dir_sep(path[1])) {
+		char *pos = strpbrk(path + 2, "\\/");
+		if (pos && *(pos + 1) && !is_dir_sep(*(pos + 1))) {
+			pos = strpbrk(pos + 1, "\\/");
+			if (pos && *(pos + 1))
+				return pos + 1 - path;
+		}
+	}
+
+	/* / prefix */
+	if (is_dir_sep(path[0]))
+		return 1;
+
+	return 0;
+}
+
+#undef offset_1st_component
+#define offset_1st_component cygwin_offset_1st_component
 #endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 649a615ec9..2c6c0a04be 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -774,7 +774,7 @@ do
 	# file with scheme
 	for p in file
 	do
-		test_expect_success !WINDOWS "fetch-pack --diag-url $p://$h/$r" '
+		test_expect_success !MINGW "fetch-pack --diag-url $p://$h/$r" '
 			check_prot_path $p://$h/$r $p "/$r"
 		'
 		test_expect_success MINGW "fetch-pack --diag-url $p://$h/$r" '
@@ -784,7 +784,7 @@ do
 			check_prot_path $p:///$r $p "/$r"
 		'
 		# No "/~" -> "~" conversion for file
-		test_expect_success !WINDOWS "fetch-pack --diag-url $p://$h/~$r" '
+		test_expect_success !MINGW "fetch-pack --diag-url $p://$h/~$r" '
 			check_prot_path $p://$h/~$r $p "/~$r"
 		'
 		test_expect_success MINGW "fetch-pack --diag-url $p://$h/~$r" '
@@ -806,17 +806,11 @@ do
 	p=ssh
 	for h in host [::1]
 	do
-		expectation="success"
-		if test_have_prereq CYGWIN && test "$h" = "[::1]"
-		then
-			expectation="failure"
-		fi
-
-		test_expect_$expectation "fetch-pack --diag-url $h:$r" '
+		test_expect_success "fetch-pack --diag-url $h:$r" '
 			check_prot_host_port_path $h:$r $p "$h" NONE "$r"
 		'
 		# Do "/~" -> "~" conversion
-		test_expect_$expectation "fetch-pack --diag-url $h:/~$r" '
+		test_expect_success "fetch-pack --diag-url $h:/~$r" '
 			check_prot_host_port_path $h:/~$r $p "$h" NONE "~$r"
 		'
 	done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 3dd229c186..35e9f3eb0d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -530,17 +530,10 @@ do
 	'
 done
 
-# Parsing of paths that look like IPv6 addresses is broken on Cygwin.
-expectation_for_ipv6_tests=success
-if test_have_prereq CYGWIN
-then
-	expectation_for_ipv6_tests=failure
-fi
-
 #ipv6
 for repo in rep rep/home/project 123
 do
-	test_expect_$expectation_for_ipv6_tests "clone [::1]:$repo" '
+	test_expect_success "clone [::1]:$repo" '
 		test_clone_url [::1]:$repo ::1 "$repo"
 	'
 done
@@ -553,7 +546,7 @@ test_expect_success !SANITIZE_LEAK "clone host:/~repo" '
 	test_clone_url host:/~repo host "~repo"
 '
 
-test_expect_$expectation_for_ipv6_tests !SANITIZE_LEAK "clone [::1]:/~repo" '
+test_expect_success !SANITIZE_LEAK "clone [::1]:/~repo" '
 	test_clone_url [::1]:/~repo ::1 "~repo"
 '
 
-- 
2.55.0
