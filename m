Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603ED2749FD
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396142; cv=none; b=netdg9sQoYl3z2Zffr+zVJiwk+ifMrobAlZXkwSj1weGiYj8YhROb4cmVQpvw5Mxv3vSbv8OgP1dSTChs8rvXR6Yqz2rlRLxb9IMkCYaoPHxGHhGu76gPhGk69Dly4HhlMVWkevC36E+0cWNim2FsoSU2r66jkRAFTiTLfZoKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396142; c=relaxed/simple;
	bh=QjCSHE9fDd6NOQyAP4uuoqELBQicWdcRDTqTX0I3SxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=pV28QVQzldZpKgCCVIJqqqRUaXq9m0PXucy+I2yJAxzun2f24Dj+M/UWu0pK7rXCdduNuDEV1rMWQ5aR73WbLDcywQGEJnNuPGHcdb9geMca2azYM4jwsqsgIiSjDNGJTu8T8y1lg35o6ez5Edrzpf+K4XYmDwizXdZ07VVR2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuGIR+KA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuGIR+KA"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1009359066b.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745396138; x=1746000938; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WH24eJuDwDjq4zoXcDGMcmgpE2/5G42BlNMkJNgV1pU=;
        b=GuGIR+KA2L3ywKVfU+Mn/wBSfS//AAEYG03BTAWPqKEb++5bxp6I2Juu23w42Mnuar
         YcbeCHW773QSfIq5wyR/3UzidJ/gK8TW9l/b0hHJdAmKU5T+k1jW9PKH7hSxLID2S5+I
         PVV0iCSDGTfn0yppaUR3WHCCBCjR+X5cc5OSKG+NosATtcSPZU6o0Ms/eGc5mXHmkhvd
         Vz82Ci/rndvcbHpZBIIDwmv74MXXl+XOr5WB0zCKFYSOeg4gYlgGRsRIoUP3Va+SO9SC
         lIHIAlLo6bHV1gesIdh6vgDtIZ/0lUOF2Ej+vxQKI5x4fXWvD5NDqTPKnhb+KYMzXr7d
         r/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396138; x=1746000938;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WH24eJuDwDjq4zoXcDGMcmgpE2/5G42BlNMkJNgV1pU=;
        b=P2EyrvfSDm/8HwYvwFStFIEuak+47mAngaZIEqXp6OivJcUmAx8SYaZDNIlvv0fIDH
         QIRKpcLKpMIjLOj9pCYrSWsOjN/q6+knbfWI3DHD5+Flk1IjfWpyMw+raQ6u1pLZwpwv
         +7znhX+1ikyBpmI61TOeA92Yz6+Ozzo3rAasRkqV4lzUQ6vycxgFdsZRo5/VYkQNsSeT
         hI7uTb6dWmJ9gy6NKZqfKcBLu3+bTtro2yJ3ZZ1tPcv6u9bKdeing0O1cXW968SFArdy
         V87TRTPLYKxh+9O0bHwCJRy74K5te1wqzzUAwbqiVPvdIF1pVW/Kb4I8CnHmX0wpH9Ox
         Eqtw==
X-Gm-Message-State: AOJu0Yya7OisQxT7FSt2gPBkfcBzF4WcoSlj7NGZBEddB+zQEyxOUMP/
	opUV28W7rNg/i/L/sIi/IdNrDGENGdAUVkZF/Ey089pOvE9au3X7
X-Gm-Gg: ASbGncvrxUj9roKM2WS3VsZVB4jVQ67LXN4Ey8oFGgcg1VvyRYvI6cjAYt1JBrS0WAm
	vRo2RhhcMuGDc+IZaQyFVL+/F0LiW2K5KyFbijpllaHgwEqDWt6n4r/XAL3GBTDay8j7AGHqAop
	OCCOKbhANFRyV+blyVfzLQgLR/kvQmEp4yIg5AO/TQmR1ITbe1tFmQehqOeIwPe4FifbrqM8INH
	9OEvqy4/XWT3trJF7dPPoj2sKNEJD2oEprynYhTidwGZ6g4L4bdtOImurfTTpeM7FlKtjHjjg0C
	hB2ZKT9MOA4o0O3/FipjgbgT+wn4V5rQOkbEr/r7Shw1ewT0ubgn3GUPAQ==
