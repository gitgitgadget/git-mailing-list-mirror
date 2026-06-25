Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD23E025E
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389627; cv=none; b=hL5NK2Ngg9Q0Ijwn6B+W/HKl1p/EwTKCV7Htx/vZaM9pgj/dPiTcTtclkCtXuU0K92ZcM0HQg6l3r0TOu4J9xNuezEKh+KgrOYkQuRSvOV27xcQd3JBezmpxsHY3PJIT9Mr8yJMpCa261BTA+W+lacPajV3w0uHZA6N2Q8zX3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389627; c=relaxed/simple;
	bh=NqC/tWXKw4FvqivuIGbuBqiaRZTxWgADKEFuFio4fcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfLfdfGPPPuSKhZH46QU4D4G3FYvmc98yQgrMH+2OvipyRRiyPVXjOL56nC23DPByq5ZiL9msMQ8yREYvmnc2kI3BvlwY3m8L++wHjr5qTROTveFQbxUEXOINNR17kiuEBdWqN/14eYh3a9DFfjTQ5eq3PZr3Fb28vTmySrvDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6XcjESl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6XcjESl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so10620725e9.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389624; x=1782994424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HobZO5K0EMIbo5BbImKFcwAe1pm6qzGuXqP23pd1CGA=;
        b=n6XcjESlV0dKb9B8bfNYBqysuJcp9IqJhqLFPYXgdsMsxaQgyHslMN2cypgWMltjJ1
         e9iR3r0YFeO1tMpoYINJLmFTy1euDVHY+kViaKWZNLd5/nBoMpXg64MtvYtq3SUOFQmh
         +KaJOhyDHO7CApFmS+/iC6/7VLZaABriYnMI4/Le2l3f/+EEsqSKgU2ci5ryXbeIEINk
         XtLt3+CzBVXQGcszlvCSBIQ3BiHu2FH7KQRgmWlxiA4xiBjGsTbo+ARmonSerHoEEoY9
         7AMb7+NI/yR0jMCPVCYq+tjnqaMLqTV/O/JbXMvMGR+DqPnPiJQcw6MWzNcGLUgZ4CMq
         49qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389624; x=1782994424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HobZO5K0EMIbo5BbImKFcwAe1pm6qzGuXqP23pd1CGA=;
        b=TFjyy0oNZxX9nj/K5HAhtHWtzch9HEEiQGAtzxzHtxURRAOYux8FTDTowsyMsljBj6
         l9HUyTK9KYC7hZpvYyS+7tbdGeSZrpPweQd2F6bGGAnvEvdKgvMIi190FkWXMha5EdQv
         vd9zZ97YUHuR8CnO3J0HD6mt96yOoKD0UgcRBZIbhURsrCekcQ6pTFTfqDeLwz2Dm90T
         413GmzkobxN4nqCYr5sDrGPS6zjU/5cnTbkBJhWw6XKN4uk7XVKKciEycbcpsllaw4rv
         wZxzqvTNMT9wD3r4FgHXcCNu59KyXt24XpWOfGlEprOtR8imnYC9p10BMenzPwPTZdn/
         mhGQ==
X-Gm-Message-State: AOJu0Yxbt3aI1DU9X6Tf4ovYoG+ibHgqKFaACN5+wC04AJzrf/9TT3hG
	SC7RGT78s85FV69SMOFHW9QEyA6PNnKX/oVjSczmgndY63gWMK5qamY8QdmgMUDp
X-Gm-Gg: AfdE7cmnaA2zcsZWgs7jVELhrA9ixlrAwMjnp1UKnjl8v6Qur75IGbTbIwoMTJggt0t
	46NCT4BF+sS/AOvvXGx8lQ/KE8Hw9wGWEGZkfhnna1aAoDbwfCiV1YENT/BEdX469JE9ubYktrY
	7pamGnanTaY5y+NZsmTsfJ2xy8JnPg4VO8AgRVeCCrua17mvzfno5/ioTj8rbTvHf4wRJ6vKMAV
	UT8hzYRx94qNYqS8eI/tYM6d3hI65Ws/xxTNzHY7WPs2pSBaPsu5sbzgKbZKjcf5NkLWdBzFWqQ
	AFJo+FEsJzsbuVWiziaC4WhRLIZOGdQ2czlBMCnkoaBR4ajbwgw3Eg5benCJ9+CTyxrQAes8DSA
	tKToINxJXIBmhEf15S0MjkTbkzhy10bMvtUxSRmB280dRr8N0rbR0Ou8v1qcZzXs4uyTBlOlXec
	/hAT9XGeQQc0ImH9PZReznwqvD4R89Q6MwAG5qCxegH94SFosBP1+sGZtDIGYWjNAxgJbm9vAVJ
	VjwRDMH8Q6ZVuUsdaCpGv/o72MoIe7b+jU20xlbrdjjRn3aYTzZJjr6ukLRZo5K2rQ6wHscbk3c
	SiwI48Gy16jcvi4HWsVU2gOyarR8xDkrImwBPLUsnr/H/tNGvOF3i1nawj0cz+mRuB2P//gNFjv
	ZZ6cHSuMLaQ==
X-Received: by 2002:a05:600c:8b63:b0:490:e19b:9632 with SMTP id 5b1f17b1804b1-492664294b3mr26361485e9.17.1782389624413;
        Thu, 25 Jun 2026 05:13:44 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:44 -0700 (PDT)
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
Subject: [PATCH GSoC v14 04/13] t1006: split test utility functions into new "lib-cat-file.sh"
Date: Thu, 25 Jun 2026 14:13:26 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-4-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

This refactor extracts utility functions from the cat-file's test
script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
library file.

A subsequent commit will need this functions, the goal is to improve
code reuse and readability,enabling future tests to leverage these
utilities without duplicating code.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..44af232d74
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
+# Print a string without newlines and replace them with a NULL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8e2c52652c..8360f3bbd9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,7 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-loose.sh"
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
