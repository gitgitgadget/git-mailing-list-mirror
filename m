Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664267;
	b=g75Ap24n+rGveQQ9cdjw1+TUXc3CMiihZ33+u04ZYQhjCmxqIRGk/YRBjUDzYt7DZiTt
	 YAIp5TGA3myc0tyPkT9YH2VK4Eno7Vilp0v/pBVgedM9jH5Vh1DmNuUfmLnuiZUYkOYFF
	 ++s6VUFtF8Yg5wgSDOVK7mpPEi590hrd0ylHoyEX/v56BRSfcDGR4LPm3zSLTTNchwT2S
	 e6FvgJFKbVRSPdrbLgRYAtUfpOrlpGoW7ZdtLcj8HZD3bV04fUtn+sprmqwIxVvIVZ4lr
	 CXyWJc5fvYB/FUHgj+kvhsc3VQhZJzpD8J+KTbBCfVfNfnJyOqESrrP3M9Bz7bGXQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Fcc:To:
	 Cc;
	bh=OvGWixWlnWKt/GRDlzgonMDi1BMsFC494MMSDF4PSc4=;
	b=ZQRxAfMIcNNuyNpVk3u6nAR44Albl/RKhLTHLYXoKe7Xoa9nqoWU2+ZPoIk6PxaRtEJa
	 fNyiTTobOzRgLhCaSwiqERUtq9NK0tmNE8encyt2VLnfar5BGdC+/e4hcF6KGdf3I08FU
	 MelJkeqvIKpTT+l8asZZGMmkx9SGVmQLrz9bwDCsIp7Nh2u0nLVmo1qsp+NsLXy6TxW5e
	 m1Wr+z+ZW3jlv0r6mhuA+e0hwVniMa57cr0QOfMKwN0sAfzfbgNlthlFFFbr9+wLGQwRQ
	 yUuONYvOfziZxHuCTTBiH+XddlthrrChDfCd2n1npkMY4SmY/Pyc9rNpZYaJSmdckxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sRR85p2A;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1C606A321
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F1C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sRR85p2A
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-71af0656bedso4066383eaf.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664266; x=1796269066; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OvGWixWlnWKt/GRDlzgonMDi1BMsFC494MMSDF4PSc4=;
        b=sRR85p2AgooGVeBkQXoXC2eGC+N9dYIy+H7fXAWF12CgDVc2vkaJfnsUQFwJD04EZO
         +jOYGwib3DrFF8prNecn/SbOfpDo6SzBt8H+dNcxa/Gylv+8k0DvWTVrUZ6gd/UpyAlD
         R4shMWeEwQM/MQW251Du4pay6hxNIOlRj5UmAs/fNVVIQexAhb1LhbZlBl00PVvfhpOb
         /0R8pFWoUJyjdKSGFC2EL3hDFudm9cL+u+hhHDPrDgGKB/nBKwd7FF/qbw4qE9p7qZvC
         hzIlTbsp4cxEvLS1+zmWTdJf79b4PISDkrXtjqutIqJVDIrkatJc0Yp/qYv35DHsCWMN
         jy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664266; x=1796269066;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OvGWixWlnWKt/GRDlzgonMDi1BMsFC494MMSDF4PSc4=;
        b=yS5Z47xBLjJK57e7fM3z3t2qRLWUVype1hUdhnKNU+xsG+Go10GX+JjUDMwD7/Ngw6
         QVEvUa8r42fTzR7PJOx/btAZZxOP4Dlyohy03mNqt0ub8KFz9oCt53WSc/XttbU/DewF
         T3VdfOKSxFYp5/ZmVhYmcM+qKht0tB+zzo5bP8yXRkJbQP58KTN/YiC4LyafKkVzvuIf
         8pDH0kkE+gIl9ed4OhYdYUyGnxogjg/cRDuefqXm/idyk4KtJu9zTjpzyHxugIwqoAD9
         TdtarD5gYkhDFN8wmkIUXXR7SHrRiM06dSL/a5HllXcEWOhDIZHpJ9Abovi9UplZE6k+
         5ong==
X-Gm-Message-State: APuU4Z/Ej785dLfulB4VB5fm6eCPoc2ta2KJTHqVIRXDhDATJjUhn4Dz
	uYStLuuRAWCl5UcccwsHT8mj80B/fsT2XKTbJr+uAsI+pvSYHm/DAnJzNZ5MW1uA
