Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC86408029
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204341; cv=pass; b=qeovLQ23wgtwdahaYFnn+413L1lLSD5uctsOHilpfSeKg/qIucAv4De9y8+hLakOhPKZIqquC3PX3qyt/sj5gv/5sc2+icltU9gxY67Jdu+p9KY8wVgZEx9iv1NU+ZZohBSvvjYk3gHch9AxDhmy/jnkOcechk3avFzNgqF3A64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204341; c=relaxed/simple;
	bh=d8BSIjsTfMtfpbtT4Q/F+dVqB+8Xc8sWbpvKMNCWflw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqqKfYuOLSBEHpzKqxW8Qj5FXPf6m5XaMD3lvwoPElcFaDFwCKNNhddK5egSEJ6qU3vf5i7OWuot7HvuDTWj26zK6h0D9wzcdaSUqVoE5zrg8JPYPhhmFuFCErE2Sh2bGEorpQf9WQaCjLPM1rzK4sazjEJKIWJn9uqfrsQvBEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1t2Zd55; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1t2Zd55"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1331e851faaso1892748c88.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779204338; cv=none;
        d=google.com; s=arc-20240605;
        b=UbhXYOrS6GdEp/TULzqUysyaH6esKMCV3rikWVBybbzx1JUvlnFLg53MdsoNNysoxU
         MAr51fCBI77ERecyHjT0B1vYdplW6KcefXEKF6GpNpgDbUdB+89OXrvwI+v8eE+Ymc+b
         3Kny/j7i6R67rNtss61nUGlHljp9LliZdTCSKkt2EAwjbcch6/Yj1TCiijcp4LfDm7j1
         EeNU0ey5/VVFDkPjJvC5CHDAf+Rbhh74+2vfwm/4prRiO1CS0NeT9D2UTACdnEUhWxE5
         KUdT7kQs24fBIMI/iQN96Q8zpYQrdEVhUReemm0xMashsAivS1iT6Rw+3EUM3vebgFOW
         SiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=59UsJuT88k3zncjGG0Fg4ezXUxnjRoaREIuzr+1RcR0=;
        fh=rnkYOd0g6i/l7E/y+/vhBWHmQUXTX4flLDwaef/8U0U=;
        b=lZf9+3gOv2D9oh5tO4szFsq2QPchYUZ7Ao55UTpsAaZvlBbpxNXPwEKvfzqo46wzcg
         HG6v8Opyjo/RfzUzav7ONmPelYUR898Gt1g5TAqH+u2GN2s205ecRGG1FIRWM4eKIT0D
         IuP0JA2SFMbfNH8RnCmvm5m3dWnjpxb6P8Zk7Lto4l22Q76vFCfZqjq3VIExkyddFxvj
         mbYMkPPYaHASzz+imui4bwjMO2uS095dtW0JKI8VEGBTBvK5fxYOmYRkU/F2kFQb+Zx9
         8xIz6O6kP/6SNjv3Wr2DxC3Fr4Y6hOAyrD6BxZX+e7DKJ6APUTHB7wDXYGuT/FMS1P6m
         575g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779204338; x=1779809138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59UsJuT88k3zncjGG0Fg4ezXUxnjRoaREIuzr+1RcR0=;
        b=c1t2Zd55GlbnuoRL22xrkxzHA1a2mRcp+K6Ef3mpvgN0jm66x6MWrod7vJfUAK1e41
         CL4z5ryMD6bezUWEXEFJIbUWf9sg3+FhwpwLoa7zyHBgcaeljKoea9c9v2gn8dnLxIQq
         CclBAlUAjLHDF7/vY4lCLlx+4/yW9oApEry+6332AJVrPUg8lt3aGaGyBpygy97SwmJW
         IF7nOEFjAJu8IetivI5PCWjL+q7AP1aM3prR4W2YwQ9YYje4i9Pv/EsGoRTo5vcKuNhG
         QeruSnFRsgFI7m/2eLlqx4G1i/V0022j1e81Zgp+34QqAXJBsjO4Cu8FE8Bo40O0vDQk
         HDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204338; x=1779809138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59UsJuT88k3zncjGG0Fg4ezXUxnjRoaREIuzr+1RcR0=;
        b=H7IHmAtTmHT+8JihXj/q/FLLIytqTqPYU093ix1p9IVzaRF+fTvVjN3vXcse5WFoDi
         4RUeaW3V+rznEAF0/JkWHAPO+EjhENmG+l42ei4zyureKgrQLVjkVcyzu3Z8D2G0F7Of
         95HS4FsmWD/VrQ+5ewXh5yvYUKFm/xrK+uO+kpriS9R3E/Wc65yT4Tj5WrRtsg9Pr6Z3
         454nqWvwF9hwgoTYpmTVwnys7+BhHF/IlruVmmRdKeN4TRtuVOAxN3GfZuljT0SuZoA9
         9NwQpiv/CcVpMmaV0ufL1FqlkP4J1DhszjL0OqXRZbDLXodkmBh+dZV/o4ZTw8fmABJI
         7EGA==
