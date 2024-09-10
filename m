Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F21A38EF
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985962; cv=none; b=gvFeQF+2mQmfhuWsmXudczbgKt+rXV2rSnxoYwzqYlOy4gTYHVcF4kl7dQylmAr1gVzzcqA1vXH9g9ZxCCymBE3G/0VADTLWzz+HalAFaQDn8ykqwG5QFq8auIH7vgyTBUOfYfdZe0W5LTpGpmVikBo71qvnh6t5UkpKQlSXMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985962; c=relaxed/simple;
	bh=+gAvbMaa04mv7eGNPZljo4Eh1JXWZMuuSKDiXQ09oDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXyAn9NXV7x/MMhFgQFAsEo+5mL80gUrA+dFoyIhhjv9ph5IDXIetUFJF8lE9lqMW3vDDxgih/aYXdn7Z/QGoYF1PVtYKhL0u+OvT6wein2A4TXHIN+xIXdP8aHY7ZKXwx67SLCYQZlbdE+QYnn6aZ4uFoxxbbUCTa5PNOvZwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUl+HUKA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUl+HUKA"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d60e23b33so300087466b.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985959; x=1726590759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lo1UfklO+FC8MO8oG4SArqzaBo9RUqeKYV7o/WZMyvE=;
        b=mUl+HUKAfsRnqJdW+QYV/imYemkRlpaNOsqmfMSsqN/Zia8o3lnUCZJvbtXURXN3db
         4K0MmpVwNk1zUD7wyslZsxdXp6cJtaIUCCCECz9MZ2cW/Zj4FhcyzQvuz7oTgxnd9BrI
         YamYcTEVZONjzumOFY7n4NbO6k7RSrTh9/uH/DMJXvEVpHZ6Shd+gy1S8bioX8+nR8Ja
         jKJEmCdPD4L2Y4BQbKoCXGYYPsorbzdC30V2KqO9/fWPr7DMfo86WMModz4c6qeOMM1J
         dWn/7xJRvBN1x+Xb1BTG7RGU1RSCf+PMlXNdYnekTRidKYAqxdwZopYGme5Usd6VDs4i
         +sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985959; x=1726590759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lo1UfklO+FC8MO8oG4SArqzaBo9RUqeKYV7o/WZMyvE=;
        b=APPKava15lCDMBIXMJSh+wCVYTocXNHd/39deRpmXtr2cpb2lQ2g6zlIwHNIxQ+412
         Zr2QgzuCR7NO97Nm9i3qN6I0Yxap4j8f1dj2ZrAfkKspPBx/y5E+dQfLCnFyJUgPJyIh
         Ggn/mG2Z2w+PGVAQkARnvd1dXUslt+76M1xhdSMvYJjbghcD67SZYyhvbDTcZ1wCYJuR
         haOhr9UdxL6Pzk4bq6DssEs4VeMOUVNP2iduah28pvhQwtaRiHeRPDrpfeHcLuRXX2nE
         Ugos/CgG1l7Q2oMVThqmlrRALiLg7LlNtPaQOwp6XbfYO8hXa8WKhdilNzsw3zqTu7A0
         EM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGeJnBW0YTNVVtzbkhgoBVln2quqbeymXv5NDWJTHTXT4prlySc2Ju4b6IWfLK/6+cMsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hPGecinQuyoUtuLAV/D2KKBFsu3FFRv5eHI3B5994zPRfawg
	p9CyZ4CVwtTUX4Q+BFmXhTdTOinRXOcWRDGScAGCmxkeBwDtr97mbcVjJYu0WMIDKTv6adgyL3F
	zSZ0Q4N4ABGQaraP+R4LJiK5apxg=
X-Google-Smtp-Source: AGHT+IE1HW65viWeyyLFgXY06eE/v0KfjwqWdMDzTXcxQr4H0CK7AC0cefBbvVBAsyn6//WzCCln7k3OukFa6ALywQk=
X-Received: by 2002:a17:907:1c09:b0:a8d:caa:7ffb with SMTP id
 a640c23a62f3a-a8ffab8286dmr138050666b.29.1725985958329; Tue, 10 Sep 2024
 09:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com> <Zqpa8/aLpgtzoBH2@nand.local>
 <CAP8UFD04M2m0_Y5uVpau2BTsJWLq85fvBCVz2VYEcx902dXWBA@mail.gmail.com> <xmqqzfp786xe.fsf@gitster.g>
In-Reply-To: <xmqqzfp786xe.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Sep 2024 18:32:26 +0200
Message-ID: <CAP8UFD3T+-ZeyQXGmFU7=qgHoGXCjihNqGW6hD3ic2rAyCHNNA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 7:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > I agree that it's more useful the other way though. That is for a
> > server to know that the client has the capability but might not want
> > to use it.
> >
> > For example, when C clones without using X directly, it can be a
> > burden for S to have to fetch large objects from X (as it would use
> > precious disk space on S, and unnecessarily duplicate large objects).
> > So S might want to say "please use a newer or different client that
> > has the 'promisor-remote' capability" if it knows that the client
> > doesn't have this capability. If S knows that C has the capability but
> > didn't configure it or doesn't want to use it, it could instead say
> > something like "please consider activating the 'promisor-remote'
> > capability by doing this and that to avoid burdening this server and
> > get a faster clone".
> >
> > Note that the client might not be 'git'. It might be a "compatible"
> > implementation (libgit2, gix, JGit, etc), so using the version passed
> > in the "agent" protocol capability is not a good way to detect if the
> > client has the capability or not.
>
> It is none of S's business to even know about C's "true" capability,
> if C does not want to use it with S.  I do not quite find the above
> a credible justification.

Ok, as you and others have said that the "promisor-remote" capability
should not be advertised by the server or the client if they aren't
actually using it, then I have changed the implementation in the
version 2 of the patch series according to that.

I still think that this change might make it harder than necessary
(for example for support teams at GitHub and GitLab) to help users and
debug issues related to this.

The only downside I saw with always advertising the "promisor-remote"
capability even when not using it, was that it added a bit of bloat in
the protocol, but there are a number of things that could be done to
avoid that. For example changing the name of the capability to just
"promisor" or even "pr" instead of "promisor-remote" could reduce the
size of the overhead.

Thanks for the review.
