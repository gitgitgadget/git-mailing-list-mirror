Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14548399365
	for <git@vger.kernel.org>; Thu, 28 May 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958864; cv=none; b=Mr/ds6XF1j6QtOG35+Ic2Z6NELzHQELhtykUQwKkylE6kKQ2Jb2r/KuzBqD4UeZOMP4X1AuYRWWxHLVe4UdVpZif4JpPKSv7IWycpW5uSwn4bvz/VUnI+boSAtk2lcnXV+grOJ5h6K7jX4Ego8hrgY8CQgu9XgTTSAv2MGod2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958864; c=relaxed/simple;
	bh=yp3FIP2q3Kc7FuyJ+kt4WrFWP+RiSP3IlOck4+Fver4=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=SguC2qvk/HP+AbkEetYSJYUemHCZoreiXH4Hh6p/HxLdPT+U1hgYorHQyZiT/D+WwOeAcakxtlcijC2HhA3QVO+JTd3rbAeBw0I+wKL28ru+tevwUAdRIdMsnNMm0Gzw/9vOdiT+NQwckzSN+DYwye+W/Z4bGJeH3INygiBog4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImfO2iwb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImfO2iwb"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso144996041cf.1
        for <git@vger.kernel.org>; Thu, 28 May 2026 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779958862; x=1780563662; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a9usWtJ4qypRxPn2ghiuAIPgG6yFLYGzv/NdILwBEOc=;
        b=ImfO2iwbqx9kEfqaWnTbaJH9UbXU3t7PVFm8Whl+HgzkVozka0bgcdi+zRPpnEyIIB
         IxU4iNbM63tEbI7SXxJeNdwHWopqQHabV3urJRqjlkR4xvNpK04Ymm2Q8obJ6yGDeLmt
         mMyYbiykPPQslclZ71akWgps4zAtYzzKVBPYP+3xBzBngOK+nqxjmtx2G/s3WafPKU6F
         BnAqGYw3bjkqCHlSIfin48o1qJKUoKA7Q91u6rIZnIYaKp+CYVH6/pU0MbEUJ/BtEHGB
         lP1meq/7XOriruddK139PRLk4J7UVkHhGnfIes6i5A8gTccybT3esbr88nVbVF6xiGZ8
         gpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779958862; x=1780563662;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9usWtJ4qypRxPn2ghiuAIPgG6yFLYGzv/NdILwBEOc=;
        b=I3FVyA3ClMg7wn7dmEZy6xdMlRLasDMmwrNmt4v8jMTaSLjcPKFwHHvDJwmKvbu8F2
         ZqahGTV4h4Yd5ty0EAFq3MVLN+y9o0mm2sZBQdO06EN7F9b9KYdysPKJkPIaUPtSoHBv
         8e7zZvwJQBSLY4Uey/Vht4HK/vZqcB7etj00PYJkpfC4S/q1bWYZp10iQBzlCRYVJrpF
         XvtyKSeBXHJ6ua8h17BikHKQf4aq2sLFDf2fgAYMKKPSzbhxa1vEROBRu+h3DdyPBQUo
         cBC4sl4v0gzhP6nijFNosYjMXro5uCMoGJCvJZZ1kqfUJZRW6/DWeAOqS4E/SpK1/PV/
         WUpQ==
X-Gm-Message-State: AOJu0YwCSx0MIIz9+d4/3YXkDf1kpkVPCWWL+UoFd3MmhpOvQAJvNf3b
	HanEZnbZD3APA/C9BKkqV5yGx6DY2ia8ajz3oVeKOsubj+ZhXYQCJk/+lXDNVA==
X-Gm-Gg: Acq92OEtriw136yDsMYuyhL4mRGH3CKeU5iLoRpNRwnM//tRbqZqSu2BvyLQ8bDc/b2
	y0+NSqMAZCvLLKS90ZWKtzuRLuack3PZm3cJVbHoQf8lkU/DL8/u+ATkD7g/mxvFoSOiSCaayV5
	4fqnmMbxY/MdKF92E7w1Di770q/e3Gur6c7Jlumc07Xn+1FeBu6oDVcaMcJ58pvj64vSRxqseP9
	ZODPJ14iTZ5fE90Ftu61Qtkh49SDCJv8d3TzsTnsvQ6WEqp1j8pRee9EQMOhIn8SSYNrx9dpgIR
	a6YTmxFSlpHyvXbxiMsHE5EfnuESMTSNmcWRM/P/SLtqhvBii0Ch4Cq8XnIb9qHuAoPUDD+zPeV
	WzPcZ2bG61LSQvsENgRmCqp6v6v3GER/Rv+AMcDERbWH3SHKWyzY3jMGJCv93Jo/WpiwWsiCPtc
	gy093AzIM+YNwyQxQKTYt3LusTH6O8raw/gFY4
