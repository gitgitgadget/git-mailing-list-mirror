Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941215EFD6
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715326747; cv=none; b=cXIMOqaU2vaKpx1DT/w9hlBTxJ9KjIKnm7YNkjXVALIPTHvpsH6Sck92CjnGtcoH/4BCgz/iWi5hCW7OJeenkiveVEdUXpoXvC8tJciumpkNoeXw5p8KxBWAOTi3O6qBUdSC/uLbrucR4cbC8QEd6i68Fv2052u5ORKF8Z0ZlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715326747; c=relaxed/simple;
	bh=i0u066TVnJJiQoajadxNLvLzRDZIRazozG6Qb33AUzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXg7SsCWQyirBwdoFDkCscJozvq+DE13ygD5JQJpT5kJKO9aZaAqMtmJr811k7yoIDoykdheJ0uNi7XwsivVR+qUxzvasZmyWVQ0JRLHYWKQwarn5Qkygq2XxX4jgPr1Mace0GgpFYnnvdDFMpQvbjBnd7VEMpg4Vfl/lF9c90Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0EZhDbP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0EZhDbP"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41ff5e3dc3bso2151485e9.1
        for <git@vger.kernel.org>; Fri, 10 May 2024 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715326744; x=1715931544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYBF+SWmc5dHUTRdLw4/wJvzX7A8LBxCd3d0y/LEUdo=;
        b=B0EZhDbPjIoxQ4pnGACNqcItTTXVKdQ7LkoBIK4/zvKaNpcTyPlAy+2lRJerh9IOG0
         R8PY8v4sqNZ0H8KcCNdc5Yvzwiwanw12lhIm/db483DxTE77Ysq/JyPkRmjqVKeW8KRj
         Yz5it9ZLLCQc4wOw+sKrf9SeIq9ClM0toXjrfZmqnavaiTV1CBsvLWoySsvBg5u4a99x
         5k+37hgCUiDwRhVwpxqp8HS2Ta4WkotHiTfyjcxozFHp4v3VHsk7LZlNRaqoe6DWU5/1
         yxhfPdDp62u4dzkkQhHaSiv1yalqj+ztb2EQeeFwZH0G3tnl2pR3i/DZ2g7WtnFFWsly
         yTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715326744; x=1715931544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYBF+SWmc5dHUTRdLw4/wJvzX7A8LBxCd3d0y/LEUdo=;
        b=DnqJuMPy0MUuzYjbzlx3KO8+or7IpOJRaDNe6/NkaJ55uGiUm3/vYjExVoI311zkd2
         8WFsxoCuMMRCgWVYHhLGD672PpJExiBFNg6wIneb5qGAFEe60q6sM55e4T1EduAhIM0f
         dUle410tz2N7t3zSIcDsQGSCtm02gFyvFzmn0jrPgUYdUUaVJ3/2HgosHdSAWMWlWJ5u
         U1GPhwrJxCvbogE/k0gvHuhn+lgv8N7fVGB+WJRsClxJF2th0y/AmDCve/rnUW8PvW4n
         QbbU6FdUdvMdbQjSHdaxfM+jId5BYZt1Tso9P/iBaio1HAPsulNUv7E6iajNRM02sok8
         J4WA==
X-Forwarded-Encrypted: i=1; AJvYcCUDoWiU6N7QvNWFUgX8O4llndumTap/ehH3xFNfy7GbkDUNNxScyJQ7S662GIioyDrSgfMIKpS2Fu4DLmFf7t4qzTHo
X-Gm-Message-State: AOJu0YzJinKai18HLZuHPctM8iN1do6kFO2KEPTu+R9QnumoIz7onRsS
	S0gmckegs9L8ICOuirdfnpMHUL6WwSif+dp54U+8wwM79PtM8KH6
X-Google-Smtp-Source: AGHT+IFwjtDr7klfUpoBKLDbBEmc8eyE91zE5uW4Tr2el81p1qX/dz7M8UqRtlyaSsNoBhrS2K5qqA==
X-Received: by 2002:a05:600c:4ed4:b0:41c:f64:2f5 with SMTP id 5b1f17b1804b1-41fead65a50mr14753045e9.36.1715326743736;
        Fri, 10 May 2024 00:39:03 -0700 (PDT)
