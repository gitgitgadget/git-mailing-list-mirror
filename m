Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFA11713
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840242; cv=none; b=gbEVGIHrQiMsJTPFoX3EEsuf+vn3F3TPiLwYZT5HNHyix/w5gBE45x+Sghiqy5Rffa8PSKnc9zX2G10fSG/bvO5f/9qTdx2X/l+5Ga3WseM89fi993Kd43MUlxa8XNnDfjBiKqYEIP9lR0pv8YQUwCYXeoDZgnNCZl6JhsTTQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840242; c=relaxed/simple;
	bh=Bq1UZ3v+Au3Zu1tdePnrgAQoMGzpFwHV0e8p509E6SU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivW28cR2jlLsPn5Me8azLuPxEW+bmhnVO8xe3iQg1iw+qhfqbgR4JfXXgEcIQ7YouGwjFvnx3vqG4f9stdR7Eoc0iNpHqp98DWv5d0EmoclPPrVRbyivynCDvXVH8E46+T0m3bauT/wS1SwQ+26n1LCCUcMW/EImgDA3FnoSKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elSPL5hs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elSPL5hs"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e29d65728so35117335e9.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759840238; x=1760445038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9safFYECbIr2g1FgZLCB0WC6kyj4zR0PO/eZoAfp9fs=;
        b=elSPL5hsT8J+C6ngorXqjbroUU07UTSKQ7Ee4n+i/vHFCPahIa0K1frf9F/I0/PqG2
         wX1gi+OlIaYJb69oBINuL+Jwh/WkquW5raAHAROSuSZb5CQou4pI4de/SY+VBhOF7Rww
         Mp+ehTOuspwFN/RCT4Po79f0QVLl4Eyexqafm1h0E91AHpG6mysUNw4//BllCSDS0/P6
         6zllwNf0Eoq8zMpFWzKPJdxXOzWreT5g35eXP4RyAszJYRFU3UtsPeMOE9c0j+P8jiEh
         GPNZOXHPzDHcyO9muoZWp513WBsVqTa1Wjm0eOcZGATa7gvOrvlMJTAmuHwEVtW5lD10
         6tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840238; x=1760445038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9safFYECbIr2g1FgZLCB0WC6kyj4zR0PO/eZoAfp9fs=;
        b=VIrNR5p/O3BtM9HFYQ9lRt6slEkC8btjpT5C2MBahbMF2ppCfgS74neV7zyShiP56/
         wHYCDsQR8JS0FXlEwINtYQphbzOmuRW3PhbKZZdnJCu8luUg+ahlVwxtyfRr4d0zBBfo
         zx7sT7mwSWT6I9PXFTxUgnhDDl17AHzpZawOCe9D8prqGElS1b9aTM7JhEn53pLguoY8
         l8r8R5QzzezQFhrx3IkTN8UHryMLfIzpEII8zSsY8c3K27TudGBohq9qpKzw/yzXSuZV
         mHkNsiA7kiTUV78B7h4ygjiFm8o0MipYwBp0vM282gg3OsHNucxjWw99LtszQ2h8Z7yc
         KcfQ==
X-Gm-Message-State: AOJu0YxkChsKoUfPK1phcWr14/WhWBwcwb5FgF41RYNUWZaYR8UuWG4D
	9z6kCZphHDf4gkW/fSl2I8Q38cn+yYjbDo6aBRyt6ChPAy6M7yx09+s9EXMc0TNb
X-Gm-Gg: ASbGncsVdQUGudRXzjN9RBwF0BEd3ir1b+jMQ2rddZCG4cDKvrCoRfatlbKijOTS3V1
	nO7BNgr8IDtGWXOMQap6kyg8CWoVO5PXRkD2V2oFOquxeAU8Hen8bQennkclRGl8OFMbTDf2qOu
	Mf/2fgcDHAzU6f/gF/fvyHikGeIrfNFcF5GdoHmOHTSa/7Z4XwbVGJqnxnIW7CqJqF/I4tplW/K
	/eLAM2i2Wn0Z5lWZVN1JyRo5LNXxJVl+NjLBtLQeRoXV/WEMMZ62X4qa7aNiYAf9SVsTvpW+h/e
	0a0a1nYQ/I5kPyn+cOLyAtKOUmXUB+9wrIt5WdZfGd1l0XZ3KAQ0eKs2YdQtTU2r0DUSa/lXF4G
	uOCLG6RHn/6zBUl+FXdpN0vplwYdS6W6dawO6aUNIZ0UTALBKXPGC6MnDFm8FUSfS4UBXoGGUvw
	==
