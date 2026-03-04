Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC063CD8AA
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652098; cv=none; b=ZNzGEkQqh2wgW+ZofYb5tn/GcRmBFy1bqjnb2J+CYGd+CRkDanYhmAV3Wcx0AVla9jV3Z81fAJK+Xmtl3WVQ9Ul9OvvqXv6itOiYpkbDjZKs/geEJ3QiChpwtImOi6yc1F9i85XGIdk0IGrr/P89//DxcIP9Y35QWR4Sjpfxrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652098; c=relaxed/simple;
	bh=hl1HafL+uojQv4VHPJ/cP9wvHL/NqMpVmToIHPhDA/s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wfo/n8afSxjYoT+S5FT357oU6knWX8jVynB4lRkKXCRz+WizmcliwYOBwpLI9OGODjIHyzBCo5BXdCqwPV1Riy363JCFGdydrbUC236RqQG8DT/JtfvkycYMoI7Vw55javJiFEXnzfL9J/HBQLGecvU0Q/emMAS6bAX6f4wFjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaeQAyfN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaeQAyfN"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso31651146d6.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772652096; x=1773256896; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+zeslNT5pjxPoI7KNYw8HK6QIL0wBxyveMW2PdemX0=;
        b=IaeQAyfN/Lj/kYUsc4jKeBrGTNIxuACUT/rjFodx5SluNQLS228HuA8qvQ77YdPnjX
         FA2u2v+Czf0vLw09W2L+w2wg7FhtXL/cDPxZrJdiBpx7i/VlcivAuy66uw7kWumLn5X7
         j1MpVtHUvgZpEGpONWGIIbxxiPrxZnW1/jdchSixEg9533/LzY4sS3SABvTdvQy7QBNR
         HdnvpaMqYnMqf+GJFT1vYd/0fpB89H7+tLg2q5WZnvmM6twCNDbqa7Cap3ojzD++CBGO
         fuHc9gZvmU0STkJTDvnWTrPCQwRg9LgRbmWgLgkMXATfYD661PVl03rqAp9glHT0QAkW
         zKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652096; x=1773256896;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+zeslNT5pjxPoI7KNYw8HK6QIL0wBxyveMW2PdemX0=;
        b=ZAjxIJq2/KUj2D6MdgB1I/TgGS0iu8Bt0Pk4YTeryC7j51OjU4Z4OVM8vppXmVu1RG
         6gHTA4CJYm7fu8ykGazxiGJmMkXTz2n+PlyNWfhgLRNiR04KZoEvCghUbdgouD+JDWkR
         mDNYXAB583W8ejNv6HyrdX1RBsAA5P+3Yb2xLsnO4YrNfbFXJI2ixNx3Ti35+b2GeM4B
         rUGEwA/vp7uOvq8tuCd5CcOyJVKpkzapYXNW0zVRqDAKM4zUYoMF44GILtauHEgFXp5p
         +NKzEp9cF1x2F0S0pkAT5jLbqPYc8p5RHQt13VBr/qlKiYWcZWUDaYsexPkqFJB9CBZC
         502A==
X-Gm-Message-State: AOJu0YwTqMXM4SwMfAjFsdByJotNmijo5O3aIeliomUXDu+ZPkrq7BNf
	TS0XAAAjDIDW5+tMg7NtuXzDgzq0JKnQLkH4oa8OxvWmlI5wYEgaBcEgMs30NeAx
X-Gm-Gg: ATEYQzxrUTcNZ6xCv+uCH83/XLuiNdMf6P71KAqFfONN2Z58khfRp0bLnaFYNt1ACo9
	i30gVhTkYie488lXXeslJSLBbtCNJte4q2oRCjdHij9ir528U1MSxUumoAmv7eWDsf0LVGUHodG
	h+vAXYh3uHTJlGQUu5VNWZ9g8cO/+c1uCTUIPNPe38oXyld45C1Slxmiky4gm4DCMX81+AWR7pX
	aQ1k5bBJzXRyvoL34A6ga7WAEAfczGnTDH9/M3kkaCgdf3TzQO0iIRXSW7P90+BtAIY7W/yzoy0
	Vjb88zTMuLbXv3hLScQADsOdvmkXQVQWqBnMwwVp34pCRxLepcRkyAYA86El8Yga+lljjN8yJh4
	tHggDxwcHtfLgEW+we0QbaKmow9O7qCuM9mrv9hibSSl+ek4v52VKMFpv5V0TISajoqL2PmEJX1
	QZ0E3lmaYPTDoSSxqP0zsF5mk=
