Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1213C67C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906357; cv=none; b=Vkeyk23TqkHCzMCiVALi/1DCzHaUiqotop4xvZFOixtyVToN0P+MFDNfRRN4qmHwjowcfW7WimfrzdIjpqU/gAuktmqCggtK6UbDqf6p+ij2sI3dT8pJ8cHLzJz8QuabFBE0mFxJDbLLr5tRPk/Dh11FbwY+GsaViTuSlbjKlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906357; c=relaxed/simple;
	bh=0tGFe2EOyXuWwetbDt2Lggii1UT+I/PSU9O4ROE2+oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua9F2ir+L308QWr8PVLbsAiVCFVv4hwLyolpZaZ+/N9lVvRYLvXpdACRcyGCM2hgrCXERDuFqKZo9mg+3Q5KDaiAvfjwNrm7nwKbuGUjrfoYVg2GB+QDeNdDd1kmOl3aGyUBFOtl53DjS+CpiUa0fJugzlh2tDEaBRKqICnuut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pvp+d1hN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ai4gKmWj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pvp+d1hN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ai4gKmWj"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE0C2114019E;
	Mon, 14 Oct 2024 07:45:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 14 Oct 2024 07:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728906353; x=1728992753; bh=sYFwcVmXS4
	5sG4BLvyrbbNXQqV8XE2f+Oc2IfUqe7gQ=; b=pvp+d1hNbX/BKCiBKYNpWkxFMc
	UI1aPmNra0LrQQ/AxlTdZcIXOv7jaoFRif0dNUm2DU5qFC1cNpB29ZTXYae1DQZ3
	UW5Y9p3nV/Fr6t2DoHJkR9m7S9npFqfQ62EKx1OCX5KgXb5Q5lbJyXcKNuLAE2bH
	hYkFUeySU+aI/TMIDmobblIRlhGwen/bLnI/ElLSTsdAt58NgvG12v1OnoUKg+Kx
	ll7X6Dpz5DJ87dt0C/4nN5w13b4WxjcfpuKxdkDxiKM9TpJ6x/814WBOV1py0bMJ
	OGFP0AcOBoJLZmZnOg9X0G0fqlaqYZ7b7vprBA+XWqeGHYLYNjnIskJuC2SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728906353; x=1728992753; bh=sYFwcVmXS45sG4BLvyrbbNXQqV8X
	E2f+Oc2IfUqe7gQ=; b=ai4gKmWjoEndBfsPvFvTQlSJponW1+6ovAq/qwFm5tGP
	KR8L2TqPjA35+xelsVvbVHY2HAgirMratxdt9s+BHvo/qQvwGLcnerjYLaU9pR+K
	0DB+KBTE3KjEfe/HTcdG0McA2fME+xAtly3xQAOtwp+pcjWwsF44fTIceJQpPMmg
	fbFUnd1ATyWfUfiID3PF7vLN3aYQocvGtppcfQE7RujClJv29hTFagpGPjUw4fDf
	GGokF26MEqggfNX5Zu7+IjwekXX8T1G6uNkJXGBkY+VAcoH+YOR5l2rtO2uFK18C
	RfuATk9UqVvfol4FIpGDNRu+m29QE5QTh4k4Bc+U0Q==
X-ME-Sender: <xms:cQQNZyKTilvEVL5unpypQaPw-fsQtGvFZnh475jFtYWFJFcG7kg5HA>
    <xme:cQQNZ6JNf-HX5z7P9gP4SDZnYRUwhZZZjXPS3dcrZyytVwrlFjpvXOKdBqMwSGvlE
    KE050mU6nX-TJT1AA>
