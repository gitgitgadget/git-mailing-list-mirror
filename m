Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF493E715E
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993828; cv=pass; b=jw0KNsNVUm1vRlMcR8rGhLXTFyGOkEegeet/fDkWN97P2fs0tKFnnEQtnCFdukZcpuwWacxhaUB0ZbK/HjdkGBVYTH4q2ovKw4vQ/gu2geUBqP6y70wdvw9SVGppTfvJBDNwPenvPMiPzX9Lg2tAG3lwvt0UIAq4F2nVLmZs8GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993828; c=relaxed/simple;
	bh=RZujEHe3g2iLAIwcT7rikqPxFBmLgooSJvLn+wJoJ6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnC9UMfU5nLEVOIdb+I+ipMwYmSJXqlszZC9SQ9njyvdZaacIlPTdYo/85jc+mYIHfMAvG/s6UiFAe/OKALGVkq0M9ohFpNeF1u9OpzwYAlAZn3xroP7JY6pHjiNj7RqSFIpG6Fe2CuivXaKw7qkZM4j+4CRgy8/ImXDjFAr4ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyHqTPjY; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyHqTPjY"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-138129a622dso2215832c88.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 01:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780993826; cv=none;
        d=google.com; s=arc-20240605;
        b=VxMKt7dwjc09mbmCLuJL+77JsqPur7dc92bczcHfDDG1JlFBy0nDjHOY8zph1zfQAN
         CMEHG8N3pYI5TUSGGyc+FbuqQtoZdi9hGqrN6pn0akJSZaq1LgJ7ki2jvQqnm/6qsybR
         zhKoJYY+cmrJd7EWvUo5n9KPNMrIJEQweGxWv3jcFR8MMsbe7LfHxZ7hWBr3c25Pmmtj
         yurUPIsY+3vfr0wxNeehgJI+2PZ2dEEeD7RJvesg8ru4D1Q0u8C+Q6TAGdSsT0ECZedz
         3Q5qeOoRYj7zgDqcEnYnhKHR8vfNyGDuiWTsOaKbUP2Owub+Df6g1PO4edifvz0laPFk
         NwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/E1oHlf388tmmDZtZHRWWG9yoI9ePH6vvx2iAYaURU=;
        fh=h94D7YhHqC52vwKFhg5FsYZH8gwZpqQ8v9jeWDiB25Y=;
        b=Yyvzbh7Q+yEs6zH8midJcONwLkt71ygKhQlujSUP3WwVIapaKaMVBw5MY8aE5QkKJk
         OsX+HoiIDb1H1sdnLPPBFAHZbI2dIVAMFp48HW+Tr4tN2QmGqzAbiy4oR/iAV38PRWtY
         qd0z1lHBcxWMFc9aD6wB87H1c7UsVsR5zCZvkUUJFZrIZ5HS99QzIFCAco2FGdk3AS9X
         y86TIpmeQRUSqbUUV6iOIgVb3RoL817ylSz9OOFL5Yb1v/QUE8Azvma54q4afInQ2SQM
         H8C71g6VP7rwXIQXsms5UmdbAMAraDliMMRBnMYJtSrMYcijCDFwioDatYe0CezHeNik
         jvWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780993826; x=1781598626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/E1oHlf388tmmDZtZHRWWG9yoI9ePH6vvx2iAYaURU=;
        b=iyHqTPjYXTmlDMubVj0aFu7FmJKXA112ZLUUNFSS4Z5PiO36K8iXW4/RSdMg4qVAe+
         So5D8/SPxe93KxSNKK60IQ1gR8uGvSP1uMPXiavePGb94ZIWxPzc4tCOvigSj+6xTvga
         IGFXn5CMMtDk3KG+XY/YO0qo8wGNQ+BNCKH7TBUbUdpIvcC6kzaROF5b6DdKQkzvBGIP
         wz7wrryYkG/49E14UrP7BLukKJ2oi+LdpngZXi7/p6ZCCh/x091PKCHHwjlVNVaTQ9rG
         RNMYALEfLXVOhOdKEntd3oniNXk2HRHkcceF0XfzLAcnqPohAY8G5FcBH+LmddXLvse2
         dFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993826; x=1781598626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/E1oHlf388tmmDZtZHRWWG9yoI9ePH6vvx2iAYaURU=;
        b=l/9gZsS27lUSwNCt4MwEqBeB6VDCsh2Cs0H6xZNa1IPFhciCySbPX0nv9qxkUOeoJp
         o6IbOrCya842xb1Ph8D1BLol2c0rgop2dkNPyb4FE/nJC2YfF0D8eeJcfRAi/oalSq8n
         pLbuMxkZeIjPD5LgGLGaY560GhltNagiNKwtuVkN1uYyKvnwz7vItSFr7lBpQz9i8LYa
         sM99wJPaAbR6vb4MZV+K9AlMYuyexMrQC+dGuwQJPXsSa0JAor6NYYRmYcYcMNyotT6L
         RyaAK6ULROdNFW9xxtSqb4xxiyoFKwZhNr9fC2M8mkdG7bYg8T1lNpJDHtLbtww5NXY2
         qmEA==
X-Gm-Message-State: AOJu0YxB1H2LwtTyC1FaTstdj4MHV7Y03ERsSWRcMiUfenizxwUJMBEa
	/Ne4k+fqV9x9tj3JpFF6qKj+fhW7Wu9SsY6pWrgqOFE2gj/QkeB5dJYXHX4duvP8kh8pUhjJtnx
	/vWdpEzPIEowee8EAXSSdqZ03YoS9N0c=