X-Google-Smtp-Source: AGHT+IHxzxOLfMfO/ZtFIP0V/TSNRvMdn6Fb8NDLmY/nWvgQYNFU4dlBvbSuiHEjvNvvDcy8D06f1A==
X-Received: by 2002:a05:600c:4709:b0:46d:7fa2:7579 with SMTP id 5b1f17b1804b1-46e7112430amr105820495e9.9.1759840237428;
        Tue, 07 Oct 2025 05:30:37 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm25476185f8f.43.2025.10.07.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:30:36 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/5] fast-import: start controlling how tag signatures are handled
Date: Tue,  7 Oct 2025 14:29:53 +0200
Message-ID: <20251007122958.1089680-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction
------------

Tools like `git-filter-repo` should be able to control how tag
signatures are handled when regenerating repository content after it
has been filtered. For this purpose, they need a way for `git
fast-import` to control how tag signatures are handled.

A previous series [1] added a '--signed-commits=<mode>' option to `git
fast-import` to control how commit signatures are handled, so this is
adding a similar '--signed-tags=<mode>' for tag signatures.

For now this new option behaves in a very similar way as the option
with the same name that already exists in `git fast-export`.
Especially it supports exactly the same <mode>s and the same aliases
for these modes. For example "ignore" is a synonym for "verbatim".

This way, both `git fast-export` and `git fast-import` have both a
'--signed-tags=<mode>' and a '--signed-commits=<mode>' supporting the
same <mode>s.

In the future I want to implement new <mode>s like "strip-if-invalid",
"re-sign", "re-sign-if-invalid" in `git fast-import` for both tag and
commit signatures. These might be a bit more complex, so for now I
prefer to start with the simple modes.

[1] https://lore.kernel.org/git/20250917181427.3193500-1-christian.couder@gmail.com/

Note about the different patches
--------------------------------

Patch 1/5 (doc: git-tag: stop focussing on GPG signed tags) is a
documentation update for `git tag`. It could go in a separate series
or be dropped altogether, but while working on this I thought that it
would be a good thing to do, as the doc is quite outdated.

Patches 2/5, 3/5 and 4/5 are preparatory patches for the main one
which is patch 5/5 (fast-import: add '--signed-tags=<mode>' option).

I wanted '--signed-tags=<mode>' to work for all kinds of signature in
tags (OpenPGP, X.509 and SSH) but soon realized that the
'--signed-tags=<mode>' option of `git fast-export` worked only for
OpenPGP signatures, so I fixed that issue in patch 4/5 (fast-export:
handle all kinds of tag signatures).

While working on the tests in patch 4/5, I found a few things to
improve that could belong to other patches so that's how I came up
with patches 2/5 and 3/5.

CI tests:
---------

They have all passed except one on Windows where
"t8020-last-modified.sh" failed. I doubt it's related though. See:

https://github.com/chriscool/git/actions/runs/18311274807/job/52140205441

Christian Couder (5):
  doc: git-tag: stop focussing on GPG signed tags
  lib-gpg: allow tests with the GPGSM prereq first
  t9350: properly count annotated tags
  fast-export: handle all kinds of tag signatures
  fast-import: add '--signed-tags=<mode>' option

 Documentation/git-fast-import.adoc |  5 ++
 Documentation/git-tag.adoc         | 52 ++++++++++++-------
 builtin/fast-export.c              |  7 ++-
 builtin/fast-import.c              | 43 ++++++++++++++++
 t/lib-gpg.sh                       |  2 +-
 t/meson.build                      |  1 +
 t/t9306-fast-import-signed-tags.sh | 80 ++++++++++++++++++++++++++++++
 t/t9350-fast-export.sh             | 60 ++++++++++++++++++++--
 8 files changed, 224 insertions(+), 26 deletions(-)
 create mode 100755 t/t9306-fast-import-signed-tags.sh

-- 
2.51.0.438.g6987fc0bae

