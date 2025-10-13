Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E82D6E44
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392544; cv=none; b=hSnn1GsvCIXEc8h8ZCp8VXXTM+ZNNQfhjTBvuXB27E+5hKOSHWrVdpKICQWbxpz1BojOj5Noehp6gk9lzvTlMZStMxmD0nk4QxcsYBDdPre4PZ3Bw5ViDYm1yPIoxx0P6F3dNd7OpypGm0hCujPljhfkZLo5R+KX+6qGduXHX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392544; c=relaxed/simple;
	bh=6novtz2dxNMteXuMFwcrAOpRBBX+OZMWp3dgRx7osQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBhhZJBAmv7RPfc8PIJSIZhrWrAQzyzaOkVT2oJByKzX4lrgSd3ILPZr+No3tRPhs1/b/r77oiiqmWC83kS6qPAI3MMu9CHmJ5toXljH9yy1QVajGJ+oCEVm0w/wKbvRf3FvUXJIhons8HzJXOW+a0TX8FHP8tp1h7ns/bYP9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC1OPnnA; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC1OPnnA"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-86278558cdeso635301785a.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760392541; x=1760997341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6novtz2dxNMteXuMFwcrAOpRBBX+OZMWp3dgRx7osQQ=;
        b=OC1OPnnAuAbd8Z75DJP26BBO2zxdYOTivpAg+2JwNiJxCm/2vqOymwNAGqwY6IP86v
         hU0vE3J3ph3u/GKOnuQa8CgnX+0hl7ciPYHmQvgU17HbkV2UIHP15u/WkhTJH0/lRkWv
         wLZy+5SxIHrV3hFM2cIel5umiC/PecrMashhoHZN9oCiWsXw/DNTmUrM4jAor126sX/n
         VYVcNPaLTlOM+h2NMO2XfOHm6bQQxQNhL/zw4iT572aIbJr1YFmUp6KKpXfanThyygLj
         hEfBsHdxybVikWyheMEbCGZ7zGjP7Jl9/7xZp137ENwxh+hCcUOz4Epa9EsksUdz7cWP
         Griw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392541; x=1760997341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6novtz2dxNMteXuMFwcrAOpRBBX+OZMWp3dgRx7osQQ=;
        b=GD8mB6BiGG5dh+wj+c8s5lagt+RWgNXHt/2QKHf6m4hNm742PbXEE7KSscSsheKStY
         +8ngDz2hwcCcjE1he/IIIawYcDdV8AAWGUf6DEjLJkA7uzj2e8/R0a+066Hhr6JksR4J
         djEo06CsjNA/YUGV68HihgefAGrMKugwqNAl8JiHQ31wiQGjTL5QZePa9Je6i1XvlOLP
         diupj6hP1ggipKEBZqK1REJrfqtSDQrmb2hfOTYa+zu4JgUSwo3QpRivTqX745p3tNe4
         jHc1+RtxN0z581UKyaV6+V+LsEv/yTruS5p7ZrFmU7S43WNrNmG3x7r1kdKnTgQzFMSE
         EX+g==
X-Gm-Message-State: AOJu0YyPPSvRGT5qWMWmU/Jwo+HefAI7PIXAtCIehILybNPM0DZLRAoO
	qxcP3KFXEeUdW4MGQa3RqSZce2iqR99Zozq1EZf0A6GRYf/7TniifEv2FYCzP9ZrHFcU1kr1jqF
	6II+dRo+ZqVtruulLf4bSAV2dp6rYAayDnXk3mEI=
X-Gm-Gg: ASbGncsMFPRhQi2zjiAvMdyWUdp6600raCS3UnUk8ZBATzauYK1bzazzAezFl75tZN8
	nwCKRjufrTUQ6pM0b/mAkdMMn44TuwVXC8oWf4PIEK5A00O3y4FSbiWlteXlLvTK5hQV7ZZmGDg
	wjqDol364CQY5wdiPCXbRbTv7aPr9eWy5sn8YBPwvJqbj2/XE6poOetIaOv237Ua7IlXm2eqSnG
	NOuOpE0Xs1Lcmss+Rb2sxwgWbhmGQ1AMDkEYDWcUEqq2+VZhcOk+OiJzOe9Xw0s9Hm6UH58
X-Google-Smtp-Source: AGHT+IFOCCc03+ncTzGcRXaIJ4nZs1UL1FwAkVCPGDXu6qmgdaQt138ToCO7eQ8WXWbfJLd89GsAgfduqOgXsL0v5rY=
X-Received: by 2002:a05:622a:1341:b0:4b7:a308:b5b9 with SMTP id
 d75a77b69052e-4e6ead76899mr327490181cf.46.1760392541448; Mon, 13 Oct 2025
 14:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013165320.201333-1-okhuomonajayi54@gmail.com>
 <xmqq4is23evz.fsf@gitster.g> <CAFpMFfBXhfy7ecBzR-cnGViivQG3AHGrQ00vSTnVY6OdxZPSLg@mail.gmail.com>
 <xmqqzf9u1zix.fsf@gitster.g> <CAFpMFfAHA8OfVXKVVSSAQ5p+B8ngT3p54on1HpM+n2qs3P1rHA@mail.gmail.com>
 <xmqqo6qa1wjg.fsf@gitster.g>
In-Reply-To: <xmqqo6qa1wjg.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 13 Oct 2025 22:55:29 +0100
X-Gm-Features: AS18NWChZWbb6wdFAdlpZ4ZyAXaJL6bZteUw9nHkiiRcIPF6f6npxnMzAZ0qiAA
Message-ID: <CAFpMFfCXy_R1iHmDDo3Zr4rhCpVukSqSsdZ+ycEfj=_6Q45vAw@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it, that helps. I'll take a closer look at how const is handled
across the hashmap API before removing the NEEDSWORK comment. Thanks
for the guidance!

By the way, I also sent another patch about clarifying the SHA1 usage
for patch IDs. Would you mind taking a look when you have a moment?


On Mon, Oct 13, 2025 at 7:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > Thanks for explaining! I get it now the NEEDSWORK comment isn=E2=80=99t=
 needed
> > since the hashmap API is supposed to have cmpfn_data as const. I=E2=80=
=99ve
> > removed the comment and didn=E2=80=99t change anything else
>
> The NEEDSWORK comment is about going even further, starting from
> question if hashmap should really be using "const" in the first
> place, to sort things out among all the components involved
> (including other users of the hashmap API).
>
> A commit that does not do the necessary study and just removes the
> needswork comment is simply irresponsible, no?
>