X-Gm-Gg: Acq92OHWkFkq3sYsBMFvFphsu9fIPqVQ+6LaDqmD1yq+hQnRQv7Z3lB+/E9w5DZYvKU
	NGZOTq4gIw7XL+Y7g3MKsbNnfHbeaqi/Jgb8VYkDeQTWCRirA72oSoIEIyk4LNDq0KjyFW03TZ/
	FuAQVodJspvfkPZokIZTBmoPY13rIUta2M8yRQUxk1wVaFkaq09SnJ8A6n0ukNqMGXuvY7S/BPR
	6Mo3Stx8K2r04l1X3OY52lQl3ZkzVvG5SMZ2PNkMGAhcxsU/dol2yMEEw/rxZc9bn2ZViShuEy2
	3/ETniLc7nLXrCslKKX9/wQDMmANQFbyMGDJkQaqi/Z4sX7U2U5gvW7xfxI+sJVmycvkjCT3/vh
	0jC8=
X-Received: by 2002:a05:7022:f83:b0:137:fea7:ed19 with SMTP id
 a92af1059eb24-13831a55766mr1179789c88.3.1780993824912; Tue, 09 Jun 2026
 01:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com> <87ik7s16sg.fsf@emacs.iotcl.com>
In-Reply-To: <87ik7s16sg.fsf@emacs.iotcl.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 9 Jun 2026 10:30:13 +0200
X-Gm-Features: AVVi8CfRkDCq4n7eTtvsGYsKQiUxZn7koKAmfaFcI9s6W3uJSYhdWRcZB-EVlao
Message-ID: <CAP8UFD0r96KxU3kW2khJ_MySgtv0ZpU26KR1vNimp_FwigQfXA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Auto-configure advertised remotes via URL allowlist
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Toon,

On Tue, Jun 9, 2026 at 10:01=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>
> _(resend because it seems I accidentally didn't reply-all)_
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Changes compared to v3
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Thanks to Toon, Kristoffer, Patrick and Junio for reviewing the
> > previous versions of this series and of the preparatory series.
> >
> > This has been rebased onto master @ 56a4f3c3a2 (The 8th batch,
> > 2026-05-25) to avoid a trivial conflict in "urlmatch.c".
> >
> > Only minor changes have been made since v3, in the following patches:
> >
> >  - Patch 4/8 ("promisor-remote: add 'local_name' to 'struct
> >    promisor_info'"):
> >
> >    - The promisor_info_internal_name() function has been renamed
> >      promisor_info_local_name() for clarity.
> >
> >    - A `const char *local` local variable has been renamed
> >      `remote_name` for consistency with another similar variable.
>
> I can really appreciate these two changes. Both make things more
> consistent and cleaner.
>
> >  - Patch 6/8 ("promisor-remote: trust known remotes matching
> >    acceptFromServerUrl"):
>
> I previously reviewed v2 and compared to that I like the changes you've
> made toward being clear about precedence. And this consistency carries
> through in PATCH 7/8.
>
> And thanks for mentioning username and password components are ignored
> intentionally.

Thanks.

> But I previously mentioned I felt the naming of 'acceptFromServer' and
> 'acceptFromServerUrl' are a bit confusing. So I'm wondering whether we
> can consider another proposal:
>
> What if 'acceptFromServer' would configure if 'acceptFromServerUrl'
> should be used? I mean, imagine we put this in the config:
>
>     [promisor]
>         acceptFromServer =3D Match
>         acceptFromServerUrl =3D https://my-org.com/*
>
> (we can still argue over naming, but to get the idea)
>
> So the value "Match" for 'acceptFromServer' would inform Git to use
> 'acceptFromServerUrl'. This way precedence isn't a concern no more,
> because every value for 'acceptFromServer' is mutually exclusive.

In this case I would prefer to remove 'acceptFromServerUrl' entirely
and to make acceptFromServer accept values like:

    match:https://my-org.com/*

By the way "match" might not be the best term. Maybe something like
"auto-configure" would be better.

> This has one downside though, you can no longer combine
> acceptFromServer=3DKnownUrl with a 'acceptFromServerUrl'. So URLs
> advertised by the server can no longer fall-through to
> 'acceptFromServer' if they don't match 'acceptFromServerUrl'. You can
> argue whether that's a good thing or not.

I think it's a good thing to have this fall-through. It allows setting
up things like this:

In the global config:

[promisor]
        acceptFromServerUrl =3D https://my-org.com/*

In the config of only a few repo that need it:

[promisor]
        acceptFromServer =3D knownUrl

This way remotes from my-org.com are accepted in all the repos, while
other remotes are accepted only if their name and URLs have already
been configured in the repos that need them.

This allows relatively lenient security for internal repos and more
strict security for external ones, and I suspect that many users will
want something like that.

What you suggest doesn't allow that. It could force users to choose
for each repo between either URL based allowlist or local
configuration of every remote.

Also I think it's easier to explain that 'acceptFromServerUrl' is a
different mechanism (that allows auto-configuration, contrary to
'acceptFromServer') if these two variables are independent.

> What do you think? If you disagree, I'm fine with the current approach
> and I think this version looks good.

Thanks for your review and for being fine with the current approach if
I disagree.

Best,
Christian.
