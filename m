Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063576;
	b=Fc1kfmy53WlwrNKm4MIdegjEv0Um9TbCMSD+lwXqDMIh3J3w8rn9oZHe0QoyZx0Z/RiI
	 y8fQYAwXVVummVzaDt8rAHGkdQ0gLT4zQSSauXUEkdNY9+v6gZqRQmVHX/n/6XwbMy2Mu
	 D06ENk7MMvwcmyAU00ogKt9g/+TuthrUwM8xWYIsAI0FwsrWe+zuHL9a3q5wX13Eh4igl
	 GGAMJtzOjMWHaEG0fdFLh2YFc4ku1mG4TcF1oHRl6h7I/Zoc1n/MMUHWt//GId4v1YzJe
	 FlfydrIpWBG87umSoOGRbw5GPoiSijcUC6QWtcgn5O5vopi8dVLkv189geUTQsJDBaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2UBuzvPu0/eKojhCvZrHSGlRTNg4lMVYjxUscZy7Z58=;
	b=yxazClrGkHa4zIUFGnUPcdJbcefBR99zEL0tpfNdhNAYpxmFutGPuGstKLFhczwXDT82
	 zF48r8yRW6KasmauoQmb45hgBfYcbTE1S9FrTAqNXdY1pPV8dFppulC8Bp8mYqrwIBoM2
	 35LTSp0RVVMrYxeitzoyLi5joZmNzHtgquo1v5PPIyfpdcX+KIM+mqsYXxUP4AKCdCgW9
	 QDPcgnyRTtQpN3CEkrnw3thDpfIDeNpHf4d6jhLTYu0wyOwIZwsH6PCv1WfDwhoCO20V4
	 4VSkimxlaSWDzbS/Z+S+Yptkni0rSTwS+N94fJe1LskIKZ2pBEz3j+BxwmCb6WAreKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbPU8frm;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DE60A2618
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 14:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7DE60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbPU8frm
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-53ec9237600so791010b6e.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 06:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794063575; x=1794668375; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2UBuzvPu0/eKojhCvZrHSGlRTNg4lMVYjxUscZy7Z58=;
        b=XbPU8frmh7B6r8Hc2Qj3zdJG5ssInAdvocysX61ntV+UTKVoZbSc6b1tRBglSFa7G7
         ZrUplYs7x9iWCfpCcm78byekSfZMJFqcrfgRTHttvYUWy+oK1Ixp9tzd9lzpNaiKqTzW
         A0b5H/2qS29oisHeSdx4I9LFE3KsV3CJrgrf3IzSKoCR1OIbolKpSgpO1XaMsFRLMjNq
         k8Sh/DU1o2PjTi+zmWzOZLl4wwHZ/rWuP8PTk2/Cfcks8N+TD0nIikVDLmeSlDxcmOe4
         L9wE7CL3ZYyQ7MnLQQViPljZvUIpLb5PgHE3KLP/pXAZaokNzXbVPOmmdKa7gipBSgUa
         pgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063575; x=1794668375;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UBuzvPu0/eKojhCvZrHSGlRTNg4lMVYjxUscZy7Z58=;
        b=lwoXoF4k8rNIw/j928muBedxuRDz6DRQiXFko1h51WVh/DIuZ7CG1wqw5fNbVwJ5AG
         NqK76KraieFdBLUGno9SLJUSAjk1J4xiEE7ibS+HJ1V44pTn7ZqZUXLyZvLto2kHEe/X
         cxJ/0oxM7A1Ba/K0bJ5TcV1y7ymyj0PR5IVPkpuZUFXMU3nyaTR+hdmJsvJ0HqxP4/cP
         JmyX7jaqUDOXiyBIEktPp1rW6lEWHmxmbe7K0e8LMw1y2mOOTo0RIRVBlYXBciRq9Qg7
         wHaQ66jeZEXDpbZP+IAuVTOSBZbw1bW2gLtc/JQZrRs9BgDQAF7XUVI7T/CmPojcHTAM
         YlEg==
X-Gm-Message-State: APuU4Z+wte6CvBYyMG/0qJzw3FpwLcsxH3mVoT7PHS00uyquQVl35Qpg
	XMwjyQsq8+cqwIhZiVjIxpnIOOvyN9RXCM+ZV3zT4FIkPMdIuAgfUOBvg8cQQc6I
