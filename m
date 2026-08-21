Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CE381EAA
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336524; cv=pass; b=tSifsoDthH1jUGBDLbMLRCbYpPVvQTD2uYIqxEcweg84kmOzsRYuYUHJGWJLHb3QNHGppGIqOC1pDaFCzZCSW0wpkQhsbKdnWRp3yaJRP+yoDmk/OZwc2kLhe+2S1br9X4WfGTugL5JieicPcJmKXeHV+9+KpGQNqF0YmIUXVOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336524; c=relaxed/simple;
	bh=xlJ2fHNfmw79ccy7WcEzYh7fJ34NrjTOdC8H4J9iDsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9rUZ7sRGROIFbpqfZQx8m63I3jQZGSd7Mf/hkdLRPkgjzLZNUic0aUrv4tWMlYib9VGn1jx8dRjJ/MBvnBoZ0DwC5dTcpCaWwHRk1QhEbgW4dEDVZvALApwpIX/DLOJrPqfIptx2UDnDwMSqIhr38EmHAYBUtz/buCQyXUI3tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB2D4Ny0; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB2D4Ny0"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ec1e9d3359so1211013a34.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 11:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787336522; cv=none;
        d=google.com; s=arc-20260327;
        b=Ze0O6QjJEwI2iTDG3sAHDB93H1wdQrSfbfZ46cYETrZhcx6ZJw72t/RWSK2kWOF5ys
         5cYriZqGcfimydH1VXkQK4fyNp4KNaR62xsaPNBB+aWsFoNz1SaBcqLGCBUQTOX9sPFY
         KumepeIHqo1CY53vHEbUgSVDwSp/gZtnjpcdjZ/W1ODLz6pnlku87uGq9xHnqF6yQgDq
         8L5PC0QBPYyf1vYHtAY2Wz5ACgfj9i1LP8eIoFrc4nQgpB1xgY83qK9LTGSlYxO1Pd4t
         4UgkgLetyIrYTF5K+m+yViJqsLu5IPI5bhX3LJ6rYpuNv6uJPGWupfukZRYXqN+wLMsR
         BMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnyPW6+bPegPVWx+DwVRbQLOXCzkc9ZX601f0yTT1sI=;
        fh=KlDBGDtvF2pEA0TVUuv78JBHxCAdm1VngVcbNTSotTg=;
        b=Fiam+LGuVrQVuMsMAzK//tPO9WRCo2seKYLwOd7deXJnNilZiQYgCU8JiIWcYoI881
         ez5jM9A4U9uSSHNyDNChlz4SIL25daFgmJb1bzr8sC8rs52BEFTFXCV7w1tKmxD/kx88
         uCyMT1A2qZj+N41MJ1yuKtu4tJQtcvrGp1HGZcx5k6BUTOq/d508qSHA0SLnX/lMUH35
         JmIxYKZvBxZ+z3HMva0Co8cJrGitkiUqpF+9DLBGv6FVkp55o06NzxVYiE1SnjaV8rWi
         LyL7iXtiAyITpThcPMtUyuPL1Pp419DbFG6RBqVCyHJXH6Bd435aEQNFnkrHujeR+914
         yS7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336522; x=1787941322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YnyPW6+bPegPVWx+DwVRbQLOXCzkc9ZX601f0yTT1sI=;
        b=PB2D4Ny0s/tVC37gE2vKUjoR818lNvnbj8BMkA3ybYuinMmaf3LsSLIuTNASY+WWKP
         POgFedzB48ZzasJh0IR/IIJ4MniH7j4GGdz5QU4GaXzx+AJcPeUlfcn7edWVLm36D7Ou
         XVxReo/NZGm+DRnBUkZC4ZE7L+6qj0IemmBo2vdukRnl2ME0nufSiNUD8DJ++kY4vCq7
         +bBt+guy8vujr8/tQMAcpILz6yMyo67rHx5mwtvgXJF8c4YrcB1cAk0QJHK5Q6UKnjvJ
         AkU42S2Zh/XgFhogd/nGM52OHqKhtxZQ8ecBujhWCT96U7c0zMD7AGCXNCklGPSCX8yT
         u/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336522; x=1787941322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnyPW6+bPegPVWx+DwVRbQLOXCzkc9ZX601f0yTT1sI=;
        b=OWFxQtYijGPRFIhbqmtWu/6hy00FZBjFJoxk1SrLTlh0gNw5PsZrzBU4/OdUxuVxf9
         busCphwB0s6InBZcql/yNOEhLKQ/vJK5kIzXrSlzZ1Y9k1tQ/Wqnbi8sDAvWCpGUGMHC
         Gh7vFESxBn7LwjC8bYqWvN7Tq10XU76AXL3M6KMifp/vcX9KmKNAlN5onQiGRFiOBgzh
         8QO23x/lnNuGDVAH6yRGrQu8Ct23PqRptInLGRqwsTsoWQ8BZPRUOxc8qpzHoLPwJ4gM
         KyTklvJB/L5fXJl37KJtTqZvckwnZE3TVvBkqIFkP3amPruebyTiR6fEyDjpNGQ4JClQ
         M2AQ==
X-Forwarded-Encrypted: i=1; AHgh+RpG1tJPTzDeNUojDbr0nEJP2tONh3v+Q+CqKlnxl4XzDHDHW+z0hNIvAbaUgO97t+EIlzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zbhe35Q3ryHBoukcKjcVLXgMHmc0GqdFkobR3t9yGuZx0ewB
	kNRNQqJRt2iuWfCW15jbNdqrnAuIHpovpok3faxIubW0xkyJn3wsX7m0nVbjrTaWNFSmHN8iarB
	DKKMGbFnjxTg1O1s8jhCeU+ERN129RZ4=
