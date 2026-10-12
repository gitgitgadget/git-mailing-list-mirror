Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644E7080D
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770578; cv=none; b=lzXz3v56twbhqpHlwfLOgr4RL/gA51ta8CXe+th5pjvOnRrdIx8XS7OO+tNc8yinLwfHvL8uQ5s/KvW01DpCewMihLfPYS3wvGFxypNny20FwP/yBZCs7Z1IiKNyVUWaaA1tDfV3gtGdqAaWdKdxMNdQh+2DKpc6zqCSxSyyFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770578; c=relaxed/simple;
	bh=o7vlWi9gATstHNmmYzYkQdTT5HeQEjiI1/4Uoi/AAfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kR06D5pXKQWyde4JI62xRT4H7A2tCXGX5sskeJtvgi9iaa6rXQNEfMN0uxp/y5wjZjtIFbOfiKgotrbvCEzljDaXGnbVIXIO7bpPciGUEjrpNOUoB8U3fIpr7Iv+jqQ64VoF4S0megydIuRnN/LmMcVgevD+VC/bW8Oz+j4OCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhqDODWp; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhqDODWp"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1517bda04a0so600967c88.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791770576; x=1792375376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXEhZTIr0Tqxp/OfNzrpJRXY0O7wdXva4c68bMrk2pY=;
        b=jhqDODWpjzUkdu02Blgxg4FRfq3kzcKqMrXLNIVGUrx66zt/JLDMnJ2h25Dp1a3/o/
         s8HmWPB8Wgy+muPB9efXZP4w5Q9eEtuRb35u+VjMXwsGjboS9/hGz5vJ/BafxG0MPOKY
         JsLJOyqp0YzCQ71WGyepWq43P4GxamNzFP8EHh3X4ykXdz6FtVB5MR6bEk/s9EOAVcsR
         TWe6Nm6WM7xXgXeBcQu+kkhv9zzIRlJetFikIX4WjiciDE/LXF/aOpQgG6hsvrd4IlMx
         zxPDNZZMtJGAraV3QN8Y6TGOzhyJMKt4ptBLZCjovv9s65GzSiMSSpTW//qLPuuGjHi3
         AI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770576; x=1792375376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TXEhZTIr0Tqxp/OfNzrpJRXY0O7wdXva4c68bMrk2pY=;
        b=Rx95vcux5gw8bUXZq52wmUWNRMBM8BtSrRQI5hjfEF5Yr5DK2sTVjsGeS2pnGQ9eoz
         odeNG+/C5tPjRy91zoXiQUgqhZNj/A/PL4SV00yw6wD+wqWPHzisqX/tRn//Cb7p/q1X
         eeZhIcMUKWHNaH+LYeQkPbt+kzCdy0bop9tCozRGXphHJgJ3sLFmyF2O8JlY8NSN5i79
         uwwPx2J0hHqykIpAzljFgTFkW1vGozEq7XftrxZnhDRpScG2CXhVy1KNFTfb8n+YTFpt
         A/hutDM4pwCbmxTRUuvweGvRQGmwZBq5ITR3/AhvloHzxKqxnTpnXCvQS9fk35VnHvBm
         2dDw==
X-Gm-Message-State: AFq9FYJt+Cw3ymc54Gbyb79Pi4EUinlcvUiuPnEG0YlXDeAD6I9rnbyi
	YCcIdXhrg21CE1lDlWfqKaXoUaMQuDTuK6UXydW/qW1I5Z+1KV5Cf28ZmJSttFpV934=
X-Gm-Gg: AYBFou1mTyqh6vXD8muinKvFFYs7lSF5K4VkL+15ac1xuy58yzOyuBEiBRH98ufj8A5
	injsF6QzMSCX+xdL0mcZfrLj//OpSEwjHS3zFmX0lZeY6aFhbXcw2TwI36PbTZ7j75xBW29mUQY
	oX2xG+I6vfzanhkq/O0AXjv2Gsdv3sizx5jOAjbRISUyN+wd40vtEiy8N0jW+BOR8iv/3yWcAF8
	NgnWDmZm7IDZcA9q+DGz28eWI5nJF5FeYet6wZuCXON/ngzzfWYgrw3XC8FZLM6UaMx7sRPgWIv
	hkjANMITs8EEpQgb9BeKEr1PUDvpnX/oK69T8UjsJvQvNZY+jBKoTPrwC6Wgtg3U52AD8GNBuRm
	RKdfWD2/wFBemL/fL/Eas6RMgPmHFGSqkndW+NDnIY5ItmGWwvd6JjLrCireYhQl+GDO/GuxigU
	8TKWLghBb1Lv0f44zokfdOkxxBHWL07VfyqaC+DlvYiNZHD2cRbAPm+jkel++OvKTAZHtFE7WJk
	fHs3VAaKqaSefYxsh8UyYYinbrMFz18
X-Received: by 2002:a05:701b:261b:b0:154:dc96:c1d8 with SMTP id a92af1059eb24-16a54ad2602mr16117731c88.2.1791770575848;
        Sun, 11 Oct 2026 19:02:55 -0700 (PDT)
Received: from isabella-caselli-linux.. ([2804:14c:9e:81ad:adb8:bc9f:a8c8:3c2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35a352d4b05sm7196412eec.19.2026.10.11.19.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:02:55 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH 2/3] t6500: get hostname from "git var"
Date: Sun, 11 Oct 2026 22:58:45 -0300
Message-ID: <20261012015846.2649843-3-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012015846.2649843-1-bellacaselli20@gmail.com>
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
 <20261012015846.2649843-1-bellacaselli20@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test "background auto gc respects lock for all operations" simulates
a concurrent gc by writing our shell's pid and hostname to "gc.pid".
It gets the hostname from the "hostname" command, falling back to
"unknown" if the command fails.

"git gc" gets its hostname from the system and only checks whether the
pid is alive if the two hostnames match. Otherwise, it assumes the
lock belongs to a gc running on another machine. Since the test passes
in either case, a missing "hostname" command or a mismatch between
its output and the system hostname can cause the test to silently
exercise the wrong case.

Use "git var GIT_HOSTNAME" to get the same hostname as "git gc".
Keep the "unknown" fallback, which is also used by "git gc" when it
cannot determine the hostname.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
---
 t/t6500-gc.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index a7142ab815..f928089bf0 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -413,7 +413,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
 
 	# now fake a concurrent gc that holds the lock; we can use our
 	# shell pid so that it looks valid.
-	hostname=$(hostname || echo unknown) &&
+	hostname=$(git var GIT_HOSTNAME || echo unknown) &&
 	shell_pid=$$ &&
 	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
 	then
-- 
2.43.0

