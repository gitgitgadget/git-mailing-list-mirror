Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60240352037
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965675; cv=pass; b=SmSxrO8XE0Q/x4CaCISK1dJqWpnkjODU60X4BEnKBUvleBC29eP59KxanymTGiFw6Gm/RUneP2KeL5o+3kM2CazEREyx7VoVx+JudtARQNT8fp0GvRgVfah0CnOxxLOYMgPSowAsNcwG2pzS+RfekdJkXeDVCBuc40ASiUk/yxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965675; c=relaxed/simple;
	bh=UeyX0WAhckYhquuL1Zu4kTMsqELzFfOKsRuXSu/wpks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/zfnt62FF3n1bh6oc1oRkHc6qEBhEg5td0UJ4HcSfiL6HHgDvgCMYr1NMACrecuSMiumvVqJXPRS9Tq/EAsWSiyFhMQ8DDVxALXDcc4JfXS/Q6hO9FjnUhgSNLBt5gCAiALfmjzZA8gK/O4qQLqHS+bCMp9l+Ag5lFR6y8sfEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl2TsTsR; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl2TsTsR"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4414d76270cso741986fac.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 21:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782965673; cv=none;
        d=google.com; s=arc-20260327;
        b=BMF3hwMEUHqdHYQ5QAT2ZSLCyKNwcmJaDZrL62VFlAxo5yjhCOLrbuoroPbidZQn56
         JcFYy7U5TqdvXWTd28gL10OyXtbBqx7gS6pO0ShkAEO6HavfiQ5rAl8pedv7/v+zoBfA
         q/JQ4w0Wy/ByiNgRSkFdoy2/QRzh3G5E6WIo3QNdrUXrgl4/dkl5/o8Aoantyj3ikAeF
         ThHtR77SzEPam43nO3b+uB+Xj8owr3X+Egym/E8GGz/41C0k8fvgoODCaTb0Fkcfe3Ec
         efm9Tr8zdBeESVnNt2gOV0ZipJ97j3uL/uufNKU9gUvCmhph9VW9gZ+wogx7/oUBTYkF
         99GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IJ2I9PoynltiDPAhZj1tU9x0pNeezSbnay5jncz9kq4=;
        fh=6fB9OHRJAX141ctgJiYd+bC9c/sAAlLnEU111mjDxCk=;
        b=JehGKyubbyP0cyh8BBbVMHbhFULS0sFlJx7ZUVZcsG/Sas18kBTqrdpurRP9zW/d0U
         jI8vSIuutbTfhiiXfJK30DCZAnP44vzuoE/PMWjF7savzNTNrLY7UoytQx8wP1XoUnQy
         REJHKxP7W17E+Zg9bLSjVsu0Zg5yrnopMCVBBa3i5JkKFwyaBcrGug/QCcjnrePRuhNH
         rWTDg1w0z6WnASI96DuZ9r3FiyqtIV8p/yWd0w+06TiQFz15AjGcTrJgjsTcnXIxETp0
         6ghOb3CE5LfHOuYEas7jP16O65YcD35hynC+T54iQeKz9QTSK06YbRP43mZRIN7NmIq9
         azfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782965673; x=1783570473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ2I9PoynltiDPAhZj1tU9x0pNeezSbnay5jncz9kq4=;
        b=Nl2TsTsRyqmW4CUha1SJVkPMTEec4IvKlDG15iijeN2LEch3fc55/gFqyDEQs0l2gK
         zBwByeRdRt7dPiIJhkum80i1IkeKfX/P+sIOuDUoM887cehPvWAc4mSFIgwuhRlA7utJ
         bJ4s/pgvPiwXjJXeKYZSlUzheb3Ni4HiOan6eNNksk9WoxecrrIOnep0br6MtJkIoTVS
         CtnJPPg4ytL1zA8U7VeAAZ8J0tJnyksXD+qHw1O8zw4j2K1n1vz83GvmQVsyI+GMEbzY
         PKKtlss9AIkwUkvO1gc0nH/J9qgU4eklFgDJVYDJEs9CRWGL9NohAtO8Xa8clWrOUPEg
         QPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782965673; x=1783570473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJ2I9PoynltiDPAhZj1tU9x0pNeezSbnay5jncz9kq4=;
        b=m1mMap1qIq7QpCH2j9pqDpXkVNaJboOSx2O9RMwxQwigZ3SisihPXon0Nmwj4jwtMv
         donv6nnrDnOyOYCxU8wrd1g+xeUk0OiwKMg8IV+wn05Gd8QaI47bmp4mRkCVuenFbKlS
         lBEDcWnZ7cY2/MWFRrev1C7E+vjeYkYxqYMhFoAwlgIRVIHuQCuK1qNyK4swiPP3PYsD
         rozM7tXtLdkbsnYi6aRg/VfcuKRvkA4XOAMPN3eOQy4pzIcw6UCqmUNiodA1Y8nJogRQ
         E75dl1XqdxnaYYC6AyDdrX4u03+W2g9OCiorZwmPZAQrguKaZf7y61G4UfJB85gOa7yx
         D72w==
