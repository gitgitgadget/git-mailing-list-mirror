Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEA1A6816
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787634033; cv=pass; b=JJfzjhaT36ZIXEEs2mDgGZgwbrHDSjTCMEVCsPlqYwhSTTphA6TpECTnSEXZVZVX9FvT1iyfsD0w4rnJYuhOJps8uycvKNIARXSKkgYrNoM9Eg9JIUpZaRvVRfw9TNbr+AcQta87PASWfpZPxYI9Jv7GUbxTibL0MIuUUUB9Vo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787634033; c=relaxed/simple;
	bh=dPness57P/Ki/jOECapbruG6rdJ9JZRm9mTISgYz7IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Stlcat5a4zNB11w/pEka/moezxFzfkJ4ojHe4IeDZkYkA1KDlbW8NnpgT91EsDtAW2b6J6i4ipeN10RInsmb4DSGQzsA0fmLj1kjuPVBOv7goTpyHPQPl5fBLxDZ56Js+zjRLPoshDssgw+oPEp9x542vziWAJX6HcEqJyxZG4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB0Bdz+W; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB0Bdz+W"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b1ba286f6bso364055b6e.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 22:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787634031; cv=none;
        d=google.com; s=arc-20260327;
        b=J1ZT/CpEJUxW/lEDpc6gchANzOKjow4HuGwENrupCANGsgsy7iC4q4CwHt0qCWVA5V
         CpJamLY68lAMYanATcsTkP4aJ9NN9SS5EQKrlA1geqejXcUWZQl8aGC+Gqf/a+bVMny2
         QyUt2pEUpJGNFwfuV6b/plyw4RSBCU0jZhV/ABuLMNobSTTgIh98HVbwSbcIham5cKIo
         EegUW/WuaIRwFfFnUUyst/p13I+47vsTNCvJuJe2D1QZ5NlccYM9mpzot0ptY/Ff7BWR
         J+7xSdw4ccL/f7pRdBO1t5y/L+hT3vSBkJmrre661HKKPYbhY/ud+dVou63QOKumgMbf
         WfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cNLV5x3vMHD6GFE9d4bYrgviOchZJWSGv9H2n0m6J9M=;
        fh=dgnBqKHaLIMT+MHZ+gGFpuOu4t/isekwRllWlqzS7p0=;
        b=j3oxhSbOyBzhjFuDqj6N0thmu2NfmvJw2qPVOeX4Wk9Q4xzIrk65p8vVT8WWpKLpfx
         JN9G+Itakf9YbaRUF4I/0WD9P71vLDDO4gxZBfdmD24vp7i7V3EGe6T1DELXy43IlyVo
         87zXWilsZCKzYDw9eF9yj2Je3Z1GeXJEk6Z6wLY9PprOt66FR7x3kVQa9fR7ctPlQxEg
         I7LQjdNhmEE1sTuZpXuTK+p7Knal6LG2qyWkLKayR8+isrGiSRj+x+Vx5/ZuxNMa2bty
         /BQ/TjZaWACMfmydNB9HGIlJz94dVeqACQwfDKsrZttmsPr5uHzTNxnp5fZCUb1Lzduo
         G+hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787634031; x=1788238831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cNLV5x3vMHD6GFE9d4bYrgviOchZJWSGv9H2n0m6J9M=;
        b=bB0Bdz+WCyLzl3PamlNL9G73LzzeSiVOjI5Xwb2qlBFCwuwu1Gc+H5YQ5QnwaFLy2z
         Y7Dm7i+dsExphhYeZxeHkpTwwh3Aysz5pTFmspn8S5lLdvGsqlhV1fZ8JGSiMlRoWeyJ
         InGfoGyvkVmwRnAMJD9i5Q/d5wM24B0G1KjH1WV6LENsXZMD3IMyFNsXgiPG5/E+GCBj
         UowhPOB+wE2Nte50KCYIh7DUzH/g84J78f5bY4JtRDN8Qj1W13eShfeHLIu9+AfiTs5h
         O1W/EZoB+s1ttWIsJWqIl4XVLK09/IL+BShZsUznvZ5OuzJwXAyMjzgVxLsvMyUbRXqu
         09OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787634031; x=1788238831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cNLV5x3vMHD6GFE9d4bYrgviOchZJWSGv9H2n0m6J9M=;
        b=fYSIR4TkznuLfQo5wdVX7IXl6ff2Jr1Nlg3C/zAuqkbmmK/29H9vZfMX2DZQGn/58q
         aHRwmqojC2NMMW/Av/IjDTeyTqAFWW9x+zJ7lQo60DacC6Qwu/TvqXyh+wgh3SIN7eWD
         ikbnQNvlraUm5jqPi0vEsGikds0U5Y6I2GMAeSaWAj5lPMaLatSXpRDzLZ0dDHoJsuD5
         0D3bhh2RGcFbX8+PGxtLVXa41q8+nZR6SKgLgH8nXuC8tGajDs+I4bDB+u2ahyzXgXzg
         ZcWabKDD7Se0sj9FxTSHBU/ilSBmBpxW+kCgjcYYAlO248Jety4zL+kw1j3bS5/GvVGi
         yFwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqEbn6xZDdhSirbltSW5HHd9TIKdk2Fzo6k6xcorYQ5kVqmCLGg0vOOc46PQwkJuqorW+o=@vger.kernel.org
