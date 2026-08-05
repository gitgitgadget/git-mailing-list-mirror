Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FAE384245
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940030; cv=none; b=X3QYClayuRMW4bTs8jjuflBeE7FO/81FmUQCAQ9Lpk8MgVDQA7+vmXkJudZiFWpGKb4u1Sfo/5bC1Q38M+46jIqcxaXtv3k6P0PY3+PHTcmiF4JnEOLu5TBSVkZl9u4BE2XzYdgQLIESq1dyhTix2zfJki1u4SGoPWlzJywnYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940030; c=relaxed/simple;
	bh=4D93c+i8GrZ65qDbbiP1zVJSpIHHXC7pfyrGvYTmbuU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E1IrnaDUoWOfevN+TpDFvZwb5Ac0hePAqLeSba9diQBXS5ZQACRe7Tb+WD6nBmBBQiNQahuJs9F/irLr0AOckEHWV1+/ar+whiVYgMCgpn253DYLVD7VhYMJEP3Xch+0niuXnALJX8Bi66Qm5A5T/skSY9bzYApqIhHCBJ2tRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiR5F6l4; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiR5F6l4"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-667971437d6so1411332d50.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940022; x=1786544822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uY48a8xaF97yhij51gXwuoquzB2HYn2xO4yq/aDj1zs=;
        b=iiR5F6l4OiJ96RynAm55E30e9Yr/wMwoKZ63wM2DJiZ5HkPL+uRcpcLSHPnoBUyMr3
         cvAqgzh2W74+3vyUh5nPQj298PXAQlYuqDoOeBOZauzrbi+dQffVdTdvUDYACY+eZy2S
         +mV3rtodBU2kNXt5p0Gf8EVW97ueU5DpkwUsManYsetMsTxZg9805hbGZ+ZeanhWbf+q
         MxVBV0EJuStrxH2IZyB9eNm8hnUzqZFpdHLfZC4pvoiB1uIP0CrayMiTBG/IUHsabJ2i
         5v5iL4Z4FQ1LfIeOdPlbcJjoByTbWlCCNWUxarmERK/GGzIPJPmy3w7SWk8G/FPKKMIX
         +dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940022; x=1786544822;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uY48a8xaF97yhij51gXwuoquzB2HYn2xO4yq/aDj1zs=;
        b=iWEWxPY5GeP7WUl+SgBMeye33TrZ/qm/CVlN7hTxGdvzv5RN+O9avzowZPIq5fCOeP
         eqQtzyM2rv5ebM68RpkQoaxR4u1Q79In6LnoSINNsBEvfXS+kkbaL2fupSt3IlNi8tBo
         JsIBFtKJciQGWR3984BVbw+kewSVXB5fZh33FqdIhWO/6mchm1vni3pQWHyTbNdvAJNS
         rpPI6R2TV9JwudZKzMKtdyO20T+wpf1C7Tp94dmZgk8H58+o/svwByaRd8GpJdSzIEs9
         684QevTaaqzawLk1fNSmPRUraWJFvmmmiWSbq84ABiLGOmTGlyukg/eBZyix76M85DT0
         NU3g==
X-Gm-Message-State: AOJu0Yx8JLqifnReEc+018VeiPpgiEMQG116dDItZ1qXCLKPCMERd5/3
	0GvF8avtEjNSPOWoRqtZ+C3IKago32/XrbImJ0N6L2MQfyd7GyBO4w8Ek1j2Xw==
X-Gm-Gg: AR+sD10uuJIccYaqMPKO0jBcX+EEbn2mCbrrQ+uusBEQbX4ox8KyU615FBUmLGU5Gjs
	HXdChSr5JJdUyRnTgCemNlnnobioKZxLVR4W74GjxNvDbde9xiq3v4gKT2EYk2BVzloeLcAfPv6
	MNQNpaTRED8ZZqcvVYKo9ofAZToXtOijsYisqDE2oZf0wLyV5WSkwXJuANIhjrYTBUM4tV+icC9
	LbpmJVGQWpBxWo7SxUPm2cozePH6IKdA9HV8tWWR7n+im8hwDzXP2j00h2wfSG3o3PNzK1QW5gV
	4jga3e8w5ZYrjcwsqBnKwbK4O1DVDwoYWXTkg0ABsZTXyMahfQC+CbbBUsm1+Juc2D5GG74tKgR
	5gCSIhjzLMsa8TgVjTY3UotVvM850bgHreA5BZJbQ7a/cxVyhXzfU4p/OEkvL2R0rcMH8ofeDP2
	rnuCZxwS67pq0gsx7miMoHk1KQ8Nr7Gxur+6R5hVvXUtQraITbRW/Bc1g6Kju+1+L7fmRi7/n+w
	g==
X-Received: by 2002:a05:690e:d43:b0:667:cf87:5838 with SMTP id 956f58d0204a3-6699aa3563emr3477541d50.25.1785940020548;
        Wed, 05 Aug 2026 07:27:00 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669915f2307sm3290803d50.13.2026.08.05.07.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:59 -0700 (PDT)
