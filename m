Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E944065B
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264406; cv=none; b=Ysu4svsKj9hr8K6cnpegMHiFkjUX0UUitTN0Ni674s8nWPaa2muJyvJtfFS/FJdaVEA/Z8A/EHiOB8ZX1x50bpWlJtgdnGwk2TanN8UpNxO381WKbQjws0Rca2HLbyN+3bONhUnYZTj5c2zZsPXipeXXCGgcQqKckvRjSA2eBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264406; c=relaxed/simple;
	bh=/bEdJuoEbLB7KmKiZ1w/gkBUk4iW2sIo8Bt5klFro5I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cjwqpPTEnKrrKLBgNSWkAj6IlpawRYXy+iETWu8blZq5NvG27mWs1m8t3zES/u1OfJ16X0/fdefTK6RpfTIQ/kY8TlJW6TgOwN6L822IksVo9vcDN3Cor9zMDgdfkPTPADoGn4CK5OaWeGg27GPqB+oY4pa3EA8PiciVdjZfnZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQDoJwQl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQDoJwQl"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-908934450cdso2987046d6.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787264404; x=1787869204; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UAwOSVABDSSM+7aFSTuWKbFDQArR8WOeaXduzdpUAJ8=;
        b=UQDoJwQlDmuiX+ynwebdV4vsd9Qoyw57Qq1H4/Gw96YkvmSZpuOpFsSoUy0ifm0/xr
         kdMnZkHQDdAIvyZJQg+qTkCJJUsUfSsg7d/v8ahcLP1szOZL7XGVQNqbDI+eRRNX+41S
         p0F0F5G1V7o1mD6SlYySGdfxmtikLxlFDcYxLVQ2oyMwcpwMuN9Xo9DET3EdzYUYvCJf
         eqXzZPfNDNYoAt39bMfKInAb+44M66W6KbyjFNa7T+lGyQ1ZxNMPXXlWJCnrvZ6hFW0Q
         ewDgYgvazGXJqbbELuB8aztVghaTWJ2MqJrmUTtY7xzlOLxyLLVN2PZ2xHdG9ckZu6L3
         xR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787264404; x=1787869204;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAwOSVABDSSM+7aFSTuWKbFDQArR8WOeaXduzdpUAJ8=;
        b=pfxZxwRjD7DdgW1UWsRoHPBQ772aDf7B6yGxHDmtbQ+TTwIreN8N1S/rGV5ZoEcfl/
         Wnynp32AmmnkemavdfNY9HTfgcrcmT2cdBX50+Ew6QvU1JaAn+8pFsXvUPKszqptMIdZ
         AM6F1CXAmpPzkQkZKtXzYaJ2ANGKm7FSOjltBAt+gAyEnvDF9y5mv13AZ5pApsB2IbZx
         zMA5MOhaqqV8PYA6roxosHAIleFY3LGyn/tKLS9Sladz3FNBF2/hxhcsGvviAdRTZxuU
         c4huxiGAMk5FYqOyUoEm5sPDhBnI5/g2j0oPfuApGimjACUUHm5TtLfZyPRB7OHzBWec
         ER5g==
X-Gm-Message-State: AOJu0YxWVsn1r5gSEg9qgetowQpvm5XATrv6TMiB3YgOl6g3IyNcVzX6
	JCnrmNtFVaVksMNF1bag55OBadNtPdICvxcy9TRU6CZP5vyzKNWknerd+87f0A==
X-Gm-Gg: AR+sD11B2eN45XX7LLbrFeP6RjVTBqCfoxUN3DXTOgheJv4Rr3eUbkAaMJYuRRE86cS
	qvApFSDquHn0VC64TzP09A5OYapYnwxIMu0L3ncqsnNK4qBQV4Sjhe7VL9vsALhiKjofmuJov7Y
	rbQoXq0K5G9eRzmcw/OXVNzHHsnZtKAXRhnCAkqXb5xP5MppwvKEjv0qF+avA99L5GwVnYPmdCT
	/Y8EaWXJojLBi9rg3kLWgr629W2lpAWSa95YXTaMsJoITpFQf0WRdMWN0fLPUex9EcjpZSABlSH
	61PYiMXadrQGZK0dYFqZDqqRDOgq155P+frFUhseh2axHBq7Klu/G2nwOwpLzBi+h+jo9/mITxX
	zf459XgvV1VYKBdPMMCMtt5DZiOEP7QmcsxJxHZYaWZVyKgU1ag3rB58nqgjdjfKCbGQDrR4DbN
	JVvxjyxRvD3jVPx2g5BY9ykFRAUoXKQJqrEqU0t9fxVbqwykaT6bq5mscVIpdEGDgBqg==
