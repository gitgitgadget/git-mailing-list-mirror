Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64440267B94
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663934; cv=none; b=uBsJvj6t/tcwi9yIGvZOUdjAc4LwFzZdjMAvbNdP4vPNumQ2tkuFhyKH9rtKzrOc2v4Ex7aNAWhRltzwAw38pqIRSk9qK15MAwOrB1GrqnlKyi99NvpA533rAbJZUcvzDCJXJanlevkxgiHKj3EXkSNPbdeLPyfOskLVXsz4ocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663934; c=relaxed/simple;
	bh=cd1we/dfP9a1ySrpAoVP1qyx1aHqC6SvQEUB2ggEp9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoVON/ZmGll3a+DkAwm9OgaTmuuEwiN2RSFXmJCiLakRiAiU5StfjjmJ/GWmBY4sLVFaBux1AXw5VXq3W73uaguBKwsE9qLipoo4D/WeYMptwRWOV6TdZ4Wak1N9NfxwODijbSPkJhlG2zTOmwec33vGCL7nRMIF6fdgCfKfDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1l+os3k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1l+os3k"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad5740dd20eso169112066b.0
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747663930; x=1748268730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPzzMdCtLNIhnbqIKTqqwgkEv++CjWjokTGQwvoGSH0=;
        b=l1l+os3kdd2PqdNGsLpCMYU+rJ2LrdaJgYsYY/te1wl1Zv7s3Z5X/KguuYMCDCkvkX
         xykXsWKJYn+bn3tAQS65psNUSVVt0P/NYoGqmCM52fr1nudtEHWp9aQtqDz7+LJsLAAj
         qz2ZpNfRoDcDAynXURFZQDJOgSWW/WxJ7u0UJvLHDyQqpu9afWCA06WPSlyYAXE+bdHP
         aX5E6UEbCqQzTjKLbfKE460YOOPtQiAAUe3MeV+9++1BxchvMk3QQ2hQwz11EggVcyaA
         wR0u/ShkekL5rLBVC9o7ptltkUMvJzMRXxWruVNaK86YYKAQgATJ8codgz+A94BaDRo2
         n+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663930; x=1748268730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPzzMdCtLNIhnbqIKTqqwgkEv++CjWjokTGQwvoGSH0=;
        b=Ro5hHS3Md7MCw2uQVJ5hrJS0EU9htBKIGnSf2lI0Vk+LGlb/Lc+xSbG5pg7ZfGMIHb
         5UnbnPQrZEtFlsCfbJj7VhBVx/Ib6oTjWlcRLdNgOuYljxgY2jr3bJoBD7lCI97q9OU3
         vr1XaukIW/T85iTYT2UM8APd6bw/vjMF0dtru7P0gKHizHmYq0xZSQnOmEDnjBWiiwBy
         BELA/mv0PSEZREA9BADm1nOv7QBS3JL/2RKEfnq2Ajlg+pBDbbIQDAjZLeMMcdtzL7Ja
         sqrSIxVk3GRUHFpXbfkQugv9l7LNk1+VCoQ0jm+/pqkPbd08hZi/e2oSkOVDapoJWHJn
         ySwg==
X-Gm-Message-State: AOJu0YxoEX9nIpe3Ggz8NK9vX3FbY9+oZI8wwE1GCIcAJ3w5HQKZlGEK
	K2XlTMuC6bBBSMoOmj+wnoyXqaZJozHBG28VaTzHOVpMK+uP/ZZ+uTpGcvY2A8nmlxECfOeEcVA
	/VpJbHlXG7foImHcqIRQ1gAatms+pldU=
X-Gm-Gg: ASbGncsG4JrN7PMgQKCCywutfG6KO8rcFKoVWTItOkabp2jdJ9jdRhr/lYdIIx7oIv6
	J1NJfpQcXe2VLjwcxeIdRwJkH92rMhiAni7Noohb5gSabS3Pnpj3Pgo99/RaRRt0+jsUXHxfOK3
	apQeBHfWyjML8KD4OpTh18o1vfnxAb2mKj4yd1TuUFalJP+Q==
X-Google-Smtp-Source: AGHT+IH/eU+IT/hrLXJ8Nbys7taXNy40k0HY87tz5KUH9FMjSLs6TuUmm51LRI7AVL3svf/dm2r/R6k7U3O09zpX3yo=
X-Received: by 2002:a17:906:dc93:b0:ad5:6ca3:c795 with SMTP id
 a640c23a62f3a-ad56ca3cb15mr449755866b.33.1747663930342; Mon, 19 May 2025
 07:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com> <20250429145243.992252-4-christian.couder@gmail.com>
 <aBsZC_MZw7BHxUiS@pks.im>
In-Reply-To: <aBsZC_MZw7BHxUiS@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 May 2025 16:11:58 +0200
X-Gm-Features: AX0GCFtv7TIwzEqukqzmm88yp6Wkc2_9X-6MN1LSvlXHqU7-chh-1V_XKrQUWx8
Message-ID: <CAP8UFD1mav=omMxSwWmrmORBnXKzKSp4C4FDNP8R9Q43hU77zw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] promisor-remote: allow a client to check fields
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:14=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Apr 29, 2025 at 04:52:43PM +0200, Christian Couder wrote:
> > diff --git a/Documentation/config/promisor.adoc b/Documentation/config/=
promisor.adoc
> > index 71311b70c8..4147d2cf44 100644
> > --- a/Documentation/config/promisor.adoc
> > +++ b/Documentation/config/promisor.adoc
> > @@ -46,3 +46,28 @@ promisor.acceptFromServer::
> >       lazily fetchable from this promisor remote from its responses
> >       to "fetch" and "clone" requests from the client. Name and URL
> >       comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
> > +
> > +promisor.checkFields::
> > +     A comma or space separated list of additional remote related
> > +     fields that a client will check before accepting a promisor
> > +     remote. Currently, only the "partialCloneFilter" and "token"
> > +     fields are supported.
> > ++
> > +When a field is part of this list and a corresponding
> > +"remote.foo.<field>" config variable is set locally for remote "foo",
> > +then the value of this config variable will be checked against the
> > +value of the same field passed by the server for the remote "foo". The
> > +remote "foo" will be rejected if the values don't match.
> > ++
> > +For the "partialCloneFilter" field, this allows the client to ensure
> > +that the server's filter matches what it expects locally, preventing
> > +inconsistencies in filtering behavior. For the "token" field, this can
> > +be used to verify that authentication credentials match expected
> > +values.
> > ++
> > +The fields should be passed by the server through the
> > +"promisor-remote" capability by using the `promisor.sendFields` config
> > +variable. The fields will be checked only if the
> > +`promisor.acceptFromServer` config variable is not set to "None".  If
> > +set to "None", this config variable will have no effect.  See
> > +linkgit:gitprotocol-v2[5].
>
> One thought that came to my mind is that inevitably, users will
> eventually want to specify different conditions and combinations. E.g.
> "accept a promisor remote if it's announced by GitLab and if the partial
> filter strips blobs, but not if it requires additional authentication".
> I don't think that "checkFields" would be able to implement such a use
> case.
>
> What is the vision where we want to end up here? Should we maybe provide
> some more flexibility now already so that we don't have to retrofit such
> a mechanism in the future?

I'd prefer to wait until some concrete cases appear. It's possible
that the current very simple mechanism will be enough for some time,
or it's possible that some users will come soon with a complex use
case where it might be necessary to have a hook or some kind of
external script called. In those cases it would be sad if we added
some flexibility in advance but it appears to be too much or not
enough.