X-Gm-Message-State: AOJu0YxH7xC7AW+67JoGQv+0pj9/peGtppYWZtf1iYG0f/p9NNPrW/fO
	0TyCesb7W1dwov7yoNh4Dg7u4QmGPAFaDpmSDVxh4nHTQK/SVRVJ4UI0EeUvrjFAa1ofnN0MU39
	VHJ81lic1HRFMxovVrzOkjjtrMKvvKKg=
X-Gm-Gg: Acq92OHgGONots+qWvuSWwRs6cDVBrnBFelHANYtEDxmxlLmZWHgLBA8LFz411yYCB/
	03XpdDybFoMSyJQIaOBDXWJGoSFxzeuWki4YFqh6WtYHjriErO6KFvM0lIHI0IHl6Pksy52d/JY
	Zd3VhXgNjfZvaKOumKDL2Y7QnDQUUPYxPu98iWshlk9WSSfYLdbQliqXRNN4K1IjUdFPmb1Le7Y
	UaqRwyaRr+hLCDyAXUhzgGSc88IwtFRgWNjGM/zuldP17wxcgQQc4rhhRJnVU74iEhlNEiPd3L1
	VK3+KZfZCHtT8Re9Q/CGFd8nWkVmPhSgXqr0EvgBdmqtrl4K5Kk1cQJwNo0phE50htDW
X-Received: by 2002:a05:7022:427:b0:135:2588:6314 with SMTP id
 a92af1059eb24-135258863a8mr6715667c88.8.1779204337841; Tue, 19 May 2026
 08:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com> <20260427124108.3524129-8-christian.couder@gmail.com>
 <87v7cunlid.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
In-Reply-To: <87v7cunlid.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 19 May 2026 17:25:25 +0200
X-Gm-Features: AVHnY4JgI2JHaLxaUuRGl2qZVco1UNC3sRn4mMTPkwQ_mSAV0Ku_RJYyElWYmIQ
Message-ID: <CAP8UFD3fT3RE=CkgS5rUW6TisV9dCN9GQeM0nSswxQw-b75QuA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] promisor-remote: auto-configure unknown remotes
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 3:06=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:

> > +static char *promisor_remote_name_from_url(const char *url)
> > +{
> > +     struct url_info url_info =3D { 0 };
> > +     char *normalized =3D url_normalize(url, &url_info);
> > +     struct strbuf buf =3D STRBUF_INIT;
> > +
> > +     if (!normalized) {
> > +             warning(_("couldn't normalize advertised url '%s', "
> > +                       "ignoring this remote"), url);
> > +             return NULL;
> > +     }
> > +
> > +     if (url_info.host_len) {
> > +             strbuf_add(&buf, normalized + url_info.host_off, url_info=
.host_len);
> > +             strbuf_addch(&buf, '-');
> > +     }
> > +
> > +     if (url_info.port_len) {
> > +             strbuf_add(&buf, normalized + url_info.port_off, url_info=
.port_len);
> > +             strbuf_addch(&buf, '-');
>
> If the url doesn't have a path, this could lead to the name being
> `example-com-8443`. But we have a MAX_REMOTES_WITH_SIMILAR_NAMES at 20,
> would this be an issue for a second remote without configured name?
>
> As far as I can tell from handle_matching_allowed_url(), it's no issue,
> because the numeric `-%d` suffix is added and we never atoi() the number
> from existing remotes in the config.

Right.

[...]

> > +test_expect_success "clone with URL allowlisted and no remote already =
configured" '
> > +     git -C server config promisor.advertise true &&
> > +     test_when_finished "rm -rf client" &&
> > +     test_when_finished "rm -f full_names" &&
> > +
> > +     GIT_NO_LAZY_FETCH=3D0 git clone \
> > +             -c promisor.acceptfromserver=3DNone \
> > +             -c promisor.acceptFromServerUrl=3D"$ENCODED_TRASH_DIRECTO=
RY_URL/*" \
> > +             --no-local --filter=3D"blob:limit=3D5k" server client &&
>
> So promisor.acceptFromServerUrl only works if promisor.acceptFromServer
> is "none"? I mean which one should precedence? If
> promisor.acceptFromServer is set to "all", the promisor remote is
> accepted by the client, but not saved to the config. Is that
> intentional? Should we document that?

Yeah, it was buggy in v2 for some values of
`promisor.acceptfromserver`, and things were not properly documented.
But I think it's correct and much clearer now in v3 as discussed in my
reply to your comments on the previous patch.

Thanks.
