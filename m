Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063579;
	b=kRnNReqTmHi32S6zQeAI+VkRgTT0+3i6yrB9Y54O3YOGXusTKJ9095eNkmNT4wsJJGXZ
	 3kw5K/+3Q7OqlPue6sEwmHpt/KH9TTcVWkvIY0ma+MfBnWJ+DHpWV16p9CGSadxx/NEnw
	 l6W8BifsM3Aj+T2mhT+rHHgEhmmEJyaOfIIhzLqquRi6eaWb0FqrJCgTkIs8NdKiRy+wd
	 fklrNgBcbnubfEzNSO2Zt2/CO8PnSFxCeOmq1t/NVeMtSyTqFy7UzPd6GdKFbwmwOzwm8
	 dFnmjSROZoik/NaGTzhjQnHu1N4erwCc6pkDZ8GW6Eo8z52NmAIb0L5z4oNc15h/RrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Ba08S4fYonn3L0aHelCFs7mwCYc4Gi8OcbF84tKSDNg=;
	b=qoLQvC7lD/K/CmMa4DptaXvda8s2tLAy5Z+Nsuc7Glp4H1ec+2Xw6FwSNWpG4xQ+stK1
	 Ya5XGy+536vn/4Nvd9qwf2nTLeob5wALmT9aOk6wwheRQAgyKY6KRpNmET8iDpYd9QxNf
	 yjpO8kCNeiCzcd4JFm+J/XPoVN0M9xpni3/6VN3lMysl+RHAFPOPQMD76ia8yKMzJqG4d
	 M2bXlgSHfKyxcO12FVM4/LnwAXxSBPAmB9euvKSgICgDdkkKgkEwfef2GSlWeZNF7dsKP
	 x7QlnoTVBO+sU3NZMiTySXcu03KTB5AM5VndIVg+YMRrvvbnCFlzOLvh5a+UhfR04TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJ+PvDtz;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8D960A262E
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 14:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC8D960A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJ+PvDtz
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6f5a0893610so1071017eaf.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794063578; x=1794668378; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ba08S4fYonn3L0aHelCFs7mwCYc4Gi8OcbF84tKSDNg=;
        b=FJ+PvDtzFOwSXiVTNuolqSkK0BXTSoWcfFNlXyTgaeO/VG55jf0NjPy+5egNSAKuKF
         02FAj4ihO4ROt64SGkD4Iq+OoQMjm/i11m6g17UjbNDAga/9hkSIMwyGY9+JS8VSGROZ
         hHnqWGpw3R77vARuQFfv+mo3eLULCgmNV9JbpfNyFclRLay5KKEOY8EQUiXqQe8uO8k6
         AlWvV8QDVynU6xP3ckmCG7pAtbAZHG5yKe3wM7uDig61R/5JvXAjKSPsoESjZczgmyoq
         x7dV/8T7uxPCUkJAusi+nW1rguI08DEBNlcsgRIGb7DobODihKmIinM/+trS4jao1jRG
         d3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063578; x=1794668378;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ba08S4fYonn3L0aHelCFs7mwCYc4Gi8OcbF84tKSDNg=;
        b=MqKSc7DP+GcTmx22wLal1/VkdwgYjT4pzsJJqH1Vz0gYn4rqOC7nBohIcB1fDdOba5
         mEUynYCFRsIlGxQYb2912Zl1gzszkYc6C21g62xMpYDMneGueyRdS/MQBt4Tf4bm4hkW
         ykg3Y7+hjAMim9Y9PiN4dQtpxq6OPbw2hZp8gKydl/32qf8uQ2YG3bWhkzTJOd588O6E
         c7ZM0VdJTUyygbafngRuhDBUAm4rCZAxmsftI8S6rDwTeNLRtY+w4eJGBnGfcmW2ZZEq
         P4vkYaX5oMo9Z+FJgMnVCO/CmdYavdFoWTvHqbSm+d0zzYnLrxSEmSMVRV05ZGhlUouZ
         M4cw==
X-Gm-Message-State: APuU4Z/pCLZFDW7VoKuwWJxYuYIVAAESdsDD2JcB/uBJkzXFKcfrZ+w3
	aAsTMFicFKFV/2ZpbsnWFn89uXo/dCpFCAokiTftym6nVNEBkwLggkrC6TZS3SA6