X-Received: by 2002:a05:6214:f06:b0:89a:14c5:f53 with SMTP id 6a1803df08f44-89a19d04972mr43758566d6.53.1772652095663;
        Wed, 04 Mar 2026 11:21:35 -0800 (PST)
Received: from [127.0.0.1] ([52.150.28.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf717f2bsm1688699085a.35.2026.03.04.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:21:35 -0800 (PST)
Message-Id: <81cb521401210bfbcd05f8201f75e93bccfba712.1772652091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2061.v2.git.1772652091.gitgitgadget@gmail.com>
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
	<pull.2061.v2.git.1772652091.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 19:21:31 +0000
Subject: [PATCH v2 2/2] log: reject pickaxe options when combined with -L
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
Cc: Matthew Hughes <matthewhughes934@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The previous commit fixed a crash when -G, -S, or --find-object was
used together with -L and rename detection.  However, these options
still have no effect on -L output: line-log uses its own
commit-filtering logic in line_log_filter() and never consults the
pickaxe machinery.  Rather than silently ignoring these options, reject
the combination with a clear error message.

This replaces the known-breakage tests from the previous commit with
tests that verify the rejection for all three options.  A future series
could teach line-log to honor these options and remove this restriction.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 builtin/log.c       |  4 ++++
 t/t4211-line-log.sh | 52 ++++++++-------------------------------------
 2 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5c9a8ef363..44e2399d59 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -317,6 +317,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (rev->line_level_traverse && rev->prune_data.nr)
 		die(_("-L<range>:<file> cannot be used with pathspec"));
 
+	if (rev->line_level_traverse &&
+	    (rev->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
+		die(_("-L does not yet support -G, -S, or --find-object"));
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 7acc38f72d..8ebc73d2d9 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -367,53 +367,19 @@ test_expect_success 'show line-log with graph' '
 	test_cmp expect actual
 '
 
-test_expect_success 'setup for -L with -G/-S/--find-object and a merge with rename' '
-	git checkout --orphan pickaxe-rename &&
-	git reset --hard &&
-
-	echo content >file &&
-	git add file &&
-	git commit -m "add file" &&
-
-	git checkout -b pickaxe-rename-side &&
-	git mv file renamed-file &&
-	git commit -m "rename file" &&
-
-	git checkout pickaxe-rename &&
-	git commit --allow-empty -m "diverge" &&
-	git merge --no-edit pickaxe-rename-side &&
-
-	git mv renamed-file file &&
-	git commit -m "rename back"
-'
-
-test_expect_success '-L -G does not crash with merge and rename' '
-	git log --format="%s" --no-patch -L 1,1:file -G "." >actual
-'
-
-test_expect_success '-L -S does not crash with merge and rename' '
-	git log --format="%s" --no-patch -L 1,1:file -S content >actual
-'
-
-test_expect_success '-L --find-object does not crash with merge and rename' '
-	git log --format="%s" --no-patch -L 1,1:file \
-		--find-object=$(git rev-parse HEAD:file) >actual
-'
-
-test_expect_failure '-L -G should filter commits by pattern' '
-	git log --format="%s" --no-patch -L 1,1:file -G "nomatch" >actual &&
-	test_must_be_empty actual
+test_expect_success '-L with -G is rejected' '
+	test_must_fail git log -L 1,1:a.c -G "pattern" 2>err &&
+	test_grep "does not yet support" err
 '
 
-test_expect_failure '-L -S should filter commits by pattern' '
-	git log --format="%s" --no-patch -L 1,1:file -S "nomatch" >actual &&
-	test_must_be_empty actual
+test_expect_success '-L with -S is rejected' '
+	test_must_fail git log -L 1,1:a.c -S "pattern" 2>err &&
+	test_grep "does not yet support" err
 '
 
-test_expect_failure '-L --find-object should filter commits by object' '
-	git log --format="%s" --no-patch -L 1,1:file \
-		--find-object=$ZERO_OID >actual &&
-	test_must_be_empty actual
+test_expect_success '-L with --find-object is rejected' '
+	test_must_fail git log -L 1,1:a.c --find-object=HEAD 2>err &&
+	test_grep "does not yet support" err
 '
 
 test_done
-- 
gitgitgadget
