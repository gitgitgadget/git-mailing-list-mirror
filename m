Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E7DDD4
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713695306; cv=none; b=Mc7SYGBDRe398PfisufvZOs1iuns1U6ZWDwXab3MMglG5C6VX4KUO/hclPbJzVKN2d5JSBAdkxtKtA7I1/Q1P6wBfN1qlT4zZ33vTsxTSx+7h2m07bSXii4RLOxMOqM6Y0AvwbveqZV64pEdzhdZxE7oNN9sg84Tep+xQW4kubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713695306; c=relaxed/simple;
	bh=7EjVL1I+Zdi+UEhdBJwyms4pzpOSS11KZMVvnY48CwQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VR8biQ88mIGk9kX3IEnmFQ+HP/Ggd2lWNB3cYsNUDh9206PomsCfU1oUkc0rJuOnO9jxZ4uqCNR5lBCyxKtXJo+7AGtVHwjttgNvdgg2L1iAvKKUSPeO8bYnGS/LRmn9DmdWJnc9modka6A8FhvzXHoGt6F76piM29CO/SiJ720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+L6riBS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+L6riBS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so18750995e9.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713695303; x=1714300103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+CjjcIk6rniiMW6tVoAaEk2MlZLZ27JdZoV3ipmpOc=;
        b=V+L6riBSfP/ZA3JznsdfTXwK82RTch3tKykTfU5IXkTE5hG+PhN1yvr/2eGpQOojSf
         jT3Z3qhoMygU6H0f2HIJZqTQLbcXWe/5YVbH4pPfplb4B+Excu/pW8anp0AddVCtkh5D
         zmJJ8PS8cZI5rRRevj/5uI7biMJzBbbv2v2L6pmu1KOPONgmmeB+6QgoPrm5x9ALsiOT
         v4UC5fkg88c9P1klr2GqvdP07jk1hpMcPgxNh7LItssPV6PBXdYY3bEaVIL8NqR+DAX5
         ncUn4IjLfAFZ9KOa/YWMTW490WbF/K/Rc3DLVHpPkkIZgH78H4ir/m84tNcKJqJpPuvn
         cMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713695303; x=1714300103;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+CjjcIk6rniiMW6tVoAaEk2MlZLZ27JdZoV3ipmpOc=;
        b=Ldv0SRtXKLpphY76Ssv4dWf5FzyoX6MPVECZJAQ7fg2rsFubbrMmudQCeILwnaRS1j
         ZWEwSrjrggAEm52sAtL9qqjKo7Wtbii3Sp7bFCbneTf/cvKaQqxZDEZfm8NjXPGZQBa3
         9+vKv557su4Z9b+1mfeNKcddcU2neX4e5Xl0YxjuXpoLcx5eNCPS55j0I3xmvbyg8/NS
         p9JjUvDTJLz6ZCPOCUz8V634jrqUUmCNnGPvqlhYojnCbag7ysboemBXvXFGaJJovdn4
         G6ZbMjtTgDfj4XHdo1RXvxRV0uzHHnnnEh78YSYsj0n+h1T0Ubxb8l08xFNZzacUJT1/
         pmBw==
X-Gm-Message-State: AOJu0YxReooutGxyjQ1PONzAfdPRWq/VlJUFh3/VerIIq5unZ7lH18BU
	ZjZosPuvdxZa6tNTp/GKybFVWLbrjF4Lc3hWvj+Ri5u1WYUDXOQXxrfXfw==
X-Google-Smtp-Source: AGHT+IFrOfhw/5g/3JEt4NcbGiDIUKTSjSOR0T/QJJWbi6puBHy3ghChg8GdE9N4vKgQlntuovA5Bw==
X-Received: by 2002:a05:600c:4e91:b0:419:f533:ef88 with SMTP id f17-20020a05600c4e9100b00419f533ef88mr2546328wmq.11.1713695303159;
        Sun, 21 Apr 2024 03:28:23 -0700 (PDT)