X-Gm-Gg: AYBFou39WXm2H2tMCSGwJzNGEgAPjUTWuN4HX6zBwNwIptOo/s4dkoDD1FSAWWgG2Ax
	9MNyBfSGviIMwlvgk+ja2PNrK9Lz1ztnvI8KwUCF7Rtmv9J6ASUHa8ejgoxapZZ0xu/lCGhs8Oi
	urrbY4yq/1ovcW+CXw+fPC6+gaNdENC0zs+Ogfw5Dtn7tkXMOm0XfBb8FYDBVCmW1OuNEmx4HeO
	bx/FiutBeMndsVcIT8RcPuKsA6XT+Y3FjIlOfbO8s+9gs1Rw1hUBA2EtlEr49nmy8w1tWoxndNc
	cnmoOHyLcdvoE8ZvYKuD7s3HP9hEbSefqdcMz/LINPlL5la9+iMK8KGhtqV4gjmr8+AkQLjByGU
	SUMaxuT8EBdQYghzYD1ZQh4fIEMKCGJD6jCobFHQRNScNeQ786xrG+2XgDKhJ2w3doJ7bBgvvha
	QmTuEByRNV6gRAMTGTJoH8yrRfOM5pcc9UJhPZhhIUYqT7RasoIIUY/kxRptZStUbbUyH32xRL4
	6d+oawZhrMxPk2oXo2XI+0e5saW6si9IjL8/7C8xZhawsCpvYM7uyj5P9zE/JmEhyS+iIQtFsuk
	IUsTif3RnUceJgNskjFWmaf2Lav3ktY=
X-Received: by 2002:a05:6808:5087:b0:4d3:6be7:c5e9 with SMTP id 5614622812f47-567e0fffd68mr4287661b6e.24.1794063574662;
        Sat, 07 Nov 2026 06:59:34 -0800 (PST)
Received: from [127.0.0.1] ([4.150.182.93])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7f010e4sm3986395b6e.14.2026.11.07.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:59:32 -0800 (PST)
Message-Id: <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 14:59:24 +0000
Subject: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Several tests create fixture data consisting of a single repeated
character with "test-tool genzeros <count> | tr '\000' <char>".  This
works well on platforms where tr(1) is implemented efficiently.

The implementation of tr(1) on macOS supports multi-byte characters,
and processes its input one character at a time through
getwchar() and putwchar(), even in the C locale.  For small inputs
that does not matter, but t4205 generates more than 2GB of data this
way, which makes that test much slower on macOS than on Linux: on the
macOS CI runners, tr(1) alone spends 95 to 123 seconds of CPU time on
it, compared to about 6 seconds on Linux.

Fix this by adding "test-tool genbytes <byte> [<count>]", which writes
the requested byte directly, and turn "genzeros" into a thin
wrapper around the same code.  Use the new helper in all tests that
piped "genzeros" through tr(1), not just t4205, so that it is the
obvious choice for new tests.

This makes t4205 much faster on macOS in CI.  The Linux jobs, shown
for comparison, only save the few seconds that GNU tr(1) took, which
is within the usual noise:

  job                before    after   change
  osx-gcc            821.1s   243.3s   -70.4%
  osx-reftable       911.0s   194.0s   -78.7%
  linux-asan-ubsan   226.7s   222.1s    -2.0%
  linux-leaks        320.2s   298.8s    -6.7%

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/helper/test-genbytes.c          | 52 ++++++++++++++++++++++---------
 t/helper/test-tool.c              |  1 +
 t/helper/test-tool.h              |  1 +
 t/t0613-reftable-write-options.sh |  2 +-
 t/t4205-log-pretty-formats.sh     |  2 +-
 t/t5300-pack-object.sh            |  6 ++--
 t/t7006-pager.sh                  |  3 +-
 t/t9850-shell.sh                  |  2 +-
 8 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/t/helper/test-genbytes.c b/t/helper/test-genbytes.c
