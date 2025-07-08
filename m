Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654452DEA82
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002863; cv=none; b=k/c7zNwogqKakZt39d/GuAEakYLh7NTkeGA5fctYETJh9EXKlXcixyLAFfA7eoTnBV5zwy08/JwIkm5XpquLSM/65P3noJhufDSkV8RvfHTuCY/zxe48Do7K+YYxIwn/KivQaj3uO3+oEMz7GvRLKMdnfvBqyZbqQ+qB7ogHJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002863; c=relaxed/simple;
	bh=2+ylin2vjhmhG8bimQFzjXnEUiw/SEaKVJjgcEPShko=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LHQnOheuPa9yFkwXjFQfX4cwzd13g4/bvGaE4/ptQk05horGTGYyTSjdN3UBgHWxcrz8DGza7IoheGJge9vacLZ2QXnYjgKnEfF0nY+jdO2IglcecA+9C0e2OnRpBByA1kmp+vhupZ8jdIdtvdCG/Q+gBUvJk7jgnSdQSQCzGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnNdKn7L; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnNdKn7L"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a7f61ea32aso95967851cf.3
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752002861; x=1752607661; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+ylin2vjhmhG8bimQFzjXnEUiw/SEaKVJjgcEPShko=;
        b=HnNdKn7LUualD36LUhL7ygFM+6+/6/zeMHIof5ZwJrKsIoBqS4VWAw7wvHv6gjHHOd
         NPnhOpYpf+AGRL7NVrInnNdy5w3bb8uBq6mw3UT5c35UwKQn/9efo5FizNn3omo1OXwW
         X668Yc1gUN5VxPYmflm1XmY0rmJWJ9yNGjnLw7CFVcHXTowVzXZM7H4bXQ8nTnjUvtAD
         IHRYjoGNcDOOZqQrcuMqIj21Iaf+JnNxOt/LTrRpVl7OkTKTLgAG191svwsvuOTDiVcR
         CE15dkoRCR7k2bqmVDt08zs2O/idlUSw95f5TVp6oYq+l0VvMUbvkRUPpegc6fExAJ5j
         8Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752002861; x=1752607661;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+ylin2vjhmhG8bimQFzjXnEUiw/SEaKVJjgcEPShko=;
        b=IXkEWvaGj2UmCvbDWWsWp83Z3qayBAMzikZJWo9DKQ/F1uDnbOnN3KQP+eCYs7v0YQ
         oMntMdh3SZ3NCVZGPT/Xzdpxct8hgMwgWEqT2pMC5xrUzNdKa2PqcpJsOPc2qIjmUB2s
         aNdbcmfuaEKAbK2WRWZeoyq9Okqrr6cyvRZcZJWMCRmc4edrp1lOsCMhNJvqmomCUFOG
         HPtSx2vmuRnvnQAp6OFP+SxyWG0jqEn514Z28M1LFTO17aMUcRP3CyveGanWIt6QUnzw
         Q5oRTaLfEXIJZIr/Bzz6YORpW3Cfx4eI6M2m9GnpZIVhFuRKz1S28O7Z5dSf4vIAZBSr
         T1aA==
X-Gm-Message-State: AOJu0Yx1AKGVg0U5N1fHckV8X1eeDrVw+ZLBrSOmR7NcAFNiuIwxonEK
	drArP65byLDU1YMPllnsp2T0L07ohzJ7cIkrlbG/CeLUc2hKjGjwCrF3
X-Gm-Gg: ASbGncuqJkkbNVmkzI/augj+r02DXtmD4p35cdWS5C+ucDERjp2pcmTrHkDsK60WPtq
	Fzmc9lI+tYlk9QYo3AghSZhL40mkcJcxS9JKD3D6cGFJfVnRysBExpVlqsY0dR8zlV1rCwnersp
	yB71zaSjqZ+AZKYWJD+STg4tJT6bHgAm11gDjnzPnYLYVrn19hlWv0JdiYk6/8GiCH1SqsTe6Yt
	aOl1q7lcfQHxpni+aIemfzmALi6bw0PVe27bGFk3Rkn/SKKAh1fDhi6C7asHe4K0fUtVqwl2C9j
	RXwgcbLVZZfyuUfvcD1xE4QyDxyAdsvLJbYOWYdVPtQllV7Cdi+9sss0yMsGSeG1ah/r1ttw79S
	nZlLsHtI8Pc7+3gn5M9oMb96QnA==
X-Google-Smtp-Source: AGHT+IGg3zVT0xBHC8unCOIMndGqmIBSmnIbkTlRYIOklBTBbBQUEpH2EOOhEkjjGuhnYQUrtxvkFQ==
X-Received: by 2002:a05:622a:164c:b0:4a9:ca85:1f8c with SMTP id d75a77b69052e-4a9dd39ad2amr3194341cf.48.1752002861302;
        Tue, 08 Jul 2025 12:27:41 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4c69sm85292121cf.10.2025.07.08.12.27.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jul 2025 12:27:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v3 0/5] repo-info: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <c1f871ec-96a0-4dbc-b84b-4add36bec682@gmail.com>
Date: Tue, 8 Jul 2025 16:27:26 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1991C27-9F57-47F7-A622-B3777BCFACCA@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
 <c1f871ec-96a0-4dbc-b84b-4add36bec682@gmail.com>
To: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Hi Lucas

Hi, Phillip!

> These all look like good changes. Looking through this series I do =
think that
> it would be more readable and maintainable if you adopted the table =
drive
> approach suggested by Junio.

Today I had a meeting with my mentors (Karthik and Patrick), and yeah, =
this is
something that I'll change in v4.

Returning the keys in the same order as they were requested in the
null-terminated format is not so useful now that I'm keeping the keys in =
the
output. Dropping this assumption allows me to make this code simpler.

> That way we would avoid the nested switch statements and each piece of
> information only needs to be retrieved once rather that having to =
retrieve it
> separately for the JSON and plaintext output. Below is a sketch of =
might look.
> Each key is handled by a callback and we have a table that maps key =
names to
> callbacks. For the json output we use one json writer per category to =
build
> output for each category.

At first glance it looks good to me. It still seems to me that it needs =
to
somehow treat duplicated keys.