X-ME-Received: <xmr:cQQNZyvyq2fLsJ0aTmvi4e57QmF2DXuceoUvBlteSeP84B2t2mcKwmT7QKZSK9bd3hzLAPipEwtGoKI69ZtDMTsQ6H6x7x37ubKYmGB_HMvXnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghsvgguvghnohesmhhithdrvgguuhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cQQNZ3YqUG51qdzU2nGMhDtlLb6lYoNw4nj-yfnUcduzZNddP4J10g>
    <xmx:cQQNZ5bcU7NszqIoQSJSyAGEzNNnchgO_hYyFmVPGfDxiySCOsyUKg>
    <xmx:cQQNZzBMEqJ4oZAzcb_gVogzNjjBXUn6WMoCyxyxjk8fy_bocmUEPA>
    <xmx:cQQNZ_YhG8HKCBXxXkmtPhefXQPZQ3h7aTRxlLsPFBf39Y8aqxW4Lw>
    <xmx:cQQNZ4mmSfyX5vk6YNPsFtWmvMvXW1Jwu2hsBDFrkNfbfY-_mNaIkEy->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 07:45:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d46844f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 11:44:37 +0000 (UTC)
Date: Mon, 14 Oct 2024 13:45:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH 1/2] t/unit-tests: update clar to 0810a36
Message-ID: <a96fbdbb5f9d547fba52ce5f9e8e58656253fc78.1728903464.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1728903464.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728903464.git.ps@pks.im>

