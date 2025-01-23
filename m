Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4588149C51
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653664; cv=none; b=OMc69qGU81pNF90Fo/hmWNf+Y/QSztU70OaSOrSDbd+CjLXx6tvS5wLUCNqN9YI4mY6S4V1MHk4jp0Kf2V2SAO0epuPYPXOZsVp+xLvtbDD58mJiXFNCe4gsXaYsMPuRtqQSxbSM0+9EFhNYpuQc/+mwBefj3Y40u/ovx6cc0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653664; c=relaxed/simple;
	bh=cEu5aB8gosLgPyDEAsZkmKTyVLh6W9D6E2/Qy9Bpc00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8mlsi0wtiKh+0pk/A8WGsM5fIJlvwQp3Ok0OFfjjraxnDtlH8OI0y13wCjdh/Cd2P7WvIzRi3huTt04sn4rYog+xeetTEenGTvqcGUJXTuYdEt998cil+31JoGM6JZc8kuvfPQnFaQw0IZSkRaM4tuhwja8oo3a4gKa11dYIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kjsSn7nH; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kjsSn7nH"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e46ebe19368so1742713276.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653661; x=1738258461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYUcXoDGE1VZui4RG1S9LRYAFXHI4AAnswfZspxdGi4=;
        b=kjsSn7nHI3eojoHmprCYNu+QqhxrpNohByVERCRd6TWQreuKtzHPaPR0Ae5zmp24wk
         YI3SXbV4ZeCmJfLQ4m1MRQ0Pa0YUzT56jBKoIsEyPUHTU7DZ+dNJper/VdBQqeYyoDzg
         Lx7gZxJUHbXNFFuwQ9K+He1CHJUJ24jTluKcEXX8xpG0g6Cu92ZTYZVJaMwsv/K62sWB
         wnPdlOwEP/qKlK8TVf1qSSPfc1qe4pQMVofPm01LspRlfeQQ+YyIuyO61kUOF5uPoBO2
         G1nWbgmoydDyyx8JjBU+ba375EAuCNiHtfLyUyq3vpiPyf7nxNZaPqDtZI8i4TkTw+/C
         sWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653661; x=1738258461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYUcXoDGE1VZui4RG1S9LRYAFXHI4AAnswfZspxdGi4=;
        b=vao+A/bhAH1aBZ9tglwAYGZ4bZ8YGz0TEn5MrWUj5fyLJGHdPI8DzWIBhp7xOZZyVg
         hxiFaPu/k1ogz/Mpz5yUstrmVb4qZermLm9z2RqJgqy4he+meXWEPSGMiQShkY4+mq0h
         du+CboHx5ObiTkWUxnNYC6bvgLqf8k0NQEgHX500HNJQY8UUWD4dwjGIjFWTxlQuQB3a
         xNox1kfT6R1tO1pihH2bdG3Tuuv2tzoSxRu+PMFqxz5nMh7mZ3yXvqs+SDxdgC4UpWoy
         FGCEqtTVFC6BkOLdg8/DGflq9eBuHVQHXdnMwOYofsOnuogkjSvOex2g1SwCAbMDyBS/
         A6/A==
X-Gm-Message-State: AOJu0YyzorSWVrYw1mmwdFwj0Jc8DtJ7TWFdTtBW0zqgADj2GK0gArit
	e2Hu8cdGJiZoEeibfABmjPcDPO9SVXKrtxJ/4Dq6MOlEDlfsSBv/Y7Q3AaXVIRl27E44oUSJsiv
	3QMM=
X-Gm-Gg: ASbGncuXUkf3k3yJ1hkqBHl2KGppiGGZ/KoOJF0vWVFqUqNyvN8s5ciBhVzzABTxUtj
	wiqY8scpBtXOVzSZlZf5O7+w93RFQ8dt3FeINLMeRoGg3uaJh9zZZ/48S87pderdEPukIbAjxTQ
	ljy2sAcx56clSYkTu54rHmNdheEzfWZ/ppCsp8IMdd9rAV1qXMj9TTNt7kQUvJuYXQUPr1gOd3C
	J8BAdyoQdMl+F2+zbD4SzlPf/r6vNk1JnyKd04JlFIIJGud/aNlwf2t4FjTZu77j11TtUJolKZx
	BzTHHPEcypR4vS0UsBoThDWDJdE4Mbx7cAPi6ZbQZE6PYbB+qZoh
X-Google-Smtp-Source: AGHT+IHWQ3hYy/maz14YmeGzgS3SUoheE68H2u6Smuk0stJj7KH6gyNa4bur/eoVa9u/qJll7p80/Q==
X-Received: by 2002:a05:690c:6e07:b0:6ef:6a71:aa55 with SMTP id 00721157ae682-6f6eb51a3b4mr217935697b3.0.1737653661254;
        Thu, 23 Jan 2025 09:34:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a2de28sm442807b3.111.2025.01.23.09.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:20 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 1/8] t/helper/test-tool: implement sha1-unsafe helper
Message-ID: <b64ae2382483b0518fd71df23433e40cd1cb986b.1737653640.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737653640.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737653640.git.me@ttaylorr.com>

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
2.48.0.rc2.35.gd215225db14

