Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5A2BE033
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783847221; cv=pass; b=BgNJEFcLAnfwddWGRjaQaP/lKCBG0XalKffwaQijRk6cMb8u2eBm9HYqDl3mrI95+KRBwzhxRFEeQ6KemNi0xszJjZ907X25DGJtwFeZlLCVmL6ytV5K3VL2s5jX5bvKNllo4Wq8mxm+jP6vVQxw5+9pwxED5jRR7KsvBCpfMgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783847221; c=relaxed/simple;
	bh=5jHdwX3R+MStUwCXpyuhM+8yzPyb7vszdWUCMIVhbmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=srQKnuq6IxOlI/HH3VD7hLrZRjC0ZYP1NCnx2L5OVP0YNEErIEyxPs9xPlgOera/TUs3pjJkkBjvegzR+BWcwCklF7/eozNzecRGEs46twQUmHawAyQ2y/v3I0/U2bEW2KQJVpJCW8eB+E6I3tyf1QqLgSsQU8aMulSyi7DsoNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opS80jaW; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opS80jaW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca0c5799eso22254315ad.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 02:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783847219; cv=none;
        d=google.com; s=arc-20260327;
        b=iskDpApjmUcZZzJ18r0p59O567xWPBHNOkd4OKNCwlDt94skt4Rf3s7cIsFBA9ltgU
         PxPHcmssGE6jiKC3PY3MsLQdQOPiK8a0fnPkknngvW+qEWTz5/VeFzhwmONZ98ykt5up
         deMJyNfE7N/HofqVIDhqTfEwd7DtfhTVMh3yC7qAFZ/Eov2XJvI1oYoFpnNPgd6sM9wZ
         g0Apv4SovfEHnQ+4jLwQbTsGDDRz9szqX//wNxbkAHNj5PpTjofrzJrSIa4GzuHApzTO
         EhHosqBcwXnwsf9kOjmfxRGXqdAZXazj5ZyqxBfuEJRzoVNGIJ8lWAfsUU2r9HbO/j3c
         9VmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wDUioqaPkEC66AoCddY+LcCbvpbp+IY/dM9l6PEC0xw=;
        fh=PjdbWf39+kjNW0G8z/UrjxWM8fidEohcojdqubEXa5s=;
        b=OfnNptLcpea1AspM8R2nKeiGeD8pp1m+7qkZXVgFJkcR1dnRZDSmV3gxFlZShJ4JjE
         qqXMPAT7qGdgjv9T5/4GM5BlA5YErD/hhO3G2TDqC1PC7mk5hvXr6DODLyFDaZOpYK8A
         sw3OY4/dByonwO1k3jkHqT1XYCXJt5gSX0tATemhbfJQqUV/EOxHPxXjId+SLR7G027g
         cv6VXDXWYF/07piohUslncNJ0k0acvG810fEW/UyBBbPcHcRHs8b5+tkoo30uo34sMDa
         7zPRcAmF5x+v9dEppteGXEVOQWlaOlTywisKzvhwCb1yxycKiR4SeCPC51eNFbQlD5UR
         jFhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783847219; x=1784452019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wDUioqaPkEC66AoCddY+LcCbvpbp+IY/dM9l6PEC0xw=;
        b=opS80jaWmP73GpiLIyZceEvkrEJ5jpWbLJSx4uH+OFgtJBvPFo/Q954UBH8wQrJQBy
         wvNlh6EPfD+GiQ8U99Xv65ydBWQJapFtN9yuJBx9/JZL5PFR5prbHsN6WCJoIGwXbYsh
         OeNUhQ43rnCSXYGyst3n09Qh0kstzUeKSKZWQZOtiDsDm805yC9deRID5obOeNgE93Iy
         6ncKFMBKTktTTzOfcagjEmrGFWrCdousy4RGClLqrDTrbR4FeFVSG7IzS99lOgSD8pto
         SXgnBQt4GelLCE9jZ413i2Pc/rOOkDlt1RcjWQbPPVxVFDCgcRKtZyDXSPMULXgux4eX
         Bz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783847219; x=1784452019;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wDUioqaPkEC66AoCddY+LcCbvpbp+IY/dM9l6PEC0xw=;
        b=VXtXwz4ALKr9cgSe83grDK5Ial0RhLUyfJB1PlAJ7ac6l8twDnsEa5C62laYf5MU0k
         8Q6F982dFJUEee1bJefPm6iW/zPW5UAK1o+j3Rovm1Vhd++O75am2Xnyr1aDjGRuQQ0G
         M9ZuzwtARq8msPOA9FS5Tpz/X7GUYHfyJmN7zLFPsAWFDTEDqxKT9sdjFrGKTXeegEeV
         tpoOaWAzaU3M/UxUJ6BysMTEi0XG6naaSIwGwspqq0yXuTICrGlfKSSubbAq2KZi+O07
         wbABuKUSDHj71OQmL6dj7uwCARHpHywt/N0TXJ1oaIp3gylcK3L1kc/cX+dSQELqojRa
         6mcw==
X-Forwarded-Encrypted: i=1; AHgh+Rrq9uFkCot2SvDGcQKw82vtE9EbX/oegQQkJHzdD45v3ceyJiGWRvqvjhKJlbCugbKVhlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/snEFr1+j872U8gp9d3EzWYF3/FVBFmJj9yres3M7lkuo5oZ
	pRK0f8CDhBEL+5/f4B12n9TW5KWobxmDwlkTHpVMjfp3H1r0GnljYlx5D8yO8OejEyKsP1n4Kq4
	uqT4F51H2bCD6IgOhlXI4dq5pBzmdKglMSSifQLU=
