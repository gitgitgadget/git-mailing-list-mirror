Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84C326927
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449596; cv=none; b=B5UFEzjIztxKSu011YXmjQLkkh3tuM4XCD9rnU4gl04fwBiHvHKRLqbcg77PI9Lbg9oOec16PlOkl+zRoJ0ri9RHKrWY9W69FsgHjJBVKsje8pGSBsOHzJEwXzWR6X6vaD0HggHqH3b9wFFR10K7LQIMVboGY94sxW+rP9kJoDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449596; c=relaxed/simple;
	bh=2qjBawYb8CpkEl5jDBVat2UGF07LDMa9XeutBdkTbR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PtmhNkhxJdxm52nCnwaNJ6VHzHnNWMc2j5g6qKcij49hOub7G8AslcoozBKMt1rzKktBcNh5wYTaTt9KTHvT21+HGobSa5ctqg37LhiiWjmcun0pIadnzFHY4CpBAQ8RBO1/f+amK716aK9n6SRbc2uAqDbh8BPwcfmue17nvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYEbvOq4; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYEbvOq4"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5faa8a9d7b7so121805137.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449594; x=1772054394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7o8VjYWxZrgyt4J+WPqKPy1haiSEGluwZXkV2A3OUU8=;
        b=jYEbvOq4I9AIKZOU/fkyHKTfJKhz7b/hj6Hm5xMmmjKP1014HVphrv0J6aaRIrJRUV
         slGsfa9SO4jCmr+AX9DiOi93YyskMdWZtYukpq6LCFPzh/BTAIvSfRTnnmUynrTK7UBH
         a/y2NwRbWisuu2C4y/kLglknwvQY5skLpDS36SBl7+jD5+vWHEJq+C0z1p5QR2jwij+F
         iLWW9425yi4dPAcDscIrT+kG1he7/J0Sc8u2kN4L1fHocHkQRRziKblIvR+C+r92cCjs
         HlDH6u6Zcx7TnCJJdRGz9reaKxH0Hb7BkSLMv8O3OkwmIU/m0tLop62d8EkGzH5WjhNc
         H18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449594; x=1772054394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o8VjYWxZrgyt4J+WPqKPy1haiSEGluwZXkV2A3OUU8=;
        b=HSEqR/J8TJuhKH7rTsuDcpYxwB6ts773IiBwpboVjTJQi6hveviU625lXo8+6dhxxO
         03KMBUO1xVxPH+NK+1HhKbEzQ3DABrHhWEqiHpXteg1Z5OWC9nkKYmMo6nbKglLip3zL
         u3Tv8fpmKA2+827S4nn8078FMbHDMsml0GEDfw1iWaJRqcTzRtTqz1FLTgXkprjbo6Pa
         80tq+PFF+opCBUsBoPDeJsKmTFrGQOY/qc4i7ZGdjBvNbTsegubq7dEe2TMKw4o+KJ35
         usAkFlvvnDt1lcxXiOmruPwHPDYEMKOyrp9T4NWDXnwoSNtdtHP1iPSNiBSgBOto1PPz
         G3zA==
X-Gm-Message-State: AOJu0YzV22A6Is5OFy+qgltBMiaklkCBqOp/qJO8f8kicDEHHRbXoEUQ
	JKQLXhcg5800aZ6aqT/UIRpr8KCvgVgy9A32VS8qLAaAVOfRnCi0JuxugbBK0A==
X-Gm-Gg: AZuq6aKvDle2Udd8T8JYmgq2U1Yr89VHWYegX5NRHjUeAlPyCIeAwg9PvSZprAb3jTJ
	ytd9iJaEgTQ8XtH667PtEfxrcBtXfl9zVIruEsqO/RSirjXS/OWWo5vJ1mIPWkz31FWbQkRX0cs
	fE4YgFUiqNdKSo2DAfkZjNBuEsp5ZyzJ1u/U86fxLruOnnxUP/nVg4J418CzHB1E/VtJgCUchrT
	bk1nqe09NWlIhLgyFPRWHrF7npdMsX4TAlacAN9biA1xj1DC9YyZK4tgePnca4vu19YzgLOHV+l
	VeqeEGTcGhwQKPG1NRxrCQFLEnHmMEgN9YRKW//d6Eb8aY1sPByPhh4WPdGFf4Iy/oz/uicXxFy
	txCPFhf0KvMZ5hi1S90yii+FclO1Ymg+qc1f6oXwmo5J3UT0ygQ68/jcnFA3LBb5f7nmEb3hH1q
	lffwJumloen35EipojEzN3ZLaGxYAsZS+BYmHW8U8Beb5PvAHqnftAw85WomAaC1kgqofIPbbEp
	f2S
X-Received: by 2002:a05:6102:26d5:b0:5f5:3244:210 with SMTP id ada2fe7eead31-5fe8cb5e339mr171386137.35.1771449594279;
        Wed, 18 Feb 2026 13:19:54 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:19:53 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 0/8] repo: refactoring leftover nits
Date: Wed, 18 Feb 2026 18:08:36 -0300
Message-ID: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This patchset refactors git-repo-info after some suggestions and after the
introduction of git-repo-structure. These changes were made:

1. CodingGuidelines now contains a instruction for naming arrays in
   singular (based on [1])

2. Rename a variable to its singular form in repo.c (based on [1])

3. Replace the function `get_value_fn_for_key` by a new function
   `get_repo_info_field` and make the structure of the function `print_fields` closer to the
   function `print_all_fields` (based on [1])

4. Rename the struct `field` to `repo_info_field` (after git-repo-structure)

5. Rename t1900-repo to t1900-repo-info (after git-repo-structure)

6. Use `tr` in output instead of the expected value (based on [2])

7. Replace `NUL` by `_NUL_` in the documentation (based on [3])

8. Capitalize some paragraphs in the documentation (based on [4])

This patch is based on top of master 59438b41ab (Merge branch 'master' of
github.com:git/git, 2026-02-18) with lo/repo-info-keys merged.

[1] xmqqh5usiizp.fsf@gitster.g
[2] xmqqh5txfv7b.fsf@gitster.g
[3] 12814829.O9o76ZdvQC@piment-oiseau
[4] aXhiIQXBvMhzkFy9@pks.im

Lucas Seiki Oshiro (8):
  CodingGuidelines: instruct to name arrays in singular
  repo: rename repo_info_fields to repo_info_field
  repo: replace get_value_fn_for_key by get_repo_info_field
  repo: rename struct field to repo_info_field
  t1900: rename t1900-repo to t1900-repo-info
  t1901: use tr in git repo structure output instead of expected value
  Documentation/git-repo: replace 'NUL' with '_NUL_'
  Documentation/git-repo: capitalize format descriptions

 Documentation/CodingGuidelines          |  8 +++++
 Documentation/git-repo.adoc             |  8 ++---
 builtin/repo.c                          | 44 ++++++++++++-------------
 t/meson.build                           |  2 +-
 t/{t1900-repo.sh => t1900-repo-info.sh} |  0
 t/t1901-repo-structure.sh               |  8 ++---
 6 files changed, 39 insertions(+), 31 deletions(-)
 rename t/{t1900-repo.sh => t1900-repo-info.sh} (100%)

-- 
2.50.1 (Apple Git-155)

