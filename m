Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300C346A13
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411413; cv=none; b=XTtrEo5ImE3/KVYUgjTYOpISCuoFdTzHvPOEwqoRgzohVXDbaQg3h6VaR5Pw5EkdHUg5y+6mB/uF2ddHTzTlPXPbZ1P85YNGW9H/izma+celB3cLOhb+WII5HO5JiGKyEjg2lb2eAgG/DNc8wlGwpXk1ivT+F0uLnNPNc4tI428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411413; c=relaxed/simple;
	bh=28lTF/ifyxrgdadUS9u2NqYqbwnbxbAIOg6GhAfrNQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujmj/LYKrScPkscH882fzHdLszVOpqTMUSwc78pHPWVGQlby7A57GJSJH6JDH8HIt7ZEBanTiRhIate79HsPvlAFI+YmVCTbsgjlA4C9nERYrworlyubE5+7v+zZhLbr8Qr+pZnViVRC1h/r9TKH9EMbrBPRVV5jFhJLHkJWdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvWzySFe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvWzySFe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495590ba856so524135e9.2
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411410; x=1785016210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aguJPFOuBRD1FGqAqH+g2i2aIRYIXaBJfAkzQOYH1Ns=;
        b=LvWzySFei7EqKkSb+i+D8E/ULLuy9rsQb3RPVJdP24WL95IxDH2YJUg58iKbVEVgz3
         bTO3QBwvVdkNcNBrI2GB2A3Jy3DKt1zuTX7OAIoHIqsdLyThQYF/3xQN3JirB01g4KrR
         s4uZ7ArYJBXMRWGRmPe968SAJ1b64NUVm8dcZIPfxVxNQSGM+rDl5ayxsCiNhtOCjhF8
         hasdZWEOq1N5XmhIH2mC18yC3Gy9peehx+x/xbzTfINg5nK2hTV4nhOTKAs1BykphOZw
         6TIp2vm2co/jCkopCkp/mXN5ifnWqj7ASe/xN4qEEWQARAQ7MtEQ1lowamB9JLOKc+cX
         IvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411410; x=1785016210;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aguJPFOuBRD1FGqAqH+g2i2aIRYIXaBJfAkzQOYH1Ns=;
        b=GGyAhEjOf/HH+JSK03+X0A4Bf3y26BrPBJsAP2uzuWkMkXgru4U9bESgzF++f2lnlK
         HbvnOWmhHAuxHBu88qnGR1jmeS+dksCJzAB/V6QXlvhKq1FX9mbkZv4F6BFklZ2L+Fik
         TyzukqJ0KDTLTxUNb5flxCqtsbyKLApfnQPsBZADJPD10G8nazTG0ZgaegIcjof/EB8B
         izsFpA6uj8d7i4I7dqnLMaQ1tN5QAjyrMkYqy2vWGeC/8hGAD/aT18+YxXNzqM2XhlbS
         rO/KG/73ERN4Zf+xz+B1T+liMQhlVMVO0dB3FMlPu+AmmAekGzq+W4MUJMjwxozGaBns
         f52g==
X-Gm-Message-State: AOJu0YwXx3Gohv0ssfKFl6dELEMW3e6qZEyuRazRa0m+lOibHgW5eKDO
	MO6h8adJr0m7WbUJmZXaH9a98qppI67BsryERLuJRpn4PMEjy00R7ixgcQRimHeW
X-Gm-Gg: AfdE7ckgN+T0XRwgORYlNlhuGCBbpkpKa/7dUoOwKfgpcZCCVscyyHOCzmeBa3q9JjO
	LBeLuOO3c2d28qtj5Zd9oNHWXV2Fxero+P/V1csEjZbUYOCyWPFB8WoIuRdCFcLe7hiX85psVjc
	frXAYbkIGWcR/e1Ck0ILdiPPLzR7ok4r6LLPXi17LA6Lnt26mWO/JEeErufQasLT+aawf/thIES
	kEZBbkBcqytUzoSqbC4IkGFjqt9j7mBecL71V2Z5HzUDr9VRLqbfNwxoNWSfH2vZtCxT+ECn9VA
	sXEJhBSiGYrcpGxa0rUj+4GwLxnBBKCI+WdkJBdGEFZ8HuGGrfjlv0ru6kTaNQnEi8LyjG/SDbE
	CInRwU3iCl7luTMmP0LQKj8cNhrmPrnVCNCdJkcg+o+aOtrz0ThbPi5VfrLwScSiafputJgI6v/
	mFSzANNa6HkwDrNCINUwbeWJcUlCBuUaLJL8Cct3AgPcrmYsWVxD7AmYALJ/+lT7wcpZYpjI3iG
	sVZm0+qHZ15JruFni8zn7CeVys8MFV7IX2ZLd5LuHEry08XovYGVLETPKN3GWi2xUx6HQO7wCVA
	XzcCYP7FAix0xXp9iKKZDH4xMn54Oyxx
X-Received: by 2002:a05:600c:5247:b0:495:573e:1c54 with SMTP id 5b1f17b1804b1-495573e1da1mr14522935e9.9.1784411410200;
        Sat, 18 Jul 2026 14:50:10 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:09 -0700 (PDT)
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
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 03/13] t1006: extract helper functions into new 'lib-cat-file.sh'
Date: Sat, 18 Jul 2026 23:49:52 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-3-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
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
index 8e2c52652c..cf65bfc88f 100755
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
