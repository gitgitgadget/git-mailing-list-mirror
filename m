Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2C1CCED1
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671863; cv=none; b=SM2zGEV5WTJZ5b0feIY/dacsQ26sREycZLedM5v63WP0X7VZPDVEKjWYgI12KbG3/R3vKXqWBhdf1I1ZhIecEmEmkvpHqD0URvTPV7G3pBgUlkU/eXx2dENVOAaWxu5gVkCZ7eMBMCOqjXGgoesE/aUKp/XU0hQth873bfxSR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671863; c=relaxed/simple;
	bh=LXQU3BK0KVP26pB6icGn2RwD8S3umsvJqxIcYhbvKDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WElV4u9LkbDjJ5Tezz4QJERuUhOMwOv9QqvNz4mMCQPPKgIcYCBorde/Pdd0Gyjk9Djflgcj/U5wlmxYfSJaYdN1I8i6463yl2+2rIEpaYaQMchlDt9C73ZPxtN7zKlDScF9U+Ll1TtSSDPrBwdoxiENybN0e4EKuxvwpRKXx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=us/mUjKO; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="us/mUjKO"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so1993675276.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728671860; x=1729276660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nILwEgilNvhvFtUErjpKPWV3/Iz/meknbMs1cGIr5DA=;
        b=us/mUjKOSUgHlK1TmObgEuhYEKHQV5n7OBUsZYtr3XeQh5UL/J30xmHgQKL3ZEgRjw
         q4fvoMkmhyTjU5ASUrX9HfBtDtb3MFK3V36KqfOvdWjqZMmkrE+58QysHFXbKOYG07ia
         25VszW96buI5VRQ/M7+74qimFFVM3rhX0aGV61z/sVApL0WPlzZld73z0EvTSnNfsaeW
         V/kHZv6zDifT8UQeFIEwIcNxCv63L2dvlJ+LnvcZWUgwcvPoZYKrCbWkTDUmKV7B5SP3
         ZR0ua4KW5Y9KdZyrxfFAUKbqfllrP7S2PQOf/PPNVFNbDfb+pUIVi6cFaqnlhaC6JWxp
         un5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671860; x=1729276660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nILwEgilNvhvFtUErjpKPWV3/Iz/meknbMs1cGIr5DA=;
        b=J1CsVvQLGLUpy0kcEf05nxaD8ULrHsc8XrgnFbcboCDbeZmexwI9aXDbC3SXzIwCZr
         M1aaigBKxOaTgE8QRNA7baExHVdEb8142/hWxeOtvbiAxLiqouxq1M8CFFAoktYtEE3J
         oxroB2jDQIBMFDTKwAh31KIXGpbc9odqbBReL5F5D6Mb0zAvjcVIktEBXqoWCJRkOug1
         5AsTgJw6lVCgt3leb7L3WYhp6Ol0GTt0Nd+CJZhpfXIjXoWotZvw6OyWF7NJ0oq0z76t
         YsO1kmB+2dgkRRk8hOhfNJUXe1c6BOhkAV+BL5538Q1YIEtuj5kD6z4qIweSwAvV5w6Q
         Jw2A==
X-Gm-Message-State: AOJu0YyckTXtsOOXfZoiYXKlm/U9GbC0QLhlBFgR1/Y3kahwpjNXB1Wm
	O8MsF2MmPqlChfALpyBCx2YDin4fshvtVXOavqARlqaCwfunj0mBr0rzeXC5nZJG5D+H/H3M3qf
	h
X-Google-Smtp-Source: AGHT+IGhl3KVb3x8KVdXMYs7HegUr0/lwxC7lrMF6EbSHsfOedaN4/+v9tHVMJKR2f/aaH6FFyao6A==
X-Received: by 2002:a05:690c:3586:b0:683:37a8:cd77 with SMTP id 00721157ae682-6e3644c023amr5422067b3.29.1728671860462;
        Fri, 11 Oct 2024 11:37:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332cabefdsm6921567b3.134.2024.10.11.11.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:37:40 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:37:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] t/helper/test-tool: implement sha1-unsafe helper
Message-ID: <d343f5dc9e5614ccd5a0e92bbdd2d1fd3057dff6.1728671826.git.me@ttaylorr.com>
References: <cover.1728671826.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728671826.git.me@ttaylorr.com>

Add a new helper similar to 't/helper/test-tool sha1' called instead
"sha1-unsafe" which uses the unsafe variant of Git's SHA-1 wrappers.

While we're at it, modify the test-sha1.sh script to exercise both
the sha1 and sha1-unsafe test tools to ensure that both produce the
expected hash values.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-sha1.c  |  5 +++++
 t/helper/test-sha1.sh | 38 ++++++++++++++++++++++----------------
 t/helper/test-tool.c  |  1 +
 t/helper/test-tool.h  |  1 +
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index 1c1272cc1f9..349540c4df8 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
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
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 1ebb69a5dc4..51ed25c07e2 100644
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
index f3524d9a0f6..24149edd414 100644
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
-- 
2.47.0.2.gd343f5dc9e5