X-Gm-Message-State: AFuF++krLU6o407TF/HUrB4s5OUVpSQs7e33pChLT8RtcorIeNDA2dSb
	+mNMdMR+pIKDiY3fCmNKLOF9x8cVdv64CR50IfLuR8jzzybOLctTChtl5+adZl/YsUGnlT0O657
	KiXOqD7C1HVvvXJIF2KaHaUZMStAu1qEnDAlV
X-Gm-Gg: AR+sD10AtU/pYaGchtsJlrf699OC1uxJNxCUAHvikPoUYWn0q8E1oxfYF+Jo14aDqTb
	2mf6cHCD9u1416s/fuZk9CIGyNDf1uDK6eQm/MyLd++Yo0MsdxfC3wcd8Mnf3PEhWMoSBcIFW+x
	o8x4Ml/AuTvOd5gqnrzH5GYcOPhQtv0B0mooJw5At9wvKB6McIDEMlKKQQRm24H3YFDJFIxKKqP
	vMrpqVPLGwBgNqPKfuEtLk5bGxMvt6/U1CWwR/gHBZgvRyfIe153rgqOkaW2c0NwSZ01Ss/smmK
	5+46vvXJkT5bULEJPav/c58w3J/r0I1vcePXhdGYp6hG2dCfeksb6EsKMJyAOcR8B7ZpYLWElP+
	Qs0GfDjW77Zfk5yJjf0ir6L/6uHffoxrpWFpvEaIsC/X6mJY5VnleS4QMv6mr
X-Received: by 2002:a05:6808:6715:b0:4af:aaca:7be3 with SMTP id
 5614622812f47-4b3504d9ed9mr2944334b6e.12.1787634030609; Mon, 24 Aug 2026
 22:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
 <aohP7GMx9oX3ZCsQ@pks.im> <CABPp-BHJj-b=ieva3-=zaCAyvn5UtNQqNT0Q76YCpqZAjO-8VQ@mail.gmail.com>
 <aovW5bxu1F8jYKYl@pks.im>
