Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D19265CCB
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002917; cv=none; b=NgKdIzNZK/tbxI2yuUEcWsOTbVmw0bvCYfWt/A/Ze3xSj4TSqLVNfvldtMSZbsx6EUhCOfXxRpYpbPA+YiYy/ySFxYoATpEguH9RcG8Y1UFiLkfrzrRqVAqkHl2Ta8woocZkFqlTexN82xuGEEvSSm4HL552PAbrrXy7SyGgUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002917; c=relaxed/simple;
	bh=xigs/KTEe+v2qgbC0bcsOrPBY2Ty/foErmPMtmzI0Sg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L4Lx8P51K2fFTS4nFbRrYu2C5So9NJ5HRNN0kAnXel3exdOVw3a/bTWF/X+tRt+VWQLuA/IfrYCaTfNiuDeqf81THWl5E0I2bEa6jiW+3rcXBB1UDMBxNaK/mieAMzCfP6/WitBgvLXLaEuMmmtMepUpAS9G33dd+FlKshtWY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smzgyt2r; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smzgyt2r"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so1587007a91.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 16:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754002915; x=1754607715; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIYwR10p6+eGRsfnPPebcCj9l7JrSd65a2VxvwbkAy4=;
        b=Smzgyt2rzoXlXIV1tgzwHePQgoJdWFaYJ/6gusjLcj6Puwjh1AdFxyZqR5Bw/5szoC
         ykSw3+WdTDldVsilIRD51sVjbXGrxW9nCSCE+EZvUdWtz5uSNqiCjdjgi0/1dxHPJpY+
         4UCcs2+u46slhecJyR5eD6bi8K4TDx4VQUcvgxX3bh3IR7cyWXGphp4aXQV+kbxA4GPa
         3Ccj82IT8hUlvKPpnqEnFemKELuWtHC49fnKnjequ3oNqhvzrIEsNKG9TEQ/i5epzCUC
         Kh1Rbj9sgU0Hz/l+M7BJHqVtGl0VAcU8ND753HQFooHoWE0k0shZPQgGe6K1QwkjzlCl
         vgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754002915; x=1754607715;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIYwR10p6+eGRsfnPPebcCj9l7JrSd65a2VxvwbkAy4=;
        b=RHhV0tddb410KzIbD5gHrZMJvNhndvzItjwVW+Lo7p3DalaiLem5HcSAANYQUzC/eT
         dveecc2siVlucR6Bo1MyL1mRgO7oYbjuZicraSGE2gQ8IRNii5TJtO1DvUE8SMK+z52M
         pbCxwb3epTZZugtgo6vnhMy+t54GeMAqkKLsqR6HFPT9PfjhIWM74GZ/WRA5WlItjPy/
         JUxwd9EbARdc0a1xBHXdBg8MfciWlsXdUa1PI8AVXrtqAYZkXZ3nfjoWXDqgEGT+64c6
         rIr8MEn1yIguVqPfH0jAlgjVZwCCKRUbE8Kr1oJH2AWj9xdAVHomOYoGZOUGJrpHiesw
         VuNA==
X-Gm-Message-State: AOJu0YwXWm6yihGSudxpiinW4/jMD1hqtUQgeb70S1OdXdKtFjetudNr
	d8RFeMa3WlaMe3rX5mJehoPE5T3NZg+9sQ1f3O2B84xVU6RnA1eiiF9L
X-Gm-Gg: ASbGnctMIanTa/irJDKapMmoYA12rMVdC9yMF3M10nMeHEOIuad44ki3EY9OKsugWHH
	DsqohbmYaY6fi9o6xP6uu9fbiFvkblIqmLNwyLH1rX49UG7ny0ukhuraN9OuHqNy2BLnJEnWQlH
	Lypn36Ls9opcKcEptuEDjskyIWGYi66WOVWDF8YTlU0zspkgjpEdXF8tWDChJnSiQl9FSkSH4HQ
	hRWIdyIpEJjLhDSW9XPyQm32F7vs2eF+q5IrtSXEfgG+OozpKcj8nOJDgHj5PngYiNuY1E5D0j4
	ELKSJwIPjBZPFyr1so40kRQLcGjh9Ow9huGTxFstMIFPY3X2lbm/Bk2TpDpCzfmNacqzvUyapo7
	J73ZGWfkLXNazr/B0T1luQ093w5k9CtCw2BQ2i3FIfMxSTlCVLnpGD6c=
X-Google-Smtp-Source: AGHT+IFIyWd0M3OjpkePRsrvoqdQrFTdXse4dlljnTPK9a1dzWrmpzNNZyYr/1sTuBrYtdwh+1SESw==
X-Received: by 2002:a17:90b:3c8c:b0:313:db0b:75db with SMTP id 98e67ed59e1d1-31f5de7ba65mr12922302a91.33.1754002914783;
        Thu, 31 Jul 2025 16:01:54 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8c1d:9856:3844:bdd1:13d4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf5f7sm2561274b3a.88.2025.07.31.16.01.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2025 16:01:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cQn7c5+k06yHOD2jxYTGnny7is=fbo4tOw26eD+4zX-Jw@mail.gmail.com>
Date: Thu, 31 Jul 2025 20:01:39 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: 7bit
Message-Id: <732406E2-DE50-40D5-A8EE-A3C2973D7671@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-6-lucasseikioshiro@gmail.com>
 <CAPig+cQn7c5+k06yHOD2jxYTGnny7is=fbo4tOw26eD+4zX-Jw@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> I haven't been following the discussion around this series, but don't
> we also usually provide a `-z` short option? Should that be added for
> consistency with other commands and to avoid surprising users, or is
> it too early to commit to that?

Yes, it is planned to be added in a future patch!

> something like this:
> 
>    printf "$key\n$expected_value\0" >expect &&
>    git -C repo repo info --format=nul "$key" >actual &&
>    test_cmp_bin expect actual

Even better, and it's consistent to your previous suggestion. I'll
do that in the next version.
