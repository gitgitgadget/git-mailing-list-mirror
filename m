Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A35440A26
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362134; cv=pass; b=PHtQiwVj3HWjx+FNK+ZRtunJo8kqA7EJSAVTKudmoFOlpc/Y6rwJk1bQ9DdoDF8oPndaBqNJwy5jCzubJamOHnZ02o3Ie1tnDUuW99QkKCdDntYDrALEBSsZIUNtCvLqNCwgimb3SiRPYTu1hStcK5o8XUJcHnVcBETWKNOKwW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362134; c=relaxed/simple;
	bh=ZT5b265RTJmImxB+ih/bSs2CNzSxobSpc9+yx+e9Orw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYRvaxqXY4aujz9TpbWts6Lpc3VjL16dRt5T3b/wlrJnQkx37m6Jsl9BURCWSA+dlffYzejYvtUL5Q5OqZeOdpzppsZccVyiMubOmeJBBeh9hYiX4hy+F/+OIx04d/qCTii2MPmiMkrDsMcK++L6zAa+Xx5cuzR00pzgH+SZ/yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEdpzVaF; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEdpzVaF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so7448445e9.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 11:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790362131; cv=none;
        d=google.com; s=arc-20260327;
        b=reDVfCcbO1sY+VvFOoh4APyE3n2lCoxl378qjaVhS+jlFERnQaRN5joItR0oy9oOhf
         NWarrYyCfUhCjAmkVRBN3RWJE4jYvGzm8+1YDiCFzqTAZAshtWoyqbXxQGb88SGyvB5t
         i2PHSD3pQWsHXOPnK4zx1mOyczMwpjCah1S9NRnvehULH8qRs/Rj/3r6LKpJ4RskgZjg
         5nEkA5A8Se0+rWh/Jmb/O+A8g40SYOdb02OhHEKRBkR45zZu1hfbbb43F/Z9sQfzyk0X
         9xVgPhGvqJ1LwNUgkw5e8QJUeKADOy29F558XayFfC8mW6EbExsHgLSc914BwDBPrsbt
         9B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMmJPAyeYWklctLMZZ3a3lJrUcS2YhZ+GkwKEUNUvAw=;
        fh=Q1FU6S1vCRhu6ppLnLb35N0jzd/hh57kV+e5E/waHwk=;
        b=lR7yfomDsuQvfAatyB3P/EiaY6sC2f85meBt6OBS1XbqUx/VDGjFFdCbHZVp+a5FTR
         WpvFHRVpZpudj3LAyhk2DNM+SMFu4SzSO44JPk9ycNQ4ngs2oX3xJAE5bpo9I1c1vp74
         uxsrskUF7k9X/Tb6Fw4Kh3QTPDHS+Ni40ESEczsBq1b4nz4NXi1uGwnXS2bfBn4p1KJ7
         p7ca/SswoTdJ/UBEgkvGKRBIwdDm7rRL8XNQxPuHs0OWWVWFz71z3fQfvZy5kRSby3NR
         R5yaqrBgoyOnWTSwQcsfqBG6J2Il1vUU0dwvj4pMPvEUR7Cl01rFmQdUItG8qFa+IX6o
         WiCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362131; x=1790966931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TMmJPAyeYWklctLMZZ3a3lJrUcS2YhZ+GkwKEUNUvAw=;
        b=QEdpzVaFA36GH2QES41aCMYoWrLJewSJleXVtknntYHBKA0rppO4JRcfUYOqe7TMdf
         6lIxrhVSV399VxWsW8aA/MjqVTqb5klHcvB8PZhMKIa0dX/jOzrWCqtmCGIUB3sC5rek
         G498j5nGVbJcY2+6HNHw4wJXnNd64Ms+B9ntCptVZKLaTtxAGfJRaYy28pbk2fu5QmM4
         mWSXc56V2BoD6MBN4RDLvRet+elZoHU/IHtgcuRKtUPOebiBazOj1mVPj9eC0+SGf2Hf
         TqqGbEEJAXG4/LIJPfP1dKUgU1CS4QRivWsNJsOtM/p7YXQ0h7YgsTapcdpbRGNZjmxo
         wrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362131; x=1790966931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMmJPAyeYWklctLMZZ3a3lJrUcS2YhZ+GkwKEUNUvAw=;
        b=HpJAriyWy1mXRT9WopyIb2ubsi/zLC0DVqUYeFXf2uSsxntqa+uQG/z9MzreBQJAgw
         3nEvIjTMDYEt0jHWgVyEuB0Cg5snXWFcdGralX52tS7PKaFgm4nUR3ldBu47rcPyUAPv
         o9wTrbvmKV5ANGa/Gd99cCCYEj8MGRRCgKrrWUzU/kvoG9/Z9zeT4LytCvnSGdtZ1tPW
         7VEoOVEVX+C6PqEEtvfaHEWPG2XOlc+U735A9SnSi5ToQXxI+riopEEPzXlmS8TrZ0A1
         bvcZqZf3ZQHTJS3JUkShKvBVls2sWdZwRlcY2YdCDSFYQYopFYHKyqBp2tZ82Ly6qQHN
         n1EQ==
X-Forwarded-Encrypted: i=1; AKwUvBxE9S8Wr0r/RuzBeG7DmxV7GdFmSwr6zcMLuiIAMeXQSac95jNWMFXm/DeCAzikStf5JMs=@vger.kernel.org
X-Gm-Message-State: AFuF++lXK88Wvb/SwhW0We06D2Fu9pmvvppi5dN4o+j+KTaF+MGos3qq
	1wzZ1x3pfExl+gEHYRzAkLuqjs8Y1Xsqm9homa1ZkEtpRroijgJDBGFbaGENEI6TU+8t62Aibm/
	5p2Th8Cqb3X22+tr254yvNLUh22mGx/n+ASKQ