X-Google-Smtp-Source: AGHT+IHeKBAS78UF2eHuTW5bjNsPls0pBT4AG3PjlUm5dwxlJVnm9bXrVvQKrZdnWA79hxebEuxu/g==
X-Received: by 2002:a17:907:868d:b0:acb:4f4a:cbd0 with SMTP id a640c23a62f3a-acb74b364bemr1736463766b.14.1745396138162;
        Wed, 23 Apr 2025 01:15:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8764:66c7:f630:d3a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec13a5bsm766577266b.27.2025.04.23.01.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:15:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/6] meson: add corresponding target for Makefile's
 hdr-check
Date: Wed, 23 Apr 2025 10:15:33 +0200
Message-Id: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKWhCGgC/4XOPW7DMAyG4asEmstAoijZ6JR7BB0UmU4I1D+QU
 rVF4LtXSRajBerx5fDwu6nMSTir191NJS6SZRpruJedipcwnhmkq61Qo9PWanDawackho8Z8hx
 SZigSYOA8jYBsseusQd2eVCXmxL18PfjjW+2L5OuUvh/firlfnzDp9n+4GNBgGmo8u8jB9ofzE
 OR9H6dB3eGCK8xsrCxYsRBP5GJsA7L7jdk1RhuYrRh30XPTo2/oD0YrDLeWUcW8Z0PGEreIa2x
 Zlh8yof62rwEAAA==
X-Change-ID: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b
In-Reply-To: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6813; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QjCSHE9fDd6NOQyAP4uuoqELBQicWdcRDTqTX0I3SxY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgIoajHI8JKSTbVxWtVM/eIhdmA8bJYOuGUZ
 O8FR1aSvBS+6okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoCKGoAAoJED7VnySO
 Rox/ufEL/3WM2BGADrHEhJOjtJQCyvQlbaCvyG6KLkfERZIxCMBR0Guyxt0ykSJzsv1QYCUm1O8
 OFW94pipRB9ts8Me/U8MxjyjQYR4OgKaahwf3Y5ZAb8ojEku/ck3NsqPwddJFowRME8/X3Ti+gm
 xUHcLR7r66cwOdLYfk4Zp4fMYFVVAf3qdOsYxO8eIrIZQ/sXbaQxw24rafSYsLOt5ntDjhutqqy
 JqcT5JDP3s7KaB6EErHUB6tRkTnMJPN5YxHSvFELA0M0PYaQvABewUX75ktxRd6d+GtHAiaMRFu
 YbLjA4DLgxlqe+9dY0tjRwQGy4dUSupMIqWliTqH6qr1do4fHcmXE0OAsnwkRw7E/fNGiNGOCh2
 b1YqqN8A4WWDJeWXC/D3d6uBv5FiRLTONZIptDRaBeuesH31pmDlhXxUS0aTUSUlrsMqD7gwhG/
 jbtwWrwKBxqiGkL0/YH3qPU7A9L2jgypsYM2a9W2uVRH5XN/be7kiebo9WSy6DfIPG+v2vPFBu5
 UQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

To bridge the remaining gaps between Makefile and Meson, this patch
series adds 'hdr-check' to Meson to compliment the Makefile's
'hdr-check'.

We also introduce 'headers-check' as an alias to 'hdr-check' as a better
named replacement in both Meson and make and add a note to deprecate
'hdr-check' in the future.

The first two commits are small cleanups, where we re-organize existing
variables to make it easier to add the target. The third commit adds the
'hdr-check' target to Meson. The last commit introduces the
'headers-check' alias to both Meson and the makefile and marks
'hdr-check' to be deprecated.

This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
'es/meson-build-skip-coccinelle' merged in.

---
Changes in v5:
- Add a commit to install 'git' in GitHub's CI before the repository is
  checked out. Without the presence of the 'git' executable, GitHub
  downloads a tar of the repo instead of cloning it. This causes the
  patch series to fail in CI.
- Expose the 'headers_to_check' variable even if 'git' executable is not
  found or not a repository. This ensures dependencies of
  'headers_to_check' can simply rely on its length. We also check that
  the '.git' folder is setup before populating 'headers_to_check', this
  ensures Meson doesn't fail in tarball of the Git source code.
- Link to v4: https://lore.kernel.org/r/20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com

Changes in v4:
- Rename headers to headers_to_check, since these headers are only used
  for static analysis.
- Added a commit to rename third_party_sources -> third_party_excludes
  and remove a duplicate.
