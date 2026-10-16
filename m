Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82313F58F0
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184969; cv=pass; b=gWEM693Vz5e9o8/qQzrWDEC1q0kWZhRnNeieSgB6DHJSdVMxdJRdG8GR2WRwbBfg+7tw/ZpRlMdH7FCF0hw6++9LY59KDRb0AFwDJGWoRkjoDjKQIYZd7RvDhT17Bemrpw0kDk2BmDP5L0kQKb2GRkJd2zYls5iNkB+eR4IiUBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184969; c=relaxed/simple;
	bh=n8cbLrnIDe7NMnLjsq/H7WS4nj4L64hB0Lt3/iurToQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9hUoGUytAazyeNpewUrLu7ZchrH9Bl6MYiXRT4aY2z58wdyNPXUAoRGJvrlL8t6Ls9j165xTxYayPZysFnT3NArK8V3qe/Kqd2DxBJRaWKlfxoHRZlk1GOr/iZ81RO3CP2kHsWdP9EIG/fFEEfqxFPP2Zht4ZLei28dJ3hGYsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/jtbQqT; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/jtbQqT"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac9d666d4eso3334977b3.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792184967; cv=none;
        d=google.com; s=arc-20260327;
        b=MRcPKUlVBm9eVD2IFZhZdgfNoKfN4DqBNEl0/V3Kddh2Ik4Jw1PhQSiIinxWalp3kC
         TH3JiKjgAGRAr4f6cBJpYdeiMySXQkJew2uy8n3lQvK++gyp4EgTR51Ru23E1HvHSaGI
         qestM4jsDFu97rUtJcJy5lWAv0r/lSAwjVinxhE0U8zM7g+D7KD0iMNllGAxxEK2nP9d
         ajJpbZuy+w9dBuqCGKMkkFUuqWE3oL7N09rOgGa90GL46n2tKMDsKRuJ9OQDFjIFziaf
         4jvF0p2VVLCeLo9uQD/3mbMpz4ws33wON8kOMF65lHz2ODvXYOwhlZLxnyBe4xsFqjQj
         PKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hW08u/Psuw3DOdZ72g0XfNEl85ka0YqkN/w5P3ASBfg=;
        fh=DZFxOA+pvaBfvZamJDlXjlOUUS9X/BEuyaMm9Od2VNk=;
        b=JckR9nX7PWvD6ZYuzXhmUP0a7FbAeacvTs+tHTrfkZgSfy43xoUNBdYPyP7b0saXsv
         LU58wAZGdyNiOFKw/dpotpqNs3XM8CEPa7bC7VqA7BJKEL5hHhoEeqkrIJm3Gn+GhQXy
         ZhRij99ndXWcwj5+xblEW9kEat3uq9+wD2+MJQ7dXPI2S8DPgZhW0T9b8LymElQYkUnx
         /biTnJ8evdXYar/z/L0RiWBD15JlpvbfOm+zbRK5kX2tA7QhGu0bYmc74vQ5EUJeJCPM
         DsWV/oLeXEIEGsPTJqbyzsjp3E4FrD+ESByjW53o2NvsuXhE0X459vIIMKcn6l90J5NH
         qIsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792184967; x=1792789767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hW08u/Psuw3DOdZ72g0XfNEl85ka0YqkN/w5P3ASBfg=;
        b=L/jtbQqTZki5slbpKH24oAMPVg3WyY18OrSA6HUITaDLPS3LfU+/RoLbn87NCN27li
         CXoxVVdSYt6olBuHaaYN8cZ+P2SD6x8zMa0hQA5RAmrB95wsOyAzw8L3L+RVQNam1Fe6
         ty3YHhjczWpNalGcX7LIrNx5LVLB35FW4aV+1z5r7kYKziGiZ+7X0P4Wv6R/obdicjig
         8I1gnb2lb/TXVsqF+qe3yweIL1oFZssrlIT+4J6V+BENenSSoGDb81JuMKNRakco55WV
         izPCAGiTjvGj5/b5wPImEn+g7n1kIVhbtBWYMmyd5s01s4sBWt02MVLEfviv5Sp1wM2m
         +yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792184967; x=1792789767;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hW08u/Psuw3DOdZ72g0XfNEl85ka0YqkN/w5P3ASBfg=;
        b=PTGWoJQGYNtlZtfsGw7U/GNgh+ziZcBEwwvK0xj5O+vB//pwU13KSOYHVpUmiufGxc
         4JhWPTntKLewCFMcDzI15cKbpQFH08Tq1hEwzp+fUAzbciRC5fUcGS5R2KALJFR9idWH
         yv4EKRwGwTBYwlYB6vM2RNK566veCDA/b77NEDTEandP/X7WCVl8jzSjiWAeWbT5VtFJ
         f5GZ7s4aX+KT+Kbrk9ww5Z3G/9KQiO8kp62UnEn21YZQdYmcPXJgDK1q1zTv8dU/tXQ6
         GiNd2f+/J48E/d+KEbws7Eodk8KWJdFMgofblovkXkrSY9GYDQ501r9e+yBy/PJYpeit
         KjTA==