In-Reply-To: <aovW5bxu1F8jYKYl@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Aug 2026 22:00:18 -0700
X-Gm-Features: AcwNN1V1ZiF3Hq57qjpJK9B5VdZw9g7NV1MM4BmjSeEolZhzs0VhMt90YUbfK3s
Message-ID: <CABPp-BHwa7QM=XDuO=9xqm-OL8dn8uGf1=rv+sgBRQ9hHKMFuQ@mail.gmail.com>
Subject: Re: [PATCH] send-pack: avoid sending the whole tree when pushing from
 a shallow clone
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 10:30=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
[...]
> TIL, thanks. I don't think I was even aware of "push.negotiate", and I
> mostly went by the folklore of "just clone with --depth=3D2" that I saw
> repeated on many sites.
>
> But this and all of your other answers make me lean strongly into the
> direction that the fix is at the wrong level, and the proper fix really
> is to enable "push.negotiate" by default.

I don't think that fixes the problem, though:

  a) Users can do a shallow clone of a specific branch for a specific
pull-request/merge-request.  Then the pull-request/merge-request is
rebased, and sensitive data removed due to a leaked secret.  The
shallow graft is no longer common.  Pushing from the shallow clone
should fail, but it shouldn't have to send several gigabytes of data
in order to get the failure message.
  b) (Very similar to a) Users can do a shallow clone of one repo (a
local repository cache?) and then push to another; the shallow graft
thus may not be common.  An error is expected, but sending gigabytes
of data to get the error isn't.
  c) Users set push.negotiate=3Dfalse explicitly.  In my opinion, they
shouldn't get this bug just for opting out of that kind-of-related
feature.
  d) push.negotiate=3Dtrue silently fails for some setups

I think case (d) is particularly interesting: For push.negotiate to
work, fetch v2 must be working.  For http, that's not a big deal.
When using ssh, it requires the client to send GIT_PROTOCOL=3Dversion=3D2
environment variable and for the server to accept it:
  * Server side:
    * Some self-hosting forges may not automatically support receiving
the environment variable.  My searches suggest BitBucket always uses
v0 for ssh, and GitLab depends on the installation method -- either
the Linux package or self-compile installs requiring manual action
(only Helm and the all-in-one Docker image are preconfigured)
    * Some corporate setups may specifically want to disallow sending
any environment variables over ssh (perhaps through an "upstream stock
configuration only" policy?)
  * Client side:
    * git only requests v2 when it decides the client is OpenSSH (I
think that maps to the command being named ssh/ssh.exe, or an
auto-probe succeeds)
    * plink / putty / tortoiseplink appear to not allow sending this
environment variable, so many Windows users may be cut out
    * Some corporate setups might restrict sending environment
variables over ssh on the client side as well

When it's not supported, it falls back to v0 with a simple warning,
does no negotiation, and runs into the old bug.

So, while I support the idea of moving towards push.negotiate=3Dtrue or
even adding push.negotiate=3Dshallow, because they would provide other
benefits, I don't think they fix the problem at hand and thus believe
that this patch is still important.

[...]
> > Since we've got another place where commit --amend can serve as a
> > foot-gun that I've long meant to fix up, I'll submit a separate series
> > that'll make it throw errors for both cases.
>
> That makes sense.

Turns out there's a bunch of additional stuff on the shallow side, so
I think I'm going to split it into two series; a single patch for
rebase/revert/am, and five or so patches for shallow graft handling
across a variety of commands.

> That's all fair, but it does dramatically help in the case of shallow
> clones. And the number of times I've seen this question come up hints
> that this is a very common scenario.
>
> We could be clever about it: if "push.negotiate" is very likely to help
> in shallow clones but mostly just adds latency in full clones, then why
> don't we introduce a new "push.negotiate=3Dshallow" option that enables
> this feature automatically for shallow clones and make it the default?
> That to me sounds like a low-hanging fruit, and I would prefer such a
> fix compared to introducing new logic.

I kind of like the idea of somehow making push.negotiate default on
for big repos in general (not just shallow), but while push.negotiate
has lots of other benefits and has the side effect of solving most
cases of this problem for some users, it falls short of actually fully
solving the problem.  This patch, or something like it, is still
needed.
