Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5542AA4
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041960; cv=none; b=TlyCPMvF3c6kFr9m6TVDP6uZUvZL0hARx10/P05wox2PSGxpjHm93c/tEIt/Bioo3y2uWj1oE/hgVP0SbnedqmoQgr3Xt8KGL3ReTdw5PPY7zfJ5xfx1LUt94X/AokCoPI01SEtrMnXmVi9B+IVnbSKa/XEOH2TGc+m6CThyMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041960; c=relaxed/simple;
	bh=lxYbFgr78jA7u2rVjofHGm97Olu4SSYSfLOuJb4JVHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=je7dwnG0UvDSz+dT/xQeAYFW/50inDSCKBPWSVeZ097TDSbbglKMtPGC0SjFw2FKnR0DcXYQCIIkj8P/+2QKwUcXK0Mvtikyo/sWzVh228uf29ZyB4gmrYFJ5JHmTVyvys6CF5PGmyVlOWGl6XEQRk1Oq+3kt6Z25krC1o00Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK3XXFGV; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK3XXFGV"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50d4797098dso1157768e0c.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 18:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729041958; x=1729646758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAsrIHelVUcr/D3PZbBHd/+01tMKgEVGb+xrkT9beuU=;
        b=hK3XXFGVXmo49ZgWSLx+Jpq6cDp4xnBekn+YIear4UVY6DL+1hQWxnTR3s+YFvPqC6
         16L5qlXvQyjcn0BwRZdRptNWySFJusJfUBYXJehiFQDHtcVoZ0xjhYZUn5iZOKYDOcJu
         uuGEpf0B1z6V1ZezXS8/yaIPTT9rPPUq71ZiorKTEyp2/AATwbTtxRn1sndd3ZMdjEIQ
         V6mC5tJtZw/++QX9VglH0J5dz6QZykuBOwW5FikStHcWYBDqQQzTO6ST/RT1VcqDfJ/b
         0f4dpTF42Nrw0uZMleDIKz5K2vdxQrS7eXbVVauiMTUnv4eubUsfV0mpGMqxeltnpb67
         qehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729041958; x=1729646758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAsrIHelVUcr/D3PZbBHd/+01tMKgEVGb+xrkT9beuU=;
        b=ZZ+9wugM9+Kj8MJdoMSjmadcxJGQCkJvMLVihbBnr0r/uL7AP1y+erDzhALX+jmD2C
         Z/2nyDr0ouJNU3ynxz4dJyrDbY/acXiCjpPalpjzejfp70XBwIPdm1FB9KxQFpTkgCuk
         FXukJolD8wzH9oyaXzhCrWNYfxj3/wlEwp1Fc1wbPkogVEjS7wzvIDWonqQ4beZlIX6e
         8D3NM8S/kgPYzz0/2kaaQyuP2KUYqhyYf4vymEVlXrxYAeqF/SxMSIIB3ttdJzNnfORV
         SfIOgxhiPbSTeF0AacN4s85bB2Gbnmsp1yPZUrb+QRDFYCOTXsGCbtX5oAo68EMYmGTz
         e/+w==
X-Gm-Message-State: AOJu0YxHnhOisaqy76ciZxKe5EZLQFU1MBp8TT/3Bzo3OFltJPZ6mOxD
	0CaevMbouqHX/Yu4bzgjXxyDy+C/+0G/xabcOxIwEz4SBDnSGRALDiXYACsJ43SoRUJJuEyV5K8
	TVhKbQvmoc+EUGxtrVTscxEZGfHo=
X-Google-Smtp-Source: AGHT+IE1yvcvNvfl2K1D3g1AFfWN2czppMAOaG4J2+QhB07gGCP2UerkS/eStyrAAjSy+9fy6gYG8uPgzHX3CRHfMgI=
X-Received: by 2002:a05:6122:ca0:b0:50c:4efb:835a with SMTP id
 71dfb90a1353d-50d8d1cc926mr2442821e0c.1.1729041957774; Tue, 15 Oct 2024
 18:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>
 <ZwqcHDzaR2U2JNu0@nand.local> <CAPSxiM_U5ffBCsTrbBqsJK0jUZtAuWSLook8CLKat46CX0QC7g@mail.gmail.com>
 <Zw26bU17+2SRfv8L@nand.local> <CAPSxiM9jHn-RQ3FXJRQNKAE9xPr_4yJbWB--oWgQeKhEMLmE4Q@mail.gmail.com>
 <CAPSxiM_qw0akVoG5cJRgwk6oP1q519zBp2m6GmFYGmrrc3jXfg@mail.gmail.com> <CAPSxiM-voyrHf0M2ELD6OmJr_ECQMd=+si0wd6_boy7VJCQzyw@mail.gmail.com>
