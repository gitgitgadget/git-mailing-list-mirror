Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6311559CA1
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084119; cv=pass; b=Esr46JQjOElMkQKrfzZLGApOO4UgLHHwWkR8KootwkdBYD6zxB7axPWYP94YY6tgXffA8Pbp1lFYo4Im0QIe76yl5k+Ira2746IqzEL8qukAHV8RcQv27ZS8lX46A1yfEmNl+QX4UwfpBtfvQK2Y6GE7pQxz15mBUTXTXCGd3TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084119; c=relaxed/simple;
	bh=IuBeX9UsLjzrQ+wORIQ+ZbnTWymThfvpTauZVL74Wyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUTJItiyI1AXnWBFomSCeGD0H+DS/x7fTRyZY093TjhbOXPQ4cUNEbSo/bdznpokbBJbr1Pkd28dmf9jBWwh24kwO8ja6oynsq2HffgIp6e9k/0eWYXMMzBfn7ZHUeBlm8EBEDY66aUNJeSLzrYVI4oye9/ZJbw0dJPP4tWLKg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJzjQu8S; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJzjQu8S"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so3032586a91.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792084109; cv=none;
        d=google.com; s=arc-20260327;
        b=I0KM8ciFM4n0jtchz/z4Hxs7aSc9t9GNsCn2lkh8+mcr37rTrjHdOMq27+H3SYXEDq
         Uh5Q2qKaGpVfbnNKCGwnRuOySvNaMn7A3I5enHOlW77aUCa5oJZgPc66bKhfbovRwagh
         sP4W87KnlZLJ6KOybzBGEKIQBbGd2E9NvN77ij6MemXEBH6eNlWHz2CkGldUtIjcc9dG
         8mRUDINB2rrfIvmbZAhr15EE9Zp/xyoWk+kdbgpEtY0VLSbkHO/huy23+Q3ymcAOKDTV
         OyZ6P06ThU26OHQDyBgvPLXgq2OhgJDQEk97/EkEg9C9fJo7G/3xTLcKUW5eS0GsxyJp
         MVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lh1gtewWyy2el0QzTV90ImZ1yRy3kuwq4wX5h6XJong=;
        fh=FRjt0STjO4kJsvRQmV+aq2IcNOm9v68xPdk9k9AHDF8=;
        b=jrmNyAcQHNtpZoohEuYeQUfHZ6re33MI13ldwHsCeu1t1kuo3S/qZoVt2IbZKUOOD7
         KT4Os3c/WAN89pSniMzGlImd1EjPpv6ZW/LsYAP5c/13mld23bZt/v1pevajNedtbRrQ
         L67qM0bu0a1OgDvHEv961QJvnE/KQGy4viezPLWdtMYF7qthkDOzXIMJDFTGCjOtKEod
         LDqC2zWVttloNts88bELFwrgVeztaWWQ6cOG1SbS4NC+KpvigMMmKOo1ntcp05Dcxpli
         BqDG4992X9tUa2Q3jJ+bOHxvmUx9lvtzX9def/9DpU3A7lF+4nfLRHNSR+/qRMT2LwjY
         xMpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084109; x=1792688909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lh1gtewWyy2el0QzTV90ImZ1yRy3kuwq4wX5h6XJong=;
        b=hJzjQu8SsTr3NygMsDryrCHt0S96+2kiyX+iQLGaQgRaLHiogDFdUH4gYOragninlV
         MqhkUNzH8nEiEJlnMpUU8zQHT8hfJ/+OGHLuAKzgjzXkEZMkz9CR859yMDp7oYTfOOL0
         tMBNesYBZPQYQgW3TGtVTK0gTEJ5wqEti5zn3t38iT2R+RDA5ZW/IaIUVlIAQBQBesR3
         VZnSWZmowK9PIr2SETyVnr6ysSaK3maSVYWufWmQcT6hE6cxz3Py3EUZYYozbijVnbAa
         0LJ8HcOdrdasoJVNLjd1UgFcUkGjK8ITnZrLR/oxGvQzqvFz+EElenGxZdFup+c5ZjcG
         F0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084109; x=1792688909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lh1gtewWyy2el0QzTV90ImZ1yRy3kuwq4wX5h6XJong=;
        b=d2/Xd1S2UI07163si6TBlrr7hTbZ21GAcikkyDpq1xGgObaDWFZZLHmioWer/2py+x
         Rsjde53+7t9oCj8VwwvjIV2688Hvc+IV+l+MHwtFHvmHo7EEFLKSugmJ/VAHRZKKNqTR
         lv0r/mobnevHAqBk+3SVSwbKE5/x771s2zee9JYAL8UvdM2SRqcq7M1uUTi0JZIqukN1
         VlIyHpO2MsPVuXJpHA1eLr11UCql/fB1C7Rj+KH98sB6cC3fWbujXuMUdoq+5lCO1WJv
         QVU9ihdC4SanrFY2qYUaWVPK1bQkXl6a1auqu4M8NB1kHPzNZYXCTHi11Fj5MncgCAlb
         pUGA==
