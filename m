Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61175131733
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985153; cv=none; b=U72Mz9kcBKkD6X6b0/ouZqlOFsh/4j+/D75NDlEM86Xz76w0saNH7nwo+gIQyQKS1JhYJHdxk8KdEGSfE3KNfYbrwPRyoRNxL26PF2vIycrj0msfm4LdTaIE0f7rhILnFW6dPEMZDaqCJYKqgZHVIAwNh5+kKB91DNRq9jGfG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985153; c=relaxed/simple;
	bh=2v1iMLle8ffKSutgp5WlsOBmQnZU4iYrNrfhRVMBI7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdU6Ha89qv6P29NrCzO66PSCjGSqkI0WgmokZ506+ChhNeVasuyuEEkTMicsn9nAQjj3mbI5m/VcnuerHoccCNw02cgGGsNUQEqg68jG4IX8MnAD88bj0kbp4WFYwzxoAz516Ef0uYTnr+ex/z9/GAegTGiZrFFiL8nkUIlNJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9rkyA9h; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9rkyA9h"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c19dd9ade5so629756b6e.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708985151; x=1709589951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdCP8yoDpS+QXsAhHn7phc5p8zsguEvYdaGFyoFNXd0=;
        b=k9rkyA9hEylx47qsU3w0RY4XD4NTj14d8shih/IIgSaPDm4EDF9MWGWSHZ5Qye3lU/
         nb8K3Gy/njtpRrQDVmGEpEyZOCdDJ8BmBpbbNRstLMeZec5Je1wnxYilnIpQoeemoEWO
         kCXJ7bEwhKlprRapGZEJzTehfeXlJQKoEYY0QLmt3Sc0A9Ox34sXXGsqxgn4pRdDTTuv
         mfJNC89A0FTDOgadvohrK00vfY+IupDql33YQNydIcFG7H4YnWz8jpE2UVEa4q0vMzSX
         VBDA/XlH8SFJ1MCvgGCGGIeWEIXIXBgu33KcPYR8YwDq4b4nQwvAvZCcpvT6DLDaUcLs
         Gxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985151; x=1709589951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdCP8yoDpS+QXsAhHn7phc5p8zsguEvYdaGFyoFNXd0=;
        b=OPyMjxNB/WPoN/Ro8mknr7x3c5AuBL8wsviURcAwYz6moI1wfcmB8ZPYmVELAKLGyI
         PfRgdNVPyph9U1uVjNC07St+BTC0PTd5l5ukIUKV39jEj0WzBr7SaGu3ebnFDbhGbfWX
         9e2BhMf9PiholOSFPrYcBgXfU2BMRTC9bln+vc/Arim4qKuaJbuC852NJX9rsU83jT6u
         8aQagTcUG+sSyCaovLhROB+qYvCqaOKa+ZTMcvre1AyunfPoFBcNa3P6HOyOkRyFxsGr
         +KFw+x/ug4f0alvt3/BfYuQsylyY71tEsiiiQXtrCqhCiwBxWZExywYaiHS3s3FuJ1Ck
         KXPw==
X-Gm-Message-State: AOJu0YxaHvTpQgzcwmiDDXkFjhescpdZhJgT20BJpgMCpfiw9noxvhe8
	A43GcptJ/YW+vJGrKEXq/rdOYdE5vth72GfOtmz/KvfcWDkACR2DvlLBapXg0KI=
X-Google-Smtp-Source: AGHT+IFEyoEOSlhqkuNhj4dDoDlzO1PELaK1aSRrPVVie+E/mNy8NAV3iN50AFI1u3M2nCA583fV0A==
X-Received: by 2002:a05:6808:22a1:b0:3c0:35db:683e with SMTP id bo33-20020a05680822a100b003c035db683emr473567oib.32.1708985151322;
        Mon, 26 Feb 2024 14:05:51 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87546000000b0042dce775a4bsm2911696qtr.3.2024.02.26.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:05:50 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 0/4] Change xwrite() to write_in_full() in builtins.
Date: Mon, 26 Feb 2024 17:05:34 -0500
Message-ID: <20240226220539.3494-1-randall.becker@nexbridge.ca>
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

Randall S. Becker (4):
  builtin/index-pack.c: change xwrite to write_in_full to allow large
    sizes.
  builtin/receive-pack.c: change xwrite to write_in_full to allow large
    sizes.
  builtin/repack.c: change xwrite to write_in_full to allow large sizes.
  builtin/unpack-objects.c: change xwrite to write_in_full to allow
    large sizes.

 builtin/index-pack.c     | 2 +-
 builtin/receive-pack.c   | 5 +++--
 builtin/repack.c         | 9 +++++++--
 builtin/unpack-objects.c | 2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.42.1