X-Received: by 2002:a05:622a:34f:b0:50e:635b:5579 with SMTP id d75a77b69052e-52df5716191mr17009771cf.19.1787264403412;
        Thu, 20 Aug 2026 15:20:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.109.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd857b6b1sm39372741cf.3.2026.08.20.15.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 15:20:02 -0700 (PDT)
Message-Id: <pull.2204.v2.git.1787264402361.gitgitgadget@gmail.com>
In-Reply-To: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
References: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
From: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 22:20:02 +0000
Subject: [PATCH v2] t1401: check symbolic-ref exit codes and --quiet silence
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>

From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>

git-symbolic-ref(1) documents that reading a name that is not a
symbolic ref exits non-zero, and that --quiet does so silently.
Tests such as t2020 and t5621 already rely on "symbolic-ref -q HEAD"
failing on a detached HEAD, but none pins the exact exit codes or
checks that --quiet actually suppresses the diagnostic.

Assert that a non-symbolic ref exits 128 with the "is not a symbolic
ref" message, and that --quiet instead exits 1 with no output.

Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
---
    t1401: test symbolic-ref exit codes on a non-symbolic ref
    
    git-symbolic-ref(1) documents that reading a name that is not a symbolic
    ref exits with a non-zero status, and that --quiet does so silently
    rather than printing a diagnostic. This exit-code contract was untested.
    
    This adds two tests: querying a non-symbolic ref exits 128 with the
    usual "is not a symbolic ref" message, and --quiet instead exits 1 with
    no output.
    
    Test-only; documents existing behaviour, in the spirit of 919eb8ace
    (t1402: check for refs ending with a dot).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2204%2Fnikolauspschuetz%2Fns%2Ft1401-symbolic-ref-quiet-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2204/nikolauspschuetz/ns/t1401-symbolic-ref-quiet-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2204

Range-diff vs v1:

 1:  345e664a52 ! 1:  22694da869 t1401: test symbolic-ref exit codes on a non-symbolic ref
     @@ Metadata
      Author: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
      
       ## Commit message ##
     -    t1401: test symbolic-ref exit codes on a non-symbolic ref
     +    t1401: check symbolic-ref exit codes and --quiet silence
      
          git-symbolic-ref(1) documents that reading a name that is not a
     -    symbolic ref exits with a non-zero status, and that --quiet does so
     -    silently rather than printing a diagnostic.  This was not tested.
     +    symbolic ref exits non-zero, and that --quiet does so silently.
     +    Tests such as t2020 and t5621 already rely on "symbolic-ref -q HEAD"
     +    failing on a detached HEAD, but none pins the exact exit codes or
     +    checks that --quiet actually suppresses the diagnostic.
      
     -    Check that querying a non-symbolic ref exits 128 with the usual
     -    "is not a symbolic ref" message, and that --quiet instead exits 1
     -    with no output.
     +    Assert that a non-symbolic ref exits 128 with the "is not a symbolic
     +    ref" message, and that --quiet instead exits 1 with no output.
      
          Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
      
     @@ t/t1401-symbolic-ref.sh: test_expect_success 'symbolic-ref refuses bare sha1' '
       reset_to_sane
       
      +test_expect_success 'symbolic-ref reports a non-symbolic ref with exit code 128' '
     -+	test_expect_code 128 git symbolic-ref refs/heads/foo 2>err &&
     ++	test_expect_code 128 git symbolic-ref refs/heads/foo >out 2>err &&
     ++	test_must_be_empty out &&
      +	test_grep "is not a symbolic ref" err
      +'
      +
      +test_expect_success 'symbolic-ref -q is silent and exits 1 on a non-symbolic ref' '
     -+	test_expect_code 1 git symbolic-ref -q refs/heads/foo 2>err &&
     ++	test_expect_code 1 git symbolic-ref -q refs/heads/foo >out 2>err &&
     ++	test_must_be_empty out &&
      +	test_must_be_empty err
      +'
      +


 t/t1401-symbolic-ref.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index a2a7e94716..6fad83ade8 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -38,6 +38,18 @@ test_expect_success 'symbolic-ref refuses bare sha1' '
 
 reset_to_sane
 
+test_expect_success 'symbolic-ref reports a non-symbolic ref with exit code 128' '
+	test_expect_code 128 git symbolic-ref refs/heads/foo >out 2>err &&
+	test_must_be_empty out &&
+	test_grep "is not a symbolic ref" err
+'
+
+test_expect_success 'symbolic-ref -q is silent and exits 1 on a non-symbolic ref' '
+	test_expect_code 1 git symbolic-ref -q refs/heads/foo >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
+'
+
 test_expect_success 'HEAD cannot be removed' '
 	test_must_fail git symbolic-ref -d HEAD
 '

base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
-- 
gitgitgadget