X-Received: by 2002:a05:622a:48b:b0:516:e517:6dff with SMTP id d75a77b69052e-516e51770admr270440841cf.1.1779958851910;
        Thu, 28 May 2026 02:00:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.68.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706af131dsm67610111cf.21.2026.05.28.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:00:51 -0700 (PDT)
Message-Id: <pull.2128.git.1779958849319.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 09:00:48 +0000
Subject: [PATCH] t3070: skip ls-files tests with backslash patterns on Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: @dscho,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

On Windows (MINGW), backslashes in pathspecs are silently converted to
forward slashes (directory separators), which changes the glob semantics.
This causes 36 test failures in t3070-wildmatch when the "via ls-files"
variants test patterns containing backslash escapes (e.g. '\[ab]',
'[\-_]', '[A-\\]').

The wildmatch function itself handles these patterns correctly — only the
ls-files code path fails because pathspec parsing converts the
backslashes before they reach the glob matcher.

Skip these ls-files tests on platforms where BSLASHPSPEC is not set,
which is the existing prereq that captures exactly this semantic:
"backslashes in pathspec are not directory separators."

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    t3070: skip ls-files tests with backslash patterns on Windows
    
    On Windows (MINGW), backslashes in pathspecs are silently converted to
    forward slashes (directory separators), which changes the glob
    semantics. This causes 36 test failures in t3070-wildmatch when the "via
    ls-files" variants test patterns containing backslash escapes (e.g.
    \[ab], [\-_], [A-\\]).
    
    The wildmatch function itself handles these patterns correctly — only
    the ls-files code path fails because pathspec parsing converts the
    backslashes before they reach the glob matcher.
    
    Skip these ls-files tests on platforms where BSLASHPSPEC is not set,
    which is the existing prereq that captures exactly this semantic:
    "backslashes in pathspec are not directory separators."

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2128%2Fspkrka%2Fwildmatch-windows-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2128/spkrka/wildmatch-windows-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2128

 t/t3070-wildmatch.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 655bb1a0f2..3394122218 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -99,6 +99,13 @@ match_with_ls_files() {
 	match_function=$4
 	ls_files_args=$5
 
+	prereqs=EXPENSIVE_ON_WINDOWS
+	case "$pattern" in
+	*\\*)
+		prereqs="$prereqs,BSLASHPSPEC"
+		;;
+	esac
+
 	match_stdout_stderr_cmp="
 		tr -d '\0' <actual.raw >actual &&
 		test_must_be_empty actual.err &&
@@ -108,36 +115,36 @@ match_with_ls_files() {
 	then
 		if test -e .git/created_test_file
 		then
-			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match dies on '$pattern' '$text'" "
+			test_expect_success $prereqs "$match_function (via ls-files): match dies on '$pattern' '$text'" "
 				printf '%s' '$text' >expect &&
 				test_must_fail git$ls_files_args ls-files -z -- '$pattern'
 			"
 		else
-			test_expect_failure EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
+			test_expect_failure $prereqs "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
 		fi
 	elif test "$match_expect" = 1
 	then
 		if test -e .git/created_test_file
 		then
-			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match '$pattern' '$text'" "
+			test_expect_success $prereqs "$match_function (via ls-files): match '$pattern' '$text'" "
 				printf '%s' '$text' >expect &&
 				git$ls_files_args ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
 				$match_stdout_stderr_cmp
 			"
 		else
-			test_expect_failure EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
+			test_expect_failure $prereqs "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
 		fi
 	elif test "$match_expect" = 0
 	then
 		if test -e .git/created_test_file
 		then
-			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): no match '$pattern' '$text'" "
+			test_expect_success $prereqs "$match_function (via ls-files): no match '$pattern' '$text'" "
 				>expect &&
 				git$ls_files_args ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
 				$match_stdout_stderr_cmp
 			"
 		else
-			test_expect_failure EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): no match skip '$pattern' '$text'" 'false'
+			test_expect_failure $prereqs "$match_function (via ls-files): no match skip '$pattern' '$text'" 'false'
 		fi
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_expect" 'false'

base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
-- 
gitgitgadget
