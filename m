Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6853B9616
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293857; cv=pass; b=ZRVHI5+xjX2RsfyziJ9u9rESXkvK4IxED8MYdJcBAKv+4mdMEaLntFDL/tfZ5GvFx4dxy0185obynKTJ+7sYeGoDgvvu1Yeqlm8dj+hrHkgPZbdTALyfDkYz7znxydT9eNnPZUlVi9at3QH/hVp5Y03A35mhhnne4POv8+ztx9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293857; c=relaxed/simple;
	bh=/Lomf9g0ri77cWRQzDG5v1yyYKl6rQ3D8RtR80vCEoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZ1dM85nRZZ1PQQChEJIkxZRJ+/CKG/ZQoyaQqznB9e0ovIQnSgTHfToIGda94D89n/Vzv512gVy7EbvvLEKPGIoN3u8B/ATh36O+fHq/w2y4ahS0J5ghtYCWSUE/qurUs4i4F0ey1fvlPgAzOsFGVNO0VmGFouSzubxE2mSs0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROXrpJuQ; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROXrpJuQ"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12dcdcd54adso3008634c88.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777293854; cv=none;
        d=google.com; s=arc-20240605;
        b=Uk9Y3ekbSmjP6p95g4wsreJ5nU+HN3iHIRfuKc6b0RyLfHoTEO2Mh1BcaeEYF5qXi0
         W85LMLib+iXnNL1EVCN4zmPT1wZhzY0WHz8OHsRfL230U7L8Hi5V834Skp1HEvlf8sWe
         Lyf3B84ToVcqxbIiYJPzhvzzGbZUFbMJOBD1IJBfHXWr78aiJtpwZfNE3atewN7OoVWV
         AvR7sd6BzUxSZQp4rVACtqVR5SozyNuppnQVO5cmGynj+KRurTK/M+RQouRWI7K/6ow7
         iwmuwIOxRgVIChFChEj5CdyuhN3z81udbeXev0LOoB77wKqGoMkpTSTvn3s5u2kYL5uf
         pdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2xcyEQ8oRgDojpFl8TLhs/sDol/oeqhlFYrHU36r8Gs=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=bntf6KsNaCiPsuJ6WSDSudTfUs/DW3i0ATkGGeEoU07HHNNVNGnvUqOCO3vaNcAimS
         wajTfdBvLi2Bbx5K3T3tpio7AaPuLJx9PABug/0HHLesumiCjM72FbhZQoKyOC9JlU5L
         YPVE7N7SrjOi5vP1bI3tSSG2mSXvl1A3wjo8anZu5oBMX1CUbvlyS7VqMCNuaTA4OtoK
         sFvBdLlkmA+F0RTRRJZ4DIrs+PwqKnLeUtK8o2lKisXQGSK24OZqM76LS+zFnIc9gwY0
         0MgD7NliSHwDQ7nLotv/D5SEPVII++QIbzzxkUlX71ZfB7MmOZGeTOFBvlINV1/Pg6ir
         h1ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293854; x=1777898654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xcyEQ8oRgDojpFl8TLhs/sDol/oeqhlFYrHU36r8Gs=;
        b=ROXrpJuQoZPjMcpPd6cUx6F1WjnzAEg1u1S8aoSBMkhpNa9C17rsz2iAvoeKBSBGVt
         PMdYOY6cG5WudVkG7j7xH/aGk3dR+GZS464OAq/trNP+iV+ypBYJB6n1xKTzv9NIbnPq
         Av9Dcdn6P0XXScRcs3bFujz5o98y0lNwQBz0F94ePzmYAOZvdxArm4NWyK/OLtIMnFJb
         edejXAybMWrQmJMVRsN1EjHZdSX/pBXOBeWqYSsuaWJlI+FlueUjOzv37X84D9sAKss0
         FXPxyehGD2v4BCauzarW5xmARmGChjnseIQI/uELUQkawuCvrncl0OWj3SOlhz0mX71X
         2GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293854; x=1777898654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2xcyEQ8oRgDojpFl8TLhs/sDol/oeqhlFYrHU36r8Gs=;
        b=ZPqd3zCwzL+9OoNg9cqZOo8aSlP53jdv1IC/njz6WYjTQ0P9iabwTAijrmH1tZFPli
         bf8irPjmhVcUnLMkvqQBFMxiwz0eEdSiuy6V9xCA8VzFFqqjsquVVdGHj32wI32gnXNW
         rh9bxI1Mi/TQDvnYMb/5aKP//xGkJVYaJanRAroyXbzlHTNbr8O4SzBA2rGq1OSfEhaD
         +J2cSa0JsBUF8mP1bfSLIJTppPBB9ErxuISrAXTbrdbQqdt0yspaC1lDfKEcJY7GkkO6
         qTDl4mGv7ECxWo+1fouCxIyJQl+YKVGEIr+4htSgwb0Wfo948i9hYl6jnKhktRuEUp6n
         Ughw==
X-Gm-Message-State: AOJu0YwLaP2vkLaLqd8AUR0pA2MICm8D1OLwUVaPnaG4mItpkR6zCoHW
	yYkm29yJV/J0ebFq8Q6sLx+cuFpqhRymPbC4QjCUnfmLHzd4Qi379ITvVGYLRoPmX7jZ8qB85k9
	yibqtAiMy28EpPBLXEzxckLvpJDdTJUg=