Received: from cayenne.localnet ([2a01:e0a:d1:f360:a123:39fa:72d0:c0c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff6cbe992sm13141375e9.6.2024.05.10.00.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:39:03 -0700 (PDT)
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <avila.jn@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>,
 Junio C Hamano <gitster@pobox.com>
Cc: Helge Kreutzmann <debian@helgefjell.de>, git@vger.kernel.org
Subject: Re: i18n of git man pages
Date: Fri, 10 May 2024 09:39:02 +0200
Message-ID: <3298196.44csPzL39Z@cayenne>
In-Reply-To: <xmqqr0ebuft5.fsf@gitster.g>
References:
 <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
 <d130d861-0071-33ef-5d40-9fd703ff97f6@softwolves.pp.se>
 <xmqqr0ebuft5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 9 May 2024 18:10:30 CEST Junio C Hamano wrote:
> Peter Krefting <peter@softwolves.pp.se> writes:
>=20
> > Should it also be merged into the git.git repository as well, so that
> > translation can be synced with the upstream version? The problem with
> > an external project is that it is easy to forget about.
>=20
> Carrying an extra tree that has been (and I suspect will continue to
> be) managed in a separate workflow and by a separate group does
> incur coordination cost.

I totally agree with Junio. The workflow is different and it is already qui=
te=20
difficult to mix the long-running process of translation with the fast-pace=
d=20
life of patches in the documentation. Moreover, the translation needs to be=
=20
opened to contributor who are not techno-friends and will not be able to=20

>=20
> > Looks like I had cloned the repo and intended to do a Swedish
> > translation back in 2019, but never got around to. I guess the lack of
> > visibility made me forget all about it.
>=20
> It is exactly why you are seeing a proposed solution to raise the
> visibility that is much lightweight and has less chance of doing
> unnecessary harm than merging of the project into ours.  The help
> the would-be translators need will be there.   To end-users, I do
> not think it matters in today's world where the manpages come from.
> The distro folks are there to absorb different ways translated
> manual pages are done by different projects, and I can hardly
> believe that our project is in any way unique.

It is not unique in using asciidoc as a single source for documentation. In=
=20
other projects that I know of, the documentation is a sister project in a=20
dedicated repository.=20

I try to present the translation of the man pages as coupled with the=20
translation of git itself, for consistency purpose. The translation of git =
is=20
already a large bite in itself (15481 segments at the moment), but the=20
translation of the documentation (which only concerns a subset of the whole=
=20
documentation) is really a beast:  73976 segment!=20

The absence of visibility is mainly an issue from my side, due to a lack of=
=20
communication. I could propose as a reminder to publish the translation sta=
ts=20
for each new Git release, if it helps remind developers of the presence of=
=20
this project. Honestly, this is not really the targeted audience for this k=
ind=20
of work. Currently the main source of translators has been through the litt=
le=20
ad on https://git-scm.com, with most of the contributions coming from Webla=
te.=20
Giving more visibility to the presence of translated content and to the=20
project on git-scm.com or in the community of translators may have more imp=
act=20
than on  the git mailing list.
=20
>=20
> I would like to hear from Jean-No=EBl how the manpage translation
> project wants to proceed.  I do not fundamentally object to taking
> an approach similar to the one we use to manage the po/ part of our
> project, where I can normally be unaware of what happens in that
> directory and leave it to i18n coordinator, but I have a feeling
> that even such a light-weight integration might affect their
> workflows at the manpage translation project side, which may or may
> not be acceptable on their end.  Also to go from the work product
> they have to what our "make -C Documentation all" produces, it may
> require more build dependencies (like a version of po4a with a patch
> or two that are yet to be accepted by the upstream), plus updates to
> Documentation/Makefile, on our side, which might turn out to be an
> overly high cost relative to the benefits both projects gain.  These
> unknowns need to be resolved before we consider heavier proposals.
>=20

Normally, I would synchronize to the releases of git, by updating the po fi=
les=20
and  opening an update window when a rc is tagged. At the end of the releas=
e=20
window, I would push a new version of translated asciidoc sources.

The translation process is not fully synchronous with the releases of Git. =
If=20
a large chunk of translation changes has been proposed on weblate, I can pu=
sh=20
updated versions to the project and publish them on git-scm.com. Note that =
I'm=20
not polyglot enough to be able to review the submissions, so except for che=
cks=20
on the asciidoc formatting itself (which is mostly scripted now), the=20
submissions are accepted as-is, like in most translation projects.

The size of the translation files already gives some weight to the project.=
 The=20
current repo size is 50MB.

All this tells me that, except for the missing visibility, the current way =
of=20
working is good, and trying to merge the doc translation of Git into the ma=
in=20
repo would make more trouble than needed.

Regards,

JN