- Fix a typo 'gcrpyt' -> 'gcrypt'
- Remove 'generated_headers', since we use 'git ls-files' and that would
  already ignore files within '.gitignore'.
- Link to v3: https://lore.kernel.org/r/20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com

Changes in v3:
- Some renames:
  - headers_generated -> generated_headers
  - meson -> Meson
  - headers-check -> check-headers
  - headers_check_exclude -> exclude_from_check_headers
- Rewrite 'headers_check_exclude' to also contain dirs so we can skip
  listing individual header files.
- Move 'xdiff/*' to 'third_party_sources' and cleanup
  'exclude_from_check_headers'.
- Use 'echo' instead of 'echo -n'.
- Use `fs.replace_suffix` instead of `str.replace`.
- Link to v2: https://lore.kernel.org/r/20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com

Changes in v2:
- Add 'hdr-check' to meson, while introducing 'headers-check' as
  a replacement alias. Schedule 'hdr-check' to be deprecated in the future.
- Link to v1: https://lore.kernel.org/r/20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com

---
 .github/workflows/main.yml     | 14 +++++++
 Makefile                       |  4 +-
 ci/run-static-analysis.sh      |  2 +-
 contrib/coccinelle/meson.build | 31 ++++-----------
 meson.build                    | 86 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 25 deletions(-)

Karthik Nayak (6):
      ci/github: install git before checking out the repository
      coccinelle: meson: rename variables to be more specific
      meson: move headers definition from 'contrib/coccinelle'
      meson: rename 'third_party_sources' to 'third_party_excludes'
      meson: add support for 'hdr-check'
      makefile/meson: add 'check-headers' as alias for 'hdr-check'

Range-diff versus v4:

-:  ---------- > 1:  d20993a59e ci/github: install git before checking out the repository
1:  0f1160fa78 = 2:  6eb10dd3b1 coccinelle: meson: rename variables to be more specific
2:  933b199def ! 3:  7950b44c6f meson: move headers definition from 'contrib/coccinelle'
    @@ Commit message
         makes it easier to understand as the variable is now propagated from the
         top level to the bottom.
     
    +    While 'headers_to_check' is only computed when we have a repository and
    +    the 'git' executable is present, the variable itself is exposed as an
    +    empty array. This allows dependencies in upcoming commits to simply
    +    check for length of the array and not worry about dependencies required
    +    to actually populate the array.
    +
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## contrib/coccinelle/meson.build ##
    @@ meson.build: builtin_sources = [
     +  ':!t/t[0-9][0-9][0-9][0-9]*',
     +]
     +
    -+if git.found()
    -+  headers_to_check = []
    ++headers_to_check = []
    ++if git.found() and fs.exists(meson.project_source_root() / '.git')
     +  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
     +    headers_to_check += header
     +  endforeach
3:  ab04192864 ! 4:  7fd64b788b meson: rename 'third_party_sources' to 'third_party_excludes'
    @@ meson.build: third_party_sources = [
        ':!t/t[0-9][0-9][0-9][0-9]*',
      ]
      
    - if git.found()
    -   headers_to_check = []
    + headers_to_check = []
    + if git.found() and fs.exists(meson.project_source_root() / '.git')
     -  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
     +  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
          headers_to_check += header
4:  69a4b5abc9 ! 5:  df0472be57 meson: add support for 'hdr-check'
    @@ meson.build: third_party_excludes = [
     +  ':!xdiff',
      ]
      
    - if git.found()
    + headers_to_check = []
     @@ meson.build: endif
      
      subdir('contrib')
    @@ meson.build: endif
     +  exclude_from_check_headers += 'sha256/gcrypt.h'
     +endif
     +
    -+if git.found() and compiler.get_argument_syntax() == 'gcc'
    ++if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
     +  hco_targets = []
     +  foreach h : headers_to_check
     +    skip_header = false
5:  a0c799cf8c ! 6:  7d9a33767b makefile/meson: add 'check-headers' as alias for 'hdr-check'
    @@ ci/run-static-analysis.sh: then
      make check-pot
     
      ## meson.build ##
    -@@ meson.build: if git.found() and compiler.get_argument_syntax() == 'gcc'
    +@@ meson.build: if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
          hco_targets += hco
        endforeach
      


base-commit: 3a956c5f69873611ae5f8dcb9acd117f66b95ddc
change-id: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b

Thanks
- Karthik

