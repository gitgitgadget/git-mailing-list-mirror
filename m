Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAF2798ED
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663895; cv=none; b=m9dOAFFYY0B24FRAtZGJJ8ToGPp0nDr8uLLhZMeOEv/r6inup/U/2jRBh2boo4KeuDd/x1UQiighByo/WlHZEijelG7qtmFpVY/GYt8ZkqFz3s2t0yOEfBxL7yl3E4YfA8ifYs2BRsDRuYI1vKxEEq44nryOm9wGjw6MOeE+CS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663895; c=relaxed/simple;
	bh=tJRG4qHjE5CXITVyacDg89IeRH0DHGMZGOuyx95ekeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8dWuFr2BQz4VlJVuSQzQVErAt4ShqerCC6k2hkMTISEFOxGPnxrFG75YFQY6GKfjlPx01KhOQDqBxU7doFVVswGjB8og4QrvWhu9kQZd6r6pmkHvz88RJN/oVPjKPLAsT35w8AQdECnkQaBr/41s72z+uuk1B6fBkl4PfSWuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knILLW+Q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knILLW+Q"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad551342f08so260770766b.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747663891; x=1748268691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NizPsf5We7aTgfdm2bwHSyjQHbRyUCBaXfFzYmzCPsI=;
        b=knILLW+QZzL/nXj70SMYpuejsUdVvO4SAvWHRlsbyYW6Z1vHVQr8INOG0fgIkdOue+
         7g/fXqUdG8okLH8SIuDMpl12wetZr8A/NqjdfNnFZ9bl3gEzP2/k7+tdOKz2CwbltP0S
         CLnYoXphDvnuVrxIIocq+Wbw21TzXDsfcxAX4VN5Ged5rTRkjwaSja9oTXUcuNpIDXxZ
         6HZjZ5sb/NwfndxyX1GvDuitgaJQ3Uy7TCB3WuwuIJUl6dzMZtlmm+VfoiUWbuOHIWfO
         ujD9/IYujPTuRE4XbS71d8L3MUbQyO0zQ+n896/te2Qegx2t9BozOsaFelqzFOGz9oQY
         h+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663891; x=1748268691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NizPsf5We7aTgfdm2bwHSyjQHbRyUCBaXfFzYmzCPsI=;
        b=fGGjOf2vxmXisVF1pmSWrsDKnA/wfpJGFkNwD5QnQc3VamSOmR1IH2+majUXPKEP+t
         tYPj/WWkyAnONYyQ18wJ/A2W+jT55/+XjLfW9XrAhWXbe/F6Q4IELFXd/nD9tGvDqOxL
         yn5AGIP4wKqaeVT394o1Fuj3elxR5hgcSih9T/CmFhm2YV1dl/X5bwRLDZ9NNVp/D5sX
         aK4/vooOedk80u52L6TwXRnq7H1m4ffk61qqxeyrx5qD783LemSW/RMWoWxyUV5C2orK
         LG+ZlvaMm6qQ6VES8fEeQrqr77A8B4sfu1EfA7ZYLiDO6CPx3SocU46ZLRZUde+VpSHt
         Ursg==
X-Gm-Message-State: AOJu0YxyQYUmlxPmySAa/qkDF9ei9v5Orp62tnhS4dvkSuF4YORSku4H
	ahdNRQn7YAYGnMtvKQleqGfpZbA2W44tYaluCPN51o/Saf/wkMAWu0QOwaAeTM1FBcDLAao12Rb
	PBEzX9pe7x3JcMGTugavXH2PeAIRu4JY=
X-Gm-Gg: ASbGncsim3qF4aq15pBzv0EDG+/j+rKlA1K/edZUFiOROfYjTtv5DA5O1dAVg1EOyZa
	A4hGwOmdplMBd1eZrK2C3rL2AZc9pTVl272F4GagiVa0vTgj9UWxQ7PyCq55asGJP2qHF0d2V36
	XucsYSSMPK+t+Wg6z1s13+qOMZ5N6yS/qXiZGuoBQwgmgb9g==
X-Google-Smtp-Source: AGHT+IFkPrVeM8ym23eV2J5wYyAtYWQ3akQ7dzNl/54XGSIxMKgpypkwBLBq90B/D3rbBbz83r0cG92YUcuwMG3NjKg=
X-Received: by 2002:a17:907:944a:b0:ad2:51d6:86c4 with SMTP id
 a640c23a62f3a-ad536fb899fmr1025849866b.61.1747663890886; Mon, 19 May 2025
 07:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com> <20250429145243.992252-3-christian.couder@gmail.com>
 <aBsZBytP6TzMYCxl@pks.im>