X-Gm-Gg: AYBFou2Ca0shlZz0NcRsR6V4Vis4N3WGt/osggyalj4SwksS4yhtC9xL/l+IbegQlKv
	HdyFLqJyL2eTtCVmbcP/PoVuxsT2mBv5vJ4zgt2YA4gDZsA9mQ8kc1TJUOR9G77MlSREX6iL2Ur
	5NYtAthG8FyEPKHKix7mJt5TZcX2BETKsZDdKcfHuAEOXPyY63a+0fEZ0AlKXu1M3GStzKn2YQ1
	1uiwCrjKxVWmiwFBbHHptLfYWLd4vvUKvOACoGLWrIAoIor71DZnt1zcV2+T7Kj5PTpzoZaQVBu
	F2QhYdi8oHYjMDgILj/xmVyVdAos4l6OIHdd1vOhRvaWrGa4aROn1yoeM2Ncf6HyrdCnyX4N6ai
	7FD/b0XHPaLi8nrnGF3spFBhAYlmI4+h6+kkFCwSID8XuE5cU1TaFBUV3Zv9lQLjkciVCf+VON+
	wn9xeeZIgtl30iMCdFV8i8nZ3RzfbB0FZAVT0qjlFgdI8NnpwqY3N2Ri3U3TBSpRAiiGAbXtitJ
	w2KjmsrwwlzbASgJELB7W5ojhrWIwDIP3Ud9XS9OKtZUlX8Y+BfUsVCa8y/3K3IdAEexAwjBDHv
	ZIQU74aWf8IJuoa1ztY9idqOCkH/L18=
X-Received: by 2002:a05:6820:1614:b0:716:bbec:d300 with SMTP id 006d021491bc7-716e79920b0mr3253701eaf.47.1794063577740;
        Sat, 07 Nov 2026 06:59:37 -0800 (PST)
Received: from [127.0.0.1] ([4.150.182.93])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716ea16753csm3672824eaf.13.2026.11.07.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:59:36 -0800 (PST)
Message-Id: <169ca5968ea2aa40c26076697f8d5c83270f9888.1794063565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 14:59:25 +0000
Subject: [PATCH 3/3] t: replace "test-tool genzeros" with "genbytes NUL"
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

Now that "genbytes" exists, "genzeros" is merely a special case of it
for NUL bytes.  It is only kept as a separate command because a NUL
byte cannot be passed as a command-line argument.

Teach "genbytes" to accept "NUL" as the name of that byte instead,
convert the remaining callers of "genzeros", and remove it, so that
there is a single command for generating repeated bytes.

Only some of these callers depend on the data being NUL bytes, like
t1007, which compares against the object ID of 5GB of zeros, and
t5318, which zeroes out part of a commit-graph file.  The others only
care about the size, but keep generating NUL bytes there, too, so
that what they test does not change.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/helper/test-genbytes.c    | 29 +++++++++++++++++------------
 t/helper/test-tool.c        |  1 -
 t/helper/test-tool.h        |  1 -
 t/t1007-hash-object.sh      |  8 ++++----
 t/t1051-large-conversion.sh |  4 ++--
 t/t1450-fsck.sh             |  4 ++--
 t/t4141-apply-too-large.sh  |  2 +-
 t/t5318-commit-graph.sh     |  2 +-
 8 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/t/helper/test-genbytes.c b/t/helper/test-genbytes.c
index 293af78d0d..ad0fb2d2b4 100644
--- a/t/helper/test-genbytes.c
+++ b/t/helper/test-genbytes.c
@@ -33,6 +33,19 @@ static int generate_bytes(char byte, intmax_t count)
 	return 0;
 }
 
