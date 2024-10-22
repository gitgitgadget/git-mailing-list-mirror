Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAB126BE0
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574630; cv=none; b=KVcpCEVmdNXGWRHHMGeNhnIky4gKyrH1mAHkKikGFly9AhbCBguE5rlTR7AJAvcY8M1qS5Q+j/QWXomeSxcyLjRzXqI5egqC2NERymdrHV+e+mhPRilYSrI/PhcgcMmQcphjdaD4Kz35tic4X7HjscjH8aZpI9YXL5KNo0oShb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574630; c=relaxed/simple;
	bh=aJkXRlrvthrfpq76DTf5fWqmXUIImKKrHoNoqH87o5c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LOaLH7xZzGmq+swpA0FNOTqqqBZU6rHgmIU/k17abm8ugBp3iralP9f6gqSY3SqldPpjp10NCx02wSuB5Tf1t8B9TlUrN5LVf4ELP4AA0ep1rU+zyu0LWkFUSwxMEHaSUdkIs1R4vC7tJdt7Db2reU8PghEtfKydfNi4dzk4OMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7UPekAs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7UPekAs"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99e3b3a411so1007825666b.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729574626; x=1730179426; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58o1diBEQxwbnUeaVytDpHr+ZVC86+u7AGBQnzIAiGk=;
        b=j7UPekAsNrhr4kGSyRINHa6HvER9b/QSBbbYGvRh1+UncP+8Ko5dHmN8CtzssoS/2h
         Krr/drlHESyS8+OOYnKjI/fgkxhxgt1sshsf767bgrJ0Is+aivHicHlPxP/oP1ohK2OA
         HpImkGDWJsFbbUHMvJMieB5bB9oj8rf2RcpS+MdCVclQJ1dXcEBCCxMfkISE+am3+Wnj
         uWpDo0L4RzcliXYnYxH8WRCNCN6KsfU31PX077DBeQopvBkoIBFMexZcqSfV9SbUccu3
         ai+pdIT/MJ6OW32oX9g0/Vztdtq82IkZZzCc3LPnmBTJ5KoqXJchEvBuEcz7mVYcPcxG
         lYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729574626; x=1730179426;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58o1diBEQxwbnUeaVytDpHr+ZVC86+u7AGBQnzIAiGk=;
        b=H5N0iKSf9gW/RnSynZIkrP0yr+AOC11tIX4omYOgAZUvRlnKtp4OCHEPju811tLT9h
         KaUzWNECxvDhzutHjOVFxJ8+dJy16yHo9nvm1NtFdIUnCudSUJ7pOMNOysvqDDDi3hJL
         w6+ODScXKCBY9ARVw22QJV2fjWujtUQiakEISOdrX7BMAsN+Wz710e4zJCMiCx1C3bqU
         +Va9S7ntoWWYN1PuJk+/Ag0fxUUjWOVUYfDL7qzZy/OJLHi2pvEtpcaVJVoWEMb923Lw
         uQjuTEdH+d/21j8J9NNjGNyRLhaeCkRXoVR5IEQ2D3Tt0wh6fK7h9n4QvnO7VsTVugHP
         8kNA==
X-Gm-Message-State: AOJu0YxhmUcURRIY8FmBhVlALZRg8500hRKmBEY1vLNB684BEDaGBhtR
	lrCbPKh/OCRlwPuaQqFix+hgLjqAZEosZOlV0UkyXH0hY8Q3mFJvwGGjzQ==
X-Google-Smtp-Source: AGHT+IFHbA0rcnKfOpkEip2IXadcta+SgNigYoebAFKUR1UGfg3CUFZkeG8ivVk3o2CPHdBo6tMAuA==
X-Received: by 2002:a17:907:94d5:b0:a99:6958:a8ba with SMTP id a640c23a62f3a-a9aaa51a5c9mr191346866b.12.1729574626174;
        Mon, 21 Oct 2024 22:23:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913705eesm290043566b.137.2024.10.21.22.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:23:45 -0700 (PDT)
Message-Id: <e292b82d6a1d46990477a043901fa9c56bc00023.1729574624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
References: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
	<pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Oct 2024 05:23:41 +0000
Subject: [PATCH v3 1/3] daemon: replace atoi() with strtoul_ui() and
 strtol_i()
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace atoi() with strtoul_ui() for --timeout and --init-timeout
(non-negative integers) and with strtol_i() for --max-connections
(signed integers). This improves error handling and input validation
by detecting invalid values and providing clear error messages.
Update tests to ensure these arguments are properly validated.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 daemon.c              | 11 +++++++----
 t/t5570-git-daemon.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index cb946e3c95f..09a31d2344d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1308,17 +1308,20 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--timeout=", &v)) {
-			timeout = atoi(v);
+			if (strtoul_ui(v, 10, &timeout))
+				die("invalid timeout '%s', expecting a non-negative integer", v);
 			continue;
 		}
 		if (skip_prefix(arg, "--init-timeout=", &v)) {
-			init_timeout = atoi(v);
+			if (strtoul_ui(v, 10, &init_timeout))
+				die("invalid init-timeout '%s', expecting a non-negative integer", v);
 			continue;
 		}
 		if (skip_prefix(arg, "--max-connections=", &v)) {
-			max_connections = atoi(v);
+			if (strtol_i(v, 10, &max_connections))
+				die("invalid max-connections '%s', expecting an integer", v);
 			if (max_connections < 0)
-				max_connections = 0;	        /* unlimited */
+				max_connections = 0;  /* unlimited */
 			continue;
 		}
 		if (!strcmp(arg, "--strict-paths")) {
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index c5f08b67996..722ddb8b7fa 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -8,6 +8,32 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
+
+test_expect_success 'daemon rejects invalid --init-timeout values' '
+	for arg in "3a" "-3"
+	do
+		test_must_fail git daemon --init-timeout="$arg" 2>actual_error &&
+		test_write_lines "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
+		test_cmp actual_error expected || return 1
+	done
+'
+
+test_expect_success 'daemon rejects invalid --timeout values' '
+	for arg in "3a" "-3"
+	do
+		test_must_fail git daemon --timeout="$arg" 2>actual_error &&
+		test_write_lines "fatal: invalid timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
+		test_cmp actual_error expected || return 1
+	done
+'
+
+test_expect_success 'daemon rejects invalid --max-connections values' '
+	arg='3a' &&
+	test_must_fail git daemon --max-connections=3a 2>actual_error &&
+	test_write_lines "fatal: invalid max-connections ${SQ}$arg${SQ}, expecting an integer" >expected &&
+	test_cmp actual_error expected
+'
+
 start_git_daemon
 
 check_verbose_connect () {
-- 
gitgitgadget

