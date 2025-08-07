Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2D190498
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754605540; cv=none; b=YCGkqJnfFU8hJdJpeuS9EhDnKiRcsjVvvSFsf4qgx+0kcMutsIVVHvt9g4sKpaO3Iih74OKIeqtMbFC1S5LbtTGtyILBYW8DlE1fe2E5eDOmrJF9TW6wJlfFWUtEO16DGIRPivligW7mBPgTqn6GKHSN0cwamswOFRg35IkntkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754605540; c=relaxed/simple;
	bh=U3H2p0JZ/fCYacagbj4w+b2/0OERm3AlYn/NUDnboTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tusQq1UDZS49iPRTS4QDjE4Xf/oiXHZqEQlgYXE4WO4h9NTSVLiQueuNYmsrFavlcvPZvBlYh56L1bWLoFDYpEdrDfoheRbGFFeSllusuhgqhs4Anx2wiu0erIVUbgZ/LqvdMwLTszjrNk6L8JQOgBPiTm8dq0o+8TEfbPKIF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=No+kEd89; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="No+kEd89"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e3d2ad9180so6373685ab.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754605538; x=1755210338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUBEdWTUXouthu1Od8Fi9E6TCiLvUGPpJZpcEOt/+ek=;
        b=No+kEd89BnaaAwY+S2M6KmUmtAfl/oKPNvevgAWQ1zhkVtEM1aITMv+41sY/0nSZEA
         Y851fukgEWL7WcNf7WigAAEQSso3YDCZraZqdXqH0fQLASTZE9WgaU4S2vfBxXz5xkfb
         SnbF4c4m25XIbDaIsFo4rW53xvn1E71FUOZ1dsD1UXIESOzTAB7/XY+CGBe1MoXbPxzy
         6QJeNILpXGQu2fL/NmX53n6887/FknIaF2fBiMT9htBuf6kDPaQlGCXIRk/f9yInORHW
         PTWzegIvLzN5byJaJfcA7sijwcVh7jrOhpk0bxL04BGtIvz7Nu76DM2AhZa61BMiAPoa
         ffeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754605538; x=1755210338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUBEdWTUXouthu1Od8Fi9E6TCiLvUGPpJZpcEOt/+ek=;
        b=EgMdwg5yMqSWsoy+YfYDpfeNWI2gJEhkUkYUwHpmUJvaSuwSoSO1AF74X2F1XWpQ0Q
         x9S9C4CokIaqE7xI/GsELASOyhcPwgyv48ahGDFI+Q6ye1Pi28D+cx09eC7GQz+DG+Zk
         ca4gelRAP7lj6wFptkSiXoBHu8LDLoG2hM1oBxYN2upX5ngju+Pm3oLUMscotIpIjTnC
         F3I6kCLZyBf3eAQOvKHlaWZpLqCHLtKi2hO0yn9aIUdxI+F5EAi9SHfZyG8ftvcJs1y4
         17c7cwhTSZAkC2667lIAqnJCK0VbvnRhFhz47EXXZSbndw2owCq8LqUUF+7MoRZEJrZ1
         uW5w==
X-Gm-Message-State: AOJu0YwHztlPOaoHdz8ErpLKHf6B0CsxvAzTtoozfiHOKE9E6y9Dzapx
	cSseP4lwVax5FfMI1B4AOQoY9/2vIIic6AA0RpI4VfU2kjssNXJkuOY0XthbJutyh4yl9Xwsgle
	kM+QZ
X-Gm-Gg: ASbGncty7rsquQEgCLq9v1mi4t+uRWPOz2kDybAPpS7pL+MXE6S5A8Zww9gYgVTeegA
	C3JX+dQHeWcm/l20T+VHQyqRzSEPwzTXRn2wbR3D1CbwoTsyONXaH9H2gp3BkvA+a4sSAlfAlRa
	K8kEuxIdhO7c6mZT6zYh795DECZf/5YluMr15amPYSRYEFNgiFNHGulRprXwfK5rkTkgr+b6QJ8
	yaNxDXvBcoRlOQb/rOxKK8jTeyTbYeLBm3fPAfolVAEddPZHb+fghuTDRRi4zrYU+lWvMSIk8MQ
	CntWGF/XD5gnBZG5PTh8Mn1X9exEjwRdrvOcpWSxsICf6DmWiD0Aj+wHE8SgP4uJLqAfgfcKMnm
	SC2EiATXB1zGnb3EuwxlLoHA9i+LS0yHb20doqJrTXCt1ibRWxODhuzCkv7RTx8nDlP4eSw==
X-Google-Smtp-Source: AGHT+IEdt5ZmBy+i5yynqVLVjBsVEmzJ1SysasuHDhDtpliyhB/USkSgJ72Sfd6/KTJkScyRxf0+Og==
X-Received: by 2002:a05:6e02:1a07:b0:3df:39e2:f1a8 with SMTP id e9e14a558f8ab-3e53318d45fmr15531615ab.16.1754605538151;
        Thu, 07 Aug 2025 15:25:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3e533c00e82sm1235585ab.19.2025.08.07.15.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:25:37 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:25:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 7/9] midx: write multi-pack indices via their source
Message-ID: <aJUn4Ggk6iSIfw1x@nand.local>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-7-bcffb8fc119c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-7-bcffb8fc119c@pks.im>

On Thu, Aug 07, 2025 at 10:09:57AM +0200, Patrick Steinhardt wrote:
> ---
>  builtin/multi-pack-index.c | 19 +++++++------
>  builtin/repack.c           |  2 +-
>  midx-write.c               | 69 +++++++++++++++++++++-------------------------
>  midx.h                     |  8 +++---
>  4 files changed, 47 insertions(+), 51 deletions(-)

Looks reasonable.

Thanks,
Taylor
