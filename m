Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0491B86DD
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720572723; cv=none; b=bXTSlF18jpLdyMkgZh2KXU4eaTLl1mKaFtB51/9ImNGesgLtfRHCC1umLwgo37YonMOO60qXDDkGf4dqafKbBbpd6LltaNh6SDPYUmIuNGuc7ULDNeF/+WSuGF1isSDHPMUrR4KjLS1hsazJlq9nKLrvTopruRzTVPLFue+RM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720572723; c=relaxed/simple;
	bh=6Tzq996+lBrFse1iIrBJbnKqd4qjfROuGnl8po1ERSM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qEv5hztILwwe3tmQR4pgw3wTNVehjYvTnRsg20QxbW8sbGmGXguLWho3GXE0QWa2YNFsVODNrto9UVtSCLMSiOnbU3+8gMJMTcEbnPj0bF38iQ9NHQYgIXhbbhtge+X3BaU+/RRJJwm/lG1l1WCzvClv6mBL2lHYWU/rkaRzELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juFsZoHx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juFsZoHx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb53bfb6easo26704275ad.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720572722; x=1721177522; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxOOpAUqwDtXidGseopFNoNxgDBP5o42WgCUFERti+A=;
        b=juFsZoHxNsaM1gftGPXQU4+2yc4NrRaggTgU/uFVorTuLmlHhgadJ4ByTVEUiLTIp6
         i8xmrg90e7Em4ycBWpC5LVh3PVyWwZH1PR0jQ35rbULdfgDyvZKPgLNE8zo5Hn2cl2Rg
         YVi1CCdKjt2Gw3ecVq8nRK2k6PbEaVjWtxZE2H0sEKnCFyDKsyjXTXn5iHHYeNzqRdJF
         1SURNHVFq5lmEPJ7kRPJ6k0zjTxodFSQ0pXLn2tsRNLwR+Pl9Hq4AzJEx9oedWIc36h5
         FsghnTlWRWO6cr6eXzbVcZ1DLCHjoL6eo3Cd15zUZfjnc7rZkcDZ1P3iZ5fzk5Wu3Vyp
         SDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720572722; x=1721177522;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UxOOpAUqwDtXidGseopFNoNxgDBP5o42WgCUFERti+A=;
        b=E2NV+XRDHrj9aTTpFRxCyJK0uIRbOfi4H22VCV8FX37iFy+iEl+Hy+ZmzrpjVhMW8I
         dyu/xYVbqxOHP+HVotFYOlcnn8nYDqKWuTj5K5pSYemZABfaR5Xx9nuG1nKqPRT7e5ns
         ZaVEPs32gQbciGBwRxrhS4e9D3ePqPud3dHk9C7zek4xw7kHM/U0CPKJkO8OcvegFmda
         /+dz0vfKKTq8ANSB/OArzBHBvNPKYz87+3cT8nfnsgqPHwuwcDF3Nap8O8S0M5S6SxED
         sf7MLXlHQyhdqb0eizweqpbHkIPCnD/hLSsWoM03z3IhqRhZgayDUoZSJiysCm7MBlJ4
         O4bw==
X-Gm-Message-State: AOJu0YzqFmsfwlgoKO9HYY24cDy/XJgM2ty8eYalIoEIoBEFqbiq1GfG
	7sQpNWdACghyVBa/1piQ2Clz6zayXYfWSFVeHBz5lYZTr2SJ9QNdUKW11g==
X-Google-Smtp-Source: AGHT+IELgDzPIHT3PCxSe2lEtVe9VJvxl5bDDT+6Ldj5CpYAnsCmaKl60fhnPsA8ZeRl8DxW7jPRJg==
X-Received: by 2002:a17:902:ce85:b0:1fb:5b83:48e4 with SMTP id d9443c01a7336-1fbb6ce52e0mr35746625ad.9.1720572721594;
        Tue, 09 Jul 2024 17:52:01 -0700 (PDT)
Received: from ?IPV6:2401:4d40:b860:500:a755:7cf0:2dda:1f39? ([2401:4d40:b860:500:a755:7cf0:2dda:1f39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a12223sm21966435ad.33.2024.07.09.17.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 17:52:01 -0700 (PDT)
Message-ID: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
Date: Wed, 10 Jul 2024 02:51:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

As we describe in t/README, it can happen that:

     Some tests run "git" (or "test-tool" etc.) without properly checking
     the exit code, or git will invoke itself and fail to ferry the
     abort() exit code to the original caller.

Therefore, GIT_TEST_SANITIZE_LEAK_LOG must be set to true to capture all
memory leaks triggered by the tests when SANITIZE=leak.

Set it to true by default, and stop worrying about someone checking for
leaks who isn't aware of this option and might be missing some leaks.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
  ci/lib.sh     | 1 -
  t/README      | 4 ++--
  t/test-lib.sh | 2 +-
  3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index ff66ad356b..fe52954828 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -374,7 +374,6 @@ linux-musl)
  linux-leaks|linux-reftable-leaks)
  	export SANITIZE=leak
  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
-	export GIT_TEST_SANITIZE_LEAK_LOG=true
  	;;
  linux-asan-ubsan)
  	export SANITIZE=address,undefined
diff --git a/t/README b/t/README
index d9e0e07506..1c97bc3331 100644
--- a/t/README
+++ b/t/README
@@ -382,10 +382,10 @@ mapping between "TEST_PASSES_SANITIZE_LEAK=true" 
and those tests that
  pass under "SANITIZE=leak". This is especially useful when testing a
  series that fixes various memory leaks with "git rebase -x".

-GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
+GIT_TEST_SANITIZE_LEAK_LOG=<boolean> controls logging of memory leaks to
  "test-results/$TEST_NAME.leak/trace.*" files. The logs include a
  "dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
-make logs +machine-readable.
+make logs +machine-readable.  Defaults to "true" when SANITIZE=leak.

  With GIT_TEST_SANITIZE_LEAK_LOG=true we'll look at the leak logs
  before exiting and exit on failure if the logs showed that we had a
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7ed6d3fc47..1dd2ea4e07 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1578,7 +1578,7 @@ then
  		test_done
  	fi

-	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
+	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG true
  	then
  		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
  		then
-- 
2.45.1
