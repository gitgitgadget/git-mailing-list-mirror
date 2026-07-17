Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2C42BE8C
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300743; cv=none; b=iejM3A0s4nUTM3e8bfb5Q0KpXnWt0fus1lNmVmQKGmt1Vuj6SJfzfiFctKx8Y3bYSdCHAcV3WwHjHPjV6bNynl6LV6UfY/s4+DsrD8mc+OG1fOD7EEV1opozEGaVGQATDA7rK5OXuk1b/lTSXBE74ectcd4yWGF0nhqQg0CKVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300743; c=relaxed/simple;
	bh=28lTF/ifyxrgdadUS9u2NqYqbwnbxbAIOg6GhAfrNQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKzmlJ5pYLhbMyLDOWVK0VDMnib7TT+iZezRsLfBgDFEflkkcHwvX5VPUEFLucwLFWJcn8h7IGPnARTP8qwkjrnX7jI/qs3pYWqBS8we2CzoJi24gEA9tRcZ+FQjbh9iulIMKIXgtFeHlkUtrrjval9VlmL57G18afSLg2jK+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDRdkFuc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDRdkFuc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so34732585e9.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300733; x=1784905533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aguJPFOuBRD1FGqAqH+g2i2aIRYIXaBJfAkzQOYH1Ns=;
        b=gDRdkFucSE4+Hn9vzPoN1qdxci6erZw6kbNFDp/OQFt4NB3zMo9+/xk5qJS3cG4ESH
         CEI3UFGAXb+2G9zsBlKqMBwVv50+kl2xnaz0wHK7/1M4BqhPBF31FTZ50un6QH0aV6hP
         TBGQRrFMzTm3wdKC4RS9x+QZ13yx88NtKPHrk6xKi7HDXv8YekFRweeb/zTPNga0TT+o
         S+jYCR04IcPAIo/faUSgTeSeoncFV/YuN1iL3rmds6JrAtkIBpoKr77lFV7xl2wEB+XS
         QkL/4N313MOeXdXGiQo3fb7uJH0nELMEWjgxnGAOywQJRsvnznRWyTEU+OR10Bl2+J1F
         iFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300733; x=1784905533;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aguJPFOuBRD1FGqAqH+g2i2aIRYIXaBJfAkzQOYH1Ns=;
        b=jh/rl94dgFwXGuVzwHVm63HeTZI4bIBp+99+FQqlAkAKwk05cWKPsKxEoAXBFcQKhk
         OXtW+HjaEIiajdN5Cr7fzwoWNCw3jO/Dq4xz45956HXrK8e94aVBnfP+zKQyxScaHZfY
         ypDQIniitSIks26JFPDJ0pvnYhQSkkc5exgmb1FWMidd0vQcEY//voXPTGRYZ9ZfVE/B
         ewrGgQgAnlIIlsHxZeqMtVhJbRn62VaBo7shcjEZz0+koHhcVs/+YvqJq0rrJdQH46An
         LW6NiqwKsxIYTl4JQxrPDvHvZbqfRXDV5AuCZc8ry4jOnfSPopnBRtvwSGAnd1B328dn
         QbiA==
X-Gm-Message-State: AOJu0YwBSZbiYqf6227/aIWC+IcP7Zy/ELTxvroKBygjTxtNpgWp2QT5
	3x+3NHNevL8SLzA8nR2/3TbdkX5pAQD7MVuJ56xJbxHykZ2smd2WUT1YiD5OJrPM
X-Gm-Gg: AfdE7ckvKdcfh2eIfXF+HIxq8vRk7Fq3HV+9NwF1kYNdFkGxtwqntP06HNRcOz8Mfb/
	ov9u60utImB7zDo31GPsYY+o8BwPyHZA+hW/SlfyrKyJQW4oFfCLleqJUCiqPdCCOCqVqO0sLCP
	TQBFq61AiecUU0+MgsUZjutSpjT8CkyT0tjpf9zeiX6t0Dlken1lrlRI9QuN2a5pgrObt8Ehbjo
	sFlfOS7FMszmkX9B/NpQ6TvhAFd5j7/TZ+YLac7xzYLYFcKLbk5eW8AKoHZ5wQouy8RJbIIMfq/
	YXI07y350na4CnCbHQOIAvOnsCL0gFGJ2IvZW0WzqJ3QfT7qbwbDEd0oySflyhMNiEG94oB9lXR
	lARJ22F2wnSKVcfR2ZNycUD/F4Aoqr5FHYAJN7pcmi4Z603F5oqE1OjAOm4G+Xvs2fbQoC012WO
	z09xCh89CzViiK9zWj0876yvbfZUQnEPK3g54nw0jpSlg3PD78/61BMuxOzPaRbrysLTWBBGzLB
	EoFToEVk8Y5wzR5kUTTlfzAX4/sJPaXJX/QnKzOs0oZg867MXii+623D0c2t67n4eCzqASVwbq1
	dH8v/B5mI0Y980rgrAvbqZi0CPrdTqGHgf8IIDjgkNE=
X-Received: by 2002:a05:600c:548f:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4954d003084mr19456975e9.12.1784300732761;
        Fri, 17 Jul 2026 08:05:32 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:32 -0700 (PDT)
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
	toon@iotcl.com
Subject: [PATCH GSoC v19 03/13] t1006: extract helper functions into new 'lib-cat-file.sh'
Date: Fri, 17 Jul 2026 17:05:13 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-3-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
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
