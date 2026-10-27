Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793129658;
	b=CoxvrIXDNI9CbKz3Zx8Bwb8wK2cu1E2i77GOTLG9CW9meo62y8e4FC+7NdjWjFlJyUqb
	 VP97SErcOV3F1QtnADVTyBxgIOX9PLaZsXw6G9k74Wi7FuDEPhGBpzAy/FkLhJ7xNKBGN
	 7cp8cZwPVUANnD7FYl6L6gil45quTwFaDn/ZTfJ0iLBDVTFyKA+zVqHQa4vfZnQUPW2an
	 1hs4aBsTC7jTPzfBM8AuUyhZ85yAdeYndMotgyrnxdtWmOLgPcNQUk/LB97cPj2f/0aMf
	 0MWG+0GMd5emN5JSnQCbdEI9taDD6KBH1rnP5PeCgKGnpfOpivTwmFTrB2spJUxUKAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BgSiKpB/PAtSFPE9zgLpqQIQbF/eJePsJ6KN+s4ir/c=;
	b=x0mTlDEKr4TiwGdtiMWWxQUPZxer0D7mUtYwcRsWk3znj77HeMW4aVeHjHjPRRBVAB6e
	 5pcef0jtK0rdzQUfr7aPMHQaBvW7hsoNXSnIyuVeeWAzIwF3GUTxZrn9KRpEYcCVpfQLi
	 /108/M5Q3GXm6m2BkVTiXTEpjYrvOBWxi6cTeh+C5BlwmEekp5SYs2V8ZnUACLjmTojEV
	 311WmdT/D29DIJhZHKoH6QAlKea94PZ5AdtFXWnScfuTmczNRDIn2gk/SA6mj1eU1EPmS
	 f/ytDIHCEh+OzsFfsvN7SBgfAKUr0FSL/wNA6VmwYuASHFCH5ykB8GTMuJaPu+3xorQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVLKfKwZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CA606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC2CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVLKfKwZ
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b486e1d02eso380410a12.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793129656; cv=none;
        d=google.com; s=arc-20260327;
        b=Na7EbqEfscySA0t3GdA3vmXMySsuZzUA8feUy8+lvOjxKLIod8JchEE6vKVrFaUkHX
         NLaAI/DbuYs9C2teGArlu/HdswmMueaF7J7NWKZI8UyxvZxyT9i9lJ8pNxlECPIAwQfd
         MNZvmxFnsNYL8UCzzxtFajBnyjWqWJ5zK/+E+dWyA+jkL3qbQaVYI+Us2/KQc48W5vSB
         7BzyrHbL+DtumEO5Gr0Y7GAOleR8aAiweN7H7RQyN5krgu0r6XXxTVQXmVrkolL8LeCB
         dgWAylFEDnU7/y47nSf8c4kr8qs96GhTP0MCRZxp12W+POBe4U10x/+MDGkkDuPnpE1U
         Exsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BgSiKpB/PAtSFPE9zgLpqQIQbF/eJePsJ6KN+s4ir/c=;
        fh=iN+dY1Swkgw1C7FGgTfcScC4v0mo1oQTzWRTh5TJU0Y=;
        b=nbQ7ON4Z2pe7yGSfZ0TpNS84U6EMzbTaQhFeSFy6t+VAMpA16+YflR1rGg/UGtpUnf
         ohI9EUjKucp8nfbJ0Pr0xe6oQTGUQ57/P+LgSMeKIzaCm4++dqByjsmbtCGNO0BRiVFm
         N+unHE1VHo7DRtnd/dTujWBFY9bJHFi4C4WdaCP3s4QX0hS7X/N7XGeHJf9INfwzZFbf
         7YX7pOesr5N0b9g/xVviQKzs+1hMoqmYAdAnhkAXARy7QTTBplA1Gj+WzwMj7AHC+67U
         +Kw/14azm4pEteS/mrIEQnJOPrn23OXhg9x9/i/27nKz7f2D59luR+JJ3dA87ErUJyCV
         EP0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793129656; x=1793734456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BgSiKpB/PAtSFPE9zgLpqQIQbF/eJePsJ6KN+s4ir/c=;
        b=IVLKfKwZnHabN1UvimXz8O2G4RiVvTHhnk0CkEH4lpnqRwtw254qkyuKzXdgDFMa3F
         b+TPiW0Izq3AiieWe7FL4vbta/ZBE2FSH3GZfFAarYxcHFgZjIKMT//8YpGP9+qz1SZK
         JmyupETJFdyWE/S/uioBQ2K3tt0kgjY0ZmxwFSV3ZKP2m6O9hUYcxrlEQH7ygn80p7Rp
         of8IlGIH/OWBgwRojW6sPuUP3SGZdt1VrFE6cjbAiqki0QbgWWysjVRnUNjvE0E7zw2a
         qvLU6woEePswziZrmeLx+elXFY8zZcG36MYJ2ppuA8lMXfWRLbPgjLnvJiUdQ7nnSMJh
         7XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129656; x=1793734456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BgSiKpB/PAtSFPE9zgLpqQIQbF/eJePsJ6KN+s4ir/c=;
        b=2MCQys2g2+fGwvYvDRuJ6Vbq100AnZKO7x9CqI1Bb/w/NF41yTNm0DLBC9iVsZv+Gv
         NimT0xelvnCDUou+zH30+WCyVahYtDuqMifSm4hNuo6uxzPSSapSX6iPnLwZ8XtnUVTH
         NSGsffIQi5c+EaSy7zCzwUpQf3Gr7AIMwBFRRSZ1rB581sQReYpgNussB2GQTTjLWNFw
         SdK94AQh646s+P8pE/D2bFHAXBR82hnDfLlbRdFxotVyPjEAJkFwVr3tRwKBgvsRNdi3
         fgPlMKGVbQg8IM4RDgM1bxyQsU0CQLmOgEHtfUa+NDkIKtI0zAlsB0F5X5NmgZkxC2Qg
         ReZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuRY17XW4lGuKBLJhAZza+s8W49uMXidHIOAWOasCmFieOAoeTYXM1J9DmTljmAKAw3nA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ4228Wimb5O9zBffEDKdoqwQcFkJTDZI333iHrtKqYKmlhqxt
	ydbUz3CCWXmTXtKFnepXr8ID/fw5TXmnRn+cCcECmPhvbXi5P2skCBAP2+AH+oQ0Y+eecUipvL6
	26rU8xsHt3cVxpz06JzxWq5IK5Vj6tm0=