+/*
+ * A NUL byte cannot be passed as an argument, so it is spelled out as
+ * "NUL".  Returns -1 for anything that is not a single byte.
+ */
+static int parse_byte(const char *arg)
+{
+	if (!strcmp(arg, "NUL"))
+		return '\0';
+	if (strlen(arg) == 1)
+		return (unsigned char)arg[0];
+	return -1;
+}
+
 static intmax_t parse_count(int argc, const char **argv, int pos)
 {
 	return pos < argc ? strtoimax(argv[pos], NULL, 0) : -1;
@@ -40,20 +53,12 @@ static intmax_t parse_count(int argc, const char **argv, int pos)
 
 int cmd__genbytes(int argc, const char **argv)
 {
-	if (argc < 2 || argc > 3 || strlen(argv[1]) != 1) {
-		fprintf(stderr, "usage: %s <byte> [<count>]\n", argv[0]);
-		return 1;
-	}
+	int byte;
 
-	return generate_bytes(argv[1][0], parse_count(argc, argv, 2));
-}
-
-int cmd__genzeros(int argc, const char **argv)
-{
-	if (argc > 2) {
-		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
+	if (argc < 2 || argc > 3 || (byte = parse_byte(argv[1])) < 0) {
+		fprintf(stderr, "usage: %s (<byte> | NUL) [<count>]\n", argv[0]);
 		return 1;
 	}
 
-	return generate_bytes('\0', parse_count(argc, argv, 1));
+	return generate_bytes(byte, parse_count(argc, argv, 2));
 }
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index af70e2bec7..16571fd702 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -35,7 +35,6 @@ static struct test_cmd cmds[] = {
 	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genbytes", cmd__genbytes },
 	{ "genrandom", cmd__genrandom },
-	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c35e7412af..1b45c8c37b 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -28,7 +28,6 @@ int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genbytes(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
-int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 463b38f990..ea1a1949a1 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -263,7 +263,7 @@ test_expect_success '--stdin outside of repository (uses default hash)' '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash literally' '
-	test-tool genzeros $((5*1024*1024*1024)) >big &&
+	test-tool genbytes NUL $((5*1024*1024*1024)) >big &&
 	test_oid large5GB >expect &&
 	git hash-object --stdin --literally <big >actual &&
 	test_cmp expect actual
@@ -271,7 +271,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash correctly via --stdin' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test -f big || test-tool genbytes NUL $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	git hash-object --stdin <big >actual &&
 	test_cmp expect actual
@@ -279,7 +279,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash correctly' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test -f big || test-tool genbytes NUL $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	git hash-object -- big >actual &&
 	test_cmp expect actual
@@ -289,7 +289,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 # We ensure that cleaning doesn't mangle large files on 64-bit Windows.
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'hash filtered files over 4GB correctly' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test -f big || test-tool genbytes NUL $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	test_config filter.null-filter.clean "cat" &&
 	echo "big filter=null-filter" >.gitattributes &&
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 361afb679b..6364c396fd 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -91,7 +91,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 	test_commit test small "a small file" &&
 	small_size=$(test_file_size small) &&
 	test_config filter.makelarge.smudge \
-		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
+		"test-tool genbytes NUL $((5*1024*1024*1024)) && cat" &&
 	echo "small filter=makelarge" >.gitattributes &&
 	rm small &&
 	git checkout -- small &&
@@ -103,7 +103,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 # the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 		'files over 4GB convert on input' '
-	test-tool genzeros $((5*1024*1024*1024)) >big &&
+	test-tool genbytes NUL $((5*1024*1024*1024)) >big &&
 	test_config filter.checklarge.clean "wc -c >big.size" &&
 	echo "big filter=checklarge" >.gitattributes &&
 	git add big &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 3e9eb251cb..86b01d071c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1111,7 +1111,7 @@ test_expect_success 'fsck error on gitattributes with excessive line lengths' '
 '
 
 test_expect_success 'fsck error on gitattributes with excessive size' '
-	blob=$(test-tool genzeros $((100 * 1024 * 1024 + 1)) | git hash-object -w --stdin) &&
+	blob=$(test-tool genbytes NUL $((100 * 1024 * 1024 + 1)) | git hash-object -w --stdin) &&
 	test_when_finished "remove_object $blob" &&
 	tree=$(printf "100644 blob %s\t%s\n" $blob .gitattributes | git mktree) &&
 	test_when_finished "remove_object $tree" &&
@@ -1157,7 +1157,7 @@ test_expect_success 'fsck with blob size equal to core.bigFileThreshold' '
 	git init big-blob-fsck &&
 	(
 		cd big-blob-fsck &&
-		test-tool genzeros 1024 >blob &&
+		test-tool genbytes NUL 1024 >blob &&
 		git add blob &&
 		git commit -m "blob equal to threshold" &&
 		git repack -ad &&
diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
index 6bc1c7a663..309807859c 100755
--- a/t/t4141-apply-too-large.sh
+++ b/t/t4141-apply-too-large.sh
@@ -13,7 +13,7 @@ test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
 		+++ b/file
 		@@ -0,0 +1 @@
 		EOF
-		test-tool genzeros $((1024 * 1024 * 1023))
+		test-tool genbytes NUL $((1024 * 1024 * 1023))
 	} | test_must_fail git apply 2>err &&
 	test_grep "patch too large" err
 '
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6cecfbeaa1..974bd21f1e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -522,7 +522,7 @@ corrupt_graph_and_verify() {
 	zero_pos=${4:-${orig_size}} &&
 	printf "$data" | dd of="full/$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="full/$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
-	test-tool genzeros $(($orig_size - $zero_pos)) >>"full/$objdir/info/commit-graph" &&
+	test-tool genbytes NUL $(($orig_size - $zero_pos)) >>"full/$objdir/info/commit-graph" &&
 	corrupt_graph_verify "$grepstr"
 
 }
-- 
gitgitgadget
