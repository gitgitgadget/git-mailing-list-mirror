Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6AD146E9B
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046600; cv=none; b=fIbnxcP791ab49AQdPXq0156oYd3n6YFq2VQYyuWK9YAKYXcLQWCJ50byeyFbCUjLbnAgnh/Sxvsd5z5A0eAidBPwz+JCSuUoCUQxBKvbakQsc2qBva3xEnQwQLRJ3Zubu6IIderPiGx9ejttj2CIprXqw3YieaGEfKoFmNNGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046600; c=relaxed/simple;
	bh=85WczTFRllXGhlMsWBBzluIBE5+d6nK+gczvg5aN9DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIt94t3LkOy8CCIRFAmKjaPJ35y5skuphM9gCHpsiWyJLaa3GgvidlNIfJUPnfNj0OZz02xK14ivDugcItBpfGkA6ODFuXOHYbU/3dtumuXpdwNRtAoJ9L2VwTnGglnGV3HC73MhPkN+GKkYVcajuXY7oAw32WVJr9bna41oHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl03LUXR; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl03LUXR"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a35c720b8so15186781cf.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046598; x=1709651398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H6BX+a5vDQDRzY/OT34jTSZbC/dsOqj+i33TWAoQ13k=;
        b=Cl03LUXRGSwwMwX5kdgYx+5+2QeNZYLpyC/iVNd95kVtJOot9KBbf49xwgbIxV+5NC
         x6c1oWUo7UNI6pNkbhERcjdNW4tSEm1SZRb7EPSdbAg/gHXVWMhSHFZwnHkzXRj/+zAB
         FLl3b3lfZipn4zb/yTTeL9KZFv5wWyBeCHVU0ygb/uCMo7rgl8576f3v4agcezev4Yeq
         Jg4ne8gdsaLd/uAYaIFfnzZxkwmqxSKjDViuSstKm+zy9iNMR52Pux0NLc1RM1llfMuS
         UVCiSLJwvSjm5jts5wzJD0C5j0wzQpgDbB7ezqCSwL7P1XSvpsVO+MEhiGsBrQF1kmCB
         YreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046598; x=1709651398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6BX+a5vDQDRzY/OT34jTSZbC/dsOqj+i33TWAoQ13k=;
        b=e8VAg1eE4E9lqv1iGT0733gfR2BlcdgGyCumZwdkZsmMuORFXqrgsJRf58eLjt/tnP
         z2rheI2UZUYoKNz016SpFS907lcDnxhj+VXqRJgMmSADgAq+9fd6lCIfYB26lvgxQVri
         YfWHipORZUn1i211ueJAlEbc1MuPrRG9JSMTpwVQ3ErZULt2WFFxr9BtGEe2XXWulB4E
         nWBBegKJmnhQUprS5xeA3duMGwJGv9cqcwgv0tzLrAnIUPQpLKWjw4UW9gCRPCvT8H+J
         x7Ojq0FMZLgCLnw4XJUL3HuDuVgsf+Le4Uh/+woSVh8fC1e4TlbcFs0j5pwihd4Rn2ez
         sdRg==
X-Gm-Message-State: AOJu0YwrCUIZMeLoE8GUnUR3W2U60T1kqbdvljJa2N61J2wTIFHDXzfM
	FU7awoF3t0iMm0RUFi2y9f171AZDj58IliCewZrxCI+fv0XSdZ3XugsGS/DP
X-Google-Smtp-Source: AGHT+IHMpSIDJUndW3M0CXqYFtdFPsNxKF0fFaWgI2THC9zADCfyJCiD8sJwsyuLQgKZ7jug9ID3zQ==
X-Received: by 2002:a05:622a:653:b0:42e:7d41:4c76 with SMTP id a19-20020a05622a065300b0042e7d414c76mr8569772qtb.59.1709046598040;
        Tue, 27 Feb 2024 07:09:58 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id t19-20020a05622a181300b0042e56fb8e0bsm3618149qtc.93.2024.02.27.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:09:57 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 0/2] Change xwrite() to write_in_full() in builtins.
Date: Tue, 27 Feb 2024 10:09:31 -0500
Message-ID: <20240227150934.7950-1-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This series replaces xwrite to write_in_full in builtins/. The change is
required to fix critical problems that prevent full writes to be
processed by on platforms where xwrite may be limited to a platform size
limit. Further changes outside of builtins/ may be required but do not
appear to be as urgent as this change, which causes test breakage in
t7704. A separate series will be contributed for changes outside of
builtins/ at a later date.

The change in unpack-objects.c is necessary as len is being passed into
xwrite that exceeds the size supported by the limit in that method
(56Kb on NonStop ia64). 

Randall S. Becker (3):
  builtin/repack.c: change xwrite to write_in_full and report errors.
  builtin/receive-pack.c: change xwrite to write_in_full.
  builtin/unpack-objects.c: change xwrite to write_in_full avoid
    truncation.

 builtin/receive-pack.c   | 2 +-
 builtin/repack.c         | 9 +++++++--
 builtin/unpack-objects.c | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.42.1

