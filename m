Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795703123;
	b=Sb6MpocjkPVtqcQyU+rPCB2hMfSV85O0jr2baTwj3P4BDEHzHge52gsum6W8k22IMXAh
	 ldTTW5K3tH4LJBG7V4H/eixozffKjFNVEcj8+G6HO/NWLqP+p+Aw0kv7ltu5lC4+EiYL/
	 l81r5EWj8WBf4lGQ+eOQlzmEgQ4f5KhelOoZVkthlZcj8pKWNpZ5ae191UTt4UnDTcDZt
	 V8Z+j/nSH/Fg/ifdlRViZcOEq/HLuscbsov/TkFSUPGisRCy0Pfh/hplPzuOh9bs1mxsx
	 IlOccEMlt984pjICs5tkioY/08OxUwsathFEK20u0YrxUg6NHI8y9M9vfTOYfXI5efw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7eRVb7B7hFu+NFObVxNWMYdoWVaKyP4wBIeZmX3N1rs=;
	b=qKilP134KXe/804+d7/ysK2ZmpwOeTQbBpw13SHuG8NvAtp57KzxGZEDo4JWQTwLQ6MD
	 9H8DXVQJMG9TLxthjC/GFMb2CcEf9jqRQ6Nrl4/0Q3rOFPwDIjdtGEjqBxYPBPmCYFXj2
	 Mga42qwjTRfXaROPubqJdvi8g84jJkfBkSPdDKnK5bI7tN3lXEA3mV8XlmeGATacjn4z/
	 GsfMwyBa6uGfKsNRWHI+Q7Ij4BXRPMMzb/ssY9y5PR6llr5x0VNqTVr0SOAC/HL8YyFkn
	 jN/wl2EQ/W3vAGESXGigUq13612KB8YeDNlubHKYu2Wq0dYssLwXNkaXfCl0TV2EU9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PaBmIpyQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5771F606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5771F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PaBmIpyQ
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso9491145c88.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 06:25:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795703122; cv=none;
        d=google.com; s=arc-20260327;
        b=qkLC/Fjc43GGqBWR7DPakrXKNtFIjSMbziDxPew1pJyW1sZ//hdqny9S3vf2OoMAdk
         rJBtC0E3IssgftxW8culxaQi4w5I0yiYSbWi43eqUYprGheLM9c3CKgI7fxPv6/S0D7v
         K7OuY5miAI6nGiqnwPBmZpJus9Wbpaa4Qru3lzDofqnVurHSosBBKt7SNHOJvuBD7udp
         iMw/eHPoXJ7VGiq+VruF91P1rrGQ03S12U62scNrdRRsIuHNpt2i3i3vf8nZ91iHCj6o
         MQrcwNlcLE1qFb5rjDhjWEmNvSNSONjrDQz5f1MSXoBwdqlxul6WwakZJITMho0SJ7Ih
         1NCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7eRVb7B7hFu+NFObVxNWMYdoWVaKyP4wBIeZmX3N1rs=;
        fh=dqU3UfpEL/nzXv+teH2zHAixR+M7uWDB+fvtY1YL9nc=;
        b=A+L4F7rXjSVwoRsxJ1q86xVs8KitwU3STcuCP+GMoKyLNXAzCyBvJB35jgyNjKVh/x
         74HypozgpCvG6imhiV2EOcL9QNtRdwRLhekFHCoLgTf7gw+4e/iI7fBm2f9HNpsMy5/4
         nKHRKj+YDloX6+0lTWpFZidJfVzCFli8qUyCfBPklk0KKFyuuN4mSz6bqeUVVPoIf9PS
         pIkqaTOv8YRfHbPXSwzx4HtK2DKADEaCyDVCLSmrS6KGCO7F01VT83H4nvHCAueXjB7l
         PZ/UIs5VGO5UjbkgUvmf/QK621ctvlyboeEcQSoGm3oVEfNVGupy0AgYopMhtEvQ3SDn
         1j/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795703122; x=1796307922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7eRVb7B7hFu+NFObVxNWMYdoWVaKyP4wBIeZmX3N1rs=;
        b=PaBmIpyQLb9A2su0Fo0zFFBzrdHs9hGP94dfHFrxlgMegGrHl3nk1Q5W7KP5ICGwoW
         uWPKFf/hW5W8Tf3dZirHKrE3w2zdMgPQy1uDBLRSQ1KHvEi08dJ/Bf2eSbWiggTWYi+t
         kNfNYf6TCyppUFsOnSJaw5oQVVr5dQMElrF14D6eY3mcDqxR5fkYORGqaFdBDfQjjd84
         uSq0v/u4FRmm9AWETMYTvnuM7HD5/+5WNB9bOy9fszzfSItXZZ/4bccjjrWRDQJFqd8W
         T/jURIV/wNaQFXMymmFi1jqkxPwb2Ry/Oc71jpwPzQ1Rir/29Rn/VntM/KCfWXwY50b8
         UaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703122; x=1796307922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eRVb7B7hFu+NFObVxNWMYdoWVaKyP4wBIeZmX3N1rs=;
        b=AU633SfunPwF8+exOQ0KMhL97KirS/8acuPBcBEkUDiMefv7rN5VGW3ivimxVAFPQM
         l4yMumdpyEJ+f2em/YNMN+l3AyoVBdcnA7Uio/8MNdheXawQpCaDgNbS6F6ArIeXXmlW
         /31iWXwJyXW9DlY6RN+A0XZgZg9nL+iBv5Wi225QMUYvjX4GOflwtoV1f5zZ36XU/vNf
         ZsuFdZ9k/580T+bHXVz4nDjNa3xuu8CSjEk8OUVUQ08Ql3KZYTlKUFHzGcYk86Bd6c61
         LmmxfgYWoOl5tjM6bR7rohN6lAtgMoPYuJYr9soRaAosEgBbSoRK5A9SCf5u1pU3OHEU
         k9YQ==
