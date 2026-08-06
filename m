Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494642BC56
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013997; cv=none; b=p/QYQy5zz6i9jNlrY5b14cqwPbCVS4IWTF3RFhe67XYudps4r0iO2x7rwONhJoAXDUk3GsPy3a0yQ9BFihS8yFySIBk3AwwDEknrC0pJVed8RdE/nZE4EzvUeLV6MXeYHtIwem2d3+S1wSJkZGghIbVWHM8y5xrUZBHNi6ULh7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013997; c=relaxed/simple;
	bh=dld0Yxbfes8KQrFox/6LF4fb+B5+NwLFsUqAXs6AKcQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nfFTqIzlor5aYr7X32mbLwAbGE8EFcDdOPiH3OppEuRZAiBhnrSb6n0x99ePTmpeZTWv++Ci/KusQnUBYU1WBglXE0n8UllH1IyCGAyVNZJGeLIqcVERDCvXzHmAaA9noAUJJf5MF7JFnsHCUNsaNiefTd7nh5hLZzZrTzbnkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dut0rSAq; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dut0rSAq"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66843536f94so2746539d50.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786013994; x=1786618794; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qRim/LAmmdctelzM4DJ7eSVv1EAJGpxdy+yc/LVbpRM=;
        b=dut0rSAqjaTx2ZULdWAIiMRxs9GzuW2Egw8hIUGL3GR/E0P7bldSY40WjhcvV8cICf
         trYq7YCRGABvrkv8VyMTcooY01lo3eUJXt8g7RH2vVXCCMl8QBTMsYVlYOjOw735VCRS
         2n49QWID5lN2H+Cmq8zeXk3KGfM3elYDxxPgOkXWkDmCa/cUgm6darzeFxcgR0csRUoN
         2KMkbJqTDMGog4EUZrM8bNjmmO5iRtPPjzcDnyTlpulR0a+xGDWR58NJsiCz7pXf7o2G
         pOl2Gjj9mPIemzxP1kBtkXh0r3hbF9r3m2cVpgB3qsPrz3kV9Iw+fM1h6nY8LvqyciMP
         CJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013994; x=1786618794;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRim/LAmmdctelzM4DJ7eSVv1EAJGpxdy+yc/LVbpRM=;
        b=ORTUA4NVQCLKir44zEr91bxcMGlV86UU4FwdHUI61aaGbJRgJXQVu7OVKlJvxI0ouI
         tbr7JgqVwSEGKdDO3EuFIvuoBXaYHc57myhfGwJZ3t7yzjNZl+8W/Ep5Bh55EHxXdR8h
         JYX/ABSscHYN+278p7zzNIDNypYQHZrxNtXtqIZ/Df6yZTDCsvmLmsT/2N0zn4vM62kO
         oGLrq5dkRw0Ulwus6WL58IJLpi0hv/HHt4IbQaOG9MMnBjDj7CH4xZ8N953qA9K1tS0g
         2fMAAq1CMzQ95eotLV7CNpblhMfHUw7Vzbhv7Ey1vOwDJGilkGqKdudJyoWv9jEjZkl4
         QCOw==
X-Gm-Message-State: AOJu0YwqEDydk54pNN7PhW7+d2hX+dCXbz8m63ks6RAZHvUVM+Iq00pA
	RQ6NfiM9yRa7epI6LckEc2oHZe6V8GRjWrKWB3QJ4FW2lXyoZN6ldmBUYEjzaA==
X-Gm-Gg: AR+sD12TfdtUdGJdHjJCVghZz7ge6ucbuiDjJ3ytYgCQ4AAZlQ1KcnAXYuLKYzo78cK
	kXNp5y4fxMVabp1Av6MFq44vf+wnO5VQoFVgZtNymt4Ky2EIThkLTV5qcFobtLQNTIAYKn9q5+M
	ZV5UAOfoOnNhg8Dp3pCmOJEYcAG7D6yWqVDyy4TfiCxvppXDNbwyGc8423gXvi4OsjkwvaZsUNN
	nbYBC2Cn98BnTChY1+ehiJT5u6OWMEYyLTrC2RqTAz3amzm32gaZbdWYfs0vZZs+Z/laxhBxQ2p
	I08YhIt+HsSVSzXWVwz3uTuwqQsSawxGYX/03eqAbPrwvuJKbdDfaL+iMOCjpTeWe+/ZaTHv4bz
	ks/2t3Rlw1dQVebgmXyH6cMHfgJxxfP9TMU9C+U08wGKolh4/CQzIa9KSqPUAPrF/NBJtrxPILl
	gxtVP8/kfKcZEI/SM4poJIBDzJVg+hOQlX5qV+L9OF3lnAjbNkSr8A3ts0pQRgcZNybeu6fndcg
	g==
X-Received: by 2002:a05:690e:4813:b0:668:19ff:7eff with SMTP id 956f58d0204a3-6699aba1423mr6031967d50.38.1786013994575;
        Thu, 06 Aug 2026 03:59:54 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66991672ebcsm4859648d50.21.2026.08.06.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:59:47 -0700 (PDT)
Message-Id: <57ecc0b18a53ac567c24d90288d75aee16eefc01.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:33 +0000
Subject: [PATCH v7 02/10] test-lib-functions: improve diagnostic output for
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
 t/test-lib-functions.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 809c662124..8c6d327b03 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1996,6 +1996,41 @@ test_trace2_data () {
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
+	*"$LF"*)
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

