Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E829B766
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465922; cv=pass; b=Ats6n6T3HOBnr/1UfPFEVUeYUlGMR+zCQXSWXKshY0wcVE3rbA+9q1Pb0ZKWXdV/7qbxWGlQ8mGk+bbI8bJl3OH0Km+31fWBI6VNyYJ1JD0sYffdYOCpXkSWO7mgy/D+TuEOIfAHVtIJKxg1EKNwuGatiuLuqjAa0vpF9EALWsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465922; c=relaxed/simple;
	bh=UcbEyjSOXkdcEaK4w3SUTa+r1O9CYEOvGLBqbAq4a6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAPa5pHcGWxQBxIFZeNetvJ5gdnE/wx9fvlx2W/56IfTsWZM5ezq5tNOmM7dkGk6BkK7wiijpf1ZXNw5O1d9fqfPZrfbN6LRSnRsePbcXYakD9VwEoAmujbOfjmmLvOkv5Yz4hqdPwxruXtxEz9lmo6Ckbdw8WncLI28mAw7K8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFBtts+3; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFBtts+3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e61ac64ec3so12167945ad.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 06:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791465920; cv=none;
        d=google.com; s=arc-20260327;
        b=sD3xEJqQzd5AD5edW7rY2D40qqqZMJU3ZxSyliRFj4bMLjWvLbT5clS12U/Y4zdLKH
         JXQxKcGQzkdURYmeBnVP2+bWuFXMzg4HfOi5OlpSYhra6kFiz5wrA/0lsOvPtCEZEFJf
         5G9vTRjIVFb2Ciz1HcL1CJ0X1f2kR8TZ4+i7CljJSZS1m2HiAd4BPw1dbq6NBdnRVrnJ
         QO34+9FW2LsxsKsZ1rDQ4Gc2S+g9O/oYIwFwSvqYPM6N2qvhAD3G4/TNFaaWZn0RQJl9
         Vkxk2ZRw0+QIrSDGu7rVA0T6ozGUkWTkr0iRHes3GFWBDHlrn1SmSHM6ZsCX8ge1NPOB
         PsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UcbEyjSOXkdcEaK4w3SUTa+r1O9CYEOvGLBqbAq4a6s=;
        fh=aLlBD5hj+0mXVm78wJzVMr09POhqdV9kRIO7ZFQdZ40=;
        b=oXPDoZn4E/YAQgDCrF1MZMoQ5U95OrbBMUT1DafijyHNLj9NDH907+SAvoB4C3kn2Q
         9ovNbPpkXlNT5kctUfUyFa/3mopcsJxoKRUi93s7iqSFhd/rsSq9lD7Aif2mYXhfKz90
         BnXt0JXX7+TJECp8sNtlAQjT49YFBhwhEDeRHJDhj/d8z4fiiIzajPvNIxSboUTlR/2O
         Pd65SE/lRWl5l/ycv0YrIjVL2dNg2vqtyZIgPtrcDZ9RIW1hasZqC0N5WK77O3pQu6f0
         5APPqcjMrOB7xezWJGM6/KX4gSwrJTLDhdVC/KxGgae9fM9+DPVDkSxc2vYcruUBd+jM
         J30w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791465920; x=1792070720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UcbEyjSOXkdcEaK4w3SUTa+r1O9CYEOvGLBqbAq4a6s=;
        b=JFBtts+3BoY0pBmFpuUfZxTWZezNMaSirM1SjJHwa9IdVCc35bqazps0UrApcvHTyw
         ELoxO6fg8It1bp7xdkTIpth/zE/hjM81VHZdpo99c4nfCST0d/gcAi3qnbSZnxSYd8HA
         eQToWOMss78b0yLVEJL4XcBkpLooWLIUenWxrZ76g37Ia0+lkLb2YGdH0U08vn2fcfzc
         +9fr8z1z33iY68+iIVP/MN7BzhfIQf8FRKVWzBmfzf5oVfjsHgfUB5fAaZiGAWqcloIO
         aqSgo7Qb28O8QxUXwah2lkYSSYfCArI2lgWsSYUNq/Vw3YTDCx1Z3xcOOSOmuDXHeRV7
         W6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465920; x=1792070720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UcbEyjSOXkdcEaK4w3SUTa+r1O9CYEOvGLBqbAq4a6s=;
        b=A7rwlZkFuH4Lo5K+4pTWbOOGJsYY1jVeiROy1XpS89V2S8lFici/nmlpRNgzZv03d2
         lx/mbJQFm5sPaBw8wuw6xPWC2F/RaXeTf6M0GmtaSJmTw/927o/t1x02bFHOonbR0lZI
         /wNNuIJn6kXQ3e59p6lxeYknltPyG0SMgY8GTW3qbMmX5KLZhs9A0olD6ZmukbYeK6f8
         jQQ8O5ENKb+cVJBxW6EYrTs5WoF8iBMO4xtjUj5zZU7efBKBf2XdXWpVtu+Pgl5PaBjo
         2xK9wgEKu2shQcKQZRKcYIC42C9WXCNi8TtvOrdKJ8jT8Qa/Orcc/BlV852E4/T5K8oR
         9YAg==
