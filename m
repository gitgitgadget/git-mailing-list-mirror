Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793628470;
	b=u6UeIceDdBKtGC2cw/KC5UTPz0Vr0h2Ic1Bt20BnPkRDStxp29VZx/EUA+RvCFwb0tLA
	 PLcHPvXe9fXNEmziH4GjcKQfqw/A46WJh8MDL2dorqJCTVEk6UrouEtYPJS7qdhfkKVHd
	 IyWU4xS/3h1QHvDNf6qcD7mC+E9Izzeh/mFyXRnUKFxiLFbvHU27HTVYrkAFNL1+YpW+n
	 IzcK2i/hv6uxql/TxWb/Xu/XWU0itbsJRAa7f8k14ms9si3ZRkB4Zcoqc9lFX+0UdzOh8
	 g3uwCivGBjI0XgCIfKdAglFlKbFrG1f6aXWvsDc8fg+QR6Wq6rhtDSVeQVklSTYbMwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l+T0wVmccgZ+tE+ecrt3TIDFSQniKo8ulDxyjqHz46M=;
	b=4Gnr0ql35G+ILw9RXYq4wArpyY8p4WvtG7LJBlZG7kNyzA1BAv1nohUQxmYYvghkb3AV
	 evawCSVPDz7Ztsy7Fxw0itjo8dnzRTWdlyU1aZbdN7UHPSS2xIAvareORdXvNIqQhQUVO
	 /PJBoYpcY0ZcS2SDt89Z28FwHp8TMTE6iNFlL3AzxZboFf7GUp3BTSq4vZ9W+L9EIHEWf
	 HJHURBSLO72FtLGPiVWnfI4679tJJRvHxdq0WB1ApRhnunzNF+LJ4+kDF6/Q6XkhoWnBd
	 11cMieT2Hz4Fo+WB4mCIVYWnPKBfoqJl+SokRZpjDbOT85WIf3RdDx9tELVbjw2CMoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQm6cfSM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF30606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF30606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQm6cfSM
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so3179024a12.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793628468; cv=none;
        d=google.com; s=arc-20260327;
        b=ijZzpkq4IPIJmwMK8kxIO5cuqkQDHTSKicXv66OY6DN4nTrwdjF3wl2QO7iSXhQpvN
         pKNNZwuTX6VPL7BBzqHKyq7HeatcisJKNhbIYVy7KgIzneeZRHnv5P516BAlbuMeksa7
         yCYM2pICIZRPWlLPlHVvbNZNpJcPzMkzGpDDngfs9YcGT5dm0qguIqWzFNdNHAGEYsy5
         ZtR7qtCxTTPO/4+EN+FrAzA4cPOspRj4frtbQJxcGDlEOnuicEvncMK+TDhaopI1tX50
         y6lmIjDKksDJCUi+kyf6cHUQ2NriF8DEjPTE434j0f+QVYP8lhJQkWh46GjxKWnf5e4R
         pIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+T0wVmccgZ+tE+ecrt3TIDFSQniKo8ulDxyjqHz46M=;
        fh=cihP4RZ2APDHh+HWEU8VntmuTZotIwxz35qcbBnHNQo=;
        b=eupDFwJbzgAO8UeURaBGUSIzh9wzotOJZd6IVsxADuoCUDyL33v10AkvDv7FMalnrX
         tbiX658F83aVw7VzRBM43QMhaSXrtPvzlSQjAzybkj/ce8ex0HtzIcug24pjS94c3u3G
         BJ/hw22E2BM0pb2HbWxHlulPfVlxfKONbtLHWQEirxBkuLYZhkJK4zi+/4SXtiSW74xF
         SzpViXMP5Wn1Q8lMth3bhc6Vtk+smiDtX77RqKZT2BS2FeCcyb8srNp8fh1IT6A4TpId
         jvAqhEXwjIgTLy4MMcjRRTTqevvViU29RzC+7X5qDXaCeAdCcCeMb7BahcuMc9aERcEB
         1O6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628468; x=1794233268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l+T0wVmccgZ+tE+ecrt3TIDFSQniKo8ulDxyjqHz46M=;
        b=oQm6cfSMnayMzMysG+izjNJR+TcpfFbNGvhnQ/MlMZMVwtv0LGXl0YgbGfQAkJ59R/
         uB+PByTfChwv3Frt9HEPLOfQG51NY2CrNlS7ozgfWEzNVZsRR1guPxLqrWNz2LZBv+JK
         J4hsrW8/r6Kf276x5/MR2vr/hfSNL+0JqFMsQ4YmXzFI17egU+lRCSW/r3b69QLiwl6W
         0q85gNqU6XbGqu/gaUQi6DFMuaQ64tch75oAsfIHhiTGqWOwtPfJ4UD/TO2338qwkRHO
         tfit4Pm/ubRsd76nkRKIe5k/pwYYOYFlEOGwqTGN9MNimxtbG1RsnUz/VJA59mrRTFhQ
         jLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628468; x=1794233268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+T0wVmccgZ+tE+ecrt3TIDFSQniKo8ulDxyjqHz46M=;
        b=lkrAA0yhdJw/2bTxpKhc6rV3PLUAU+DsVTlqvOf2ir+IJfOzKo3hPwCSnBX1x9PLu3
         9WG7i/n3FHcWwPK1eMH3eeYaIhGuTCn9dnzlXRsk+h//w7Si2CbJ8QSRyoUa/G03LD+e
         Oq1dFN7kv6ByaddqdTQ/P76+QM8o9Cbk+oCyteKOwtWfR4FGEFh7LQYdFl1WA0kNahE5
         riurDLFG9BlRLX/1W9C11agQasyW1bLSh36gYaWpVZ8/oA5KkoQ/H8B/QWuEbBnIEcJk
         ADCG1jp7kAXakjVFEAhVmv83Xo8A0tQvcuTJoHxgXSxJaCqc/u1FWJ/V59UahRzfnSR7
         kHhA==