In-Reply-To: <aBsZBytP6TzMYCxl@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 May 2025 16:11:18 +0200
X-Gm-Features: AX0GCFu3fRi5wbsSKIWjWMmXtj-61HLrWyT7f0PNsKAOBFBHsusQ_MDAcQlkqq0
Message-ID: <CAP8UFD1+c11JgSKzs=A39-5EP2Senob-NxSXB7orU0usSLT83A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] promisor-remote: allow a server to advertise more fields
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:25=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Apr 29, 2025 at 04:52:42PM +0200, Christian Couder wrote:
> > diff --git a/Documentation/config/promisor.adoc b/Documentation/config/=
promisor.adoc
> > index 2638b01f83..71311b70c8 100644
> > --- a/Documentation/config/promisor.adoc
> > +++ b/Documentation/config/promisor.adoc
> > @@ -9,6 +9,24 @@ promisor.advertise::
> >       "false", which means the "promisor-remote" capability is not
> >       advertised.
> >
> > +promisor.sendFields::
> > +     A comma or space separated list of additional remote related
> > +     fields that a server will send while advertising its promisor
> > +     remotes using the "promisor-remote" capability, see
> > +     linkgit:gitprotocol-v2[5]. Currently, only the
> > +     "partialCloneFilter" and "token" fields are supported. The
> > +     "partialCloneFilter" field contains the partial clone filter
> > +     used for the remote, and the "token" field contains an
> > +     authentication token for the remote.
> > ++
>
> Should we maybe convert this into a list of accepted fields? Makes it
> easier to extend going forward.

I am not sure I understand what you mean. This promisor.sendFields
config variable is for the server side which advertises remotes. The
server advertises its remotes (if it wants to) before receiving
information from the client, so it cannot know what the client
accepts.

> Furthermore, should we maybe refactor this to match the restrictive
> design where valid fields are explicitly specified? In other words,
> should we have separate config keys for each of the accepted fields now?

Maybe I don't understand what you mean with "accepted fields".

> Also, shouldn't this setting be per promisor remote that we want to
> advertise? I expect that servers will want to send different partial
> clone filters for each of the advertised remotes, and they may also want
> to send different tokens. So it seems a bit too inflexible to only have
> a single, global "sendFields" configuration that covers all promisors.

First this setting already allows servers to send different partial
clone filters for each of the advertised remotes. For each remote it
advertises, a server would send the partial clone filter that is
already configured for this remote on the server. Same for tokens.

Also we can extend this setting to be per promisor remote later if
there is a need for it. I don't think it would be difficult to do. And
I don't think it's necessary right now, because it's likely that for
simplicity most servers will manage all their promisor remotes in the
same way (at least until usage of promisor remotes grows a lot).

> > diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitproto=
col-v2.adoc
> > index 5598c93e67..b4648a7ce6 100644
> > --- a/Documentation/gitprotocol-v2.adoc
> > +++ b/Documentation/gitprotocol-v2.adoc
> > @@ -785,33 +785,52 @@ retrieving the header from a bundle at the indica=
ted URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >
> > -promisor-remote=3D<pr-infos>
> > +promisor-remote=3D<pr-info>
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >  The server may advertise some promisor remotes it is using or knows
> >  about to a client which may want to use them as its promisor remotes,
> > -instead of this repository. In this case <pr-infos> should be of the
> > +instead of this repository. In this case <pr-info> should be of the
> >  form:
> >
> > -     pr-infos =3D pr-info | pr-infos ";" pr-info
> > +     pr-info =3D pr-fields | pr-info ";" pr-info
> >
> > -     pr-info =3D "name=3D" pr-name | "name=3D" pr-name "," "url=3D" pr=
-url
> > +     pr-fields =3D fld-name "=3D" fld-value | pr-fields "," pr-fields
>
> Tiny nit, but can we maybe spell out "fld" fully? It doesn't buy us that
> much to abbreviate "field", and it did cause my reading to trip.

Fine, I have done this in v3.

> > -where `pr-name` is the urlencoded name of a promisor remote, and
> > -`pr-url` the urlencoded URL of that promisor remote.
> > +where all the `fld-name` and `fld-value` in a given `pr-fields` are
> > +field names and values related to a single promisor remote.
> >
> > -In this case, if the client decides to use one or more promisor
> > -remotes the server advertised, it can reply with
> > -"promisor-remote=3D<pr-names>" where <pr-names> should be of the form:
> > +The server MUST advertise at least the "name" and "url" field names
> > +along with the associated field values, which are the name of a valid
> > +remote and its URL, in each `pr-fields`.
> >
> > -     pr-names =3D pr-name | pr-names ";" pr-name
> > +The server MAY advertise the following optional fields:
> > +
> > +- "partialCloneFilter": Filter used for partial clone, corresponding
> > +  to the "remote.<name>.partialCloneFilter" config setting.
> > +- "token": Authentication token for the remote, corresponding
> > +  to the "remote.<name>.token" config setting.
>
> I think we should define semantics of these fields more closely. What
> exactly is the consequence of a partial clone filter being defined?