In-Reply-To: <CAPSxiM-voyrHf0M2ELD6OmJr_ECQMd=+si0wd6_boy7VJCQzyw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 16 Oct 2024 01:25:46 +0000
Message-ID: <CAPSxiM-Cn8ZSC+LzRfeyY+Z_Vfj=DguweQ+ZjC4dau-Z64dnWg@mail.gmail.com>
Subject: Re: [RFC Outreachy] Leftoverbits, which involve replacing atoi with
 strtol or strtol_i or equivalent.
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	phillip.wood123@gmail.com, Christian Couder <christian.couder@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:04=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Tue, Oct 15, 2024 at 3:54=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 3:49=E2=80=AFAM Usman Akinyemi
> > <usmanakinyemi202@gmail.com> wrote:
> > >
> > > On Tue, Oct 15, 2024 at 12:42=E2=80=AFAM Taylor Blau <me@ttaylorr.com=
> wrote:
> > > >
> > > > On Sun, Oct 13, 2024 at 03:46:05AM +0000, Usman Akinyemi wrote:
> > > > > On Sat, Oct 12, 2024 at 3:56=E2=80=AFPM Taylor Blau <me@ttaylorr.=
com> wrote:
> > > > > >
> > > > > > Hi Usman,
> > > > > >
> > > > > > On Sat, Oct 12, 2024 at 11:21:13AM +0000, Usman Akinyemi wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > I was looking at some #leftoverbits which I can work on and I=
 came
> > > > > > > across this conversation.
> > > > > > > https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZj=
s+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> > > > > > >
> > > > > > > I followed the conversation and came accross
> > > > > > > three instances where I think atoi can be
> > > > > > > converted to strtol or strtol_i or parse_timestamp().
> > > > > > > These are the three files which I think the atoi can be
> > > > > > > replaced with.
> > > > > >
> > > > > > This seems like a good #leftoverbits to use as an Outreachy
> > > > > > contribution. From a brief skim, it looks like this is going in=
 the
> > > > > > right direction.
> > > > > >
> > > > > > But to get help from the rest of the list, please submit this c=
hange as
> > > > > > a patch or patch series, following the instructions in:
> > > > > >
> > > > > >   - Documentation/MyFirstContribution.txt, and
> > > > > >   - Documentation/SubmittingPatches
> > > > > >
> > > > > Thanks Taylor, I already went through these as I already sent my =
first
> > > > > patch before.  Also, I already sent a patch as you suggested. Tha=
nk
> > > > > you very much.
> > > > > Usman Akinyemi.
> > > >
> > > > I must be missing something... I don't see any patches from you tha=
t
> > > > touch e.g., merge-ll.c, which is the first file you mention in this
> > > > thread.
> > > >
> > > > Try searching the list archive for:
> > > >
> > > >   f:'Usman Akinyemi' dfn:merge-ll.c
> > > >
> > > > Is this different from the other patches you have sent to the list?=
 My
> > > > apologies if I am missing something here.
> > > >
> > > > Thanks,
> > > > Taylor
> > > Hi, Taylor
> > >
> > > Thanks for the reply. There is a little confusion going on.
> > >
> > > This is what happened. I had two patches which are entirely different
> > > from this leftoverbit. Both has been reviewed by other maintainer and
> > > integrated into seen by Junio through
> > > https://github.com/git/git/commit/4dae47e02757333b7d6a6508e36ccb5463b=
6ad92
> > >  and https://github.com/git/git/commit/dfdc6a71e76c7a1dab22fc9d9e437c=
858cfea6dc.
> > > I submitted this leftoverbit patch but I made the mistake of basing i=
t
> > > on top of the previous branch which I use for the two above commits.
> > > This is the commit which has the leftoverbit and the previous two
> > > commits which have already been integrated into seen.
> > > https://public-inbox.org/git/pull.1810.git.git.1728774574.gitgitgadge=
t@gmail.com/T/#t
> > > That is the reason why you saw it again. Also, I noticed you also
> > > integrated the two patches again into seen and gave some comments. I
> > > think that might not be needed again. Thank you.
> > I meant for those particular two patches, since it is integrated into
> > seen already,
> > I can probably wait for it to be merged then work on the review which
> > you gave or what do you think should be done ?
> > Thank you.
> Hi Taylor,
>
> I went through your comment for the two previous patches, some of them
> have already been addressed in the original thread
> https://public-inbox.org/git/CAPSxiM8cpX9NYB02fAPA7WbLsLrvmFfsE2=3DVN=3DN=
cguif7mQN9Q@mail.gmail.com/.
> I am really sorry for confusing you.
> Thank you.
Hi Taylor,

I am bringing your attention to this. Thank you.
