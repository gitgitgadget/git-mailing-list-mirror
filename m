Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED2426EBB
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931160; cv=none; b=QXlHmYaA+OJp2TgHkOsoIRJq/bvBs//ZRjYuBppoMxCuOK/D/j02hWCXPI6BuNAsCbFg822QDEjJ7clUiQbuDBb9VhT33VwoQ7TY2Ykk1Ds2nv1eMpol0wvchcJh1Q3LzG5kcS0NQHc3Yky7qHjtIPxPKn1cLrB6P0CS1YoYHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931160; c=relaxed/simple;
	bh=Yyj1jPW9N0nie/5ygfelZ6J40ze9Dsbxf0Fbm+b9X0o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o6mjAWbpI9PRRskobn+s/f+tqp8Nrkz6cICsVelEbicHxfTPj7tA5ik1KVZTd/oRgPXuboJadbgOcUNaS8rRnEch/jqTK3lmVZVUvB3M0vsBtXdojFNAGQRbH+YQ/q9X8YVMfFRpuPtg/LQMmgR1C+lKPxHdkq4BEH8X64yPRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlC2HMTv; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlC2HMTv"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59ccf81e6feso1386831e0c.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780931156; x=1781535956; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8UQ+eoLe93cnRt13kYVDs2z+fgLlmFTSg1T2AkUpAA=;
        b=OlC2HMTv+oewTLuNzNFKY1F0SzOvixLwOQEbj3nmLlS1HHRcUA/8kPZ4b7FAylipwA
         /sWYH6CzuQ4jBE/4nmZGl1bPp4JeV48CEfAFe9tvPUrJFqbr9HxivRkHoidKKYnpowEB
         /ZTThIuK67unQGjtlPB3yptGmSrjr1+XeH3Zo1SSmiULC1ZVcRCyvKkyDGbSwHtKd3Ml
         ggoS8C5BmrTCP+RsX+NQPQtP6KVqW68IRF53s3WNNEepojOWL+pEdVAxPmkMKYWOfPNv
         BNGwHdcbXOgQfOEye4iax/yYOSTdhbtyeYlqvdAtzatSkdrCTJr7tlC3xLgT+vMtDqL7
         /sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931156; x=1781535956;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8UQ+eoLe93cnRt13kYVDs2z+fgLlmFTSg1T2AkUpAA=;
        b=Th7Qc5PavoM2GFXPAar2ii6MPpFfff4PyWgVQwwS4nT2PmzuKM2vTUz7sgXq/h7dDY
         n7mQxD9nCot2Pojo5bBUdyTMXA7OEvzblpnx0jSgzpl5ytQWm89Q136VM+McQRIw+ktU
         RA7f5hnON8CSHeS5KmaCN09f7piy2ZH3YsISCcM+UT1/W86mGBWEumlNLEmhvGMOk4k+
         My/Gt8FinJ2ZzZevZ8oYsUjc9+ZEPLGXMRRO4AXpoDLhRx92N+E+Yd8EBJIADsIeSNvw
         7lU1ONIqUtyi3QSgjjkZwi242cnUrMZLwSfgAg8Njxk4fJtnsme2qnk4wBZVqlmuV6BM
         eIKw==
X-Gm-Message-State: AOJu0YyBa8c6KHQAl+drDKARGdGVzhXa4c2lmz+9L3AlGe9IiIL8wrIn
	FlMyvRsfF+kg+o7qlhypz2J/pf0Qd0YfabkDhttfgk3C+yNzmChBd3NT
X-Gm-Gg: Acq92OE7MGrHCHqonbQ5ogboHw0mJBK4uTN8VmcZGCxve18IQZ/3SpvkoVixF1YcMgE
	z4OulyyFtOjWGQ6zOLRo56IpxY1+fJAnD3eHndXhDr4bK/SW8vjTDK8xfJO9M7gYXupLcHDt+hX
	Za2JcgPPPZ6GdY1ekh5vUJkukKQKmJOXecAxgvNONc9oVmzStK7X+les3PtCGowQ3EN9EiwtqkM
	ZFBmvv99Ml9vXADMgru1Pc8Pe3n/4V/WLWSs9/9bmB5Voc/JuUfEzp5eeoZSotpBUB6QWk1s9uS
	bfvc7zbEoPbxUWDP2IMPCguPwKl2JmbX3Zy5AB02n+ERq8B3l7KH48Dv7gZOvGm3/CyEXzmlx8z
	zCke+vh/HcdUlJX23Mz3Os2CM23sv61P2nnaTIVTRi8KkdzYWVXQVIhpcMAsfaUZzHBxr1Dxynj
	8kmBMzwbjBWeGaFzClNCSCCcq8d8z5H08u09U0DkUsXUShar9m7dqTDE7UPSJIKkc=
X-Received: by 2002:a05:6122:3d12:b0:59f:4c56:9d0e with SMTP id 71dfb90a1353d-5ac4ec9396bmr7300830e0c.5.1780931156256;
        Mon, 08 Jun 2026 08:05:56 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dcc2ecbesm13838417e0c.13.2026.06.08.08.05.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2026 08:05:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC PATCH v2 1/4] path: introduce format_path() for centralized
 path formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 8 Jun 2026 12:05:40 -0300
Cc: git@vger.kernel.org,
 a3205153416@gmail.com,
 gitster@pobox.com,
 jltobler@gmail.com,
 kumarayushjha123@gmail.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <22E79E77-BCC3-4622-BD39-F4ED7DDA9511@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> +++ b/path.h
> @@ -262,6 +262,36 @@ enum scld_error =
safe_create_leading_directories_no_share(char *path);
> int safe_create_file_with_leading_directories(struct repository *repo,
>      const char *path);
>=20
> +/**
> + * The formatting strategy to apply when writing a path into a =
buffer.
> + */
> +enum path_format {
> + /* Output the path exactly as-is without any modifications. */
> + PATH_FORMAT_UNMODIFIED,
> +
> + /* Output a path relative to the provided directory prefix. */
> + PATH_FORMAT_RELATIVE,
> +
> + /* Output a relative path only if the path shares a root with the =
prefix. */
> + PATH_FORMAT_RELATIVE_IF_SHARED,
> +
> + /* Output a fully resolved, absolute canonical path. */
> + PATH_FORMAT_CANONICAL
> +};
> +
> +/**
> + * Format a path according to the specified formatting strategy and =
append
> + * the result to the given strbuf.
> + *
> + * `buf`    : The string buffer to append the formatted path to.
> + * `path`   : The path string that needs to be formatted.
> + * `prefix` : The directory prefix to calculate relative offsets =
against.
> + * Pass NULL to default to the current working directory where =
applicable.
> + * `format` : The formatting behavior rule to execute.
> + */
> +void format_path(struct strbuf *buf, const char *path,
> + const char *prefix, enum path_format format);

Nitpick: the documentation is clear to me, but maybe the function name
"format" and the parameter name "buf" can mislead the user to think
that it only formats the path without appending to the existing string
in `buf`. My suggestion is to rename them to something like=20
`append_formatted_path` and `dest`, respectively.

