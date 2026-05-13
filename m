Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62C3B0AD4
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707142; cv=none; b=K986UK/aj3bp3pEjFB9fdUkKBekjBOEpcJB+/K04x1q0XMzDpBj+PIWKvBGeqI3+lTufU17kj09DkgBh/FF7kxvZ3tBh/lTLaBqo1ORE5XgxLr2fiXeX0QcavLacaQz+bTd2a5BZBdhxXPXa/uL1rlM1FkQu2fH8v7h/bUkRL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707142; c=relaxed/simple;
	bh=aJqsTBenCaaV9v4tAgQ/0ruOMqXUmnnvcvbIHXNB4VU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IDfcGW4cNVZ50IUbTDbja/XWrQmMqHD7M0L4ILDkY4ZNVPfSm1G8OvDFxkIFoCg+cUydl9QR0s2MIwc/1VtEs3EbMchF7uHrG94y0kYZfp4OUSYabEs5P49HWhbaJLRBdmutgLGOAwMBSGWkfUmoZo9uOS/kVf9U0G4x+kSYalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL2qhu2L; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL2qhu2L"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso891892eec.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707139; x=1779311939; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTGmM7qTm5jewS8ssjhnMwqu31YH5UBJAn/TQKx3yJg=;
        b=EL2qhu2LYJkyi08QpXS89X4WKHXMi02CsPkOLshMufseLkkTOTcluuY+E/l91rVIPI
         J7KLnObyxbc4HZfyqTJDTDwGnRdX7BsA6lsJh2I5hrb/HjnS4F5g5ygLNblo+vyT8Kwx
         7PxGcZgoHooWAlHqIU8adeeT5DPyGdk6irXVSeaffx4drCMxKI4U0nGoVm5pMByS4D6H
         l5KMG9LfpAU+o62F55dZ394CQ+xsqJiWdNSQot453u9MTun3NXp58ibijB28aWjcjk8R
         80k0JY5xnicXDwzN0HjQIKYuCio4DllWBoeg229ZxgsKvp2exlL75dBM0bIzrJ1rUpvy
         tH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707139; x=1779311939;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTGmM7qTm5jewS8ssjhnMwqu31YH5UBJAn/TQKx3yJg=;
        b=RDyNto5itfC7Ov8ADIRknulEOLN4hhtYRQum/4EByHvc1kyFWWnDOuyseQU0GyboKW
         mZ700g+wWGOqVbl6ghpBF5Dy2eV4e93dkhsHF9E2bF57nW3QcNNtZQsuOdc2tcjUbJ5r
         OFFJOtOLXt248hO4iYGkgEF085wbhmfQiGbIEKq82DYYG+gIQ3KQlzeoPa+EnvmEr9x2
         nbNkjW/n2mGwQDx56XxbnoJuhNAPlVN+JK1D8TqRmnl66jVSaDTmeeSWIr+HZMsISM6A
         I61+XldB7HK+IGs6n06X1ueu8xUZVXq8C/aUJyz/NUkEGEh37fq3dg0jHXbqvGxzwDWy
         uKew==
X-Gm-Message-State: AOJu0YzVZvLXl3h7C2LtcnL0ndOtB3qq3vhkLeECezPyh5+oX8RtDzNO
	l8xefC0N89mfTHdfFI2pPe7XI03UN0i1CtZC03WbHsSUk1E3qRFlG+NMuPNkKw==
X-Gm-Gg: Acq92OHLrxunUETOT2LK7Aqaq2RyctgSk9+VxcLEuNCEDQenu9KXgKOOZ01Qp08BlSE
	jjILuuSJqvU9U+cJ4wYDfW0pLMDkQhTGOW2ZwTTes/vw67MRHZOYxSDZDAMWSPCfYES8fby4iqH
	Uwy4dYz3zfN9V1TeYh36EGfztcNMyL4v0zGLqo7VHwM30VT0u+0bYwUvzVXHqasKdjHu4NPbYDw
	Tp9IouRYzTJ7IeHfzK9gA95aebn6WpY3hyoJFxgsxL0LJqCb2w70uFjoAUukBfW1/GlKRE2iVMu
	ABUYISNYopcZ215bD2YoW+6gQZkhptExHfhSBChjNololswQqoAuCIN4XzdUAs0URC+eQ0gLbMF
	GaZ3qOVx9WDgRmk+2E8Xk0/EpX7KGILQZxOtWD7PtIrwxPP1PkavnLGm9wFx3/Ru8GHwTq1/kfj
	Ay11OQVWmnQ0FHTZI4WVBT2V3DrjIKJP64xFKZWDXDWhjSPZw=
X-Received: by 2002:a05:7301:607:b0:2d9:6373:ad10 with SMTP id 5a478bee46e88-30117faf29fmr3274374eec.7.1778707139206;
        Wed, 13 May 2026 14:18:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm481712eec.26.2026.05.13.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:18:58 -0700 (PDT)
Message-Id: <0840110116a967d39d8b63dbfe822ea9b2500088.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:43 +0000
Subject: [PATCH v4 01/13] t5620: make test work with path-walk var
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The GIT_TEST_PACK_PATH_WALK test variable allows enabling the
--path-walk option to 'git pack-objects' by default. This sometimes
engages the warning that --path-walk is incompatible with the --filter
option. These tests in t5620 fail due to this warning over stderr in
this case. Disable this variable for this moment until these options
work together.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5620-backfill.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 94f35ce190..e174290787 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -298,6 +298,9 @@ test_expect_success 'backfill with prefix pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
+	# If we enable --path-walk here, we will get a warning overs stderr
+	# due to incompatibilities with --filter.
+	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- d/f 2>err &&
 	test_must_be_empty err &&
 
@@ -315,6 +318,9 @@ test_expect_success 'backfill with multiple pathspecs' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
+	# If we enable --path-walk here, we will get a warning overs stderr
+	# due to incompatibilities with --filter.
+	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- d/f a 2>err &&
 	test_must_be_empty err &&
 
@@ -332,6 +338,9 @@ test_expect_success 'backfill with wildcard pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
+	# If we enable --path-walk here, we will get a warning overs stderr
+	# due to incompatibilities with --filter.
+	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- "d/file.*.txt" 2>err &&
 	test_must_be_empty err &&
 
-- 
gitgitgadget