X-Forwarded-Encrypted: i=1; AKwUvBzNupYGmTOE9kMByvYLSJ4jR/aYjZYqBgZ7POpj8oq5xqyIONWNFW7B5xYyBuUf6Dbvqxo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJF4cUzkf/PpL88K5hswB1MYZluWBDMdAGf4coZp1kxh+RQE44H
	3nzmkv7Fz3NOF2YMg1R/HKy5EyYurc1/4/qpLJiLADXoCPj0uyyO7OR27YbisiVsnR+eeKuudQg
	r0ov5IzvcAIUeEyO/M3sap2hqb8+sRlw=
X-Gm-Gg: AYBFou0mDefO+Zj77ph/2GwVmVwHOgv6QcK8LtJl6kuIkQK2n8DHWhLr5Pg+5NS5XzV
	3obIL7+YLMQZYCy7boK3zU4+OCrrc3mWkXPqxovFU5FPMKDt0Kgf3c0X6DHWCDPkYrfG8TMKomJ
	RP9qXM78tw9EJ5fCR75AhGVfwG3gy9OOZNuw+jm+3YOI6smCDK/OEdRA60nFH9Q1U5ZEK70ClFH
	1JBcqn90hNpOuaYg2aDyTB5O/MszIzDy50dwhkTFq0iiSB1P+q+F+jIv76BVy6tl9iUMMqFVDSZ
	159ScUUpUxJj5EUtgEatYTi8XGHH63YxM87EeWfMPhMtf5qOnPcB7l3ED3kmR6oT9LiE/Me6Ykb
	cINOGi9PhI4fakopcrevhjZsPAPqvB4Rvp96miwt4XJJx60ZJlpRTLcRZiQdDHO7H8W2qRSgG36
	iRkN1PRnOKU7A69isNVFYe4Af0k9ActmT7PIEYU9+D
X-Received: by 2002:a17:90b:51cf:b0:3ab:c370:3684 with SMTP id
 98e67ed59e1d1-3abc370392emr11531851a91.30.1792084108770; Thu, 15 Oct 2026
 10:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com> <20261015133624.82112-1-haraldnordgren@gmail.com>
In-Reply-To: <20261015133624.82112-1-haraldnordgren@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 15 Oct 2026 13:08:16 -0400
X-Gm-Features: AclHuK_PValQBD6rdRqP4TofGMuXB_94c3r1B0LV_-DgCzWCU7tr2FfyqPn6Rrc
Message-ID: <CALnO6CAi_rh_JMOhL0wrHSYZQYCZZstVNFuTxCGCavBnBPe+oQ@mail.gmail.com>
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, karthik.188@gmail.com, 
	mail2venkat21@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 10:20=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
[snip]
> > +                     if test "$storage" =3D mixed
> > +                     then
> > +                             git pack-refs --all || return 1
> > +                     fi &&
>
> I don't see any reason why a test would need an if block, we know what da=
ta we
> expect, no?

I didn't examine too closely, but this test is wrapped in a loop over
the storage variable that appears to determine whether and when we
pack-refs, so I think the conditional makes sense for that?

--=20
D. Ben Knoble
