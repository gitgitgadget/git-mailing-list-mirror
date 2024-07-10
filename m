Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59FDDB3
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578619; cv=none; b=QKVN0rqNkGnTdefE+k2ljCBjaSEKTpidWeUDUcN4aEfeBx0fpmV8qM8pqqfMPiwD036+QoCdS9Gr7saOLrQc8Y0d6sDy9FaOuzDoUKzyikqjbYj+XdfkDisreYG97uqxPstjA55FxMhAbV396Zl3+5/lKN6kmr+6Z3nvomlVNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578619; c=relaxed/simple;
	bh=cO543ZL9Pt5YyR/rac6b3arzAz9XC50+cD5k8V1mm2E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=clDwUcIHBCRc71rnatqTjSJ0rX8H0a2omlnF6N83M5fT/+14bVQ1ehqXLuG7pRNwEqrmJinwSgl91XS26uJdMZhFzIn6EgCu1gNCD2XvxsGiShM3eNvebpEfwbJ/JUvw4aob2X+cGOI48VHeJGpISxtr5kRGOIsVXRPbROfDSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBXawC23; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBXawC23"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa9ecfb321so35558735ad.0
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 19:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720578617; x=1721183417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vw016smyVGjyQBzNmEHYcyAsPAb+KAzolHSkcB05IDU=;
        b=lBXawC23eobWV1vfJujgOuR/IHgbuN0mGx5YRlAxYdr4gImcJiTAS7180om5SglXoJ
         2TlJeu8Z/fJo3QMf0E33JnILOMilb0vxuDpZ3eI9RlHE4kLDusnnRKrJBiQgFxTeMl3w
         NR6dkXa3ZI9VgRRcfkUeuNN/H5BvesekjBvCXhuEI+yKvpvbuibjlfWsPWI8IYjJ0fFG
         GpuVuojUnn7IphUG2NNSKgDO/XV0SngKvCTEpUXboX+C74JYwti5Z0VBsELeAbLnE6R7
         wV96niEoPdmDqiQzyBZGJl8eHXaaFb48s8sPVHl53Y3x7ybcBgCv0W2iXemCzoCbSFw9
         L/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720578617; x=1721183417;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw016smyVGjyQBzNmEHYcyAsPAb+KAzolHSkcB05IDU=;
        b=PIzdgHbyicPV/9wivyCp2rolGZL97yDbXKNjR9BJRkf9br6sIv7N9Ezlna1WGsIUiF
         ZGRtClYTVYLaqVLVqWzf+bZ1szX4uaxXjfDMwUEahpf8yoqCHQqZK4SSCGYaoiaEs6qB
         TQIpix8wvEZFh9l/9fJ2QhOicfmYo34IijcD3q/MTn9AgcwjtnSUw61i18zfoeAy8yy0
         dchtYJDieJ4GtrfD6RsEc/jmjHUgZZ5Tu+dXQLBlmQJATEgA4OentNDlizVBlwi+inki
         2loM2J4fCHj0MbMmeMz0OK8MiSE5m0K72R96EWkz3t714S5/mkAAWg3zjZpOkSJRUHX4
         0Ggg==
X-Gm-Message-State: AOJu0YyRsapABL5toTK9xQb5TJm2gt+D6RdReaX+an0QL/K3Onx/sZL6
	PyBz83S2oxWaOKDJwIqpjg1+rdsaBt2EM5iX3M3TQduZFo6Fg5hVuI1B6w==
X-Google-Smtp-Source: AGHT+IHk9cWQjRhBX57nSt+GxGhantyyVx0s7l619YXGirzbt3OLSvVUzv+yNpHEqdSD8Oo7lRbtPQ==
X-Received: by 2002:a17:903:41ca:b0:1fb:9e80:b501 with SMTP id d9443c01a7336-1fbb6d25508mr39616475ad.2.1720578616741;
        Tue, 09 Jul 2024 19:30:16 -0700 (PDT)