Received: from gmail.com (145.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.145])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b004186eb69a55sm12865786wmq.25.2024.04.21.03.28.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 03:28:22 -0700 (PDT)
Message-ID: <8e6ab088-2026-43e7-a869-b1c7185ee765@gmail.com>
Date: Sun, 21 Apr 2024 12:28:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] apply: plug a leak in apply_data
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Language: en-US
In-Reply-To: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Plug a leak we have since cfb6f9acc3 (apply: accept -3/--3way command
line option, 2012-05-08).

This leak can be triggered with:

    $ echo foo >file
    $ git add file && git commit -m file
    $ echo bar >file
    $ git diff file >diff
    $ sed s/foo/frotz/ <diff >baddiff
    $ git apply --cached <baddiff

Fixing this leak allows us to mark as leak-free the following tests:

    + t2016-checkout-patch.sh
    + t4103-apply-binary.sh
    + t4104-apply-boundary.sh
    + t4113-apply-ending.sh
    + t4117-apply-reject.sh
    + t4123-apply-shrink.sh
    + t4252-am-options.sh
    + t4258-am-quoted-cr.sh

Mark them with "TEST_PASSES_SANITIZE_LEAK=true" to notice and fix
promply any new leak that may be introduced and triggered by them in the
future.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 apply.c                   | 4 +++-
 t/t2016-checkout-patch.sh | 1 +
 t/t4103-apply-binary.sh   | 1 +
 t/t4104-apply-boundary.sh | 1 +
 t/t4113-apply-ending.sh   | 1 +
 t/t4117-apply-reject.sh   | 1 +
 t/t4123-apply-shrink.sh   | 1 +
 t/t4252-am-options.sh     | 2 ++
 t/t4258-am-quoted-cr.sh   | 1 +
 9 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 34f20326a7..2f752d71a8 100644
--- a/apply.c
+++ b/apply.c
@@ -3712,8 +3712,10 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 			fprintf(stderr, _("Falling back to direct application...\n"));
 
 		/* Note: with --reject, apply_fragments() returns 0 */
-		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0)
+		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0) {
+			clear_image(&image);
 			return -1;
+		}
 	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index c4f9bf09aa..c40b661ac1 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -2,6 +2,7 @@
 
 test_description='git checkout --patch'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index d370ecfe0d..144619ab87 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -9,6 +9,7 @@ test_description='git apply handling binary patches
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 71ef4132d1..dc501aac38 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -5,6 +5,7 @@
 
 test_description='git apply boundary tests'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 L="c d e f g h i j k l m n o p q r s t u v w x"
diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 66fa51591e..2c65c6a169 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -6,6 +6,7 @@
 test_description='git apply trying to add an ending line.
 
 '
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index c86d05a96f..4d15ccd28e 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -7,6 +7,7 @@ test_description='git apply with rejects
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
index 3ef84619f5..3601c0c5dc 100755
--- a/t/t4123-apply-shrink.sh
+++ b/t/t4123-apply-shrink.sh
@@ -2,6 +2,7 @@
 
 test_description='apply a patch that is larger than the preimage'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >F  <<\EOF
diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
index e758e634a3..5b680dc755 100755
--- a/t/t4252-am-options.sh
+++ b/t/t4252-am-options.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git am with options and not losing them'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 tm="$TEST_DIRECTORY/t4252"
diff --git a/t/t4258-am-quoted-cr.sh b/t/t4258-am-quoted-cr.sh
index 201915b45a..3573c9147f 100755
--- a/t/t4258-am-quoted-cr.sh
+++ b/t/t4258-am-quoted-cr.sh
@@ -2,6 +2,7 @@
 
 test_description='test am --quoted-cr=<action>'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 DATA="$TEST_DIRECTORY/t4258"
-- 
2.45.0.rc0.4.g08f77eb516
