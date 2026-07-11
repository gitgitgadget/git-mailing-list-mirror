Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8E3C8717
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776475; cv=none; b=IEp3n5dCeTNpWAhg9ZWMeuAa1sUKrLq65/gU0VehkU+wCUtIF8Ba7E/Z6PcZTKyN83FEg+MbXAVQ3bWoLxi4wAdNd3WmfzNwH7pYUDWaIGiy2uBvuR0C8t5sECwBtURDA2AN7d3Z8yDB+oOiYNCvEN3JbwPXfK0XibB2OJb/jcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776475; c=relaxed/simple;
	bh=34eNGhVokQjNuhnPR8/BjVA03cSQtxYYM1nlsamVJmU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z1PnTlet69rp1Jicx5VYe+QJT5XhuN3EBcjsKWJ/m9UIdAkFngxWaaQ/4PzLaiyq2feq92OIqltV6aVd/S8pSiOcnWtjyYoCPEpCSr1EbldImM5H5BWKp1c4vLTttHfqMnRulHujU5sCQR7QMrvhewLr9V/neodzA7S2iU5gX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EscStzGw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EscStzGw"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso1142793a12.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776473; x=1784381273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7bIsbbyc5QAk1d3Wy4aol6HkBiyQBs4BLbMLfNYiJsg=;
        b=EscStzGw1bmHC+ARl4eyytG2VKof3d4mLweiPhQfMRsYBdIW5H8LNi5w2udVzgD7Z5
         2EsSCcV++4X456RY1B96XJ7kIZB9hdGUWCW8yur8S1S5ujvYh4LlXdu1A9zDrTQDp2qW
         ocFWemsTvIZlcNKsyFpEDIYFtPHequKaNCyOHwxF6j+arw0rgs9lr1igW2kMK3uN40wJ
         yRsKBVIZB9yU959XVtBtl9v2qPYHPwixUNTiiBiW22G7+1ZuIZO/NGWYImDphfbGRIv0
         1TZnNsco6BNUKCxxv9nbV5Y449wLBHcFb8StDMs53F5kruLWj8BW5IrNOexsy3Lgd7Ya
         dvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776473; x=1784381273;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bIsbbyc5QAk1d3Wy4aol6HkBiyQBs4BLbMLfNYiJsg=;
        b=O4O8//M+LxBMUFGzYGVtArQLKv/eUjaOgpkmXooqiCq/On+W1rl8igg4v71JOljVJT
         4TE/G8r8TvSjIpduTPn0Tg9eZyB75X2KSjOU76zpAtH8oUqjqOwff8cknzYyYhlSQOJI
         uGiD97AE5J1SnJkfnJk4Lb1zq9j4IHEJt4nUzdeGLtwF616BgnbghMfQR0jWN7/gajqO
         cJjp7RKSqiOU+8kQpJ85NAi9VqC70PUcswwRSBzEopG7Zt2Taohgw98IKolYk2EzZcb9
         x6qK6iGNM8lFA6hC5OoK2Vz2sav5WpBs4LooUnQvG7wOo7YGjEsGnZOMDdlG4xvPjMvf
         2NYA==
X-Gm-Message-State: AOJu0Yz/6m0RmtVCNUphvROJMw1+3RwOtDQp7AI0XO6oFuyVPJb+w2pz
	zJ5GAR/HlrICm2vW6CbbN9KWS6SnVOcPTs1K3xCCjer0beEoZNEK83bBDAui2w==
X-Gm-Gg: AfdE7cnXKEhm1BZfDpd57P34LE3BiebwQVtSSAmSrAiNIv2FlYDu9sFgnIPz4IGeCj6
	N/oh2sYhIPQRfbFLpDk6C6JTK2D6qohMqURbTOSuVSuOc5E2Mc9RlLD+8co556fQNfxrkAHgBNL
	xrhvTv4+d9wN+Bq37R1p8ZVwy4ilzs4ojl9HDD1FxGnvQZ+F27F+L2q7zUjJzgZINXTG8F1nXrP
	1HaaVM0arVwBZFqd3/oKu8fLFbE4W+tiLciIHLpVjtY5nydIukPXthRAEVbON63jTq8GhgsWUem
	HtIvWiRV4f7rmOzksMav2MRH2jhqT/+aiBT3L58b5ooBXsL7FQbDdCD5HnFm45nOZNKd6MEFMsJ
	JiauvC9rS2kkDEpOt659fmD809a5kNGfDj4Yk39e1RsvE337etgPDwXM1MPCutkvSn5/AThcoC+
	3Cdswd72muy7ApUy8=
X-Received: by 2002:a05:6a20:4322:b0:398:9379:d04d with SMTP id adf61e73a8af0-3c110a6e39fmr3033762637.24.1783776473248;
        Sat, 11 Jul 2026 06:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm19890349eec.15.2026.07.11.06.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:27:52 -0700 (PDT)
Message-Id: <d0ee6d062ef60e2d9e4572ed2dd4d0968e1e29c3.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:37 +0000
Subject: [PATCH v6 02/10] test-lib-functions: improve diagnostic output for
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

test_trace2_data is a bare grep that silently exits on failure.
Add a more informative variant that verifies the event appears
exactly once and reports what went wrong: key not found, multiple
entries, or value mismatch. Diagnostics go to FD 4 like test_grep.

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