Received: from ?IPV6:2401:4d40:b860:500:2d93:2ac1:14f:2de8? ([2401:4d40:b860:500:2d93:2ac1:14f:2de8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a0fc2bsm22762165ad.25.2024.07.09.19.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 19:30:16 -0700 (PDT)
Message-ID: <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>
Date: Wed, 10 Jul 2024 11:30:13 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
Content-Language: en-US
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

As we currently describe in t/README, it can happen that:

     Some tests run "git" (or "test-tool" etc.) without properly checking
     the exit code, or git will invoke itself and fail to ferry the
     abort() exit code to the original caller.

Therefore, GIT_TEST_SANITIZE_LEAK_LOG=true is needed to be set to
capture all memory leaks triggered by our tests.

It seems unnecessary to force users to remember this option, as
forgetting it could lead to missed memory leaks.

We could solve the problem by setting GIT_TEST_SANITIZE_LEAK_LOG to
"true" by default, but that might suggest we think "false" makes sense,
which isn't the case.

Therefore, the best approach is to remove the option entirely while
maintaining the capability to detect memory leaks in blind spots of our
tests.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

@Peff: I thought your preference was to keep the option.  I agree to
remove it completely.  This, v2, address that.

I'm traveling, and while I think the change doesn't break anything, I'd
appreciate a double check ;-)

By the way, I used, more or less, the text for the message that Junio 
suggested.

  ci/lib.sh     |  1 -
  t/README      | 24 ------------------------
  t/test-lib.sh | 41 +++++++++++++++++++----------------------
  3 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 814578ffc6..51f8f59a29 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -370,7 +370,6 @@ linux-musl)
  linux-leaks|linux-reftable-leaks)
  	export SANITIZE=leak
  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
-	export GIT_TEST_SANITIZE_LEAK_LOG=true
  	;;
  linux-asan-ubsan)
  	export SANITIZE=address,undefined
diff --git a/t/README b/t/README
index d9e0e07506..c2a732d59e 100644
--- a/t/README
+++ b/t/README
@@ -382,33 +382,9 @@ mapping between "TEST_PASSES_SANITIZE_LEAK=true" 
and those tests that
  pass under "SANITIZE=leak". This is especially useful when testing a
  series that fixes various memory leaks with "git rebase -x".

-GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
-"test-results/$TEST_NAME.leak/trace.*" files. The logs include a
-"dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
-make logs +machine-readable.
-
-With GIT_TEST_SANITIZE_LEAK_LOG=true we'll look at the leak logs
-before exiting and exit on failure if the logs showed that we had a
-memory leak, even if the test itself would have otherwise passed. This
-allows us to catch e.g. missing &&-chaining. This is especially useful
-when combined with "GIT_TEST_PASSING_SANITIZE_LEAK", see below.
-
  GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
  will run to completion faster, and result in the same failing
  tests. The only practical reason to run
-GIT_TEST_PASSING_SANITIZE_LEAK=check without "--immediate" is to
-combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
-first failing test case our leak logs won't show subsequent leaks we
-might have run into.
-
-GIT_TEST_PASSING_SANITIZE_LEAK=(true|check) will not catch all memory
-leaks unless combined with GIT_TEST_SANITIZE_LEAK_LOG=true. Some tests
-run "git" (or "test-tool" etc.) without properly checking the exit
-code, or git will invoke itself and fail to ferry the abort() exit
-code to the original caller. When the two modes are combined we'll
-look at the "test-results/$TEST_NAME.leak/trace.*" files at the end of
-the test run to see if had memory leaks which the test itself didn't
-catch.

  GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
  default to n.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 79d3e0e7d9..942828c55d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1270,8 +1270,8 @@ check_test_results_san_file_ () {
  		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 
'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
  		invert_exit_code=t
  	else
-		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory 
leak, exit non-zero!" &&
-		invert_exit_code=t
+		say "Our logs revealed a leak!" &&
+		test "$test_failure" != 0 || invert_exit_code=t
  	fi
  }

@@ -1555,28 +1555,28 @@ then
  		passes_sanitize_leak=t
  	fi

-	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
+	if test -z "$passes_sanitize_leak" &&
+	   ! test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" &&
+	   test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
  	then
-		sanitize_leak_check=t
-		if test -n "$invert_exit_code"
+		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
+		test_done
+	else
+		if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
  		then
-			BAIL_OUT "cannot use --invert-exit-code under 
GIT_TEST_PASSING_SANITIZE_LEAK=check"
-		fi
+			sanitize_leak_check=t
+			if test -n "$invert_exit_code"
+			then
+				BAIL_OUT "cannot use --invert-exit-code under 
GIT_TEST_PASSING_SANITIZE_LEAK=check"
+			fi

-		if test -z "$passes_sanitize_leak"
-		then
-			say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting 
--invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
-			invert_exit_code=t
+			if test -z "$passes_sanitize_leak"
+			then
+				say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting 
--invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
+				invert_exit_code=t
+			fi
  		fi
-	elif test -z "$passes_sanitize_leak" &&
-	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
-	then
-		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
-		test_done
-	fi

-	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
-	then
  		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
  		then
  			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
@@ -1599,9 +1599,6 @@ elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = 
"check" ||
       test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
  then
  	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
-elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
-then
-	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
  fi

  if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
-- 
2.45.1