Message-Id: <f822133191c9cca40477fb1bdd5d1416c9fe66c1.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:38 +0000
Subject: [PATCH 12/12] mingw: allow `git.exe` to be used instead of the "Git
 wrapper"
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows wants to add `git.exe` to the users' `PATH`, without
cluttering the latter with unnecessary executables such as `wish.exe`.
To that end, it invented the concept of its "Git wrapper", i.e. a tiny
executable located in `C:\Program Files\Git\cmd\git.exe` (originally a
CMD script) whose sole purpose is to set up a couple of environment
variables and then spawn the _actual_ `git.exe` (which nowadays lives in
`C:\Program Files\Git\mingw64\bin\git.exe` for 64-bit, and the obvious
equivalent for 32-bit installations).

Currently, the following environment variables are set unless already
initialized:

- `MSYSTEM`, to make sure that the MSYS2 Bash and the MSYS2 Perl
  interpreter behave as expected, and

- `PLINK_PROTOCOL`, to force PuTTY's `plink.exe` to use the SSH
  protocol instead of Telnet,

- `PATH`, to make sure that the `bin` folder in the user's home
  directory, as well as the `/mingw64/bin` and the `/usr/bin`
  directories are included. The trick here is that the `/mingw64/bin/`
  and `/usr/bin/` directories are relative to the top-level installation
  directory of Git for Windows (which the included Bash interprets as
  `/`, i.e. as the MSYS pseudo root directory).

Using the absence of `MSYSTEM` as a tell-tale, we can detect in
`git.exe` whether these environment variables have been initialized
properly. Therefore we can call `C:\Program Files\Git\mingw64\bin\git`
in-place after this change, without having to call Git through the Git
wrapper.

Obviously, above-mentioned directories must be _prepended_ to the `PATH`
variable, otherwise we risk picking up executables from unrelated Git
installations. We do that by constructing the new `PATH` value from
scratch, appending `$HOME/bin` (if `HOME` is set), then the MSYS2 system
directories, and then appending the original `PATH`.

Side note: this modification of the `PATH` variable is independent of
the modification necessary to reach the executables and scripts in
`/mingw64/libexec/git-core/`, i.e. the `GIT_EXEC_PATH`. That
modification is still performed by Git, elsewhere, long after making the
changes described above.

While we _still_ cannot simply hard-link `mingw64\bin\git.exe` to `cmd`
(because the former depends on a couple of `.dll` files that are only in
`mingw64\bin`, i.e. calling `...\cmd\git.exe` would fail to load due to
missing dependencies), at least we can now avoid that extra process of
running the Git wrapper (which then has to wait for the spawned
`git.exe` to finish) by calling `...\mingw64\bin\git.exe` directly, via
its absolute path.

Testing this is in Git's test suite tricky: we set up a "new" MSYS
pseudo-root and copy the `git.exe` file into the appropriate location,
then verify that `MSYSTEM` is set properly, and also that the `PATH` is
modified so that scripts can be found in `$HOME/bin`, `/mingw64/bin/`
and `/usr/bin/`.

This addresses https://github.com/git-for-windows/git/issues/2283

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c        | 65 +++++++++++++++++++++++++++++++++++++++++++
 config.mak.uname      |  8 ++++--
 t/t0060-path-utils.sh | 33 +++++++++++++++++++++-
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index afdc1ef2db..563e6299bc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3134,6 +3134,45 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
 	return -1;
 }
 
+#ifdef ENSURE_MSYSTEM_IS_SET
+#if !defined(RUNTIME_PREFIX) || !defined(HAVE_WPGMPTR) || !defined(MINGW_PREFIX)
+static size_t append_system_bin_dirs(char *path UNUSED, size_t size UNUSED)
+{
+	return 0;
+}
+#else
+static size_t append_system_bin_dirs(char *path, size_t size)
+{
+	char prefix[32768];
+	const char *slash;
+	size_t len = xwcstoutf(prefix, _wpgmptr, sizeof(prefix)), off = 0;
+
+	if (len == 0 || len >= sizeof(prefix) ||
+	    !(slash = find_last_dir_sep(prefix)))
+		return 0;
+	/* strip trailing `git.exe` */
+	len = slash - prefix;
+
+	/* strip trailing `cmd` or `<mingw-prefix>\bin` or `bin` or `libexec\git-core` */
+	if (strip_suffix_mem(prefix, &len, "\\" MINGW_PREFIX "\\libexec\\git-core") ||
+	    strip_suffix_mem(prefix, &len, "\\" MINGW_PREFIX "\\bin"))
+		off += xsnprintf(path + off, size - off,
+				 "%.*s\\" MINGW_PREFIX "\\bin;", (int)len, prefix);
+	else if (strip_suffix_mem(prefix, &len, "\\cmd") ||
+		 strip_suffix_mem(prefix, &len, "\\bin") ||
+		 strip_suffix_mem(prefix, &len, "\\libexec\\git-core"))
+		off += xsnprintf(path + off, size - off,
+				 "%.*s\\" MINGW_PREFIX "\\bin;", (int)len, prefix);
+	else
+		return 0;
+
+	off += xsnprintf(path + off, size - off,
+			 "%.*s\\usr\\bin;", (int)len, prefix);
+	return off;
+}
+#endif
+#endif
+
 static void setup_windows_environment(void)
 {
 	char *tmp = getenv("TMPDIR");
@@ -3186,6 +3225,32 @@ static void setup_windows_environment(void)
 			setenv("HOME", tmp, 1);
 	}
 
