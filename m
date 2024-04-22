Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB0178CCA
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826450; cv=none; b=B1Leq6vv2oOqvYkJDdGAGLmiBumhwEuHw+gNRcOTGy8o1xDb940jQV/E0e58Y7kiJ5n+zioxl2Aq18t0FzYqNj6itahtb3XFFbrih2zT166slyakoX4aOi0cLMV0fsnShN1bx5+7P+C24NrGhsOjyohd59Dqgw8GvMhNe9QsRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826450; c=relaxed/simple;
	bh=i8wuzEYS6/StxI9LalXfM+qpMIJ0yIco1Q3UPSerKlM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=oOQCPFV9G8llIdQ9Uah/pY70zfkqcjdX7YL3a6dtVNqXHluUyVw1suoTR/Zwz09DMN7rQamBvXfAp3hBv4HsJETNE9toNJLttucY1omfgOf73oWa4nHTQ0akvVZ/wHeIhqIAxk1c/VfQ3i1NvA6/Ww4Gm/HhPZbgIcffU/oItjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/dJRqBj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/dJRqBj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso12504035e9.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713826447; x=1714431247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM9fjBak0nEzn0YlqL+17ArTt1hQ7pQ5sS4xmUmEvqI=;
        b=T/dJRqBj2eE4j1LlsFb1LUCrQCDIIOX4Y2YqffYLmXSP0YavZRy/9KFV5yI/dIYOlx
         d6pe4/IibS5NaXFKobT97h8iHiHhxWlW3uB74lU03nm9m+XJHm9gpR1u0ngP5aEHjNMj
         NImxuGlFOzUGhd+adk6p3l6l3R0FwP0tWZaM4AUnEYVc+9k74AFNbUC4tmeibXSW7sWV
         0mtZ6CqZeLKLXvQjy062ccikizgeHYcOx1njJyVkYsvmu/eOkSR3qRFIBfHkWZgQLiOz
         tgHAaIvij9gnUfIMj4xnhjWGfm6OVjFrKHH8BWU3n+tWR/O/I5/VTyE/8s3NvgEJIa+z
         mOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826447; x=1714431247;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM9fjBak0nEzn0YlqL+17ArTt1hQ7pQ5sS4xmUmEvqI=;
        b=R1LezAHt8Tnpswve0V9+QnDW1qnWQCKMVZveU9YYDrnmUQz3g8iohqedvFKLHsenMf
         bEIquth9UKBB2XS+vOCVCHMClwGxCkDBujWpHTGuooZ6KeZptXfW4cq2WFZ7Oo+cf2C0
         YR9ghJSsc51VvbUteOW0RYTlMYLf1zr2eClsk/VBkTytmKbui/oeCO05HdTtr0ccqpWT
         tD5UzZ2BN/c+2i7yiXPJd5dOx+qRKUgFIjYSl6Q9cHRtDFDkkIRFSfWKcCPaWeFHY5px
         PXPZIG2R35T37PApzBKVjpR6WSZABMZQl8ARSmxSpkcVIj4vhiB99RSL/ZVGaVEdNF3Q
         P4fw==
X-Gm-Message-State: AOJu0YzAQaqErHDNBqyGQVS1BpGoaSDZe7S9edxvbCpWFrxGUAX+pRXk
	cHcW6ieMruIhszUWZYhycfsG8sHl8Z6kRYq4KPvAJzjraBuL707maRP7Lw==
X-Google-Smtp-Source: AGHT+IEn3KP+Ipb0ZJ2XzZlKK7TlDlxQ0QucMeG+ep1mGEjGD6UEDBgsAQZtMkTOJxXTImrmCC7IxQ==
X-Received: by 2002:a05:600c:470f:b0:418:c1a3:8521 with SMTP id v15-20020a05600c470f00b00418c1a38521mr8222833wmo.26.1713826446848;
        Mon, 22 Apr 2024 15:54:06 -0700 (PDT)
Received: from gmail.com (247.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.247])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b00416e2c8b290sm22082853wmo.1.2024.04.22.15.54.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:54:06 -0700 (PDT)
Message-ID: <5e97fd0e-8aca-43dd-9f6e-a8cb28fa01b8@gmail.com>
Date: Tue, 23 Apr 2024 00:54:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/4] apply: plug a leak in apply_data
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Content-Language: en-US
In-Reply-To: <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have an execution path in apply_data that leaks the local struct
image.  Plug it.

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
2.45.0.rc0.4.gfff7e48949
