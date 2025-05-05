Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF338DEC
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457400; cv=none; b=n/nI14iCtbRc0pKY8xt02QAQ0oCCfl+JLehfKIEErpaSMXOCfQt6gLBzbglmAn6Huk6iTH56naBjBd2XOwoLdr6C8Yz2a/2GuCwB2Y0pd5Y7Xi77T+OtRd2n6zRXBEiokYaFlABwMRv2PWSHqgx30SpHxZidm2Jx7wuYK42VeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457400; c=relaxed/simple;
	bh=AhIB4DBIgx2NqfLMZfjxAtN8uEsY3dy7HaNHBi1M0jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0JfuJsogFJZ15XsEkQxSVKs9emDq5oIp0hUg2NwkcAkZrNp8YIujTpzq9+iZKsPMhkzdPhnIvxdBQJGpXfSZVgGQha52Kyr0oIy4TCQilQekyClPMsR7aM8gwOS2Pf2KSLsRcL3USHwo2Dxu+sliM/nMoOGhnd1hAK7kYjKNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvz+Mpq+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvz+Mpq+"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476977848c4so60110901cf.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746457398; x=1747062198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVrv/gs9Xul5xnv+ySxA7JSkgSpd1AmaPhbJ4QYuiYU=;
        b=jvz+Mpq+pgCcYjzuZSpCrAXEpS4PRLFFiokIqHpgtgj5X6W6gzovwBglfJfs4igVeT
         e0PKjlDWHYCskGMDxN4fT/BY0L3L7o9uoLoahB1bj9CmV9P7zkf7kX6iIBAOdJHZwQ16
         3PVn/zwE19D8ABr67QrIqpA3ibmRtLei1fW5BpEe/Sg4wX5IPcjHi7Er7MjoDfpdwgBN
         0Nnlug9V5n05yKvnSj9au5ZD8CnFfrAqVZSNYCF2qvP7HhBlqYkjl6nmses9hd87M39f
         roeB59NrzdDZ9gvtYjdNospyGqmB10gfV3JzndkTcFVNzRqq606szssG4pUopo0ePaLX
         bfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746457398; x=1747062198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVrv/gs9Xul5xnv+ySxA7JSkgSpd1AmaPhbJ4QYuiYU=;
        b=VXHJaFx6OCLc1WH/STuOcw3sbFTlq76SUfPqyvPzx4yna46KUSOrc76k1BU39u26zn
         RmEkjxNSwUT4dZayskWkJ0F2XoQLTw1B22QY9XeU6y6Gs0BN/hmPgksOJPUKq7Wefo/D
         vE7uq/QNkEtvnVZYZqwgoUfJBhnelG5CVMgKqtAKxzbv9WwaN8CpKSPI/El+OviS5OVH
         MgaQepG474FD3sOZYl860jeaVeew46ZKSqgFP3pbhD3xbMrkSlpfgMzZeinmzcZn8dk3
         vIHnINqQEYUYQEgwm38FpPmvSSQy2VHd6XRYRRpJpS7akd+cTFqTyDG4xuEZ5GsvMSAi
         XdqA==
X-Gm-Message-State: AOJu0YxMLqCjCvAdHheaACBX7RDt/GF1+8wTE0iDAY49nPFNN7ucAh+t
	nGsN5ycnTRaM+tH7HpChoLLH/66yr3ZUvFVIOP6fECgL7gc2BdlKjmYLKNK6NeEcDg7Vrft0nDQ
	4reQjNxvi3GEqa2nH2+a+TjVFzGU=
X-Gm-Gg: ASbGncuKuq0eY5awYYwzdAgPQukCMLi4nkKJaY02vvkUi5191Kskm3abVS7OrXH6kx4
	WSSE/OjSxVtUcgALMyy0/VISin59Yc8E/WYJkEEoPlMxJ3E/84nKXKM9fNUnLCcALBzaKtwtHWi
	K5jZqbLndMsVxnLob1vOFMhF3dUn4hIiir6UJtHhPJLKl88SYWiGQbuw==
X-Google-Smtp-Source: AGHT+IElFxsqs4pmht1nFs7NKZeHbLr4hhNA1ognkDwWxNdRjLX+od00oCH9CMJbddwYxXkanxyiqSg2T/Yn7cMKhmI=
X-Received: by 2002:a05:622a:13ca:b0:476:b858:1f2d with SMTP id
 d75a77b69052e-48e012612d6mr113542581cf.42.1746457397838; Mon, 05 May 2025
 08:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqecxk3u5l.fsf@gitster.g> <20250503060736.587286-1-jayatheerthkulkarni2005@gmail.com>
 <CA+rGoLfFCi-q52ABUr=0O=pu+qSikcomSk1akHWUkfAfSf=pZg@mail.gmail.com> <xmqqwmavqfvp.fsf@gitster.g>
In-Reply-To: <xmqqwmavqfvp.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 5 May 2025 20:33:06 +0530
X-Gm-Features: ATxdqUF6GkyO0LBipOXePebuSaJRc3KHYtt19S_w4r3qYgq1MeTKg6p1S-rxnCM
Message-ID: <CA+rGoLe5-Jk=nQ_hv0gVgNH4BTdcHDZ1SP7_Xo9rPUkNADFNPQ@mail.gmail.com>
Subject: Re: [PATCH] dir.c: literal match with wildcard in pathspec should
 still glob
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, peff@peff.net, 
	piotrsiupa@gmail.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> >> +               if (seen && seen[i] =3D=3D MATCHED_EXACTLY &&
> >> +                       ps->items[i].nowildcard_len =3D=3D ps->items[i=
].len)
> >>                         continue;
> >
> > For some reason on my computer when I check the formatted patch the
> > ps-> line
> > align with the (seen && ...) line perfectly
>
> Because the quoted patch in the message I am responding to has tabs
> expanded already, probably by your mailer, I looked at what you
> originally posted, and it has these lines:
>
> -               if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
> +               if (seen && seen[i] =3D=3D MATCHED_EXACTLY &&
> +                       ps->items[i].nowildcard_len =3D=3D ps->items[i].l=
en)
>                         continue;
>
> Removing the prefix '+'/'-'/' ', and replacing HT with ^I for
> visibility, the above looks like this:
>
> ^I^Iif (seen && seen[i] =3D=3D MATCHED_EXACTLY)
> ^I^Iif (seen && seen[i] =3D=3D MATCHED_EXACTLY &&
> ^I^I^Ips->items[i].nowildcard_len =3D=3D ps->items[i].len)
> ^I^I^Icontinue;
>
> As the display width in monospace for "if (" is 4 spaces, "seen" and
> "ps->" would align only if the third HT expands to 4 spaces on your
> system.
>
> Perhaps because you are telling your editor or terminal that your
> tab, unlike everybody else's, is 4-space wide or something?

Thank you for the clarification.
Yes it was the 4 tab thing, my editor has default as 4 therefore the confus=
ion.

-Jayatheerth
