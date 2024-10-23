Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931D14A639
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669227; cv=none; b=mVR0Ga2owuwZwBjkMo9TxYsJJWzYog6wVBiURUO1WCx2PADPiU/fF4fl5tlj7gkKlmS3HUY4++0xd82e32u6WAQOm5RyGpyqVgNdLnybK3LGB6p1sz/ZpmrUXnQkn4ZlfFVGRCHkY3kj7Z0BWy1NiBrbaVtxrfnrCkabQd3rhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669227; c=relaxed/simple;
	bh=deKq+A9LnK+oqwjEPHhGiFvL8WASgJwQOit1fL5TJwA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DvaG5yQkLc4bulhJjDeA5AtCUeLwdQDt4s2amIoa39+sKZACWpKij4yiWJDxEICHlvOwtT3TmgtT0HA7K3wzMmEDY2y8ypn3mHuM6SVJXc7BUluXb/7jCN4t6KDih6e5XmN3IeIHt7UKrF3vXwNP9bux3QHGExOlPYMuBIWXs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELKlTTPw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELKlTTPw"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so776179466b.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729669224; x=1730274024; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3kU7eI+PYLSlOBjI4sp2ao+VRlCLuTcWtBPICI1TrI=;
        b=ELKlTTPw6ckHLVjR0gewBRelFp23/1bg5Y/zPZMfEBzagLIJoX1UqwcTitx5/lfN1l
         KgmQNKdDNh1Tugr+FAbwE4zB1UfcZ9CW3rhW6om/WLUfZ68WKn90+mnsh7G0D56kS8lW
         lkVvXAx9RkGcaR7q+GQCG9ZIADvfAbs3oD2muPlAErazQS/Nrt3Yg6I0etUTjlNMcz1c
         D25aXZJw9psdcSK4pHJDRf/yBh/61DlrQ8zCLQRvbqMGTTyZV2J17HQEyLsKaNr20kFE
         WrqPbVu6ImuMkKDOyl264UbywCigE+WNmqAtav7Wai9PGo6ce0Wt47NWllfrJKNL8RGs
         WAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669224; x=1730274024;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3kU7eI+PYLSlOBjI4sp2ao+VRlCLuTcWtBPICI1TrI=;
        b=d+L6u1QPhnrAmPSNssUq1PGt5D2FeZ4VtI/Eb4/2dxCFe2B/4ZJ88JMP3tLBNvO+XP
         oBx7SqxAm8CCtw4uLPBJN4phjynGvl6hkFi5pzoCe5KMrjI5NbUxv5QS7bTKOPV8ofwD
         LG4HF/6IOFB9J7Nj2JpP6VqfQrvk1H4UZ38/RrF7+te7UcHFvfOCRw04IXvhqr8LvYn2
         5+KCCtcHb3jDc8cbuvYOgaremmrDc7AhNZm1gjbWuaZSzZARRa6x9Hvb3WQVH7JSrqlt
         YR1a3qN0u+Wh4ndgYwLLP5YPii2bJ7ZLwPiEACVZh0OwuosT+fxks7OwrRMxqAAjZgBp
         qIDQ==
X-Gm-Message-State: AOJu0YxlOdJOao0Z4Wi0i/TcEWFmwQgD1mzzG0M9XPz+yB7moC51vhYc
	inLTEjveanNnEvw8QlRSUjLejR9DcdC3UDvg0G4tJdaKgqfXUtR0F5jrjA==
X-Google-Smtp-Source: AGHT+IEtQ399TQ4WbGr3IImGZX9lS1zovBudUC6jhjEfTyFMbX77WqMQYHN6XSZgxD3HvqWfp7/YTg==
X-Received: by 2002:a17:907:9452:b0:a99:8178:f7ed with SMTP id a640c23a62f3a-a9abf845edcmr156571766b.4.1729669223383;
        Wed, 23 Oct 2024 00:40:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6551sm435621666b.39.2024.10.23.00.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:40:22 -0700 (PDT)
Message-Id: <d9c997d7a9c8975ce845aa0cb4deaba22cbf3b94.1729669221.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
	<pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Oct 2024 07:40:18 +0000
Subject: [PATCH v5 1/3] daemon: replace atoi() with strtoul_ui() and
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace atoi() with strtoul_ui() for --timeout and --init-timeout
(non-negative integers) and with strtol_i() for --max-connections
(signed integers). This improves error handling and input validation
by detecting invalid values and providing clear error messages.
Update tests to ensure these arguments are properly validated.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 daemon.c              | 12 ++++++++----
 t/t5570-git-daemon.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index cb946e3c95f..a40e435c637 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,6 +4,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "environment.h"
+#include "gettext.h"
 #include "path.h"
 #include "pkt-line.h"
 #include "protocol.h"
@@ -1308,17 +1309,20 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--timeout=", &v)) {
-			timeout = atoi(v);
+			if (strtoul_ui(v, 10, &timeout))
+				die(_("invalid timeout '%s', expecting a non-negative integer"), v);
 			continue;
 		}
 		if (skip_prefix(arg, "--init-timeout=", &v)) {
-			init_timeout = atoi(v);
+			if (strtoul_ui(v, 10, &init_timeout))
+				die(_("invalid init-timeout '%s', expecting a non-negative integer"), v);
 			continue;
 		}
 		if (skip_prefix(arg, "--max-connections=", &v)) {
-			max_connections = atoi(v);
+			if (strtol_i(v, 10, &max_connections))
+				die(_("invalid max-connections '%s', expecting an integer"), v);
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