X-Gm-Gg: AeBDiesvIoB9c2fpiSObQrtE64XFjoy0wZnfWUJcuNdKvwCbKhodOYsBuAfvdjq0jVr
	p+dGftebYX8FmLqijfvayBMR01snW76qIFhnp7YOpPQSRVseUiDFb7poqRSLg6sFG6/Vb0t00H2
	wH/Jy14hyvBUkqdp3oTozsSDbzqEJskEsairpQdtM8cqo/opjTC82fPpmSImAWTmwj9umFUibOU
	uAbOF1mUud1kjA4kKyajGiiz+D2bmp2rbfGp8b9pYQCUDZw3v2nI2DmnhJ5tJGeKVBRfwVb9GMh
	YtB01bctpJpx5t57EYfHV+1XKrcxIO87bXgQjI0WBOCrZa/aVwmaqZcQzrwqm3IV92GKwin4+Ry
	25B8=
X-Received: by 2002:a05:7022:6289:b0:12a:9b80:8a1b with SMTP id
 a92af1059eb24-12c73fb27fcmr23003729c88.34.1777293853922; Mon, 27 Apr 2026
 05:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-16-christian.couder@gmail.com> <acUk11mt06GJZaur@pks.im>
In-Reply-To: <acUk11mt06GJZaur@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Apr 2026 14:44:02 +0200
X-Gm-Features: AVHnY4JLE8eEN9booH8janu_-WKGGNkHswVP6UtjTNck2oUhBnVk2YZFyksqzII
Message-ID: <CAP8UFD20=ArLUDbD36=02_i2io8+uMYhm5LJVGayzKYOkqmMBg@mail.gmail.com>
Subject: Re: [PATCH 15/16] promisor-remote: auto-configure unknown remotes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:18AM +0100, Christian Couder wrote:
> > Previous commits have introduced the `promisor.acceptFromServerUrl`
> > config variable to whitelist some URLs advertised by a server through
> > the "promisor-remote" protocol capability.
> >
> > However the new `promisor.acceptFromServerUrl` mechanism, like the old
> > `promisor.acceptFromServer` mechanism, still requires a remote to
> > already exist in the client's local configuration before it can be
> > accepted. This places a significant manual burden on users to
> > pre-configure these remotes, and creates friction for administrators
> > who have to troubleshoot or manually provision these setups for their
> > teams.
> >
> > To eliminate this burden, let's automatically create a new `[remote]`
> > section in the client's config when a server advertises an unknown
> > remote whose URL matches a `promisor.acceptFromServerUrl` glob pattern.
>
> Would it make sense to extend git-clone(1) to have a command line option
> that basically does this as a one-shot? Something like `git clone
> --accept-promisors=3Durl:https://gitlab.com/*`? I assume that many users
> may not want to keep on updating their configured promisors all the
> time.

I don't understand why you say "many users may not want to keep on
updating their configured promisors all the time". It seems to me that
what I propose requires even less effort from users than what you
suggest.

If users set up something like:

  git config set --global promisor.acceptFromServerUrl "https://my-org.com/=
*"

or:

  git config set --global promisor.acceptFromServerUrl
"https://gitlab.com/my-org/*"

they would then automatically accept the promisor remotes with an URL
matching the pattern when they make a partial clone.

So it's a one time setup instead of having to use
`--accept-promisors=3Durl:...` each time they clone.

Also `git -c promisor.acceptFromServerUrl=3D"..." clone` can basically
be used to get the same thing as the `--accept-promisors=3Durl:...` flag
you suggest.

> Furthermore, this here reconfirms my thought on the previous commit that
> it would make sense to detangle accepting promisors, storing them in the
> configuration and updating them automatically. These are all different
> things:
>
>   - Accepting promisors is basically an ongoing runtime thing where you
>     start to use announced promisors even though they are not configured
>     at all.

Why an "ongoing runtime thing"? If users think it's fine to accept
promisors from their own domain, why should they have to confirm that
every time they clone?

>   - Storing promisors is typically a one-time thing that you'd want to
>     do when creating a new repository.

Except that some fields and maybe sometimes URLs might change on the
server side and it would be nice if this didn't require manual updates
on the client side.

>   - Updating promisors automatically is probably something you want to
>     do on an ongoing basis when you have stored promisors.

Yeah, so it's similar in many ways to storing promisors.

> We're currently putting all of these use cases into the same bag, but
> they have very different characteristics.

I don't think all use cases are put in the same bag. There are a
number of config options already that allow a lot of customization.
Adding "promisor.acceptFromServerUrl" as a separate option from
"promisor.acceptFromServer" also only increases the possibilities for
users.

> I guess the most common use
> case will eventually be to never auto-accept promisors, store them at
> clone time, and keep them updated whenever they change.

I am not sure at all this is the most common use case.

If you require a `--accept-promisors=3Durl:https://my-org.com/*` each
time, people might just copy-paste it or create an alias for that and
then use it all the time and you won't get much more security than
something like:

  git config set --global promisor.acceptFromServerUrl "https://my-org.com/=
*"

once and then regular `git clone ...`

When users have to often pass parameters manually, the typos and
misconfiguration risks also increase compared to admins setting things
up globally for everyone, or even users doing it once for themselves.

> This cannot be
> expressed with "promisor.acceptFromServerUrl" as far as I understand.

`git -c promisor.acceptFromServerUrl=3D"..." clone` is basically the
same as the option you suggest.
