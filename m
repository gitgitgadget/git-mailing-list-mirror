Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFD26B098
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689808; cv=pass; b=rD5x5FzEoHEGORchZ6703qs1xly7hJ69z8gSeuhkUlLQ0tJv69HU8CI4czymqUdQNayc3D7f5sE/ogxJC1tCJXvtv5WNlwsBdjrNGfpRN2HirRfhGRTXZRToIw6+AWnjVn7FrUI5RWg3TXUHbm+P6lTOYXf2IRGz9gsXsbApiso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689808; c=relaxed/simple;
	bh=adHm8FzRGN4AG7Oyc2rXglwMOckzyYXrd3UryX1W+YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWnyOL9wnl/phnkPHa4lld45EzzzsEarIaQLrctLGCgwWzt0Hjo4rf2VqBfTS2hdRZ669N0SwZJsbI3jHk51vsgTnZ3Kj8KkKLGlzLOoyDIurrdhb0QrN2div+N5r98gXmhlebDdp7dCubcq43L8TKXzxn3Ceh7XSrb+JJ1GQo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RStM3Cw7; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RStM3Cw7"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d1890f7cefso350849a34.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 18:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770689806; cv=none;
        d=google.com; s=arc-20240605;
        b=kWe36iRtjnoTPBgl05g+eQ1TTLpQpg/3o6k8RoCnvqLz7PkHAwro0rKua+2Ow3JkyS
         si2DVMvDS023BkrmR7gZyYlSqzS22iuiFby5Qxbb5bxzHAHGDKUPRj3J9kZtmhjDBx+t
         DhbIaCohLnOOUbFvSUHJS4rGLmcsR2VFprGNAy6DeOrYLqd25ts76PmGsdYxThvy1MKA
         cycajGvDi19FUIKvoOQKlOHGZiWNiyQJALBmajZZK/ctzTRuJPt8eu83LQQDp1wN2qmV
         v516ZRoUjXYUGLMwLJ2N8EDCv0/ZFMe8pBTX38reMDLfShQOhlLG8qvhbBokq4UzZMEb
         FEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2nAmf1BoVniktVLAzK2xAHySfqn0P2ml7lqWwJPueSM=;
        fh=UwmjjBZ6l190jMh4P74qqfZJ6u6ysea2/x/34KB1n9M=;
        b=jVgOeNioA3Pdi5U1gYG2gLFWcSHMBzRqFu0w6SU3Id8UNZ6kVrbuHCCxyFokbPwMoT
         /kb1vKRpt5GmWAJz3QWuqFi9n0mQ1CR65D+BDGBa5L40fq0F2xoso7sHQ9U7Tx4eUN1j
         zodo/mNe6qIUfPH/76ddEX6EmbOMeI0tBhQe3Ockq03/aB2iZVMcayvOFys1vx7QIiMr
         rkGHRAXYo4IF1QAxF8eG0A41841jabtUPETMLu3VxdBrYLGLyilVBQvDVuo5XPRO4MuF
         Dz/un/uLaTrh8K169z4ymK6DQL2oLOLgREtH1XKnbiUc85KKZYyCgO0wJk/1b6uXphno
         vC8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689806; x=1771294606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nAmf1BoVniktVLAzK2xAHySfqn0P2ml7lqWwJPueSM=;
        b=RStM3Cw7HQdLOYCPcCdxNcTCmQoCpeP6GYTg9YRMYjohk645AkLD77mOqxDwZd4cZ9
         JlaG0956AiMFe/qqUz4Q2eq+brtVJQgeujzTspMDmsRKk4rGxqBH18akJfAu6RteLw0A
         xaI0eV4JloXR2EbQHTPJLTY6cILYXWqJwGSz0+wB3WQ7dR8b15pGABApAmfySRV5aG96
         ymkj4W+PcMOHR5G4H5qrx4XZdJW8RIsW5Tr2hrroZrKsUTNZ6fRl+wJW94Y1oCab7lSb
         MsE/UmhN470YhwFuZUDR3w8q6T1J/eH8SpwcuJKtmG6SgtuFwDUppy/jU5eOriglfifq
         CrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689806; x=1771294606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2nAmf1BoVniktVLAzK2xAHySfqn0P2ml7lqWwJPueSM=;
        b=AM7+8CpPXLDayz2vsy+Rm5cwg3HWFKSjDe4rlmFVrvoh3j43s8FVnl5GnQqlyqHNwV
         eY1CPXjxrLHhGr8DApDDXghCS0NaAOhw7wHbMUbmPfux+PsCJ4VfUfFeydL21g2p25wh
         gFbPyTI6OsZCcTqSgFVC9YCeAqhDfPWQHFocVN9EVyX55VTr8N/PnGwpErMsxn4DR+Ix
         +DdwqngPSjHqPHK3WQmNDWX5R1ZKcDT5NlHt17JasdG7bAtH2Wqtm0tv3HyJCabe6Y6X
         xvnCFknA93pncn6lt/Sxu19b+msD3YssC7YP3BnnT7aC2tXqUuJ92pCQNN/sIfQ4M71F
         1sxg==