Update clar from:

    - 1516124 (Merge pull request #97 from pks-t/pks-whitespace-fixes, 2024-08-15).

To:

    - 0810a36 (Merge pull request #107 from pks-t/pks-sunos-compatibility, 2024-10-14)

This update includes a bunch of fixes and improvements that we have
discussed in Git when initial support for clar was merged:

  - There is a ".editorconfig" file now.

  - Compatibility with Windows has been improved so that the clar
    compiles on this platform without an issue. This has been tested
    with Cygwin, MinGW and Microsoft Visual Studio.

  - clar now uses CMake. This does not impact us at all as we wire up
    the clar into our own build infrastructure anyway. This conversion
    was done such that we can easily run CI jobs against Windows.

  - Allocation failures are now checked for consistently.

  - We now define feature test macros in "clar.c", which fixes
    compilation on some platforms that didn't previously pull in
    non-standard functions like lstat(3p) or strdup(3p). This was
    reported by a user of OpenSUSE Leap.

  - We stop using `struct timezone`, which is undefined behaviour
    nowadays and results in a compilation error on some platforms.

  - We now use the combination of mktemp(3) and mkdir(3) on SunOS, same
    as we do on NonStop.

The most important bits here are the improved platform compatibility
with Windows, OpenSUSE and SunOS.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/.editorconfig            |  13 +++
 t/unit-tests/clar/.github/workflows/ci.yml |  20 +++-
 t/unit-tests/clar/.gitignore               |   1 +
 t/unit-tests/clar/CMakeLists.txt           |  28 +++++
 t/unit-tests/clar/clar.c                   | 115 +++++++++++----------
 t/unit-tests/clar/clar/print.h             |  11 +-
 t/unit-tests/clar/clar/sandbox.h           |  17 ++-
 t/unit-tests/clar/clar/summary.h           |  14 +--
 t/unit-tests/clar/test/.gitignore          |   4 -
 t/unit-tests/clar/test/CMakeLists.txt      |  39 +++++++
 t/unit-tests/clar/test/Makefile            |  39 -------
 11 files changed, 177 insertions(+), 124 deletions(-)
 create mode 100644 t/unit-tests/clar/.editorconfig
 create mode 100644 t/unit-tests/clar/.gitignore
 create mode 100644 t/unit-tests/clar/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/.gitignore
 create mode 100644 t/unit-tests/clar/test/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/Makefile

diff --git a/t/unit-tests/clar/.editorconfig b/t/unit-tests/clar/.editorconfig
new file mode 100644
index 00000000000..aa343a42885
--- /dev/null
+++ b/t/unit-tests/clar/.editorconfig
@@ -0,0 +1,13 @@
+root = true
+
+[*]
+charset = utf-8
+insert_final_newline = true
+
+[*.{c,h}]
+indent_style = tab
+tab_width = 8
+
+[CMakeLists.txt]
+indent_style = tab
+tab_width = 8
diff --git a/t/unit-tests/clar/.github/workflows/ci.yml b/t/unit-tests/clar/.github/workflows/ci.yml
index b1ac2de460a..0065843d17a 100644
--- a/t/unit-tests/clar/.github/workflows/ci.yml
+++ b/t/unit-tests/clar/.github/workflows/ci.yml
@@ -10,14 +10,26 @@ jobs:
   build:
     strategy:
       matrix:
-        os: [ ubuntu-latest, macos-latest ]
+        platform:
+          - os: ubuntu-latest
+            generator: Unix Makefiles
+          - os: macos-latest
+            generator: Unix Makefiles
+          - os: windows-latest
+            generator: Visual Studio 17 2022
+          - os: windows-latest
+            generator: MSYS Makefiles
+          - os: windows-latest
+            generator: MinGW Makefiles
 
-    runs-on: ${{ matrix.os }}
+    runs-on: ${{ matrix.platform.os }}
 
     steps:
     - name: Check out
       uses: actions/checkout@v2
     - name: Build
       run: |
-        cd test
-        make
+        mkdir build
+        cd build
+        cmake .. -G "${{matrix.platform.generator}}"
+        cmake --build .
diff --git a/t/unit-tests/clar/.gitignore b/t/unit-tests/clar/.gitignore
new file mode 100644
index 00000000000..84c048a73cc
--- /dev/null
+++ b/t/unit-tests/clar/.gitignore
@@ -0,0 +1 @@
+/build/
diff --git a/t/unit-tests/clar/CMakeLists.txt b/t/unit-tests/clar/CMakeLists.txt
new file mode 100644
index 00000000000..12d4af114fe
--- /dev/null
+++ b/t/unit-tests/clar/CMakeLists.txt
@@ -0,0 +1,28 @@
+cmake_minimum_required(VERSION 3.16..3.29)
+
+project(clar LANGUAGES C)
+
+option(BUILD_TESTS "Build test executable" ON)
+
+add_library(clar INTERFACE)
+target_sources(clar INTERFACE
+	clar.c
+	clar.h
+	clar/fixtures.h
+	clar/fs.h
+	clar/print.h
+	clar/sandbox.h
+	clar/summary.h
+)
+set_target_properties(clar PROPERTIES
+	C_STANDARD 90
+	C_STANDARD_REQUIRED ON
+	C_EXTENSIONS OFF
+)
+
+if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
+	include(CTest)
+	if(BUILD_TESTING)
+		add_subdirectory(test)
+	endif()
+endif()
diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index cef0f023c24..64879cf2bd5 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -4,7 +4,12 @@
  * This file is part of clar, distributed under the ISC license.
  * For full terms see the included COPYING file.
  */
-#include <assert.h>
+
+#define _BSD_SOURCE
+#define _DARWIN_C_SOURCE
+#define _DEFAULT_SOURCE
+
+#include <errno.h>
 #include <setjmp.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -13,6 +18,7 @@
 #include <stdarg.h>
 #include <wchar.h>
 #include <time.h>
+#include <inttypes.h>
 
 /* required for sandboxing */
 #include <sys/types.h>
@@ -28,6 +34,9 @@
 
 #	ifndef stat
 #		define stat(path, st) _stat(path, st)
+		typedef struct _stat STAT_T;
+#	else
+		typedef struct stat STAT_T;
 #	endif
 #	ifndef mkdir
 #		define mkdir(path, mode) _mkdir(path)
@@ -60,30 +69,11 @@
 #	else
 #		define p_snprintf snprintf
 #	endif
-
-#	ifndef PRIuZ
-#		define PRIuZ "Iu"
-#	endif
-#	ifndef PRIxZ
-#		define PRIxZ "Ix"
-#	endif
-
-#	if defined(_MSC_VER) || (defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR))
-	typedef struct stat STAT_T;
-#	else
-	typedef struct _stat STAT_T;
-#	endif
 #else
 #	include <sys/wait.h> /* waitpid(2) */
 #	include <unistd.h>
 #	define _MAIN_CC
 #	define p_snprintf snprintf
-#	ifndef PRIuZ
-#		define PRIuZ "zu"
-#	endif
-#	ifndef PRIxZ
-#		define PRIxZ "zx"
-#	endif
 	typedef struct stat STAT_T;
 #endif
 
@@ -102,7 +92,7 @@ fixture_path(const char *base, const char *fixture_name);
 struct clar_error {
 	const char *file;
 	const char *function;
-	size_t line_number;
+	uintmax_t line_number;
 	const char *error_msg;
 	char *description;
 
@@ -195,11 +185,12 @@ static void clar_print_shutdown(int test_count, int suite_count, int error_count
 static void clar_print_error(int num, const struct clar_report *report, const struct clar_error *error);
 static void clar_print_ontest(const char *suite_name, const char *test_name, int test_number, enum cl_test_status failed);
 static void clar_print_onsuite(const char *suite_name, int suite_index);
+static void clar_print_onabortv(const char *msg, va_list argp);
 static void clar_print_onabort(const char *msg, ...);
 
 /* From clar_sandbox.c */
 static void clar_unsandbox(void);
-static int clar_sandbox(void);
+static void clar_sandbox(void);
 
 /* From summary.h */
 static struct clar_summary *clar_summary_init(const char *filename);
@@ -218,6 +209,15 @@ static int clar_summary_shutdown(struct clar_summary *fp);
 							   _clar.trace_payload);					\
 	} while (0)
 
+static void clar_abort(const char *msg, ...)
+{
+	va_list argp;
+	va_start(argp, msg);
+	clar_print_onabortv(msg, argp);
+	va_end(argp);
+	exit(-1);
+}
+
 void cl_trace_register(cl_trace_cb *cb, void *payload)
 {
 	_clar.pfn_trace_cb = cb;
@@ -271,9 +271,7 @@ static double clar_time_diff(clar_time *start, clar_time *end)
 
 static void clar_time_now(clar_time *out)
 {
-	struct timezone tz;
-
-	gettimeofday(out, &tz);
+	gettimeofday(out, NULL);
 }
 
 static double clar_time_diff(clar_time *start, clar_time *end)
@@ -386,7 +384,8 @@ clar_run_suite(const struct clar_suite *suite, const char *filter)
 
 		_clar.active_test = test[i].name;
 
-		report = calloc(1, sizeof(struct clar_report));
+		if ((report = calloc(1, sizeof(*report))) == NULL)
+			clar_abort("Failed to allocate report.\n");
 		report->suite = _clar.active_suite;
 		report->test = _clar.active_test;
 		report->test_number = _clar.tests_ran;
@@ -479,9 +478,10 @@ clar_parse_args(int argc, char **argv)
 
 					switch (action) {
 					case 's': {
-						struct clar_explicit *explicit =
-							calloc(1, sizeof(struct clar_explicit));
-						assert(explicit);
+						struct clar_explicit *explicit;
+
+						if ((explicit = calloc(1, sizeof(*explicit))) == NULL)
+							clar_abort("Failed to allocate explicit test.\n");
 
 						explicit->suite_idx = j;
 						explicit->filter = argument;
@@ -505,10 +505,8 @@ clar_parse_args(int argc, char **argv)
 				}
 			}
 
-			if (!found) {
-				clar_print_onabort("No suite matching '%s' found.\n", argument);
-				exit(-1);
-			}
+			if (!found)
+				clar_abort("No suite matching '%s' found.\n", argument);
 			break;
 		}
 
@@ -540,11 +538,17 @@ clar_parse_args(int argc, char **argv)
 		case 'r':
 			_clar.write_summary = 1;
 			free(_clar.summary_filename);
-			_clar.summary_filename = *(argument + 2) ? strdup(argument + 2) : NULL;
+			if (*(argument + 2)) {
+				if ((_clar.summary_filename = strdup(argument + 2)) == NULL)
+					clar_abort("Failed to allocate summary filename.\n");
+			} else {
+				_clar.summary_filename = NULL;
+			}
 			break;
 
 		default:
-			assert(!"Unexpected commandline argument!");
+			clar_abort("Unexpected commandline argument '%s'.\n",
+				   argument[1]);
 		}
 	}
 }