X-Gm-Message-State: AFq9FYLpeZfawo0dW+Ry9/hsoT9/pCX9URWLUQQ1GuWq6z3ympNf/urx
	90p5aJN1y1IrM698blhVCfp1/X9Bpu3WarAqMlwzwdiSLkou20AUR5yz+Ti+dTNUTSNNnPtycOc
	8Uy9pYkBS7t8DCrXTRcx5PocobU7lFXC4oKR8pbAXORf3
X-Gm-Gg: AYBFou2GZXeQ8DERT3l0oNHUn9qcGJb4E/DjaXq4zc8Z++02eDWowgQFVkl5licURa6
	jEwcNwQm4QfYGL7QBpkrOsCC26q/Guu3cTbYk7Ejj6EpvvVDCU5GuTVbdzRU++Yo1F9yU1CYwwl
	1S14npAZGMKYQ/Fk7aESZCTHEIl4V2c1Ci3VLY2UIGxMmoohXDa7Kjg1FVxSoOlrLuAudL6m2CH
	hMr94W4esDkcs9zEma5g5HXynKX6YPygRAVJmcVToDE7eB9kco8Mk+31Zys5dVssEmKMpnXFwBn
	//Rii7G3z1ZibpQbUnkcgl6MIpgve750soGbUsHyJ+aXf54ZNli8hTRsHqO7yZGHV6JxJbtGCoN
	eltdXU0MjfVHqlikw2AMd5r2hbWJM3XFqt2LaWBSOzD6TXlCRcyn0lvVX0QMeymg8wrslWAdNOf
	SvrKQ1+8zEGHeI75N/OX/Rdf9LCP8Cp3XP+RoHd+sFnJPKVyrwtplOMPw=
X-Received: by 2002:a05:690c:c509:b0:8b0:a8cf:f447 with SMTP id
 00721157ae682-8b0f2189847mr4520937b3.46.1792184967519; Fri, 16 Oct 2026
 14:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014155529.84134-1-okhuomonajayi54@gmail.com>
 <20261014232739.23021-1-okhuomonajayi54@gmail.com> <xmqqcxtaonu2.fsf@gitster.g>
In-Reply-To: <xmqqcxtaonu2.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Fri, 16 Oct 2026 22:09:15 +0100
X-Gm-Features: AclHuK9OFzd8KS9oOS2LIubaJCf-y_9h2dqwRHOg-0qWbcBd2rPZptis2KQC47o
Message-ID: <CAFpMFfB5muJzEit4sGa5iuQBSvBsKS6gC4xALKV8F8bpvpx5ZQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH] credential-store: add lockTimeout config option
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> As it is necessary to keep the above two in sync forever, it may
> make sense to do this instead:
>
>         for v lockTimeout lockTimeoutMS

Thanks, I've turned the two tests into a loop like this for v2, and
wrapped the long lines in credential-store.c.


> Ahh, the key to this test is that we make sure "in 0 ms" part of the
> error message does not say "in 500 ms" to ensure which of the two
> variables are being used.  It is not like the credential-store command
> would fail with 0ms timeout but succees with 500ms timeout.


Yes, that is the point of it. I've added a comment above the test to
say so.

> This one I I am not sure what it is trying to test, though.  Would
> the test start failing as the machine is loaded more and 1000 ms
> becomes insufficient?  No.  The thing is not locked, nobody takes a
> lock competing with our test, so with any value of the timeout we
> should succeed, no?  Or would it fail if the timeout is set to 0ms?


You're right. Nothing holds the lock there, so it passes with any
timeout and does not test lockTimeout at all. I've dropped it in v2.

I'll send v2 shortly.

 Thanks,
Okhuomon
