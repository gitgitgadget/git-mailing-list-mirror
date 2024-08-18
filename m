Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F12374CB
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993165; cv=none; b=Q7E/pRR84R+76vEkzbmDh0qnURyKjjuQpiT04EQoLfRECdZOmToY4V84ZiMjWb/ikeyQtry99P6PkTvvZ8qC5my5MLX5MKCFIPrHy6dSjW0hBJM0xjvDCTfb8ciHjwoJ83qnRcgv/Go/+8LehKReLoyBcUokMsj08DcYADPWKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993165; c=relaxed/simple;
	bh=FaYan3pHF+tMEJW/wwn5vKSA/+RFPf/VcAN8z6LcRgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu12NGn5ukSOU24II2CJxjeOY2EFegrEOBKV9SMLvV2SMHQp63JWlanvWcztEBOxq7UaoSOAL2fQWYbhSd5pkZP3C5kG1BIb3MZJc/+9wJDjJ8ymaH7iPu3XRxkqtXxOphvt/gX8ShMGzHFN/mYLkPkRdALc8FvGiKM+ejUJmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPwIH0HH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPwIH0HH"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so3189916b3a.2
        for <git@vger.kernel.org>; Sun, 18 Aug 2024 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723993163; x=1724597963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1k/DUO2k+sKUz28MaYvGvWj+kpUC3P/3qAnRK+CniPE=;
        b=UPwIH0HH1nssqHiDIRqT5r+f559j73z8llIzqkQt0/CdLO8zs21klg0EYTzYcc70XB
         j+QaZma0raVCXBAUsQ+Mil3ZeJBN7hxzunY6lJ6Za3D1g6++SiTRgfmSMIvYwje288wp
         7UKuz1Xnt8njSJVfTwwY05F0aIK/j9WojBAWdgK9QeQP1ya1+OcmREsIBQ4DTfv4WFrT
         0EsniVhT/1IrkouD5y4smLBerBWS9+6hFBt0PPimqAZhRhPgdvqBB+3iYuTYHYKzAHPS
         XKkPg6qA9jfenFtBLAmvLXPflPrUliXiWOVuYaLwR+rGXwsVj/9vSPN6VpT+zz2wd6aR
         nA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723993163; x=1724597963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k/DUO2k+sKUz28MaYvGvWj+kpUC3P/3qAnRK+CniPE=;
        b=CQteGWRXKJjY3kBCLqsM7MlTd87NpggW/1pEBwv5AK7y9cg9tUq3YdMYaqLjdsjWnY
         HigTJ/zhKT/fu/0JwRuIwZTHTdOqTRpWhJYbCkCztlx6jEH2JTo3qn6dV/xA3CIXcCDi
         P6RpZycAtoJd2p+LCIAKX/WTltUSpSskotztBebCGFZscQlPY3PoPIYJNKzf1LVtCsCx
         NLS8CKPnoxhrPNyVifzPBalf5cODcD/5WBJnLm8FPgBIEDhmdm2TWB5U+4bpf3QMKBJT
         WaPev1ECr/GHAb0xm8vkAhS1jWxBWAvFaSNxfOc7GlZO0nfNE3+i+vTxRsImpL5+Vxei
         Hifw==
X-Gm-Message-State: AOJu0YxleVZWWczO2R607FfW38jSjrFJxWvSNX0p8FNwInEXJYRcMZpz
	HyEzKzSNOpes3lfT6kRnPIefvqbTN575WdnfjM0gZOeKFTDppjjbo9rGFQ==
X-Google-Smtp-Source: AGHT+IFWVMQt1vYuk75tR+2T0liOf5VSjoLt/JjqxJFUmUQCSEofeZuT7WG5KEbfQOKGO1CdW6nM1g==
X-Received: by 2002:a05:6a00:3cc9:b0:70d:14d1:1bb7 with SMTP id d2e1a72fcca58-713c52645bfmr10537335b3a.28.1723993162584;
        Sun, 18 Aug 2024 07:59:22 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c72d8sm5333557a12.23.2024.08.18.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 07:59:22 -0700 (PDT)
Date: Sun, 18 Aug 2024 23:00:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 0/4] add ref content check for files backend
Message-ID: <ZsIMc6cJ-kzMzW_8@ArchLinux>
References: <ZrtrT1CPI4YUf5db@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrtrT1CPI4YUf5db@ArchLinux>

Hi All:

This patch aims at adding ref content check for files backend. By the
RFC we have discussed, I add three types of checks.

1. Check regular ref content. I enhance the "parse_loose_ref_contents"
to validate the content of the regular ref and warn the user about the
trailing garbage.
2. Check symbolic ref content. Check the trailing garbage and content.
3. Check symlink ref by reusing the function introduced by #2.

The CI is passed:

  https://github.com/shejialuo/git/pull/14

Thanks,
Jialuo

shejialuo (4):
  fsck: introduce "FSCK_REF_REPORT_DEFAULT" macro
  ref: add regular ref content check for files backend
  ref: add symbolic ref content check for files backend
  ref: add symlink ref consistency check for files backend

 Documentation/fsck-msgids.txt |  12 +++
 fsck.h                        |  10 ++
 refs.c                        |   2 +-
 refs/files-backend.c          | 188 +++++++++++++++++++++++++++++++++-
 refs/refs-internal.h          |   2 +-
 t/t0602-reffiles-fsck.sh      | 183 +++++++++++++++++++++++++++++++++
 6 files changed, 392 insertions(+), 5 deletions(-)

-- 
2.46.0

