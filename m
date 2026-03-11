Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F123ABB9
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266106; cv=pass; b=dV+CVpy/mP2lhj0/p6NQorfs+Q0cixyWA7yGRs3WLD3prNBbSXxE/QvXVcqZDFLErdkVIpxO71/dIJI4Q1MhxW7U+zXgtOLGxVXIuQmdcYZNQYD9h3r6pJ8Lkszd2YJhlbeqaer8N83ikvx6CRT4xxPc0OwxWptr3IhY/pLlM0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266106; c=relaxed/simple;
	bh=U7cxx8wlqPzMVCNiMD4/ddlyKuuswxCpMiatfGsFfIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkigjkrQM9lhmv/E3dpihgWjZBvLu/gM0J6lrv4NVCUDMkfFuMlwgxgHzPSP8EQW5tiRD0karHj58IFEjfFHzMTa/KD5RZc16qXd8HmyTjNYvSfky9rWjGWTED8pBngcDDLvM33is+10x5Us5Ig2BqqE1Qrn/g08r9B1Am7OBGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12714f01940so36753c88.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773266104; cv=none;
        d=google.com; s=arc-20240605;
        b=BlPRQ20cwT67piFwsQpUMSJd3+C7R5hb+ByTWSxK1Ra31cU0pkmoiM+OlrFTmMQ5cO
         Qd2a4ZAeoM0qOX90shnRFWZUpSMX3OyqXVSWB6TZVkjj0yig2KWmAeqbee7jU76u08z1
         W/nPyTaz64QrmS94a3QEXY+1Va5hT2P91SkCvgXSGtVjySU1Ik+d6CPWB9WjCsQH1N9F
         K8v60kmu9q+VukVTJgCL2b4Gf5Ih+oNqoDx2SIWKt8RNWBvNRSHZ4/zQvuwkkkkGcpIB
         fFxtMiMd4ZW59bUUkkHfuxDzpwnFn3yS9lH2IgqC/5KZbf+dTnSErMhAMnl7mBFk3oSz
         8ukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=CYqzgYKkK7GK/QaCjw2RA3EzCUnEpavDsBBbKUsELts=;
        fh=fz3N1wlezk3+Hi3rSZJlrsoKVJQGCQPJE8/nHCLlTdg=;
        b=USDMMgMWQE7GSKGL30+N5ZUVOMsvhC7GGon8V7JT/EFWtkZCIq0AIfxI9jNzXaowbR
         gKr05COby++smqBufjlyt9JUq6m4Kd7Hw34qxtoFWu6JIdBIbJeV0K2we+sCJqnOi7Vh
         BT9Htqtt7XMUWY+sOQgrTQbrC7ZtIL9v3Lgn1gdb8bBgL/rF9ElDV153DAwMcIflNtnh
         OUJyYSm4bDeM9PLzY4ipXHqlEwd10KPvRnsG7BYWh8O08CwQ03ow7FChZXCG4YQmP68C
         rKCsE33NI1z3NK41T0uQ24AkQsTShmogTMxXjKnFvZnNzD84Xa+KWzHkzykO81TJ5oz0
         tvRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773266104; x=1773870904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYqzgYKkK7GK/QaCjw2RA3EzCUnEpavDsBBbKUsELts=;
        b=oQaujYpROMWM2bB08Il+hCiZVAhHDuxujeCDyO6UpMAfjLp/3FGX5qJ5F6ELz1Sab6
         ERk9KKOvDcK7TuNcU39dk/mwDb4DC77T5qZV82mkhp00jz1eYT5YbxDdS2OAh+ipPC1P
         htFeF7qqZC8o4mRslCq7V1eUPxs+ImMAGDi6VeJbyrhvTKiLoNjNYlJ6PenIXpjkDNLE
         HLSexOdgMdDZrEO7S9GzyMe9mJN2yN1F33DzOtYe5POy7yWnIQtt7ZKpZ1mttiHHHagw
         Oqo8EFc4co4Y/5RCCi+bqLAGoEROtTdqAPS+CNMcvdrr+U0a/BGzHu8qEYbKImaBANDu
         RJng==
