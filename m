Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83A261573
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295757; cv=none; b=TlDRwM9eVeZPWAPkLzE1m5r9EUeK79AVaHkyloVlz1WMw7C1HL3kCgrZLdFjCWws3157aJnzqcaOtEfWlfppaZ9QdXknTPMDRh9YzWv39c83Xopa3kXmJhXesNy3/Ol6EYziAW+Gt8yElZw/WpseQ5z8mHIQZkK2h86Rvrq7uHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295757; c=relaxed/simple;
	bh=KELucDVSwk1gRAB23tn6l01ao3GWzVE+Zhuy+/1bPxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjrH51NBOXJEuTLdjuYRGFt9gRXxYFGqHUYItA+tofmZITNIPwXz1Fl2W+ZjQtoJ61B0LFJlKQ2eF9qTI8S7Xmwz+7HOjYcXhPhAWIXLltacmslUAEeyQp7nXdLQcbZDJCMjkuWRQ0fLmJLtOY77NbLqoyoqPKC0wxJnjX8+Pmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c02e4450a7so84535285a.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 09:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295754; x=1739900554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KELucDVSwk1gRAB23tn6l01ao3GWzVE+Zhuy+/1bPxg=;
        b=lIQlyiUO97N4QutjfhRXtKUEUCWETshEOH4H5kj1l7ZKysvmXAGPz7nLnE8j012L1q
         ByhVHYPbuWROBEUu0wqRLRcg4gGp3kS0RxYCegEbPdgswYHfCDqdoz7HNIQ275cSXjF+
         W460ASi/EkMElyoeAkzrKCPtfutQw2dojhn2IMhG9wqdwSs/HmIjnkt9v0V20skSZ3wg
         wWj3XkSJsefz1FdB+cXB49EQetDwxu0HaGeffiNV4FEHv95iFK4iXesVyU8MBWWgzhIr
         t8uu/txujPoiBMaszDPIiUHUNOmwJ1bK6Q3Fc3hSNUy3rK0Xk/o7RNkDtUiFILg6Sma3
         4N6Q==
X-Gm-Message-State: AOJu0YwJCbOjCE81Z1tVRukMGumzr0M32MeXuewxVZNtn5649A2wiVGE
	ZAAUNWtjFtJyXEyhlxAhIoIeb1iYqh0jIIMiAs9L6vQcxXMqIk6fn96Y4BUIqrSqJWwulOfhuQa
	3FhzDW+PA22+OFt8za1PHMKA7S8s=
X-Gm-Gg: ASbGncvIbxogPigRZXYoVFbvE5CUxwo2RO3zvY1CGewf03h1icMETbaOJ0Alp42bsyp
	YFXxP93ZuRAJJCpsKD+GU8p8UZ+tRaOmfD1URjhBni3iCq9h3MlQchSSjHfMoqepJ5pcT/AOj47
	ukkQuD91TGFj4BbVGESOCGStVhhDwveA==
X-Google-Smtp-Source: AGHT+IHp19gJLCbf7wamz8NRRaR9NNDHslMYuT4kFMJ4Vhmxp/D8IlJWNhUAZiWFTXMf36fJR1fqpiF0q0MilnEkZpg=
X-Received: by 2002:a05:6214:b62:b0:6e1:860d:6987 with SMTP id
 6a1803df08f44-6e46ed77327mr1496076d6.1.1739295753690; Tue, 11 Feb 2025
 09:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqy0ycz9dk.fsf@gitster.g>
In-Reply-To: <xmqqy0ycz9dk.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 11 Feb 2025 12:42:23 -0500
X-Gm-Features: AWEUYZmHUP_hsVF54QlAoO_JzWBgImD0Hb8lYn8AYe4QdmmM52jnvWV8SEq33Bg
Message-ID: <CAPig+cQ2miLtU1HXCcn7q6GqTPiBAqKT3gGOMoug1m0VHczN1g@mail.gmail.com>
Subject: Re: [PATCH] doc: centrally document various ways spell `true` and `false`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ivan Shapovalov <intelfx@intelfx.name>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> doc: centrally document various ways spell `true` and `false`

s/spell/to spell/