@@ -566,22 +570,18 @@ clar_test_init(int argc, char **argv)
 	if (!_clar.summary_filename &&
 	    (summary_env = getenv("CLAR_SUMMARY")) != NULL) {
 		_clar.write_summary = 1;
-		_clar.summary_filename = strdup(summary_env);
+		if ((_clar.summary_filename = strdup(summary_env)) == NULL)
+			clar_abort("Failed to allocate summary filename.\n");
 	}
 
 	if (_clar.write_summary && !_clar.summary_filename)
-		_clar.summary_filename = strdup("summary.xml");
+		if ((_clar.summary_filename = strdup("summary.xml")) == NULL)
+			clar_abort("Failed to allocate summary filename.\n");
 
-	if (_clar.write_summary &&
-	    !(_clar.summary = clar_summary_init(_clar.summary_filename))) {
-		clar_print_onabort("Failed to open the summary file\n");
-		exit(-1);
-	}
+	if (_clar.write_summary)
+	    _clar.summary = clar_summary_init(_clar.summary_filename);
 
-	if (clar_sandbox() < 0) {
-		clar_print_onabort("Failed to sandbox the test runner.\n");
-		exit(-1);
-	}
+	clar_sandbox();
 }
 
 int
@@ -615,10 +615,9 @@ clar_test_shutdown(void)
 
 	clar_unsandbox();
 
