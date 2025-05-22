Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1E770FE
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938853; cv=none; b=MbXQxja6N/uEcI+TFutgZt1nJKUKE7AiE4fRh7DbUxHWFu+GxaApG3DRkI5D0n0uLkp7JDAEu4UKxZ+lQsQF+rXkBX3Lcv7K+0AeCl/Bx7/NIr4XqhMTzWfYiwGrQSfccdiVKOJ4kO3KHjGeqUPOwh3Y3j8LofQrum5zxGeh72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938853; c=relaxed/simple;
	bh=IrTt/wrcQVYkPyBiYncfTdtU/kBfSUTSb26/5Fm9xtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDX2QvdUzdJxRFR95FdXy8tI+bYf4sId7bMEYpdmqR+pyNrhc4/CpGSDFTSKRBZFrvdlOO+jTf3jYYjtryGldb1O/uygVYEWFA9RDx/K+1fBaGkTY5xiAfd4qbxw+VpOzt0E+fojVDNuVbwn46azbbGrLDhxaizRwoj8V3ZC6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6eeceb05894so11036876d6.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 11:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747938851; x=1748543651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StzlPjeEipQj+1Fh0hIvR1Lq/aq/CnngMh6oU3y/A64=;
        b=oekOrVEW7zMwHX3LX4DrrjqR2rDzGsuqNd6ZD+vcf+LFoUlMdw00dBhsoTrC+l9k1C
         oxYXr7ADjks8lmK9OqTu4Hyg/AU3ZgnA35E4XTIuv3WICDGvSrtdtIjmNBqhRRC83LC0
         PeAIKlfPxhGbiAEKdsEe2w0KxhNQz9M6mZJ+wQ+Z8d4eFTh+PVF5vIzVGWepFj2OmZn6
         Pn9PnJcyS7BBpHiaw4rFhOqdMkUP7XvG25qsaeyJBbjdhrIsQs2I7fNKGzr7kSrBB37I
         zAVUE+nDrTZX2y01usceLj1DoY0TuwnKfkvk0HJ++F66ixRj/DyEGEFrq8O+Azq5eK+e
         G7oA==
X-Forwarded-Encrypted: i=1; AJvYcCVEuUOwGkcj19DMh91q9EVh7UleEOgyyR7/RkTMLyexw9khu+kXxPqXwlHC5iXc75Tm654=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWCem3kWadVso7q06KC4FGeWqapG7KiELvp6K867ZSig0UJ+w
	PkDjMRLXMT3JoFKw89B4gbgO0tKngG9KiXnQDyHJ+KmHcBNWp7BrJvXnUfMZjh727JAdPxu8G75
	xiinr27g48VXY8l7mOX8jMpGWbVfWxWA=
X-Gm-Gg: ASbGnctyru1VumwboCev2RRyF3IYQ73huvqiP6dr4Pdsnai6pbciZj2Oax2jWLub2cu
	svZDhqXRMVsICaNYfolxsCocAN+ykqWfW5bYgw9F5EEMafAl1gbSa9dpt80Hw4NgZgaZeMmjb6i
	IMmE6xr9uSqCxv+n/4Lr0jh4E+9hm648KYdguyKz5c2m06pQczyN9IHzCCnHnbBG0=
X-Google-Smtp-Source: AGHT+IEgOdaVbbofqWM1Gru5cR723tjG+6CHx5GA+X6rOyJxRPEYQ1zn4wGON0RjFpNYsO35av+5yKF1/ujmzQgk+pw=
X-Received: by 2002:a05:6214:29c7:b0:6f8:e361:78aa with SMTP id
 6a1803df08f44-6f8e3617c79mr64808926d6.8.1747938850800; Thu, 22 May 2025
 11:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
 <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com> <20250522183121.GB14871@coredump.intra.peff.net>
In-Reply-To: <20250522183121.GB14871@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 22 May 2025 14:33:59 -0400
X-Gm-Features: AX0GCFv-CXCeO1yjkME6U3BpnrWTG4bQXUNRpUlBTQHE0Xcr6ErLqn4A8YMD-Uc
Message-ID: <CAPig+cQK6i1QdA-iAcpEybQq2GcXX2uKSaeN3_5GRR-5ScJzuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to NULL
To: Jeff King <peff@peff.net>
Cc: Aditya Garg <gargaditya08@live.com>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>, 
	Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:31=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Thu, May 22, 2025 at 02:25:47PM -0400, Eric Sunshine wrote:
> > It's subjective, but I would probably fix this a little bit
> > differently and (to my mind) more simply:
> >
> >     response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);
> >
> >     ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(respons=
e));
> >     free(response);
> >     if (ret !=3D strlen(response))
> >         return error("IMAP error: sending response failed");
>
> Doesn't that introduce a use-after-free for response? You'd have to
> store the strlen() result in a local variable.

You're correct, of course. Aditya, ignore my suggestion.