X-Gm-Gg: AYBFou1gRC8sl+W6FwsTY0ny4gzkKI/9HrSKa8atSAVI7CKXlLEV/kvuhBmOEOz1s3A
	WaXbEloYBRUe/jWlAWHuJXSzq8ZrlLtkKV3vZVEY0f59aABepD1YjzpFIJXO8dhYwvNhZq39x9Y
	qYgES51WcbpSgJ/6hTjHAild2p8m6/DUrp+TZomP11tSbaISCYzfC0YJn5cASHKROuJkGJFYXk8
	sVaHJrCoY6RLlZ3PJrVmy+5QY2aW/xL2n610hROCCCo8pjzOGrB3kc8n2lPV/TrJtJLUVYZ6lz1
	UiPzo5aE0e8MtXttov+1MeTdlpCz8fDYT0215V+IBDuSIu5wa4FZWRKGg6VCED+fZRqNkfmVpEr
	KrEAWfFjLUXcUyQBxA3wzcUM/1r+FaRs+smWR/Uawuhz2CBpajTD4sHuIUoTpG1Eb+hynE44=
X-Received: by 2002:aa7:d286:0:b0:6b3:8018:7643 with SMTP id
 4fb4d7f45d1cf-6b44300a8d3mr7987910a12.45.1793129656123; Tue, 27 Oct 2026
 12:34:16 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqq1p9cv6tp.fsf@gitster.g> <C1614059-9903-4F95-8570-90EC5DEFAE8F@gmail.com>
In-Reply-To: <C1614059-9903-4F95-8570-90EC5DEFAE8F@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 27 Oct 2026 21:33:39 +0200
X-Gm-Features: AclHuK8suJCUnyMrLSJotvLGjLvblEzrZXAAWa3hatOQVUKzv5F03HVYYJMN9M4
Message-ID: <CAHwyqnW=bKY2SHMgMNav0gK+dOA4gUv5rm-=CvOeVZYTHCN4JA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:40=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
> > Le 26 oct. 2026 =C3=A0 11:07, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
> >
> > =EF=BB=BFHarald Nordgren <haraldnordgren@gmail.com> writes:
> >
> >>> It would certainly be nice to avoid creating lots of entries in the
> >>> branch reflog when cherry-picking. I'm not sure what users would make=
 of
> >>> us switching to a detached HEAD as some people seem to find it
> >>> confusing; if we do decide to do that we should make sure we update "=
git
> >>> status" to explain what's happening. I'm more relaxed about changing
> >>> "git am", but like you I normally detach HEAD first so maybe I'm not =
the
> >>> best person to ask about that.
> >> I think that the fact that all of us have our tricks to work around
> >> things is indicative of a real problem.
> >> We should attack the root cause and simplify git so that even us would
> >> prefer vanilla git.
> >
> > I do use and prefer vanilla Git as it was designed to work, though.
>
> But you also workaround limitations in am by detaching ;)
> which I think was Harald=E2=80=99s bigger point: let=E2=80=99s eliminate =
the need for such.

Yes, on the bigger picture.

The specific example I had in mind was using 'git reflog @{0}', which
I never knew about and will use from now on. I'm looking into maybe
making this the default as well.


Harald