+	if (!getenv("PLINK_PROTOCOL"))
+		setenv("PLINK_PROTOCOL", "ssh", 0);
+
+#ifdef ENSURE_MSYSTEM_IS_SET
+	if (!(tmp = getenv("MSYSTEM")) || !tmp[0]) {
+		const char *home = getenv("HOME"), *path = getenv("PATH");
+		char buf[32768];
+		size_t off = 0;
+
+		setenv("MSYSTEM", ENSURE_MSYSTEM_IS_SET, 1);
+
+		if (home)
+			off += xsnprintf(buf + off, sizeof(buf) - off,
+					 "%s\\bin;", home);
+		off += append_system_bin_dirs(buf + off, sizeof(buf) - off);
+		if (path)
+			off += xsnprintf(buf + off, sizeof(buf) - off,
+					 "%s", path);
+		else if (off > 0)
+			buf[off - 1] = '\0';
+		else
+			buf[0] = '\0';
+		setenv("PATH", buf, 1);
+	}
+#endif
+
 	if (!getenv("LC_ALL") && !getenv("LC_CTYPE") && !getenv("LANG"))
 		setenv("LC_CTYPE", "C.UTF-8", 1);
 }
diff --git a/config.mak.uname b/config.mak.uname
index 2f7d445eb3..0b63be10b7 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -535,7 +535,9 @@ endif
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY \
+		-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" -DMINGW_PREFIX="\"$(patsubst /%,%,$(MINGW_PREFIX))\"" \
+		-DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -ENTRY:wmainCRTStartup -SUBSYSTEM:CONSOLE
 	# invalidcontinue.obj allows Git's source code to close the same file
 	# handle twice, or to access the osfhandle of an already-closed stdout
@@ -758,7 +760,9 @@ ifeq ($(uname_S),MINGW)
 		prefix = $(MINGW_PREFIX)
 		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
-		COMPAT_CFLAGS += -DDETECT_MSYS_TTY
+		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
+			-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" \
+			-DMINGW_PREFIX="\"$(patsubst /%,%,$(MINGW_PREFIX))\""
                 ifeq (MINGW32,$(MSYSTEM))
 			BASIC_LDFLAGS += -Wl,--large-address-aware
                 endif
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 8545cdfab5..56faf5fe73 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -602,7 +602,8 @@ test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX wor
 	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
 	echo HERE >expect &&
-	test_cmp expect actual'
+	test_cmp expect actual
+'
 
 test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
 	git config yes.path "%(prefix)/yes" &&
@@ -611,4 +612,34 @@ test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works'
 	test_cmp expect actual
 '
 
+test_expect_success MINGW,RUNTIME_PREFIX 'MSYSTEM/PATH is adjusted if necessary' '
+	if test -z "$MINGW_PREFIX"
+	then
+		MINGW_PREFIX="/$(echo "${MSYSTEM:-MINGW64}" | tr A-Z a-z)"
+	fi &&
+	mkdir -p "$HOME"/bin pretend"$MINGW_PREFIX"/bin \
+		pretend"$MINGW_PREFIX"/libexec/git-core pretend/usr/bin &&
+	cp "$GIT_EXEC_PATH"/git.exe pretend"$MINGW_PREFIX"/bin/ &&
+	cp "$GIT_EXEC_PATH"/git.exe pretend"$MINGW_PREFIX"/libexec/git-core/ &&
+	# copy the .dll files, if any (happens when building via CMake)
+	if test -n "$(ls "$GIT_EXEC_PATH"/*.dll 2>/dev/null)"
+	then
+		cp "$GIT_EXEC_PATH"/*.dll pretend"$MINGW_PREFIX"/bin/ &&
+		cp "$GIT_EXEC_PATH"/*.dll pretend"$MINGW_PREFIX"/libexec/git-core/
+	fi &&
+	echo "env | grep MSYSTEM=" | write_script "$HOME"/bin/git-test-home &&
+	echo "echo ${MINGW_PREFIX#/}" | write_script pretend"$MINGW_PREFIX"/bin/git-test-bin &&
+	echo "echo usr" | write_script pretend/usr/bin/git-test-bin2 &&
+
+	(
+		MSYSTEM= &&
+		GIT_EXEC_PATH= &&
+		pretend"$MINGW_PREFIX"/libexec/git-core/git.exe test-home >actual &&
+		pretend"$MINGW_PREFIX"/libexec/git-core/git.exe test-bin >>actual &&
+		pretend"$MINGW_PREFIX"/bin/git.exe test-bin2 >>actual
+	) &&
+	test_write_lines MSYSTEM=$MSYSTEM "${MINGW_PREFIX#/}" usr >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