X-Forwarded-Encrypted: i=1; AKwUvBwGA8SGn8IxJqh+pn4YrFhf13xily/TJwS25GmgUwv1jk9HgWjWu48UchwChyd+ItqMzp8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0faFL5SSaIBOe9ldrX46YCz2RbnUt1G4dETOaH38/8etrCV57
	8QHfxxk3y5YFVXjCQTttu+SWYVpP8umEqO9DdlHveJ3isSipPnTMRGdwdl+LziTHoFwMRuefNSV
	NOpj6E1dtYeS2bxXpCVnpSsxNkSQRWxtiS7rM
X-Gm-Gg: AYBFou1s1XsVK8eOO0UBjtWiIlf1/pGiPpwGS+Sj8glDD8RX0gpBMD8ldYbACeSqxxQ
	gk1WZAM3A6N9NhfwotNlsEoSNUYnska29O4JMJ4miHYPzYlqMzAClQlO8R3dUviA6aAtD6N/55l
	2DwP0QGxanpKadC4ui7IeOM0hhVvukK4ziM25RScv259TmOpFlzCHIbnhMVuZIVAEsSNig66z2k
	9BiCKxWNNxo8Bc7JKwFUrcvpCiRb+EIh/l25ZKZwQJsvuBREm7EXCbQyMI45KYL0KPjTXWNjYal
	k89qhyZ1qnQkiOIyfFSiN85X0OGgaD8goykYuXNQV1cewtP7V4H+BVWp65IodgJ77vb19UQ7Ry4
	r/3RJ1cXPLfNRvDBj0ladnSdHDptl6w+3DAkrhozofaNO3xQt5uc/BB02CW7IJMVcjRyfXB1G7K
	FMWrD17J0=
X-Received: by 2002:a17:903:26c3:b0:2dd:c053:a6f1 with SMTP id
 d9443c01a7336-2e6004e73ddmr52071135ad.35.1791465919085; Thu, 08 Oct 2026
 06:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929112544.86511-1-scott@gitbutler.net> <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
 <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com> <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
In-Reply-To: <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 Oct 2026 09:25:08 -0400
X-Gm-Features: AclHuK9exgdLjI_T6Qo2Y9BcRwYSBN8OT8MElOBC7jWL82ma7UofLDwkgdFxs-M
Message-ID: <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
To: Sam Reis <sam@opencanopy.dev>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>, Scott Chacon <schacon@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Thu, Oct 8, 2026 at 7:23=E2=80=AFAM Sam Reis <sam@opencanopy.dev> wrote:
>
> Hey everyone. Just for the avoidance of doubt, very happy to see
> Scott's patch here land and for git to benefit from faster sha1dc
> hashing. Let me know if I can do anything to support!

[We bottom-post here]

> > On 07.10.26 20:13, Scott Chacon wrote:
> > > Hey,
> > >
> > > On Wed, Oct 7, 2026 at 7:23=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> > >>> This series ports the approach of Sam Reis's sha1dc Rust crate [1],
> > >>> which gitoxide recently switched to [2], to C.
> > >>
> > >> Which means license-wise the original is compatible with us, I
> > >> presume, as they are "Apache2 or MIT, your choice".

Leaving aside the question below about AI policy, I think the
important question for Sam and Sebastien is license compatibility?

The sha1collisiondetection submodule and the sha1dc code (extracted
from that submodule's upstream, if I'm reading 28dc98e343 (sha1dc: add
collision-detecting sha1 implementation, 2017-03-16) correctly?) are
MIT licensed, too, so there is some precedent for Git here. I skimmed
what I could find of the original threads:

- https://lore.kernel.org/git/20170223195753.ppsat2gwd3jq22by@sigill.intra.=
peff.net/
- https://lore.kernel.org/git/?q=3Dsha1dc%3A+add+collision-detecting+sha1+i=
mplementation

but I didn't see a discussion of licensing at that time. Perhaps the
idea is that we are clear that such code carries a different license
from Git?

Anyway, I suppose the fair thing would then be for Scott's code to be
MIT (and/or Apache2), in which case it would need similar
clarifications? (Or are we prepared to take the stance that de nouveau
code based on existing code can be license-washed, in this case to
GPL-2?)

Interestingly, Gentoo claims Git's license is only GPL-2, but I think
they compile in the sha1dc code since it's the default in meson.
Should we be claiming the Git package (with sha1dc) is actually GPL-2
and MIT?

(This is complex territory and I'm sure to have gotten it wrong;
pointers to past discussions, esp. those by copyright and licensing
professionals, welcome.)

> > >> How can you/we be sure, with respect to the current AI policy in
> > >> SubmittingPatches (which by the way was vetted by SFC lawyers), that
> > >> your "AI generated" code did not "borrow" from places that gets
> > >> you/us into trouble?
> > >
> > > It's a good question. I actually just submitted a proposed update to
> > > that policy based on SFC's updated guidelines, but either way, I
> > > learned about this from Sam and have talked to him about the port and
> > > he seemed excited about it. I can triple check, but I'm fairly
> > > confident that he's fine with this and I am fine signing off on it
> > > under the terms of the DCO language.
> > >
> > > Of course, he in turn used AI tooling to produce _his_ library, but
> > > within the guidelines of the updated SFC guidelines. Johannes's
> > > alternative series is the original Rust code of Sam that my agent
> > > looked at to produce this (in addition to his blog post explaining
> > > it), so I'm not sure how that might be materially different.

[snip]

> > >>> [1] https://sam.dev/blog/faster-sha1-collision-detection
> > >>> [2] https://github.com/GitoxideLabs/gitoxide/pull/3008


--=20
D. Ben Knoble