X-Forwarded-Encrypted: i=1; AJvYcCVm9OaDW+GivMSfSe9HFeErmome6v3FELmraD0fJR2i2Vr/pT8ChcJS9t+z5Y5hLb/fK54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/WQOp7Fh097kSzbmsLhkk5AITLH8arUV+lCN52ctP8lu2YNl
	Ff3sgEW4uc0+LFotAYFLPKU5nh5VLArAdUFUCgRjwB5sA5kVwVah+jdHptwZU0F1ih1DlaLH3OT
	OIxqmS9bOt7q0jn5WX8e5/JsTuVmocjlgcd/x
X-Gm-Gg: AZuq6aIhOnShV6RcgrHsiKHA/voeNvieoIBBojqpmg3QADRTbfyVehsUTjhZgXuhATy
	urPAnc+KnMxX68fDED6nK5pbLUhvve58/mv5q2/EopdoHYbepMfpzvHNaUUSPPw58ZgxzkHzTDE
	m6PmccFoG2T8EQRmjtUdIJY5F0ccefPAjmSYDbC8NdxoB/9Vl8CqgilBS8pYxhJwQqIVTkaeCE+
	A6Vz4lw3+fHjWGOxxiBI+k6tqzqOB/MFzWjDRFpwoTxnsh0+RlDWx7QC37oyorxGx9HfcZ4Qqo6
	+n6Sjw==
X-Received: by 2002:a05:6820:4ded:b0:672:afe2:4b7f with SMTP id
 006d021491bc7-672aff19c72mr669768eaf.47.1770689805781; Mon, 09 Feb 2026
 18:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
 <20260206090358.GA2761602@coredump.intra.peff.net> <aYoEO0CcVt2Qjgnb@pks.im>
In-Reply-To: <aYoEO0CcVt2Qjgnb@pks.im>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Mon, 9 Feb 2026 18:16:35 -0800
X-Gm-Features: AZwV_Qh67ft4dGxmF9BrzcbSUkdTIroRYbBY8u7b5MiVGP0PyfMCYQtV7i_nbqM
Message-ID: <CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>
Subject: Re: git-am applies commit message diffs
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, Matthias Beyer <mail@beyermatthias.de>, git@vger.kernel.org, 
	pyokagan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 7:59=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Fri, Feb 06, 2026 at 04:03:58AM -0500, Jeff King wrote:
> > On Fri, Feb 06, 2026 at 09:18:50AM +0100, Matthias Beyer wrote:
> >
> > > That said, I am no expert in either C or the git codebase at all, but
> > > from what I saw from reading the git-am codebase, it looks like it tr=
ies
> > > to find the patch by looking for three dashes on a line with a linebr=
eak
> > > behind ("---\n").
> >
> > Yes, that is how the split is made.
> >
> > > From what I read, it looks for that from the first line.
> > > What I would think of here is looking for that "patchbreak" from the
> > > _end_ of the email rather than from the top, that would have prevente=
d
> > > this issue, right?
> >
> > The patch itself may legitimately contain "---" on a line by itself (it
> > would indicate that the line "--" was removed from a file). That would
> > confuse your parser, including in a way that we end up only applying
> > part of the diff (everything before that fake "---" becomes commit
> > message, and everything after becomes cover-letter material up to the
> > next "diff" line).
> >
> > I suspect it also creates corner cases with cover-letter material
> > (between the "---" and the diff itself) that itself contains any "---"
> > marker.
> >
> > I don't think there is a way to unambiguously parse the single-stream
> > output that format-patch produces. This is a reasonably well-known
> > gotcha (at least around here). E.g., some earlier discussions:
> >
> >   2024: https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c=
9eb19.camel@scientia.org/
> >   2022: https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0=
708e8.1662333027.git.matheus.bernardino@usp.br/
> >   2015: https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=3DFGpHQT=
kjE-guhwkya0DRVA6g@mail.gmail.com/
> >
> > There are probably more, but it's actually a tricky thing to search for
> > in the archive, so I stopped digging. ;)
>
> Maybe we can't parse it unambiguously. But what we _can_ detect is that
> a patch is ambiguous in the first place, right? So maybe we could extend
> git-am(1) to bail by default with a hint that tells the user that:
>

I think it might make sense in a breaking change to update format
patch and git am to have an "unambiguous" mode which would allow
somehow to unambiguously distinguish between commit message contents
and patch data. I'm not 100% sure how to do this, and it likely
requires some sort of breaking changes to both tools to allow
distinguishing properly between the two points. Obviously if you're
sending the contents together, a malicious user could edit the
formatted patch to move or copy whatever the "signifier" for patch vs
commit separator is... but at least we'd prevent the cases where
someone accidentally includes diffs without intending to.

>   - They ought to double-check the patch.
>
>   - They can override the check with "--accept-ambiguous-patch".
>
> It at least notifies the user that something potentially-fishy is going
> on, even though it still shifts the burden onto the person that applies
> the patch. But I guess that cannot ever be avoided anyway, at least in
> the general case.
>
> Patrick

These steps also make sense... check the commit content for a diff and
if we see one, make sure to warn and not allow it by default?

I'm unsure how the receiver end could detect the patch actually is
unambiguous since multiple different diff hunks can exist to handle
each file. We could improve the parser to complain about the extra ---
separators though?