-	if (_clar.write_summary && clar_summary_shutdown(_clar.summary) < 0) {
-		clar_print_onabort("Failed to write the summary file\n");
-		exit(-1);
-	}
+	if (_clar.write_summary && clar_summary_shutdown(_clar.summary) < 0)
+		clar_abort("Failed to write the summary file '%s: %s.\n",
+			   _clar.summary_filename, strerror(errno));
 
 	for (explicit = _clar.explicit; explicit; explicit = explicit_next) {
 		explicit_next = explicit->next;
@@ -649,7 +648,7 @@ static void abort_test(void)
 {
 	if (!_clar.trampoline_enabled) {
 		clar_print_onabort(
-				"Fatal error: a cleanup method raised an exception.");
+				"Fatal error: a cleanup method raised an exception.\n");
 		clar_report_errors(_clar.last_report);
 		exit(-1);
 	}
@@ -673,7 +672,10 @@ void clar__fail(
 	const char *description,
 	int should_abort)
 {
-	struct clar_error *error = calloc(1, sizeof(struct clar_error));
+	struct clar_error *error;
+
+	if ((error = calloc(1, sizeof(*error))) == NULL)
+		clar_abort("Failed to allocate error.\n");
 
 	if (_clar.last_report->errors == NULL)
 		_clar.last_report->errors = error;
@@ -688,8 +690,9 @@ void clar__fail(
 	error->line_number = line;
 	error->error_msg = error_msg;
 
-	if (description != NULL)
-		error->description = strdup(description);
+	if (description != NULL &&
+	    (error->description = strdup(description)) == NULL)
+		clar_abort("Failed to allocate description.\n");
 
 	_clar.total_errors++;
 	_clar.last_report->status = CL_TEST_FAILURE;
@@ -798,8 +801,8 @@ void clar__assert_equal(
 			}
 		}
 	}
-	else if (!strcmp("%"PRIuZ, fmt) || !strcmp("%"PRIxZ, fmt)) {
-		size_t sz1 = va_arg(args, size_t), sz2 = va_arg(args, size_t);
+	else if (!strcmp("%"PRIuMAX, fmt) || !strcmp("%"PRIxMAX, fmt)) {
+		uintmax_t sz1 = va_arg(args, uintmax_t), sz2 = va_arg(args, uintmax_t);
 		is_equal = (sz1 == sz2);
 		if (!is_equal) {
 			int offset = p_snprintf(buf, sizeof(buf), fmt, sz1);
diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
index c17e2f693bd..69d0ee967e7 100644
--- a/t/unit-tests/clar/clar/print.h
+++ b/t/unit-tests/clar/clar/print.h
@@ -21,7 +21,7 @@ static void clar_print_clap_error(int num, const struct clar_report *report, con
 {
 	printf("  %d) Failure:\n", num);
 
-	printf("%s::%s [%s:%"PRIuZ"]\n",
+	printf("%s::%s [%s:%"PRIuMAX"]\n",
 		report->suite,
 		report->test,
 		error->file,
@@ -136,7 +136,7 @@ static void clar_print_tap_ontest(const char *suite_name, const char *test_name,
 
 		printf("    at:\n");
 		printf("      file: '"); print_escaped(error->file); printf("'\n");
-		printf("      line: %" PRIuZ "\n", error->line_number);
+		printf("      line: %" PRIuMAX "\n", error->line_number);
 		printf("      function: '%s'\n", error->function);
 		printf("    ---\n");
 
@@ -202,10 +202,15 @@ static void clar_print_onsuite(const char *suite_name, int suite_index)
 	PRINT(onsuite, suite_name, suite_index);
 }
 
+static void clar_print_onabortv(const char *msg, va_list argp)
+{
+	PRINT(onabort, msg, argp);
+}
+
 static void clar_print_onabort(const char *msg, ...)
 {
 	va_list argp;
 	va_start(argp, msg);
-	PRINT(onabort, msg, argp);
+	clar_print_onabortv(msg, argp);
 	va_end(argp);
 }
diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index e25057b7c49..bc960f50e0f 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -122,14 +122,14 @@ static int build_sandbox_path(void)
 
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
-#elif defined(__TANDEM)
-	if (mktemp(_clar_path) == NULL)
+#elif defined(_WIN32)
+	if (_mktemp_s(_clar_path, sizeof(_clar_path)) != 0)
 		return -1;
 
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
-#elif defined(_WIN32)
-	if (_mktemp_s(_clar_path, sizeof(_clar_path)) != 0)
+#elif defined(__sun) || defined(__TANDEM)
+	if (mktemp(_clar_path) == NULL)
 		return -1;
 
 	if (mkdir(_clar_path, 0700) != 0)
@@ -142,15 +142,14 @@ static int build_sandbox_path(void)
 	return 0;
 }
 
-static int clar_sandbox(void)
+static void clar_sandbox(void)
 {
 	if (_clar_path[0] == '\0' && build_sandbox_path() < 0)
-		return -1;
+		clar_abort("Failed to build sandbox path.\n");
 
 	if (chdir(_clar_path) != 0)
-		return -1;
-
-	return 0;
+		clar_abort("Failed to change into sandbox directory '%s': %s.\n",
+			   _clar_path, strerror(errno));
 }
 
 const char *clar_sandbox_path(void)
diff --git a/t/unit-tests/clar/clar/summary.h b/t/unit-tests/clar/clar/summary.h
index 4dd352e28b8..0d0b646fe75 100644
--- a/t/unit-tests/clar/clar/summary.h
+++ b/t/unit-tests/clar/clar/summary.h
@@ -66,16 +66,12 @@ struct clar_summary *clar_summary_init(const char *filename)
 	struct clar_summary *summary;
 	FILE *fp;
 
-	if ((fp = fopen(filename, "w")) == NULL) {
-		perror("fopen");
-		return NULL;
-	}
+	if ((fp = fopen(filename, "w")) == NULL)
+		clar_abort("Failed to open the summary file '%s': %s.\n",
+			   filename, strerror(errno));
 
-	if ((summary = malloc(sizeof(struct clar_summary))) == NULL) {
-		perror("malloc");
-		fclose(fp);
-		return NULL;
-	}
+	if ((summary = malloc(sizeof(struct clar_summary))) == NULL)
+		clar_abort("Failed to allocate summary.\n");
 
 	summary->filename = filename;
 	summary->fp = fp;
diff --git a/t/unit-tests/clar/test/.gitignore b/t/unit-tests/clar/test/.gitignore
deleted file mode 100644
index a477d0c40ca..00000000000
--- a/t/unit-tests/clar/test/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-clar.suite
-.clarcache
-clar_test
-*.o
diff --git a/t/unit-tests/clar/test/CMakeLists.txt b/t/unit-tests/clar/test/CMakeLists.txt
new file mode 100644
index 00000000000..7f2c1dc17a9
--- /dev/null
+++ b/t/unit-tests/clar/test/CMakeLists.txt
@@ -0,0 +1,39 @@
+find_package(Python COMPONENTS Interpreter REQUIRED)
+
+add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
+	COMMAND "${Python_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/generate.py" --output "${CMAKE_CURRENT_BINARY_DIR}"
+	DEPENDS main.c sample.c clar_test.h
+	WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
+)
+
+add_executable(clar_test)
+set_target_properties(clar_test PROPERTIES
+	C_STANDARD 90
+	C_STANDARD_REQUIRED ON
+	C_EXTENSIONS OFF
+)
+
+# MSVC generates all kinds of warnings. We may want to fix these in the future
+# and then unconditionally treat warnings as errors.
+if(NOT MSVC)
+	set_target_properties(clar_test PROPERTIES
+		COMPILE_WARNING_AS_ERROR ON
+	)
+endif()
+
+target_sources(clar_test PRIVATE
+	main.c
+	sample.c
+	"${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
+)
+target_compile_definitions(clar_test PRIVATE
+	CLAR_FIXTURE_PATH="${CMAKE_CURRENT_SOURCE_DIR}/resources/"
+)
+target_compile_options(clar_test PRIVATE
+	$<IF:$<CXX_COMPILER_ID:MSVC>,/W4,-Wall>
+)
+target_include_directories(clar_test PRIVATE
+	"${CMAKE_SOURCE_DIR}"
+	"${CMAKE_CURRENT_BINARY_DIR}"
+)
+target_link_libraries(clar_test clar)
diff --git a/t/unit-tests/clar/test/Makefile b/t/unit-tests/clar/test/Makefile
deleted file mode 100644
index 93c6b2ad32c..00000000000
--- a/t/unit-tests/clar/test/Makefile
+++ /dev/null
@@ -1,39 +0,0 @@
-#
-# Copyright (c) Vicent Marti. All rights reserved.
-#
-# This file is part of clar, distributed under the ISC license.
-# For full terms see the included COPYING file.
-#
-
-#
-# Set up the path to the clar sources and to the fixtures directory
-#
-# The fixture path needs to be an absolute path so it can be used
-# even after we have chdir'ed into the test directory while testing.
-#
-CURRENT_MAKEFILE  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
-TEST_DIRECTORY    := $(abspath $(dir $(CURRENT_MAKEFILE)))
-CLAR_PATH         := $(dir $(TEST_DIRECTORY))
-CLAR_FIXTURE_PATH := $(TEST_DIRECTORY)/resources/
-
-CFLAGS=-g -I.. -I. -Wall -DCLAR_FIXTURE_PATH=\"$(CLAR_FIXTURE_PATH)\"
-
-.PHONY: clean
-
-# list the objects that go into our test
-objects = main.o sample.o
-
-# build the test executable itself
-clar_test: $(objects) clar_test.h clar.suite $(CLAR_PATH)clar.c
-	$(CC) $(CFLAGS) -o $@ "$(CLAR_PATH)clar.c" $(objects)
-
-# test object files depend on clar macros
-$(objects) : $(CLAR_PATH)clar.h
-
-# build the clar.suite file of test metadata
-clar.suite:
-	python "$(CLAR_PATH)generate.py" .
-
-# remove all generated files
-clean:
-	$(RM) -rf *.o clar.suite .clarcache clar_test clar_test.dSYM
-- 
2.47.0.dirty