X-Forwarded-Encrypted: i=1; AFNElJ90+yZW6D9KT260FNUwdrhP7WL2QhF49rBwcJy9FmyAXaFY8o6wJPMxxtwcWlL66oXvFds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAi7li9YQ7z0DUB+gNJ0JUh/gZ8PME385p1T7dCdWJ0URDVGpj
	V3BTrJ24UITEbC92seNRIahoylT+fB7vucVY805Usjud0u+mj2xNULiA0JpKLuef1vPx3VkuFxD
	/d3/J2c1ljJVQWCb7TwQgmeYi/ac4v8/C8iwN
X-Gm-Gg: AfdE7cmQlZGDNWzu+XZMF+lkzZEElfnpxTNFoZY+djqUhj0Ja/V7z8rQ0EoZRUwG6QQ
	Nzf78GQZM+8MBBKs1Ks+Vcva9xt+d9TmMP1LAtthqjc0Z/YpE658XGbZtD+/nFfCkJrj+HZ3hVM
	UjqgwJ5K5TLOd2wXhTmSD0rGM5Cbhf+fjF2AMLnJlNhm2t9JmfHB3BLINvrqoXv2LTV9gnM9khc
	Fp2mh4KyZ2/SlUylTr92570hakeQF2B3s2NNBZekUpssKK/rh5ljHbOQtYZ+xzdIrvwrK7rnI1O
	7u+naPsKMqbaoQohko2+9RoUx3mWieFuVI4+OrGjx/A6xPMo50wFIgxGodY1k/hxbJFc9QuCnuo
	TKKLNN+6FLpp7h/c=
X-Received: by 2002:a05:6870:cb8b:b0:43d:343b:b8e1 with SMTP id
 586e51a60fabf-44cab98e63fmr2928918fac.31.1782965673255; Wed, 01 Jul 2026
 21:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
 <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com> <3a589ef7386303075413f388e61c203c4e325d44.1781323575.git.gitgitgadget@gmail.com>
 <aj93BE8MYatQAjoy@szeder.dev> <xmqq4iio59uv.fsf@gitster.g>
 <xmqqldbz4f1a.fsf@gitster.g> <xmqq4iin4e1i.fsf@gitster.g> <xmqqqzlpt543.fsf@gitster.g>
In-Reply-To: <xmqqqzlpt543.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 1 Jul 2026 21:14:21 -0700
X-Gm-Features: AVVi8CdL7DsmFPSMPXS1tdZuJlznbIULTVJPzmWKDuCOgzkas1HfQnhUWwWyxVY
Message-ID: <CAC2Qwm+-r0RphATu7UiO7yLn4Phuzpjhx8NC339+DwL6q=nMDw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] t: convert grep assertions to test_grep
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 2:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> > It may not be a bad idea to go through "# lint-ok:" introduced by
> > Michael's series with finer toothed comb (there are only a handful
> > of them) and see if there are similar "look, the file we are
> > grepping in never exists with correctly running Git" gotchas.
>
> In any case, I think SZEDER's fix to stop grepping in the file but
> instead insisting on its absense does make sense and it is now in
> 'next'.  So perhaps this topic can have a small and final reroll v3
> that omits change to this particular line (and possibly fix other
> lines that punts with "# lint-ok" if needed) and we can declare
> victory after that?
>
> Thanks, all.

Thank you, SZEDER, for the nice catch.

I will apply the suggested fix to the series locally, and go through
the other #lint-ok's with a fine toothed comb as Junio suggests.

Appreciate the eyes on the series, will send a reroll soon.