X-Gm-Gg: AfdE7ckIFpdbhokKhbd0ecOimLOjfEmYrCWP62g3TxGNwwi6vKkzFvzwNfKGZcsIKtC
	7j05RduKKXcfXU5SnzGZg1ouJn3UDY27eTNbpH8axVZqd5DsfjnbZByF5InXKdR3TwjIgTh/IB+
	ua3TSM+d21wjt5q98+1UL1d7tRIW9ArBzyxnjDalfNo9SDhWaujhzSA4eO+nywSaY4lnEyGFJJ0
	fO/xNqRZWRw9vFvAYke57NTNluKQmhxf9GC6iMDNI0AwlvYoSC5+x4TXxH+HfunaXkmdOhUgiuq
	2ySiCC5whd5N539QnH+kN4olFHWnO2qVngY93AkT5dSQbLuYFLnlw+2rng==
X-Received: by 2002:a05:6a21:7010:b0:39b:dea7:5626 with SMTP id
 adf61e73a8af0-3c110a73f8fmr5349900637.35.1783847219063; Sun, 12 Jul 2026
 02:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710085137.4171240-1-christian.couder@gmail.com> <alFM-4FJQfaEjyju@fruit.crustytoothpaste.net>
In-Reply-To: <alFM-4FJQfaEjyju@fruit.crustytoothpaste.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 12 Jul 2026 11:06:47 +0200
X-Gm-Features: AVVi8Cd7kRKAg7iCHxJepzYd14y9ECEgjIYWBckIDpn_TKp1ZmgNwiLzFdQ_HE8
Message-ID: <CAP8UFD0_S9eg_w42tcNRnT9E2ntLr_eHLnzE4c2dSu67DzZoXg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce a 'fromAccepted' option to GIT_NO_LAZY_FETCH
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 9:50=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-07-10 at 08:51:34, Christian Couder wrote:
> > Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
> > 2024-04-16), lazy fetching has been controlled by the
> > `GIT_NO_LAZY_FETCH` environment variable. This is currently an "all or
> > nothing" boolean that is set to 'true' by default when calling `git
> > upload-pack` for security reasons.
> >
> > Recently the "promisor-remote" capability was added to protocol v2,
> > allowing servers and clients to agree on the promisor remotes they
> > can safely use.
> >
> > This series leverages that capability to implement a pragmatic middle
> > ground. By setting `GIT_NO_LAZY_FETCH` to 'fromAccepted', lazy
> > fetching is allowed only when fetching from promisor remotes that are
> > both advertised by the server and accepted by the client.
> >
> > Note that using an environment variable for this is probably not the
> > best from a usability perspective. An `upload-pack.allowLazyFetch`
> > configuration variable would likely be better.
> >
> > Unfortunately the `GIT_NO_LAZY_FETCH` environment variable is the way
> > things currently work. It would be a much bigger and more invasive
> > change to implement `upload-pack.allowLazyFetch` in a way that is
> > compatible with `GIT_NO_LAZY_FETCH` which has to stay anyway for
> > backward compatibility. Therefore, transitioning to a configuration
> > variable is left for future work.
>
> I don't think this is a good idea.  We get a lot of reports on the
> security list involving various tooling that isn't within the scope of
> our threat model.  This substantially increases the amount of code which
> is now subject to that threat model and therefore our security
> guarantees and I don't think we should do that as it stands, very
> especially while so much of our network-facing code is written in C.

This small series doesn't change any defaults, especially
GIT_NO_LAZY_FETCH is still set to 1 when calling `git upload-pack` by
default. And the new option is more restrictive than the
GIT_NO_LAZY_FETCH=3D0 option which already exists.

So I don't think it's fair to say that this _substantially increases_
the amount of code subject to some threat model.

I agree that client acceptance of some promisor remotes doesn't make
the served repo trusted. It's a real concern, but I think it's
addressable by different mechanisms. See below.

> The fetch code by default reads lots of configuration information from
> the repository, including remote settings and information and we really
> want absolutely none of that code running in the context of an untrusted
> repository.

When a promisor remote has been accepted, it means both the client and
the server trust it, so at least the promisor remote is not untrusted.

Now the main security issue on the server side is making sure the
served repo itself is also trusted. And I agree that the operator of
the server should decide and mark that trust, not the client.

I also agree that on GitLab/GitHub-style multi-tenant hosts most
repositories shouldn't be marked as trusted.

However note that:

- The operator of the server is the only actor which can set
GIT_NO_LAZY_FETCH on the server (where it matters).
- In the case of corporate/self-hosted repos, the operator also
controls the repos.
- Different features could be developed (in future work) to improve on
the current state:
    - a way for lazy fetching to work without reading config files,
triggering hooks, or doing potentially sensitive things,
    - an explicit way for operators to mark trusted repos (like
perhaps a server-side config the operator sets per-repo),
    - operator-defined allow/deny rules, or maybe
    - some ways/scripts/commands to scan repos and check configuration
information, remote settings and everything potentially sensitive to
decide if a repo looks safe enough to allow lazy fetching or not.

I would be happy to hear opinions about those potential features or
any other ways to address the issue.

So I agree that this series doesn't fix all the problems on the server
side, but I think it's still valuable to be able to restrict lazy
fetching to accepted promisor remotes.

Also I definitely agree that the current series should have better
documentation about this, and I plan to improve on that in the v2 of
this series.

Thanks for your insightful comments.
