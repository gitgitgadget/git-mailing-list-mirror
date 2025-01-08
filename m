Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC2202C25
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363677; cv=none; b=cqEpY+u1+Am0XGMdBLToT9btDA6LpeS1wN7I6O8WV9H/PZ5CcCgj90tQe+0tftxLtAbydBX9sMTUbbcSjsuSMgQNGpdc6yC1hEY4AnIFEabMVb0lI2dB2ZIXg9H7iLNNe4T7q5bdiMN/XM+QUlHFMJQi2kJl2c1c9l7/UKcQR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363677; c=relaxed/simple;
	bh=/hI/VO+IIDfdkwDz/wVXehrZAu9rGcjhNDYmybrUDgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz3DZQ5fX34u2lasillsKiQnXWaV/BKM1b/Ufr3ywbjIt0phtq52rH4+OOQAOwnLyyuWLtqCq0AStMDqEaZ1tIr0YyOIJKwLJATyF0nRWIRA1JH/QBXQsscRgb5YmivcTxzEUmS4PVSXZbZapL/Q9KCQinIcdZu9jK3+7KpgFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=02L+rK9r; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="02L+rK9r"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e46ac799015so100285276.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363674; x=1736968474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BETTMx/ufgLN7/xuQO/U961kXk4u6htxwTmP1PEfcJg=;
        b=02L+rK9r75L4mkraeAmsh4bV1t/2haY6t7wCSiiiLWS1S+geT0aPfFGDewDy2P231g
         z/Df0cw7s8NfyOypUnnBBtOfAKLM39aqSTJOxpRcu65qZel1+PDX+J421KUFuW21bUSt
         WFP7r62/UKjuLw4l8AmlCkUNA5GFLbbyAWymXi9keDcuOjBbr/l9Fbynk5akXIP50gES
         Jr7cuEQkCRRtAbeX51h0cpesZ0OSIqE0yHeuR8tZmUGqt6uf2sL9jkpjYaph71LEw6DA
         2it9X6rWdH1nSuLsu39UA1QtHTY+lMGgZkr6f7QnmltZPEhI2ykBSj1XbyN1BFsHREvx
         kLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363674; x=1736968474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BETTMx/ufgLN7/xuQO/U961kXk4u6htxwTmP1PEfcJg=;
        b=f8RO8+UwNlbBipTzFAj+EJjVO+mgnRbo2t6y0AoiFK1CNBTzR51OJrY2L16eba9oiK
         dAFXymB3nJFguds5KUojLA488AMA14gx/nAJOPA+w8apl44vUVaIw9ui/PX7oABoL/Gr
         ZfeldXJ3gLeJGRW7VlbrH5afSWveasukrqlOQJ/DKJalXf5rOpLSNc4B6pB3R6dU3Hq2
         nrY69GJPXXFWvq6PVy9cbQzHpjlb9nHZBEVgeetzoQNHnJ0Kt7VME13ogvBnOoXH4aXK
         fd6jEbqv0OG3PlhOBiBZuU4nbZ4L4kt69nrC5x11HEfFoH2tZJs0xk0kpWjM2UleAyKn
         vMcg==
X-Gm-Message-State: AOJu0Ywy/5ByhBM0Dbj/DYW1vZVydBMRy6Mtxye2+OFNivOPGVPjyDfa
	JBSfzi0jPORbMA48TkdAXYOYLiUvjFWvkCT2oevuEM8BypEviLFfshJed+AuyoWDKwmKKgmqgP/
	0M7Q=
X-Gm-Gg: ASbGncvmSdJY5eyedSICTjMyZsPrZAUbPUAgRpH6xhwR1WZ7mGf8mcvds8pG/RaYz9R
	UwEak41KoCT3BMpklxN7XtKTLZUKGcuX2bpbmxrpTjPSGFgw7Cv95vpZC+X/eMTSu3klvCFYmtc
	UasHshY6YODTtROALiCPjcO18vAnHQ5vLxES5mUNDwToPkJzXJz1W1cnkKrHxIDgGGs6YLcDDMG
	PSI69lJmndKGgS/OthO8wkJ7FLjvN+9YlwNAHoDeYHL3WPFOBEjUmDbLMG6Vh44WXoDk5Qx2/hV
	e8e3SkFoBQpf/2Xw0JLsU4CuDP9k
X-Google-Smtp-Source: AGHT+IHQz7xU527gj7XQPOFHbmWSaik7AdpjI1hz4I4+KfPRQfr6XSOijG9ephbNXyN6BUVajWewtw==
X-Received: by 2002:a05:690c:61c1:b0:6f4:2794:6626 with SMTP id 00721157ae682-6f531203891mr42233797b3.2.1736363674223;
        Wed, 08 Jan 2025 11:14:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ed1f2sm94698547b3.72.2025.01.08.11.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:33 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:32 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/8] t/helper/test-tool: implement sha1-unsafe helper
Message-ID: <4c1523a04f1b4750da38f5e2149109753d84022b.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

With the new "unsafe" SHA-1 build knob, it is convenient to have a
test-tool that can exercise Git's unsafe SHA-1 wrappers for testing,
similar to 't/helper/test-tool sha1'.