It's just that the client will know what filter the server uses to
access the promisor remote. In a later patch in this series the client
will be able to decide to accept the remote or not based on that
information (depending on whether the filter matches the filter
already configured on the client side). The client will still not use
the information for other things than deciding to accept or not the
remote after this patch series.

> Does
> it mean that this promisor remote should only be used in case we do have
> the exact same filter passed to git-clone(1)?

It's up to the client to decide, but yeah it will likely work better
if the same filter is used. It should still work if a different filter
is used though. In case the promisor remote doesn't have an object,
there should be a fallback to ask the main server for that object.

Also the filter mechanism already exists for a long time and this
series doesn't change how it works. It's already possible to have
different repos using the same promisor remote with different filters.
So documentation about what happens when they do that should not be
specific to this patch series.

> Does it mean that the
> remote only contains objects that would've been filtered _out_ by such a
> filter?

The filter specification in general is always about what is filtered
out from the repo accessing the promisor remote (not about what is
filtered out from the promisor remote). Again this is not specific to
this patch series. This is general partial clone information since
partial clone has been developed a long time ago.

> Furthermore, we should specify how the token is supposed to be passed to
> the remote.

First for now the token is not used for other things than deciding if
the client accepts the remote or not. (Same thing as for the filter,
url, name...) I think it can already be useful in some cases.

Now, if we want to talk about a future patch series when the token is
possibly used, fine, let's do it. Please consider the following:

  - If the token is passed to the remote through a remote helper, then
it's up to the remote helper to pass and use it, and it could do so in
many different ways that we can't anticipate and maybe we will not
necessarily know about them (for privately developed and used remote
helpers for example).

  - If we develop a standard way in Git to use such a token, then we
will know about that standard way's use of the token at that time (not
necessarily about how remote helpers in the wild might use it though)
. But to develop such a standard way, it's better to already have such
a token passed.

  - Suppose we require this standard way to be developed alongside a
patch series such as this one which passes a token. The main issue is
that this would prevent remote helpers from using such a token until
that standard way is developed. And for now we don't really know if
such a standard way is actually needed or if people will only or
mostly use remote helpers.

  - What if this standard way to use a token is actually not needed
because people use very different backends for large objects with very
different remote helpers developed by different people?

  - There are not many technical similarities between code that passes
a token and code that possibly creates it and then uses it. So I don't
think there is anything technically that requires us to do these
things in the same patch series.

  - There might be a catch 22 between a patch series such as this one
and a patch series to develop a standard way to use a token. We might
not accept patch series adding a token like this one because the token
is not used yet, while a patch series to develop a standard way to
access remote helpers using a token cannot work or even be developed
because no token is passed yet.

So I strongly suggest accepting that we pass a token right now, and
not wait for possible ways to use it (other than deciding if the
remote is accepted or not).

If 'token' is not put into the promisor.sendFields config variable by
servers, the only cost is that clients might check if 'token' is
passed when servers advertise their promisor remotes. It's a very
small cost to enable something likely very much needed and important
for security reasons.

> > +No other fields are defined by the protocol at this time. Clients SHOU=
LD
> > +ignore fields they don't recognize to allow for future protocol extens=
ions.
>
> Shouldn't we require clients to ignore unknown fields? Otherwise, if
> it's only optional to ignore them, we still can't introduce new fields
> in the future without breaking existing clients that chose to ignore
> this guidance.

In v3 this is now:

"No other fields are defined by the protocol at this time. Clients MUST
ignore fields they don't recognize to allow for future protocol
extensions."

With "MUST" instead of "SHOULD", we now require clients to ignore
unknown fields, so they shouldn't break if we introduce new fields.

> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 24d0e70132..70abec4c24 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -314,6 +314,84 @@ static int allow_unsanitized(char ch)
> >       return ch > 32 && ch < 127;
> >  }
> >
> > +/*
> > + * List of field names allowed to be used in the "promisor-remote"
> > + * protocol capability. Each field should correspond to a configurable
> > + * property of a remote that can be relevant for the client.
> > + */
> > +static const char *allowed_fields[] =3D {
> > +     "partialCloneFilter", /* Filter used for partial clone */
> > +     "token",              /* Authentication token for the remote */
> > +     NULL
> > +};
> > +
> > +/*
> > + * Check if 'field' is in the list of allowed field names for the
> > + * "promisor-remote" protocol capability.
> > + */
> > +static int is_allowed_field(const char *field)
> > +{
> > +     const char **p;
> > +
> > +     for (p =3D allowed_fields; *p; p++)
> > +             if (!strcasecmp(*p, field))
> > +                     return 1;
> > +     return 0;
> > +}
>
> Nit: it is a bit funny that we talk about allowed fields here, but
> the recommendation is to just ignore unknown fields. So maybe this
> should instead be called "known_fields".

Fine, it's now 'known_fields' in v3.

Thanks for the review!
