Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766133991
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822415; cv=none; b=WIxSXhVu82wIShVVBQTymOMqP37GVDzczn58MAORc4/eDqq7ZWTFGYfgvvuiwD6Xko12/NPkME5PUR2+0s2cZZDLXJktOYlyoXTDhQKPSNr8TUtFY6KAQ8N+iSI63qQ0IgKLOmP2FwNvrQCmZWXz+MUlRomCeGwr9JLpY1isOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822415; c=relaxed/simple;
	bh=kkyFv10ZhPX0nlmFDoHFDPqpLVbzLu9JNas72cb0000=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kdkT9mclpHTh2Nhfu5eMcfpnGCv/WyROBUvFGKQGAwJZmmsy+zHYEumNgONqc/MNtvlBhdIxkWP1/Ot/WmxGiTOhuYgPjr65dVPGu2Tb+RcMPkLO89LPi51X8WMrOAJJ5EI0hnxrQ99U7pKLNFwTIoo7mRl/jimvk5veNcdaEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=depynSEQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="depynSEQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c336fcdaaso10682145ad.3
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744822413; x=1745427213; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkyFv10ZhPX0nlmFDoHFDPqpLVbzLu9JNas72cb0000=;
        b=depynSEQujsNh/5LB+Z1qeZaSATpm1m3vFQrFPoHc4zqpO+RFO9NTaUQswtduJTuzJ
         xIsNrq9b1oPDYMEKeKPEPjzsSlyNZUnMsWsrIi8lBlwPu4H1+k8lIwPwwGYOIXD9Plop
         1xXQM+EjC04fF6t4nI/vkUMVZ3OhtUYFMjPXKcM7CTgNsLKTIEJEd5gSbNdIrV9JPxQo
         VpGFH8okXCoN6UcAYW5rC9Xc9a3xyNsE39zYGM18eogBSsof8VZpSXqzEOl5GDQ0fduy
         87ol6Ff7HipJ6KH2EOp7BIluGfFW2LducvsSvfVuGtXJVoejMdbXXTnm9XniCsbooOYH
         6J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822413; x=1745427213;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkyFv10ZhPX0nlmFDoHFDPqpLVbzLu9JNas72cb0000=;
        b=PgYBPDHCmku44JvH0d2IX/OoB83p3LBucbwqh4EyURpspftBR0qMUS4gQuzifeFWND
         G7sZpmzWkJrt6eaq7CVB5jp2Rv9XQ9553suR5YafdGIMBDICQ9SHxYmtGFWZcVVgf76D
         kdd5EjhAwLC7sdlhVOaELHsEdKyMprMhPqTSnKqGpqRkR/R0hUEHs47O2gI39k4kAE9V
         6EVM3Q53A8zI8RrV3Ds7iaSEd/U3btNJ8+m+wBQmHxPkoS8Gu2IIczaSQcMDzSqRwhsj
         aWzhj1rhXiqHg4rm75Emu5UP+y0Qf5Hkq3F/cTl3E6rEQ+1DXcAUJhZ711k5WNr3eJGg
         O5kA==
X-Gm-Message-State: AOJu0YxInMZSiRpfRvHQTKFW/W3ZeUEWfcmt8Z7oy3B0zM5/+iCDjPNL
	PTB7AtN9UHlHS8BwlpRiBiGO+oE6Nx9IlGlo8WHACMXd16yymIb5
X-Gm-Gg: ASbGncvw//ITVDqIQkY+p7PI0js5OzYUWSWQje4C/oCrfdk1KOKFVHOd6DOkIHn/Wp3
	pE1nrAtorLtH763BdxIh/rxS+dklr1uzrl3CeJggDxLF21FrqrWYcQud3tKwpHQeeZkOIXwdGuD
	4ocEzOpXau31NkzalUrPdpzNL5wF4rcYRlYMiXOge2RH8NiqquXVU/US55UvzKMSEXTv3lU7DZd
	qaNsq4M64PDUnhf/O6TsrBWxU2GahFRN0UYBXKmw5/SlK4tC4S+XTfqTjfUU/90VpCx88965/V3
	lJ0EuJnvBHn0EdjgQzB6CQcvmv7It2LtUSNFLOIGC4yEfZavPebQ80JXH6Et3QXfRt+nkPlfNIv
	Rrl8=
X-Google-Smtp-Source: AGHT+IFlWthbLaKNUsNNk0LBqPuqSTB5+Yqkd1oOsOfVFZRhzr/943+mK5hWdAvOTdYVYtC//eSwXA==
X-Received: by 2002:a17:902:d491:b0:223:54aa:6d15 with SMTP id d9443c01a7336-22c358db441mr47758565ad.12.1744822413472;
        Wed, 16 Apr 2025 09:53:33 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:899b:9db3:7efc:4ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe70a9sm16501735ad.237.2025.04.16.09.53.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Apr 2025 09:53:32 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2] docs: document core.hooksPath=/dev/null
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <pull.1899.v2.git.1744818135435.gitgitgadget@gmail.com>
Date: Wed, 16 Apr 2025 13:53:18 -0300
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 james@jamesliu.io,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <BD8FCCB1-C97D-4057-982E-93A7F8B01AB9@gmail.com>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <pull.1899.v2.git.1744818135435.gitgitgadget@gmail.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

> +You can also disable all hooks entirely by setting `core.hooksPath`
> +to `/dev/null`.

Personally I think it would be better to focus on the non-expert user,
something like:

"""
You can also use this variable to disable all hooks entirely by setting
it to `/dev/null`. For non-expert users in a per-command basis it is
advisable to use configuration parameters of the form
`git -c core.hooksPath=/dev/null ...`.
"""