X-Gm-Gg: AR+sD13xXuOGBw/ezY/WFdGUOjEb/4Pvk120mdnotH7Fc8L5X5ZWH7uIX1XX1/vtNzM
	z0ahrxQ7riIPpi4A9zjpOvvTtvOCXBPu/bjbCLx8q6+31WHmHpPCeXRSJcaax/bIpH1/uQ0uQ59
	a4IVXTph+4XoMHuljt8kOOU71fE48/UIaud9w+6DsctbT3IMJZCIABD3PWON36Ku3gU8ITLrpf9
	WLdKfWPL52Gy9DullJy6TdQiRM/R18zQ2nNGB1jCs4efTFjGYYO9Ngg0LJZULhcl0smshJV1dSA
	D4cprz9FBjo1qrAPOONNADgs/yXCfJ0j3LqK6rnAuaT3ecTygYHJvy6Fwi6MnWuJLUzix1DrIya
	0M8ZHzFz85tLhd9zeSH8xbYWFrnK7pLF7Ym3jE0T4E/Z/Qh2w2eKhCtlO+qXzmg==
X-Received: by 2002:a05:6820:615:b0:6a1:80a7:2c8d with SMTP id
 006d021491bc7-6b15944db93mr8560046eaf.32.1787336522218; Fri, 21 Aug 2026
 11:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
 <aohP7GMx9oX3ZCsQ@pks.im> <CABPp-BHJj-b=ieva3-=zaCAyvn5UtNQqNT0Q76YCpqZAjO-8VQ@mail.gmail.com>
In-Reply-To: <CABPp-BHJj-b=ieva3-=zaCAyvn5UtNQqNT0Q76YCpqZAjO-8VQ@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 21 Aug 2026 11:21:50 -0700
X-Gm-Features: AcwNN1V_cFapQiIjbaFUatBe9q8cDHVTDqu3Hz5Wf8OwwNrmNc4lnJmC818RX8A
Message-ID: <CABPp-BHWz_cugSO0EezqjHhDGok-xGuVQqWLqf=jMUvVM-Vpyw@mail.gmail.com>
Subject: Re: [PATCH] send-pack: avoid sending the whole tree when pushing from
 a shallow clone
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 10:36=E2=80=AFAM Elijah Newren <newren@gmail.com> w=
rote:
>
> On Fri, Aug 21, 2026 at 6:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> > On Fri, Aug 21, 2026 at 06:55:51AM +0000, Elijah Newren via GitGitGadge=
t wrote:
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > When pushing from a shallow clone, even if we only have made a small
> > > one-line change to a tiny file, we often push the entire toplevel tre=
e
> > > of files.  For large repositories, this could be gigabytes instead of
> > > kilobytes.
> >
> > Oh yeah, that issue. It's a common foot gun indeed, and the common
> > advice here is to never clone with "--depth=3D1", but always with
> > "--depth=3D2" so that there is at least one non-grafted commit availabl=
e
> > on the client so that they can indeed perform proper negotiation with a
> > server. But over the years I had to explain this again and again, so it
> > is clear that this common knowledge might only be commonly known to
> > people who have spent way too much time in the Git codebase.
>
> I don't think --depth=3D2 actually helps here.  What enables real
> negotiation is push.negotiate, not the extra commit, and
> push.negotiate works just as well at --depth=3D1.
>
> Without push.negotiate, send-pack's only negatives come from the refs
> the server advertised filtered by what we actually have.  In the
> foot-gun scenario -- clone shallow, server advances, then push, using
> depth of 2 just walks one commit further to the graft and then
> re-sends the whole tree anyway.  Running the four combinations (server
> advanced after clone, optimization disabled) in a small test repo:
>
>     depth=3D1, push.negotiate=3Dfalse:  Enumerating objects: 205
>     depth=3D2, push.negotiate=3Dfalse:  Enumerating objects: 208
>     depth=3D1, push.negotiate=3Dtrue:   Enumerating objects: 4
>     depth=3D2, push.negotiate=3Dtrue:   Enumerating objects: 4
>
> --depth=3D2 without negotiation is if anything a hair worse, while
> negotiation fixes it regardless of depth (the negotiator offers the
> shallow graft commit itself as a "have", and the server ACKs it).
>
> --depth=3D2 can in rare cases help, but only in the lucky/accidental
> case where some advertised ref happens to point at the extra commit
> you now have.

I guess I should add that --depth=3D2 is not really "luck" for some
users, but may be guaranteed by their workflow:
  - customers of forges
  - assuming those forges (make refs for merge/pull requests AND
advertise those refs from receive-pack) OR (keep a branch pointing at
the tip of the {pull,merge} request)
  - assuming those users never push directly to their main branch
(instead only updating it via merge requests or pull requests)
  - assuming those users don't use squash merges or rebases on their
merge request/pull requests, but do actual merges

If all the conditions above are met, forges should have a ref pointing
to the tip of the now-merged {merge,pull} request, which will never
change since it was merged, and thus a --depth=3D2 clone will pick up
such a commit and have some common history it discovers.

GitHub includes refs/pull/ in receive.hiderefs, and users often delete
branches upon merge, so neither half of that second condition holds
for us and this wouldn't help our customers.  Further, even if we did
change the ref advertisement, we have a number of big repositories who
don't satisfy the other conditions (e.g. some customers make heavy use
of squash merges), so it still wouldn't help them.