X-Forwarded-Encrypted: i=1; AKwUvByoywgs6fZsNkUh28BeeDKqgbEgpztrPjdORGtTFQmyZkc+ckjSiD9UnhZLgT9yapcJtsU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Lb3/uIk0qGRg88DCElppvyOoBZuH3q9iea36duVSAeCM5UERB
	HURb5N3Cj1HArl8z+h7+vJ4h6kBpTTihczyDDD9eJMnze5fUHYVHlmUSr42E7RiU4/5nCoTzyhF
	rUT8Q2lKDNzuxUXOF8pz2Qlmz189s/Yk=
X-Gm-Gg: AYBFou0KsfmL51/5nhMI6uNh1SYIYtst8+h8YBJyQdD1bHYtr4DxeCYrVf/Br4qoYgj
	wwwVPX1AjxjJPo+xfinroEarel1kbRGXDQhPN1JNHXJACPJOVb17mLPRrARC/KiKex8rXHMHnnH
	GA8DAD+QvlboVJftBlU3CqZO/qPLQTzo/1souHf1gtaFzJjA1Gvlu/vCrDtQisadJTt7cNZC6GR
	dSRaX5cCB1JXX+Uqpe1NpOgfIRhcla9UrZqz1XdXhiOw0ez07Uae+E1hMXEqOnM9jEuQB5lczEf
	ahAkcwyiGW9Zz4uWLY5kcZ5kfYSIM4Y3pzVTz7Tg0QWRYzT6l3OAraGiX0S6PQROuAylhtt7az4
	ymwrdpHwXXh8ycPagfjCxFvgrVbs9wjAfiae4
X-Received: by 2002:a05:6402:c9:b0:6b1:a509:875 with SMTP id
 4fb4d7f45d1cf-6b4d468ad1emr5849364a12.20.1793628467839; Mon, 02 Nov 2026
 06:07:47 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g> <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com> <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
 <auiBFhXI_xiBTPbg@pks.im>
In-Reply-To: <auiBFhXI_xiBTPbg@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 15:07:10 +0100
X-Gm-Features: AclHuK9TRwziw7o3RGeK0bFECaxtD8iuFkINraVKBBh0pqtYLR3Jk4SuRGd1O_o
Message-ID: <CAHwyqnWXb6AOgK-tXzrZ5-=WYitv9iXv7N1R2JrvPJAXeCYoqg@mail.gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>, 
	git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:25=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Mon, Nov 02, 2026 at 12:07:29PM +0100, Harald Nordgren wrote:
> > > > Is it possible that maybe the review process needs to change if too
> > > > many things are getting stuck?
> > >
> > > The regular reviewers have been talking about review work being scarc=
e
> > > compared to contributions (contributor work) for at least several yea=
rs
> > > now. How can this be changed if there simply aren=E2=80=99t enough pe=
ople to
> > > review everything?
> >
> > We can loosen the requirements on perfect code, as long as it does
> > what it's supposed to and doesn't have security backdoors.
> >
> > Many things like tests, leaks and linting are already handled
> > automatically by GitHub CI. It's a good time investment to automate
> > more, because it frees up resources long-term.
>
> Even if we automate more of it, that would still not fix our bottleneck.
> I do no trust automated reviews enough to just merge patches without a
> human review, as part of the review is also the conceptual direction
> that we are moving towards. And that can only really be reviewed by
> someone who is familiar with the project overall.

I'm not primarily talking about the review part, but about the
mechanical aspects around reviewing:

You might point out that while the tip a series builds and tests pass,
a commit has a test added before the actual logic was added in the
subsequent commit. This is a class of problems that we can find with
automatic tooling, and then the human reviewers can free up more of
their scarce time for actual reviewing.

> Now automation could of course still help us. For example, if
> contributors started to self-review their patch series before sending
> them out, or if we had a tool like Sashiko [1]. If so, the human review
> would happen on a patch series that is in a better shape already, and
> that would likely require less of a time investment overall.
>
> [1]: https://sashiko.dev/

Interesting if Linux is using that. Linux is our sister project right? ;)

> Granted, at times we err too much on the side of polishing the last tiny
> nits. But quite often that's also us trying to train newcomers to write
> proper commit histories in the first place.

Yes, this is a bigger issue than I think we understand.

The Pareto principle (80/20) generally holds for things like this, and
maybe the last X% of code improvement is not worth the (100-X)% time
investment? For sure it's not linearly distributed.

> What I would very much like to avoid is reducing our standards just
> because "carving in to AI is inevitable". I've heard that argument way
> too often by now, and I don't think that it's a reasonable stance to
> have. It is very much not "inevitable" that a project must move faster.

This is not my main point (although I am AI-positive).


Harald
