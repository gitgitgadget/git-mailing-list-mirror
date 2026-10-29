Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284466;
	b=1IXwYTSc5rCGui/xPGWqflgdE5hCfh22+pnfg7JIf9Eo1iJzHF4bNukuIZ9q2sfv90xw
	 KqmSP5ZR8ZXNdCvgagAq4x5zVNgzYBDcdEQyVAS/yjJGUWGGpadWZo9ntyCcCyTbToCKJ
	 dOKixTf0Beae8Ce0y+rfExVAPa7gOFSo+zAD/3GHXgea07qK6mxbZ7OReUVU/Z8SssGku
	 I59fjywIKJ0S5ePM6gf4vFT4escph6oWdkQ/2vILzVe7eysZef6PWEXAe25A9wJH7gjlP
	 vKksOsbdU3wTxovebcyvRydJDc5g3siZKmbt1ksvO+B1Y99aw7EyxL6CiBwDAWIBZnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=f6AAJ4V2LOrWGjB5IVnaWSDBmbtPXIvbUqS1j51iqZw=;
	b=z6X0YCJ7mrUAZpA3qbDx69QajfjXGY3L4ulkWqzp1Z0PtWqnOL88vRvJUZL4zOC2UEAk
	 ee5QurtK/iiCXXgYuqWKYCTgwOXaW8QNtQuK2Qi71xbqVM9sIMw7H1sDB8N7B3uCDpZ3y
	 VAx3vGRwoF270ee0SxIKmX2mVzVJUWVq+mrw7twAyJuPYvXklYInYStYlNyNzO50glCBx
	 4N6H7fkYWfLJ74SngJdgQbMJsqu3hQ4UJF2+/+FdbiCbIa4orlUcnn39KGUZz0xG6P1Wd
	 LfZclOSbjRumSf5ruS9ogbrGYeAw/6IkBofvRQg6gzvXcrBbmA60uTNKMYL7kK/Qz7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dkRPBCNG;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99120606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99120606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dkRPBCNG
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679a420b5afso2042958d50.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284465; x=1793889265; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f6AAJ4V2LOrWGjB5IVnaWSDBmbtPXIvbUqS1j51iqZw=;
        b=dkRPBCNG/pBGH4DNckdsa0p4BEkodrDzyx9V3FRUVy9ZisCiidB5hHDlfHiebm5FCi
         g/TDpNMBw8pM2kuhr52ddwCFyUB6Ut+dz32VyABncy5L3+1PB1L5CKi24n+qTbBq/BIE
         zsZxgW3WksFbH+mu3Pmb7x73bpva7ZtWaoLwX9tYjsCZhy2OkvXSAIThShSZCZyF3hrS
         afzHmqeMFmzSavRW5fA07FvkxsZDLlNjjLd5fxKe0D9pU02cpr7dnzfNp5TGMhX/hTyl
         zEDljv0cfzXgsWsNNMJNEbCl0QvyE1c3cLAtkSljCRZ42nlbCB2aJoUCVOH9QKhIGxJw
         COYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284465; x=1793889265;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6AAJ4V2LOrWGjB5IVnaWSDBmbtPXIvbUqS1j51iqZw=;
        b=oSVsrnE8PFG6FxKv4IrXazqMM3e2ouPAfunrCMmzZfaamdMIPfCEkucw4at2MfMH6p
         hBwxB8sDOj6F6QADCUr29xS5Lp3O2JKmVMxKJOL9mlZmO21FjklqxHhbKjKYQp/XQ5O2
         BJhpn+RA+MMEaCj5KMw/zf5aIwKaJQUPCgz6le8AjWA85f+CH4V7ACEPeH97O3FRAkm5
         /3A3M95est6lkCcLGK236n4Wik2kK5EfJtF2q7zr/2cp74q+CE3rt2iWAJ9GvyKmofAF
         I/pz2mr2ENjUYAyHxtVSJ4gtlDlqugx6S9YnPqdQo/HyVDUZ3MG2qWVJCZojbFh90LKH
         ImRw==
X-Gm-Message-State: AFq9FYI1HW64b5OpJqTlPLqlePniOSlewbarycmypwM2xUmqjezhqb4l
	62WZrWUzZV6v/OY9W3ZmM0gvZastnMVsagX/XWFIWLgbx9/BmuUoTR5CSkTLS1en
X-Gm-Gg: AYBFou0TvJpTvT3U1YyfZNNwoFa5lIyzrE6EC39hS2wQC/yMFIJF6wtf/wnOlnVWOaq
	llcbkgjlFB0PuV/o/70lhwchedJ01ZpQ9O7zD8xucIX7h4vI9U8F9iMhlgP3Uj7pIcWUuC1IYHI
	vrk4Qv/awwM/aW8dWQ9M7vx3J9ro+fD0+ZFiYY4kH6LRKOE+TjJBn/ECMhdIf6blLTsJ/jzKW9a
	SCCuIuQ/qxjqGRXS6Bp4CsmeLyJcV8kh7rJ7q64qoWEcwbvaGcYOBehYVxewEtJbryOXvnYsUXx
	lM4JPhlNhlJYdYf0PxF+bgVQNyJxrdv7LDZy298JQQjyUQzIK6my3sn5kqm1sLILdPXEOXXVIiM
	zQKb9oT2Uh50rWHpQN0jE/FM6kzEKFx47GPAKx4aV6DSQ7q6TiRrS/CBOq63epSanA/UOWUerlv
	G2Yn71p56wcA5pirP/kyojEl2njhk3kU1IquMWn7d00piGlqN6CkoEYTg42ChfEZxiI6GCSobnQ
	XR77Jnpie/dw0EFr100x5//s+KoW/CjUuATSGmTVDB4U5qO1GG3+24Ipq1pANNKOPlMqiqSJJyc
	FGzzld8pr4ENQ8mR3iJREWWv941gQYQdQqo=
X-Received: by 2002:a05:690e:43c5:b0:676:8c05:8426 with SMTP id 956f58d0204a3-67a7bea0224mr2498460d50.130.1793284464413;
        Thu, 29 Oct 2026 07:34:24 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.229])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a10c63fsm3376461d50.14.2026.10.29.07.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:34:23 -0700 (PDT)
Message-Id: <pull.2260.v4.git.1793284463139.gitgitgadget@gmail.com>
In-Reply-To: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 29 Oct 2026 14:34:23 +0000
Subject: [PATCH v4] [Outreachy PATCH] t0001: avoid pipes in test scripts
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith Poojary <poojarysrujith@gmail.com>

From: Srujith Poojary <poojarysrujith@gmail.com>

Avoid piping output from git version directly into sed to ensure
that any command failure is properly caught by test scripts.

Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] t0001: avoid pipes in test scripts

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2260%2Fpoojarysrujith%2Fmicroproject-init-pipe-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2260/poojarysrujith/microproject-init-pipe-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2260

Range-diff vs v3:

 1:  a70ccdf49e ! 1:  4373eef413 [Outreachy PATCH] t0001: avoid pipes in test scripts
     @@ Commit message
          [Outreachy PATCH] t0001: avoid pipes in test scripts
      
          Avoid piping output from git version directly into sed to ensure
     -
          that any command failure is properly caught by test scripts.
      
          Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>


 t/t0001-init.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f271..c8c74f681b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
 		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat
 	) &&
-	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
+	git version --build-options >build-options &&
+	sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