X-Forwarded-Encrypted: i=1; AJvYcCVPNPukA0Q9NDyvcf1/hLyN3XMAnMz+br+Qsmr/slK3xrN+0WwqeOMgBdJMUwG8nZOa4xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFkfUt9cTgt4wO5H7+nDqI/q2gK7tSvp+CnxYfebTUrchv5F5
	KXdkQ3jU9CCqXPEZXrphL4ekltK/cpli0oFQa+PLUGL5Gx+XuJQViIzVdCTGeSaTd7OdNMo80Wr
	ma6XEbAiNr3zQvROvar9GfwtdtAmEv34=
X-Gm-Gg: ATEYQzydy4X2A1KhWgVE4BhGIbfqyH/Ydo8N1ihTfW8ixk7ihmBpMkeTUhrIex5b+uV
	0RSltAzkc8XWm8vzBSlqXmSEkW48Eul4pymWardZMpPlfjmq24WpOJwtuWkg7snDcw6hoT87tOp
	sWXOAMbXF4kCnaeN4D4E68geEHmAofkQd4IuSB8OKQtL7jy8+2fERQZxiPLu492z/V9MSVwXXvX
	oRMKcr+FbDzM3IdmA6BWEKYUbFI8khRgwMNUPwcTqLM/8XRjx4jh4Um24yDMeJp5Jry7yQATLJm
	4/N+9smeBYZJf3LSACzfRT5XXMC3lMQ7Xme0h2ko
X-Received: by 2002:a05:693c:300f:b0:2be:7eb2:2ed3 with SMTP id
 5a478bee46e88-2be8a25c04cmr1058906eec.1.1773266104489; Wed, 11 Mar 2026
 14:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212041017.91370-1-amishhhaaaa@gmail.com> <20260228104654.80831-1-amishhhaaaa@gmail.com>
 <20260228104654.80831-2-amishhhaaaa@gmail.com> <xmqqwlzu43rh.fsf@gitster.g>
 <CAPvEtrf7gqyQYMcsii===kXY5Vut0EC_VsJ=xWUKNrq6YmA=nA@mail.gmail.com>
 <xmqqfr66m5qj.fsf@gitster.g> <CAPig+cQ+HLjBjtGA9s_ZYYWNjRj_Bax5CkJFa98a-z=LoyEFoQ@mail.gmail.com>
 <xmqqwlzikpbz.fsf@gitster.g>
In-Reply-To: <xmqqwlzikpbz.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 11 Mar 2026 17:54:53 -0400
X-Gm-Features: AaiRm53BHsdgeb2ciPzNkOSSeQ4y8LFHAXC-9wBeqB9YsoBvb2ZAvsp1s2WCBsY
Message-ID: <CAPig+cS4vUDu0j5w3XvgdCXTV1bnwqeoGN3MRtmjvYsaMwsp6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] help: cleanup the contruction of keys_uniq
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Amisha Chhajed <amishhhaaaa@gmail.com>, git@vger.kernel.org, avarab@gmail.com, 
	peff@peff.net, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 5:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> >>         sed \
> >>                 -E -e "
> >>                 ...
> >>         " human |
> >>         sort -u
> >
> > For what it's worth, line folding capability was added to
> > check-non-portable-shell.pl by a0a630192d (t/check-non-portable-shell:
> > detect "FOO=3Dbar shell_func", 2018-07-13), so it does correctly detect
> > the errant -E in this example.
>
> Ah, thanks for correcting me.
>
> But "sed -n -i -e '/.../p'" would not catch "-i", and that is not
> all that unlikely, I suspect.

Correct. By only looking at the very first option following the
command name (`sed`), the checking performed by
check-non-portable-shell.pl is very weak indeed.