X-Gm-Gg: AYBFou0Ea6lLFHX6cHSkIMAFl2gRbYukwpeHoAS2880qtklBIny1ACQJtaOy8A+vYbm
	RUHIIqA2X2jCuz3yy9sAfvAK7r0IzvFyXjbSTIiJ2JB4YZwfJK4BBJKdln0/2HJjNHpFAptU4yI
	8suqIOw+9glBMBAqTwlKQcH7bQj9LQZPKCs5aXlSId/0IbvgmjdL6+bIohfxkVHgnWEQgES+6bC
	wDKcJlDNENGjNNNBZMo/yDMGoioB5wMaL8vpTMe66NLpzs5kS+QHRuEM4Xv2WKyE/c1sRWySzbj
	/iNS5peJLAG/6PlaBDKBW3wH9Y7fspE6qOsKv9+ceA5Ir5JxeY2NM09O
X-Received: by 2002:a05:600d:15a:20b0:49f:f963:7093 with SMTP id
 5b1f17b1804b1-49ff9637122mr1546555e9.23.1790362130630; Fri, 25 Sep 2026
 11:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
 <xmqqwlsdhmvk.fsf@gitster.g> <CAHeTm9OMLba_h0B2jRh_-GhogQXuwROBpX2jE__BPJ0GHq9P1A@mail.gmail.com>
 <DLNDRU6GIB30.1F5G8Z3JIR67W@lfurio.us>
In-Reply-To: <DLNDRU6GIB30.1F5G8Z3JIR67W@lfurio.us>
From: Colin Hinton <colinlewishinton@gmail.com>
Date: Fri, 25 Sep 2026 11:48:38 -0700
X-Gm-Features: AclHuK9LCxBzzdIhaNEB1mXbPU3Cq23hZBlCsloDBGsqCal3-eRLO6z3ZX-v1Ks
Message-ID: <CAHeTm9M9c7D71QUA-Dy9o_YD2PGbNYRa9LnNWKrYSaHEoUtpSQ@mail.gmail.com>
Subject: Re: [PATCH] fetch.c: defer fetch.followRemoteHEAD validation
To: m@lfurio.us
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:50=E2=80=AFAM Matt Hunter <m@lfurio.us> wrote:
>
> On Wed Sep 23, 2026 at 1:03 AM EDT, Colin Hinton wrote:
> >> > @@ -1962,6 +1953,14 @@ static int do_fetch(struct transport *transpo=
rt,
> >> >               if (transport->remote->fetch.nr) {
> >> >                       refspec_ref_prefixes(&transport->remote->fetch=
,
> >> >                                            &transport_ls_refs_option=
s.ref_prefixes);
> >> > +
> >> > +                     if (transport->remote->follow_remote_head)
> >> > +                             follow_remote_head =3D transport->remo=
te->follow_remote_head;
> >>
> >> The code assumes that remote.*.followRemoteHEAD has been pre-parsed.
> >> Doesn't the code to do so in remote.c::handle_config() share exactly
> >> the same problem as you are fixing here?
> >>
> > I agree that the same problem that is being addressed here is present
> > in remote.c as well. The only difference being, that there is no
> > return call in the followremotehead block in remote.c,
>
> I'm not exactly sure why the config parsing in remote.c doesn't end with
> a fallback 'return git_default_config(...)', though the followremotehead
> case piggybacking the common 'return 0' at the end should be no problem.
>
> > and it at most only throws a warning if no valid value is present.
>
> which _was_ the case for fetch.followRemoteHEAD as well.  So, we should
> keep the two in sync right?
>
To respond to both of your emails, I agree that the two should be kept in s=
ync,
as Junio pointed out, a valueless followremotehead will currently
result in a die,
yet I agree with your point from your [1] that it would be more
sensible to warn,
and treat a valueless or bogus followremotehead as FOLLOW_REMOTE_NEVER.
For this patch, I will keep the behavior similar, but for a follow-on patch
and with some approval I agree with this change.

> > I think this
> > should be addressed, but I am uncertain if this is within the scope of
> > this issue and should be resolved now, or if this requires its own
> > investigation and should be resolved in a future patch. Regardless I
> > am eager to work on it, but would like some guidance as to what is
> > most appropriate for a change in remote.c.
>
> I spent some time drafting up what changes to remote.c could look like,
> based on your work so far.  This follow-up patch also has extra changes
> to builtin/fetch.c to accommodate the same allowed functionality as
> before.  There are two awkward bits to this patch as-is, though:
>
> builtin/remote.c::set_head()
>
> 012bc566bad7 (remote set-head: set followRemoteHEAD to "warn" if "always"=
)
> added this behavior to overrule a remote's "always" setting if the user
> ever modified their HEAD manually.  So, this file needs to know about the
> followRemoteHEAD values, but parsing into the enums is currently confined
> to fetch.c.  This just adds another bit of string parsing.
>
> builtin/fetch.c::get_follow_remote_head()
>
> is updated to serve double-duty for both the fetch and remote configs,
> and needs a better warning message if a bad value is detected.  Perhaps
> add another parameter to the function?
>
> With this patch below, it's arguable whether the enum definition for the
> followRemoteHEAD values now better fits in fetch.c instead of remote.h.
>
Thank you very much for this. I think this is a great starting point
for a follow up patch.

-Colin Hinton
