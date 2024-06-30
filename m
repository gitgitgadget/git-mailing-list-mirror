Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976C38DD9
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719729732; cv=none; b=aDpim0rXRy10l+ADjjc/qJSADmUoglec5QorJ8nvx27Yh6bjiN6O/EarUGyHDHqXu7hhSqGKgJjJq/pHQQhTnjdWVmPhjlVKC1JdJsoCB/2dWq2Aw/el6OpbWAjLz78WkiQ4ltJpCRiPusRZAc6pIeKF15ZHGQisj0umyAoDx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719729732; c=relaxed/simple;
	bh=5HLuNaYOxl0THVU4Lik+DqxsNHaKXO0OXGjcJ8OEJsQ=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qzv4lolg8rmmJuPf/Wu5lMJYgoAcsIOsNDcO58QSgTkwEe+fI93BiXgEHKY1D2NAAdTBI9uHB/brrO3mWiFnSecAgyH7ojmpb6IdYvyMIvQfuHR/YGYtrDLcIuDuNpqD90m/OIEAzHbeuHPQCxAYEW80/l0EzKnXZBAm32caJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXfyj28M; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXfyj28M"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-364a39824baso991911f8f.1
        for <git@vger.kernel.org>; Sat, 29 Jun 2024 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719729728; x=1720334528; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eKOMlJPY8/eglxH6Mde4jaLjh6HqYP5VHYKz0Nooz0=;
        b=AXfyj28MGtdd7iVZc8QAwkTcTfwr59TQqkz7tOB0QHddxel/qGEcXwa8hqgwAaULD0
         vKt1JgSrhns9gwrLT1pWjee5bPVtWoBMxsyw/vtt8/sytaxteN1djS2SBWm6s/qBW2Nx
         Ucz6JOnojvCpFjz365rxudG252J+DXPQ4lj1KXwyPr9u7lQ/8RlN0flOE/hjoGQ0RQpP
         4ims8j/yZ9l008Yv/jRpUNC+GM59Ttedt48U29k0PRqjG5mynN/u7cmngyhu5CtK8Otk
         ALmSr0BMv4c3V71/cTpns3xQZUNzbb+lP4/TfYE9qRANwM25hTsMT7ta1ORvJtsqRICs
         /ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719729728; x=1720334528;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9eKOMlJPY8/eglxH6Mde4jaLjh6HqYP5VHYKz0Nooz0=;
        b=qLdThGwMUj4DK6qLeL02cilxs8ZhecumVRVhnjn9+T3y4gnKsGSfyIMeNReZawi5YD
         xLIaAmDgwGyEktmwLKmJDlVyJqo/c6AWgm5iK7gNL1egCpSS/Y1KinHGm4o8fku7cEz4
         438RIq8SHSi3CyVE3qrmYW+ZiSpQyszlSzzD1667BEY9vd4m6YApDxGRRNLv/NaOoVe8
         PDoaODhNJd839BdGoxPCvl6v81BtpYgyItCPwjkvn2VL4ejt91GjIfNbWzkf6zxwUQ0y
         Iku3Z+x8DESnulsFhUh3IyegiMtKjO/TYC/bueZeJW8yeWBVT+Jf7DCiNS8ACQZcV0Sq
         NhiQ==
X-Gm-Message-State: AOJu0YwTJUQhe+9xkkxrzM+uYdbNgdhsF76HJK6wrdFcsWh3vAhjTtjp
	nd0R02TLk9KOoUWw/Vz4S0SRWe6A7HCcUbiNFVa9D1NrwNp+Jn6+QsP7VA==
X-Google-Smtp-Source: AGHT+IFsFFI8RlZWPKQN3nxx8hizG2f2N4te7ush61OWKVax0+9MoDjYcEKcHE6yEt1x62V3pIc5bA==
X-Received: by 2002:adf:f04e:0:b0:366:f323:f59b with SMTP id ffacd0b85a97d-36775699f37mr1821511f8f.1.1719729727930;
        Sat, 29 Jun 2024 23:42:07 -0700 (PDT)
Received: from gmail.com (123.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb950sm6605717f8f.83.2024.06.29.23.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 23:42:07 -0700 (PDT)
Message-ID: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
Date: Sun, 30 Jun 2024 08:42:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the if-else's chain we have in "check_test_results_san_file_", we
consider three variables: $passes_sanitize_leak, $sanitize_leak_check
and, implicitly, GIT_TEST_SANITIZE_LEAK_LOG (always set to "true" at
that point).

For the first two variables we have different considerations depending
on the value of $test_failure, which makes sense.  However, for the
third, GIT_TEST_SANITIZE_LEAK_LOG, we don't;  regardless of
$test_failure, we use "invert_exit_code=t" to produce a non-zero
return value.

That assumes "$test_failure" is always zero at that point.  But it
may not be:

   $ git checkout v2.40.1
   $ make test SANITIZE=leak T=t3200-branch.sh # this fails
   $ make test SANITIZE=leak GIT_TEST_SANITIZE_LEAK_LOG=true T=t3200-branch.sh # this succeeds
   [...]
   With GIT_TEST_SANITIZE_LEAK_LOG=true, our logs revealed a memory leak, exiting with a non-zero status!
   # faked up failures as TODO & now exiting with 0 due to --invert-exit-code

We need to use "invert_exit_code=t" only when "$test_failure" is zero.

Let's add the missing conditions in the if-else's chain to make it work
as expected.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

This has already been sent: 
https://lore.kernel.org/git/54253e98-10d5-55ef-a3ac-1f1a8cfcdec9@gmail.com/

I have simplified the message a little, but the change remains the same.

Thanks.

 t/test-lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 79d3e0e7d9..7ed6d3fc47 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1269,9 +1269,12 @@ check_test_results_san_file_ () {
 	then
 		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
 		invert_exit_code=t
-	else
+	elif test "$test_failure" = 0
+	then
 		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
 		invert_exit_code=t
+	else
+		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak..."
 	fi
 }
 
-- 
2.45.1