X-Gm-Gg: AZFdTZciysFxHtyzsTnPhDtnGS/dLbRK433ciKFVqQSUNiB0TFCsCvm6yflk08l/Xya
	QLllSXH4Zoq9bN7PBWS5h94z23KwcKwJr0xJUzpW3VoW3hdNJKL71u55zfNSHDKXCjoNs6C9QZW
	K1mpiQ12/FHHfQDl2e/4EHmeVRrFA0AjYO4yACE7Y+Qg0Ci1CS6Z7fYzEf+EhzACyOlWXkoXwqu
	Cpn+HgDtu+q0Xn0ZaSbItIjZ8QLK2R0Hfab3sVt9pAGfiDbx2tVI2jEDVJvGaaOBJpMODdyqWXH
	zPhIkBku6ipbPGEg3Gk9uGcnaXzFx50a8eyIaYcJ15rnDuNfc8Y6Q2Nf0yv11z/lhm4hxK0NB2l
	/cpL+2ctWrZNEgAwSvl0Ab5yOKyvNalV64pcDdvVNFC6JIJVaUqo99XCDcvT1UC9FYB5wOAqWUN
	6b/n+ZIkdWuweiYjz/CEibcpO0ZzA/6ApiloUyjw1rfFCDizAvrreI35cfbfQLO9ey3f1uIf9i+
	m0AFlpWAYcxgYyvuwiBmbQC6y/VpeX1mgGOhhMhCNEoXp1wUS2lrXz2lHej1phMhZw01FOkPSqv
	7PTwjoTJW75mbHuIPYLORRGPi2363w==
X-Received: by 2002:a05:6820:80a:b0:71b:81a5:8bad with SMTP id 006d021491bc7-71b81a590dbmr2409830eaf.87.1795664265994;
        Wed, 25 Nov 2026 19:37:45 -0800 (PST)
Received: from [127.0.0.1] ([20.83.55.24])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380bdff9sm13455604eaf.11.2026.11.25.19.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:37:44 -0800 (PST)
Message-Id: <pull.2332.git.1795664263318.gitgitgadget@gmail.com>
From: "Onur =?UTF-8?Q?G=C3=BCnd=C3=BCz?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 03:37:43 +0000
Subject: [PATCH] refs/debug: free the wrapped ref iterator
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Onur =?UTF-8?Q?G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>,
    =?UTF-8?q?Onur=20G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>

From: =?UTF-8?q?Onur=20G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>

Commit cec2b6f55a (refs/iterator: separate lifecycle from iteration,
2025-03-12) moved deallocation of ref iterators from the backend
callbacks to ref_iterator_free(). However, the debug iterator still
calls the wrapped iterator's release callback directly. This frees
its backend-specific resources but leaks the iterator itself.

Call ref_iterator_free() instead so that both the resources and the
wrapped iterator are freed.

Add a test that compares reference iteration with tracing enabled
and disabled. Without the fix, the traced invocation leaks under
LeakSanitizer with both the files and reftable backends.

Signed-off-by: Onur Gündüz <ogunduz@gmail.com>
---
    refs/debug: free the wrapped ref iterator

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2332%2Ftetsuo%2Fsubmit%2Frefs-debug-iterator-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2332/tetsuo/submit/refs-debug-iterator-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2332

 refs/debug.c              | 2 +-
 t/t1405-main-ref-store.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs/debug.c b/refs/debug.c
index 639db0f26e..96bf9d55d3 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -200,7 +200,7 @@ static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct debug_ref_iterator *diter =
 		(struct debug_ref_iterator *)ref_iterator;
-	diter->iter->vtable->release(diter->iter);
+	ref_iterator_free(diter->iter);
 	trace_printf_key(&trace_refs, "iterator_abort\n");
 }
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 6d8f401a2a..e414b61c10 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -55,6 +55,12 @@ test_expect_success 'for_each_ref() is sorted' '
 	test_cmp expected actual
 '
 
+test_expect_success 'for_each_ref() with tracing' '
+	$RUN for-each-ref refs/heads/ >expected &&
+	GIT_TRACE_REFS=1 $RUN for-each-ref refs/heads/ >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'resolve_ref(new-main)' '
 	SHA1=`git rev-parse new-main` &&
 	echo "$SHA1 refs/heads/new-main 0x0" >expected &&

base-commit: 03b41523c576f26ad34085378717a0c1b287470f
-- 
gitgitgadget