index b895436a32..293af78d0d 100644
--- a/t/helper/test-genbytes.c
+++ b/t/helper/test-genbytes.c
@@ -3,29 +3,26 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 
-int cmd__genzeros(int argc, const char **argv)
+/*
+ * Write "count" copies of "byte" to stdout, or an endless stream of them if
+ * "count" is negative.
+ */
+static int generate_bytes(char byte, intmax_t count)
 {
-	/* static, so that it is NUL-initialized */
-	static const char zeros[256 * 1024];
-	intmax_t count;
+	char buf[256 * 1024];
 	ssize_t n;
 
-	if (argc > 2) {
-		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
-		return 1;
-	}
-
-	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
+	memset(buf, byte, sizeof(buf));
 
-	/* Writing out individual NUL bytes is slow... */
+	/* Writing out individual bytes is slow... */
 	while (count < 0)
-		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
+		if (xwrite(1, buf, ARRAY_SIZE(buf)) < 0)
 			die_errno("write error");
 
 	while (count > 0) {
-		n = xwrite(1, zeros,
-			   count < ARRAY_SIZE(zeros)
-			   ? count : ARRAY_SIZE(zeros));
+		n = xwrite(1, buf,
+			   count < ARRAY_SIZE(buf)
+			   ? count : ARRAY_SIZE(buf));
 
 		if (n < 0)
 			die_errno("write error");
@@ -35,3 +32,28 @@ int cmd__genzeros(int argc, const char **argv)
 
 	return 0;
 }
+
+static intmax_t parse_count(int argc, const char **argv, int pos)
+{
+	return pos < argc ? strtoimax(argv[pos], NULL, 0) : -1;
+}
+
+int cmd__genbytes(int argc, const char **argv)
+{
+	if (argc < 2 || argc > 3 || strlen(argv[1]) != 1) {
+		fprintf(stderr, "usage: %s <byte> [<count>]\n", argv[0]);
+		return 1;
+	}
+
+	return generate_bytes(argv[1][0], parse_count(argc, argv, 2));
+}
+
+int cmd__genzeros(int argc, const char **argv)
+{
+	if (argc > 2) {
+		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
+		return 1;
+	}
+
+	return generate_bytes('\0', parse_count(argc, argv, 1));
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..af70e2bec7 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -33,6 +33,7 @@ static struct test_cmd cmds[] = {
 	{ "example-tap", cmd__example_tap },
 	{ "find-pack", cmd__find_pack },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
+	{ "genbytes", cmd__genbytes },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..c35e7412af 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -26,6 +26,7 @@ int cmd__env_helper(int argc, const char **argv);
 int cmd__example_tap(int argc, const char **argv);
 int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
+int cmd__genbytes(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index 0b27d75fe3..0b74ff6157 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -146,7 +146,7 @@ test_expect_success 'small block size fails with large reflog message' '
 	(
 		cd repo &&
 		test_commit A &&
-		test-tool genzeros 500 | tr "\000" "a" >logmsg &&
+		test-tool genbytes a 500 >logmsg &&
 		cat >expect <<-EOF &&
 		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
 		EOF
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 01b97c8888..894d88c39b 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1182,7 +1182,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit mes
 '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
-	test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
+	test-tool genbytes 1 2147483649 >expect &&
 	huge_commit=$(git commit-tree -F expect HEAD^{tree})
 '
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index aac139e6a0..38dc4021b7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -9,9 +9,9 @@ test_description='git pack-object'
 
 test_expect_success 'setup' '
 	rm -f .git/index* &&
-	test-tool genzeros 4096 | tr "\000" "a" >a &&
-	test-tool genzeros 4096 | tr "\000" "b" >b &&
-	test-tool genzeros 4096 | tr "\000" "c" >c &&
+	test-tool genbytes a 4096 >a &&
+	test-tool genbytes b 4096 >b &&
+	test-tool genbytes c 4096 >c &&
 	test-tool genrandom "seed a" 2097152 >a_big &&
 	test-tool genrandom "seed b" 2097152 >b_big &&
 	git update-index --add a a_big b b_big c &&
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 75ca7a25da..8f1f71bf12 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -662,8 +662,7 @@ test_expect_success 'setup trace2' '
 '
 
 test_expect_success 'setup large log output' '
-	test-tool genzeros 50000 |
-	tr "\000" "a" |
+	test-tool genbytes a 50000 |
 	sed "s/a/this is a long commit message/g" >commit-msg &&
 	git commit --allow-empty -F commit-msg
 '
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index 27cc49bbd1..d56edebda7 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -30,7 +30,7 @@ test_expect_success 'shell allows interactive command' '
 '
 
 test_expect_success 'shell complains of overlong commands' '
-	test-tool genzeros | tr "\000" "a" |
+	test-tool genbytes a |
 	test_must_fail git shell 2>err &&
 	test_grep "too long" err
 '
-- 
gitgitgadget

