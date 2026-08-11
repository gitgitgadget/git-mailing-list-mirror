Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B73064B5
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440539; cv=none; b=imIzaMd0q+zatzxTyG/JXR6bFmHfR4tFwFIyL7YQM+pCEwAba7tv1IYjEcFQTq5TOpAUBo9/CwVeBHt9HaZUE9eNwBuJUZJ9gVtUeoicX1LffzrZT4BuY/ZzEJ/p5JnWYX6arbUbRmsvsKN8vx1g0HH+idSG70Gwpqo0jk3MkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440539; c=relaxed/simple;
	bh=dld0Yxbfes8KQrFox/6LF4fb+B5+NwLFsUqAXs6AKcQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q/rJBVieMCZuSmNp0flMXbCf/EtqM3E4ENtE/jwlv1pTHEFAwXbNnrNC70Ytk8gJjSe8q9jOQqXaIsAUBVh0el7uXJFEgLzfogVUQHyLROj/VacrAhszv8wV683idoZK036u7I8msXJU0kf9kgTvPwRDYLOzl8QQ8SEK+v+7on4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjqO6VgQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjqO6VgQ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2832401a91.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440538; x=1787045338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qRim/LAmmdctelzM4DJ7eSVv1EAJGpxdy+yc/LVbpRM=;
        b=IjqO6VgQ8C+IWxHwxNIqgUa/P99ULDEth/IbQpHfLbRVjjn8ry9eMF6b3gKQbEpY4W
         uplARWr70Eti7GNVkshO/4Pp/qk3gqwSPUu8UmCotn6Yi13jGs09cwB85L8L/3cGRlvv
         c1d/gRAi0uzXFSSSQx0x96kd8P99XK9T8jjhhNJtTPqF1SLoW/dHklltLJ85tND3fV3U
         douU4Af+awQzC35RcmlDHOBTgH8D5P7go1Xhbw/hGOswsQqB7KSaq8fn11sEdXAN2gnn
         6XdtUaqqvMx0qoJSMMZ1n3/7d4i8g7C3Ulot8HzYeqg9AAtwXC8eKGAp0LeEQ2spE1iP
         oRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440538; x=1787045338;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRim/LAmmdctelzM4DJ7eSVv1EAJGpxdy+yc/LVbpRM=;
        b=knrGgeNkFFrIXahzXjKw8cmZnASQZxnsomD9tZLM40wj0SOlDpnZSVcVVu5jlyJtBd
         xlRm1ISNTBgEeveRUWV9K72wgQMMgxj4i8opUZlvidYc12OlHUxhYgolDp7a/B3Z0n8k
         pu0z3XxL1B15f/WnA0IhOhlr9Jszi3MjOQzmi99sZ2ZSZvjJZUbbHpdNa/camJhL9HzZ
         TqaVBZlHC9sUCU01LWJ/MpFlQCx1Zx31j0FARj9yNI+UYIyk1o3EPFDiFHOKV9Wi1Qmw
         vz8ylXbkHKocYSBq4W7ga3O8cracPKRxRq5hCuI0Ho9Wrd2rX7SpfYVfl1U7orvM1coV
         c0YQ==
X-Gm-Message-State: AOJu0Yzz4mR2VTHCOBze0gzsnTTqtWzo4yW1bAJDT4pyu1su2uwfgY+Q
	m/0MAnAhWVDtq7+ooU/TnP/Tsl2Ya0ZXneCDRfR2KNhP0OPnVJxpN3V69Wf0jQ==
X-Gm-Gg: AR+sD13minMjyT/HRdAJ77NR6ivcUbwOOcBFMZapuQl3eROF9pKy53Oj+M1RYTdhOvU
	iO9r/rwXbkOoFntfFdNciHgwx4TxvkwdsxOouvEicp4P4/nge7vGYPkhwPO2DfiqqpZjATrf+gU
	VLtre1yeJoAwbbsn1NCYaYQ5EI4KQI+nAUbpQHDg8B+R6NARvSbBuW4vGDfXKiBqd23OxwwG/F4
	c3mTiOL+c2CYR7P6BhNkxaOEbK11bccPizZGgRGDxE0PGZ7N533YsraSD5VgtNzXz4++kjD4jzc
	p0Wzg0ckawym5/+aOWcEeguHfJXPXNM0YBb7Kdx7m7rfWaNhxNbS0O4SADBWcU86hiTfc9666P4
	+OHlhn/wvEeT8KPJI0MGaohG4nD+34wG8/6J4+EaZ5YtphS5PBMWEV9/lnG+q+/mQvmKajiFRcA
	nol11kyQvTAawJHPHWladmmxLhLqqJvGY7JJ/dsoNcOpMtf5fdwpbt1fuu0uTGk0E=
X-Received: by 2002:a17:90a:ec90:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-392ec53e6c1mr2032593a91.12.1786440537474;
        Tue, 11 Aug 2026 02:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392ee41936asm1224071a91.14.2026.08.11.02.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:28:56 -0700 (PDT)
Message-Id: <37ec7e9aa350e20717344f119d2352a16688d128.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:44 +0000
Subject: [PATCH v8 02/10] test-lib-functions: improve diagnostic output for
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

