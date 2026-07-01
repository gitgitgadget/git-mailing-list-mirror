Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91337186F
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923839; cv=none; b=LEggb7j/ia5vDU6agol6PZT83CK5o62WUL9yN7wgdxh1/C3GGY0FKI3saSHwEwEDNESdZNY7MUR/jeNaLvTxyF+5SPOYOAeXyVZg7oZvneIP1k7ZVY0UwKA3rwIZJ/waiDtVOd+MDKoJXRiZes+GiR9K5bo80Vtptkfpz0OoN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923839; c=relaxed/simple;
	bh=pT/xuCBMpwJwrzmLT6KcwjNOcxJTaecHgxW2+4vYi58=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=saX0EinOEQtl11s3bBtYjLE52fSJE3te7aU+E17XKJ0WpL68J1L3EbfMGNW4dqWLoH70hAJy++OtyseUZQUh1GwUowpv7zl0erKLLKHH7Gy2lFpSm0v08f+7bVm2/HeitCpLC84GNXKEiz2szbgK/DjWhE+u6deZK63FzTElJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNdSDsD0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNdSDsD0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9ed0c7fc7so7377395ad.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923837; x=1783528637; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bIsbbyc5QAk1d3Wy4aol6HkBiyQBs4BLbMLfNYiJsg=;
        b=XNdSDsD02y0FJocYRxVcOYFj3rAy8gq0ad2IerqZ3K63dcUFfjCb4Ga0v4g40e7vWs
         djBmSCrh56ijqMh6DbY8MXgsQftahqHcsRLhZCsCNu6BxrOYw4vuH7kInM/tZ+QQ/Bzc
         WemByLAqo/oBLWsFmZMxxkUka49u1hBQBVbgteRhhFbfF3gGqNMHiB7UnGEchpXPwuk/
         IwWzMdA0s+evj1W6Rg0pVXNCvTVDOFef3LR6cwDqPjQ+VSnEY7iZIXrd6ZLm3vxf0nIb
         4Oj/N+Pz/mm2C//UUDgasLQMONX3erbGRH7a6T1KuA3+OlbG3bhfHxojxluDkxI747aA
         P9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923837; x=1783528637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bIsbbyc5QAk1d3Wy4aol6HkBiyQBs4BLbMLfNYiJsg=;
        b=FhkAJ+p8HX1/GEmlPt4ZBclH//lQPBqFpadaIp2lgGPUIGnEr21fPoo7A5wjXWDYnL
         P5CiVQoX1kXLEE66deoqJjCFFh5nqIZkHgdqxM3yxi0CW2YbJjwvkXvO8jwhgcCSteza
         zfG7gHg5ywdrlBcBKUkVigkEGWVVKVeQ10WsYyubnZKH9nrja+sIWrCEeBk4t6a0Muyd
         eEwAD6oPk420wbJIEX6pWeUTv4gek6sim/I+/ZlInA4sZP2c0Ugxh8uYU0oGoFzo+YF+
         shhh1kSL9oZzv8gmmUI8ICjX9Hp0iA9lfd5afiUlQ7shelTqcYYHjrDduKX15jVJmF4t
         Pfxw==
X-Gm-Message-State: AOJu0YxTFBIeeiGL2KTe7fc1EVi5szdO8975vgRwsFTuDyxNeDpwx4y1
	rtAhGqmTqfo8jMzMXpy3XAAO9NbuI2FPX1aus8HnnbHjuetALgrLaDUPw+FxcQ==
X-Gm-Gg: AfdE7cmTvajRft1K6esZEOQ4/Xh0dYLN5aqu4HCAR4igv7qs5wUj+mawWRdeIqpStGy
	a0sFmV4zcKZ3AVG+9qjOkL1LGGc5k92R09ppw6m9rNS0TKhF/UqZQ87jEFwVpLRtkjjcnZT9NI+
	eUz332up7cETdKWDgHj85d/sWEtCKu/zAp1KrgWGdWvRvqS0Ip+ZyHIwalduHBIb4WeVPfG4zf0
	BDehBkkVnSigxlqEOjhGDXNX5yC4HGahAShJrQ4YIaTI8bMtdEszIPNRKx8IbyMQZnizGrQv3yM
	gjdN4HyqEXPQaKstkADxRebNK3lkHELa0X2ZJvnqyFyDZRCGSppx3/pe5+yzPCnm8fRrjGHwswR
	Sj+x9+LUxbNJf17q2r/y1X8NZthJfYgtJK/CDlzm5SoFpe1T+Hft3HFSGkkQzaDH2HzJgZlrHZh
	K79+nd3A7BpNQEHdU=
X-Received: by 2002:a17:902:ecc6:b0:2c9:fa31:84f9 with SMTP id d9443c01a7336-2ca7e682af0mr22965065ad.5.1782923837422;
        Wed, 01 Jul 2026 09:37:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dade5sm874585ad.13.2026.07.01.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:16 -0700 (PDT)
Message-Id: <143f5e0cc183bff1bbc5e9cfa65f456f615f4ad0.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:03 +0000
Subject: [PATCH v5 02/10] test-lib-functions: improve diagnostic output for
 trace2 data assertions
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

test_trace2_data is a bare grep that silently exits on failure.
Add a more informative variant that verifies the event appears
exactly once and reports what went wrong: key not found, multiple
entries, or value mismatch.  Diagnostics go to FD 4 like test_grep.

Before (value mismatch):

  $ test_trace2_data status count/changed 999 <trace2.txt
  $ echo $?
  1
  (no output)

After:

  $ test_trace2_data_singular status count/changed 999 <trace2.txt
  error: trace2 data 'status/count/changed'
    expected: 999
    actual:   0

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/test-lib-functions.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 809c662124..3521efe5d7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1996,6 +1996,42 @@ test_trace2_data () {
 	grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
 }
 
+# Check that the given trace2 data event has the expected value and
+# appears exactly once.  Produces a diagnostic on failure.
+#
+#	test_trace2_data_singular <category> <key> <value> [<label>]
+test_trace2_data_singular () {
+	local category="$1" key="$2" expect_val="$3"
+	local label_suffix="${4:+ [$4]}"
+	local kv_pattern='"category":"'"$category"'","key":"'"$key"'","value":"\([^"]*\)"'
+	local actual
+
+	actual=$(sed -n "s|.*${kv_pattern}.*|\1|p") &&
+
+	if test -z "$actual"
+	then
+		echo >&4 "error: trace2 data '$category/$key'$label_suffix not found"
+		return 1
+	fi &&
+
+	case "$actual" in
+	*"
+"*)
+		echo >&4 "error: trace2 data '$category/$key'$label_suffix has multiple entries, expected 1"
+		printf '%s\n' "$actual" | sed 's/^/  actual:   /' >&4
+		return 1
+		;;
+	esac &&
+
+	if test "$actual" != "$expect_val"
+	then
+		echo >&4 "error: trace2 data '$category/$key'$label_suffix"
+		echo >&4 "  expected: $expect_val"
+		echo >&4 "  actual:   $actual"
+		return 1
+	fi
+}
+
 # Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
 # sent to git-remote-https child processes.
 test_remote_https_urls() {
-- 
gitgitgadget