Implement that helper by altering the implementation of that test-tool
(in cmd_hash_impl(), which is generic and parameterized over different
hash functions) to conditionally run the unsafe variants of the chosen
hash function, and expose the new behavior via a new 'sha1-unsafe' test
helper.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hash.c   | 17 +++++++++++++----
 t/helper/test-sha1.c   |  7 ++++++-
 t/helper/test-sha1.sh  | 38 ++++++++++++++++++++++----------------
 t/helper/test-sha256.c |  2 +-
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  3 ++-
 6 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 45d829c908f..d0ee668df95 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "hex.h"
 
-int cmd_hash_impl(int ac, const char **av, int algo)
+int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 {
 	git_hash_ctx ctx;
 	unsigned char hash[GIT_MAX_HEXSZ];
@@ -27,7 +27,10 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 			die("OOPS");
 	}
 
-	algop->init_fn(&ctx);
+	if (unsafe)
+		algop->unsafe_init_fn(&ctx);
+	else
+		algop->init_fn(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -46,9 +49,15 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 		}
 		if (this_sz == 0)
 			break;
-		algop->update_fn(&ctx, buffer, this_sz);
+		if (unsafe)
+			algop->unsafe_update_fn(&ctx, buffer, this_sz);
+		else
+			algop->update_fn(&ctx, buffer, this_sz);
 	}
-	algop->final_fn(hash, &ctx);
+	if (unsafe)
+		algop->unsafe_final_fn(hash, &ctx);
+	else
+		algop->final_fn(hash, &ctx);
 
 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index e60d000c039..349540c4df8 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -3,7 +3,7 @@
 
 int cmd__sha1(int ac, const char **av)
 {
-	return cmd_hash_impl(ac, av, GIT_HASH_SHA1);
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 0);
 }
 
 int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
@@ -13,3 +13,8 @@ int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
 #endif
 	return 1;
 }
+
+int cmd__sha1_unsafe(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 1);
+}
diff --git a/t/helper/test-sha1.sh b/t/helper/test-sha1.sh
index 84594885c70..bf387d3db14 100755
--- a/t/helper/test-sha1.sh
+++ b/t/helper/test-sha1.sh
@@ -3,25 +3,31 @@
 dd if=/dev/zero bs=1048576 count=100 2>/dev/null |
 /usr/bin/time t/helper/test-tool sha1 >/dev/null
 
+dd if=/dev/zero bs=1048576 count=100 2>/dev/null |
+/usr/bin/time t/helper/test-tool sha1-unsafe >/dev/null
+
 while read expect cnt pfx
 do
 	case "$expect" in '#'*) continue ;; esac
-	actual=$(
-		{
-			test -z "$pfx" || echo "$pfx"
-			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-			perl -pe 'y/\000/g/'
-		} | ./t/helper/test-tool sha1 $cnt
-	)
-	if test "$expect" = "$actual"
-	then
-		echo "OK: $expect $cnt $pfx"
-	else
-		echo >&2 "OOPS: $cnt"
-		echo >&2 "expect: $expect"
-		echo >&2 "actual: $actual"
-		exit 1
-	fi
+	for sha1 in sha1 sha1-unsafe
+	do
+		actual=$(
+			{
+				test -z "$pfx" || echo "$pfx"
+				dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
+				perl -pe 'y/\000/g/'
+			} | ./t/helper/test-tool $sha1 $cnt
+		)
+		if test "$expect" = "$actual"
+		then
+			echo "OK ($sha1): $expect $cnt $pfx"
+		else
+			echo >&2 "OOPS ($sha1): $cnt"
+			echo >&2 "expect ($sha1): $expect"
+			echo >&2 "actual ($sha1): $actual"
+			exit 1
+		fi
+	done
 done <<EOF
 da39a3ee5e6b4b0d3255bfef95601890afd80709 0
 3f786850e387550fdab836ed7e6dc881de23001b 0 a
diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
index 2fb20438f3c..7fd0aa1fcd3 100644
--- a/t/helper/test-sha256.c
+++ b/t/helper/test-sha256.c
@@ -3,5 +3,5 @@
 
 int cmd__sha256(int ac, const char **av)
 {
-	return cmd_hash_impl(ac, av, GIT_HASH_SHA256);
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA256, 0);
 }
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 4a7aa993ba9..958452ef12e 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -70,6 +70,7 @@ static struct test_cmd cmds[] = {
 	{ "serve-v2", cmd__serve_v2 },
 	{ "sha1", cmd__sha1 },
 	{ "sha1-is-sha1dc", cmd__sha1_is_sha1dc },
+	{ "sha1-unsafe", cmd__sha1_unsafe },
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
 	{ "simple-ipc", cmd__simple_ipc },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 21802ac27da..24149edd414 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -63,6 +63,7 @@ int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_is_sha1dc(int argc, const char **argv);
+int cmd__sha1_unsafe(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__simple_ipc(int argc, const char **argv);
@@ -81,6 +82,6 @@ int cmd__windows_named_pipe(int argc, const char **argv);
 #endif
 int cmd__write_cache(int argc, const char **argv);
 
-int cmd_hash_impl(int ac, const char **av, int algo);
+int cmd_hash_impl(int ac, const char **av, int algo, int unsafe);
 
 #endif
-- 
2.48.0.rc2.33.gaab3d23ed4c

