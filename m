Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43061714AC
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487530; cv=none; b=QCZXb8Lfs9SBrVB2pbFj93tw06F6eeXRCRrpfhZJKTDeFWBCTeG9ZVilCTKfLA+DWUHJWPvRpE/H1h0jKIL/dDoqI/sSVfaledNoSfda8ne9zXEDaZEJcM3fG1nZ6PRTpuagOLURyvpqL0qUEVy36LeskM5OgiRUCo2fHulVFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487530; c=relaxed/simple;
	bh=TmgB8W/oqquyuwfc/OE6w8mVCrtVFuMByhiWZU0WCK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE4er61bmyECsp6LrC50FZl0GvHOTiMVlgePAwBHa8sjb7/cSIElzKOsFLapr9ZPRZ9h5I/136ysaKuACpmiLr++57YfM0jvkROZdOuaSagXjCRMSACZUcXyugyf9m7jVBFCVln8H3veep8+IVxwoKoPGck05j2vIIHeT2pB0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6Pq58zm; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6Pq58zm"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e2bb84fe3so882376a34.1
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 21:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736487527; x=1737092327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv+TQstjK+/uyfNDHQRhxejlB1ctBPNFgUoNmQjYG3g=;
        b=A6Pq58zmIn2ypmjz0VAj2c/kGvMTn4x0kNe1MsK7qXgISfi2wpUmvohm06NwAxGn1B
         COGTlD7f1zPCTCNiE1zlGGfAGDJwOyDSylFEQP4/jrRutGGlJI7bJWimBo+4nf7834ui
         TliK2YDzu+FV8gmVihWziZxDsDTGI2IvYpdCKj/IwbO9HYlN3Kmrf2bx7C6PTzArp32t
         YYZTTBidAZSsfUVTNuNpY+yqcMwFzusBbDyVuSMMNRoJAFBm6FIjG9G04WZsBIHlThaP
         fJQbRq+FwFFY+RxdHXa0kicZoEZDI7K2PuVPg8ZgewKiwc3Xl0a1F1+sWa86e0oFx9E2
         rj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736487527; x=1737092327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mv+TQstjK+/uyfNDHQRhxejlB1ctBPNFgUoNmQjYG3g=;
        b=bHENtLlR1MIDIbe81GxvQyB4nntqPZdFamN3uXM6HiKSZs9oeqWAEvVrE6aLmz6wT7
         1PhlvoFDstU4YEWoAs8dLZM3DQbfMymQdQCOvn/7pubQZ95dh/XLWXNxe/6Czxg2Sq85
         YrIO/jqYTDV95GX18pT9EbFpGU1ffTqBgRUsHgLJlxrWIAlApqiH3e+d/nugwyOFENQu
         3uw6ws8mmGBxSoZIF5fZeAHmrnoDADfctdjK2Lj937OBS3KA3c6IYSwR4GHUd9O5ex5n
         7EKIG5hklgRx9Wc+GkTNC9aMUNmoWOS9NAvenGewrNFgh2MKC06k+t2cnoJM7Dc1QMPA
         Bzlw==
X-Gm-Message-State: AOJu0YxVCUhS+BWUdMbhE+ska6Y0rb8Bf4mordlHT3f/H9Qlr+80buL7
	fVBc6DLa8wxC6Q1VvmIbtknCn7Y8OjStZsGJJsNbHR7fhn5GJMNNL1iGnw==
X-Gm-Gg: ASbGncsB+JpENpVkOg7gOfDYyPGn7uORu0mrOutyWkNtRocdAuTS8IxqLv72+kbWyVD
	ee/1LUIJE9RJko0F+gYlTgVi42c0X+p30WmEuzh0I9jroVgFtUb47fjXva/enyHoBJyJrAPcjCQ
	dRT8zc40ollZ8/VEI/YsMdgLZhZ4Y6pElVp/RoS6z8qxFa/pYlVb/+skzBbbUXPicUVZ8wiKPW4
	zXYWbQWSL0Hkkjc6/vwTkAOTY5GU5gmQc3oscJL5+PsTDHqomAOlWt1Qtwmdg0n
X-Google-Smtp-Source: AGHT+IFPV7WAuIQeb91UENzI1aPc5idVfGHM8QjcOTkVrnNJUajVZ9uwl2inlOBZgikXQlQKhquLtg==
X-Received: by 2002:a05:6830:620a:b0:71e:1ca5:fc93 with SMTP id 46e09a7af769-721e2e62cffmr6528222a34.16.1736487527197;
        Thu, 09 Jan 2025 21:38:47 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231861c02csm714044a34.46.2025.01.09.21.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:38:46 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/2] rev-list: print additional missing object information
Date: Thu,  9 Jan 2025 23:34:16 -0600
Message-ID: <20250110053417.2602109-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108034012.211043-1-jltobler@gmail.com>
References: <20250108034012.211043-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

It is possible to configure git-rev-list(1) to print the OID of missing
objects by setting the `--missing=print` option. While it is useful
knowing about these objects, it would be nice to have even more context
about the objects that are missing. Luckily, from an object containing
the missing object, it is possible to infer additional information the
missing object. For example, if the tree containing a missing blob still
exists, the tree entry for the missing object should contain path and
type information.

This series aims to provide a git-rev-list(1) option that, when combined
with the existing `--missing=print` option, prints other potentially
interesting information about the missing object.

- Patch 1 introduces the `--missing-info` option and supports printing
  the missing object path information.

- Patch 2 extends the `--missing-info` option to also print object type
  information about the missing object.

Changes in V2:

- A `--missing-info` option is now used instead of an explicit
  `--missing=print-type` option to print additional missing object info
  in a more generalized fashion. This enables other use cases outside of
  just the missing object type.

- Support for printing the full path of the missing object from the
  top-level tree is also added with `--missing-info`.

Due to all rearranging/changes in this version, I opted not to include a
range-diff.

Thanks,
-Justin

Justin Tobler (2):
  rev-list: add --missing-info to print missing object path
  rev-list: extend --missing-info to print missing object type

 Documentation/rev-list-options.txt |  15 +++++
 builtin/rev-list.c                 | 103 ++++++++++++++++++++++++-----
 t/t6022-rev-list-missing.sh        |  53 +++++++++++++++
 3 files changed, 156 insertions(+), 15 deletions(-)


base-commit: b74ff38af58464688b211140b90ec90598d340c6
-- 
2.47.1