X-Forwarded-Encrypted: i=1; AL+hErEAZmSP0DZ/1ycqn0HfApVEx/G2XEPB2hqWJatsiKqrBHklBx0ug/ttfB2mneMOG0TPL4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z94oUv1r9lxb89icY/Tey/zcQuAXyn/C2nHyQ2ANgGfLfsrZYjN
	FtpihkKNPwfL4xxQOELz07o1kPnwMEfxJ//VbAa9ehJtCrHICFFvXrO08MM2c0aUsS5+QqmKDPw
	+R3ETEDddOkpPiGcSIwCMCrpKTo4li5I=
X-Gm-Gg: AZFdTZfLJeYDLdgdS98bnBET6u2QAZ/tkHSKCy471kJ6Xup+lw74Yt5m8G/kxszqeRq
	DuN4FwJc3uTLQDQ1NCtF2hIYHj+TZYQwpJXKfIS5RDbRtzjrDKnRmNMcwPXaB0UUOzQD2jG6A4c
	ZizEj4FUif4OUTZUcK0IGkpcKWjfB7S9oxBYKZfiYfHk3eb/aYYiWO13SC+J6NAID5KBd/u1V1s
	UWsdbQGzg3NHLYLO+7Ei1uv/RCXFMcy4E97kHldw9sqh6I/iuv6Xr+DdeZIi+N4RdmJIPvkIZ2y
	ul9/iL1XnZcMHDIspmQnw0077Jyim5ToNdhxd3FwWUjxLluZdj4xFevT6H+vrqdX2d8abToHBmd
	GFfzQRiJ7DRskPM8DEIgDcSNfe2YdTEKclCzfNXWWN7+IQx52cHU05UnRYwR2wRDqshRw+0yEce
	Y4eqZj67i4XGZ1E+3dEODsn5rHqEtOclgJvga9Gy4csa5VCj2Q6bUMCDUZGnzODkNYPocIwValL
	jymL8rtvg1RIxnCu8DFfDdg
X-Received: by 2002:a05:701a:c9c1:10b0:183:3c2a:ae8 with SMTP id
 a92af1059eb24-1b55690bb6emr19572881c88.41.1795703122388; Thu, 26 Nov 2026
 06:25:22 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113000600.202744-2-christian.couder@gmail.com>
 <xmqq33t4bjrc.fsf@gitster.g> <avqkLnnMwBNeWWtK@pks.im> <xmqqtslgn6ad.fsf@gitster.g>
In-Reply-To: <xmqqtslgn6ad.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 26 Nov 2026 15:25:10 +0100
X-Gm-Features: Aa3M54oyRDGG-OLYM9XU_C2bAdTat2Z9psBNJ1CesDox7KPqAx04a-vV50z71Nc
Message-ID: <CAP8UFD3T47nv+eDVacRsL8hkmVmP=CTwbMrfDzS42-xdOkeNkw@mail.gmail.com>
Subject: Re: [PATCH] promisor-remote: fix crash without a repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 4:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > I was wondering myself whether a better fix would be to start passing
> > down the repository and then detect this case by checking for `!repo`
> > instead.
>
> That would be the most sensible way forward, as it would potentially
> allow us to help more code paths free from the_repository.

This is implemented in the v2 I just sent.

> > From my point of view it's nowadays a bit of a code smell to
> > check whether the passed repository itself is actually an initialized
> > one or not: if we aren't operating inside a repository, then the caller
> > shouldn't pass one.
> >
> > That may be a bigger refactoring though, so depending on its scope I'm
> > happy to live with the easier fix for now.
>
> Yes.

I have just added a small preparatory refactoring patch in v2. I think
there is no need to do more than that in this series.

> >> +    /*
> >> +     * "ls-remote" has no business talking about promisors, and worse=
 yet,
> >> +     * it can be run outside a repository.
> >> +     */
> >> +    if (!repo->gitdir) {
> >> +            if (accepted_out)
> >> +                    *accepted_out =3D NULL;
> >> +            return;
> >> +    }

Thanks for the suggestion. It looks mostly like this in the v2.

> > But in any case, we should also detect the case where `!repo`, I'd say.
> > Otherwise we'll have to adapt this code again once this funciton's call
> > chains get rid of `the_repository`.
>
> Yes, again, but as long as we have sufficient test coverage right
> now, the dereference repo->gitdir would immediately segfault when
> our caller stops passing the_repository and instead passes NULL when
> it notices that we are not in a repository ;-)

The check is `!repo || !repo->gitdir` in v2. Even if we have test
coverage, I think it doesn't cost much and it's a bit better to be
ready for when NULL will be passed.

Thanks both.
