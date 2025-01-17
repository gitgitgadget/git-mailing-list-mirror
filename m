Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711461ACED2
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151395; cv=none; b=EPiRcIT+ep9hGrAFF4L6riUul/WjOKjhNJN57t9P2bGxGN4jiTLtwDZl5NKgdIemYO5R6btmTo+C5FJMbD1fbr4624vyrGtKP4apBscWeJRBb910TJ/3TbUzk25Dgq7oWtr/tdY398iQ6zbupDtf5tVEHPPmdlLhCxDJT0GAqNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151395; c=relaxed/simple;
	bh=jbPcViVQHxoayWAQ1lou2ZsbjQo0KUGNLUNBWiR0PFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3ED4BTHHZ9CkkVMKmPZvuW6cNXpL+aWSpJ9oC/F9Z1hHKr7aluN8cQSfTeglGqwv1folZW2tKq0I6XCk7iwHnZaEOvg/6JvL4nrwyithmveIKk8Tr9vzzs22ztAZPd5lYhUn2RmyQnZTLDopADGctIKap3Y9EqCiaHfZfFuFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=n4HXqy+Y; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="n4HXqy+Y"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso3783824276.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151392; x=1737756192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uwx/Hv6AEC9pPJADNyNzVM/LHaZ+FmSV5k9M6I4Z3Rw=;
        b=n4HXqy+Yi7VvRn2qM/608F8N0+xzzTUaagpWP4o7hN4GdqGxgVNmAEKYxn8g6z5Lsb
         4okmaS49Nft3oA28r9AyzlGOrpruXTxXQdES7iVfMLNIQs6kVGySmrfcbhJNCeyo0XKS
         EXZXsCYibcX3aP8nwwFXEfWdexQqD1x77U7Ly5LwThDzsvO3iXsDZ5L3eBp0h2XmnTxc
         WG484t0l5lAREljCTxHkooscnnnfHD4bGJP5PtaKoyaFJ3YXmo0wLi5cUD1yn/RljCJv
         CyMeHu1r4tQCChsMhkErCd9MVVHP8mU9KAU9UA+b+qB4Nh5jhMiVanyGFwoQVeQW5h9P
         oK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151392; x=1737756192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwx/Hv6AEC9pPJADNyNzVM/LHaZ+FmSV5k9M6I4Z3Rw=;
        b=bqi/cZaPWwGrX5ehmv6WuvPCeAB6V2NeBPE0l50QFA+SZXswatF3XQ/87h/CNds7t6
         9urrYlOD9s98XisP4vQX6+PAj/NMj0YqP8OBr62sStzTlt424JO5qzUY17scd4rJBACE
         0heFsbRcmpioSOFMbV/KxguXmUn0DOGbqon6a0EFlreK+8Q5RVjPFkoTo7YAuW2xJ/0Q
         mxVN9YsHlRMrzHz0EHLBNK3pjnGeaLFU8DAyKM1N/6tSptz3hROJXF9JgLgBbTonCYtr
         xjA8VFS52+btLf83L8W+BSB+hTjGF37rYvOZL7yT9cnhZssjdeQbFFTtaqSJXJk2bsCV
         SEHQ==
X-Gm-Message-State: AOJu0YyYpxzH7LdlEtoo9/EfrB8k30193w38Kl+osHceX/nrZ8bwnD0c
	N44+YNCgXkUNN2wQJWeFuWPwf76weUb3xsY9SsHMVaPvugx+h9dmLcNu3PqZfs0nAg4SPcNS/Rp
	EXfI=
X-Gm-Gg: ASbGncu/+GL+ntWCidI9braKjlz4+crwevHVWW8a7WNGZN1mp4NLQU83Zwbbz7C68tt
	iG2GpM4RtfiJd3adk8wkEILFIVN8CnMmEPfFz5WFboH4sxcmakXpjh54R+UGhGTTV/qfKzDGGmS
	vuZGwcUG6rabzExOJh0bhtSyl/Nyk8i2b58qkNAB7n6GjfIAuEBD3WBV91Kxx4Ve1i1mH2voTYy
	aeouMr8H6lqvLCWULQZP0JgkXBNUz9iYGmLAry+rJ/EybfG1MhbdRBCYq47QFX+3ocLPsqOwPyv
	Mm0hEMJnplbTESAC2xpdP6pBvD1a
X-Google-Smtp-Source: AGHT+IECln+/MrMAOi5fHC4HDsFvV/ma1BliZn1WVBjNDnUmXLwRDVFbkUlht6VVZRcsZgFWU9utow==
X-Received: by 2002:a05:690c:4d06:b0:6ef:9017:3cd8 with SMTP id 00721157ae682-6f6eb938a1emr38856277b3.35.1737151391984;
        Fri, 17 Jan 2025 14:03:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63fd82bsm5894277b3.31.2025.01.17.14.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:11 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/8] t/helper/test-tool: implement sha1-unsafe helper
Message-ID: <ae6b8c75294933fbf1f9112a6d22b8730a454ccc.1737151386.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737151386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737151386.git.me@ttaylorr.com>

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
2.48.0.rc2.35.g0c4d006e6e8

