Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B2427A1A
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890475; cv=none; b=qQ36u/786mbly9rR2gWjlEWQm5TltVTKfT8Uuv1NcZ9mWuYMNkkTmkNkwSAVlSTfbKsajUydFCQrtrxJNDtcx89VE1w8rAkRPjGkUc1WJNd4i47Ulsejq1hfog4X7kaDrl/WMRK0npIb3eKgFDG42zC1SDZy3a3PYvuNFioyakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890475; c=relaxed/simple;
	bh=medI6obxQfWheJMSqik434VsJG4bungIyzqeRHgUinM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0erAmAqtn4asUtS4KOx4AMCq2P3C+/knqUR7mWRbQcxIkPMYS7Yp62riwOoaX9Gkuhv2Oa9l+lSrNeap+QTcrr/UKPBTIAzf+ggXiRI51Wekzvax0XIA9OV02ZTau0kk2bF7KLy4KUskgc+mFlSY+Jfw94Ksl5bunT9KbbyPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxAVZj0W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxAVZj0W"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49571fea44eso1957565e9.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890470; x=1785495270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lk/+661qOqIKa1H254Rsv1txZEod0es01mm1+tWcuBQ=;
        b=BxAVZj0WguhyqccU3Idrrz9VydwSkw+YattbK0xnV0CdklAzvb5F0h7Qs3qsVIPGZB
         tMvXHcP8UZ9mqiJJwlRbBxXq8qNE3VvoH/43vExyY4vxaIXJmAieTv6H8NFQ91aYRg4H
         CEjzi3A87RaCT7lhYd5jL9J0q4/JJ5TQY8EhnfDtKyr867uqFw/UwNoSN+wyz/84byFr
         GURPJmcM9BH8HNcTAJYdgyQ92NFQkjijHy+gbsP4RpqHLDtcdk9r3e0/rmfK9BHv6Umi
         7Ab80r90bYkiTiQ8Q1eaXJ7P6wWxBDzNzJ7BVeXUaj7LJWlZR9yWTcDSjZJX16Rajo6i
         iw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890470; x=1785495270;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lk/+661qOqIKa1H254Rsv1txZEod0es01mm1+tWcuBQ=;
        b=sK1yOqy2tz30D4rQtBmwrqHaDaCF9e3SFi6EPHf83OKX55p3IzU/khVlS2TlGk5Jlb
         34OBvMDxDa4muERjFmD/v39SMiwPE7UfXpPHoS3x3u/VgX69yRLvbPt/rQeJ89SjVmvi
         xA2EOrevt+5XlMFaxofkZ4wNMP6KiEaUFyDabWblYPqUiMbmSQzxX8XFT9M/yX4NTNxU
         DStaHGFIVtaKt0pzHA+UXEEuBqjNhllcj6uh2XnlAaDPwtczSzUZ2QTsnCfsFkAA69ns
         EQPKij2XvKM4e8T+DLEt5RblJdDTHmXPAOHnNc/iuFRTVxSPZzPBliXfi59eMwESUo6k
         UQOQ==
X-Gm-Message-State: AOJu0Yyfw6PvV/VUdnIRrD85LK1SdTH69eBzGBxihqJNokM8nyE7qeS1
	OqZF76o/1MoFzk/tqcM7hzCSe3RU9pu+Wfbrn+oEG8dReMowwi7cXNIvTjJXYOsu
X-Gm-Gg: AR+sD10Mkb4Xa7L6exW7bM5o/IFGKXKSChnp8yxdIpmyWAunLPCU4pEJw7go+i9+Xbl
	GH1Ws/gW56LsNBkoCNyPX8+Lb8lASoAn2PLRocTsozQIkTraQXl8t9nkFYycreUKq3/t5DqUQu/
	HHnGQKnt+faBzjJsrBVBsYZCGTYB8SMqJS9fyMM9cCHqOctngmv2LqCB5JHmjRmsg+bO2EFaO2W
	m2OMyRKgNOAoTrCp6fl9q2vq9+CWIfRmZ6ETF/4s9EiFd8MYyAt9LbnJPqXW1sEKBs3JSbvbV+E
	2Nvu7dcIOEx42OMFLkApg/zbZ3rarZ+TY3D1Cvf9nX3nZSBBTRC3xB9gMnBRjqFqCT4+i4f2BWa
	7r/bsUaisDRIGichkvp47UXqN2wnKSURyRkx431JP6l70SAQ27HJNugD+nfdzN9OjnKFy3J9vlk
	Jx71svleuX1uRm5dCcUBqVhQWRk/e5kOAV4OfEE84kKxbPzwMX64znjpTxP+7x0P+SDr7fnil0l
	oot8vqh6DegTJsulBYXR744ByF46ADZzWY4ASF12vbXRZwjCLgLp72TQwXhU5JmokWgTtSkm446
	JuRCjZo8L183ELT+HbV232gls5rmzZx7iYE4
X-Received: by 2002:a05:600c:8b35:b0:493:f6c1:2f09 with SMTP id 5b1f17b1804b1-49573cc2b80mr65063365e9.6.1784890470213;
        Fri, 24 Jul 2026 03:54:30 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:29 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 03/13] t1006: extract helper functions into new 'lib-cat-file.sh'
Date: Fri, 24 Jul 2026 12:54:14 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-3-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Extract utility functions from the cat-file's test script
't1006-cat-file.sh' into a new 'lib-cat-file.sh' dedicated library file.

A subsequent commit will need these functions. This improves the code
reuse and readability, enabling future cat-file tests to share these
helpers without duplicating code.

While at it update the style of this line to follow coding
guidelines:

. "$TEST_DIRECTORY/lib-loose.sh"

to

. "$TEST_DIRECTORY"/lib-loose.sh

Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 15 ++-------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..7c2e877016
--- /dev/null
+++ b/t/lib-cat-file.sh
@@ -0,0 +1,16 @@
+# Library of git-cat-file related test functions.
+
+# Print a string without a trailing newline.
+echo_without_newline () {
+	printf '%s' "$*"
+}
+
+# Print a string without newlines and replace them with a NUL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 762c77c351..0c1dc0fb40 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -3,7 +3,8 @@
 test_description='git cat-file'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY/lib-loose.sh"
+. "$TEST_DIRECTORY"/lib-loose.sh
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -99,18 +100,6 @@ do
 	'
 done
 
-echo_without_newline () {
-    printf '%s' "$*"
-}
-
-echo_without_newline_nul () {
-	echo_without_newline "$@" | tr '\n' '\0'
-}
-
-strlen () {
-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
-}
-
 run_tests () {
     type=$1
     object_name="$2"

-- 
2.54.0
