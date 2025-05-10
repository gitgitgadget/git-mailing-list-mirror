Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF61553AB
	for <git@vger.kernel.org>; Sat, 10 May 2025 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746907661; cv=none; b=t22ilYzSj4sypgj6PXHZ7LxFELhCbGn4VTbwqbwpEL93z1gu4t3D5WkAlJVYgvmfaD3bPe++DALK+HIkoLUjH7Xjob3N0LyoEODyqf3llhfWffmtcYQzN468bMoVMlE51/xGl0+dQ5V6TqoBe6J6/EfO5uqVUO6ND7SUbGi9ZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746907661; c=relaxed/simple;
	bh=0MzkNa9YyqlCQ6j4YSy/XSGmSjUaGMuGo6fg9waVka8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gD/W2WxLKzjS4skXeguz9UjbCfb1cdzyKazoaPeEYOw28VzkLcvghH+712oXS2mhFeiOCN+0HQb3Z5eojutkUZtCHC0DVdQAaHa5uhMvd1vJ8tSKd99oWIcI9DzWPDCIiuY/mgWUlvl2U5ZgPwrEgPH17PeQjX5fAI/1apKFCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXI4Gc/H; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXI4Gc/H"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad2216ef31cso277187066b.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746907658; x=1747512458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LOKIo5n4BJ0Wdw6jzediioPNIXE/UH9+oGVgzvOdVI=;
        b=SXI4Gc/HTc/cQCHFEJnlKxaNhSH/kDggSUM86wsmFCB3g2sYHeUxXQdYs10OFDDko9
         cYkQrCl/G8akJOOgSxX9F7zmgixhASOZ9WjjFXDEqwTUU4yvW7FNZ5OzGPtsNR/DVn4g
         4w0OBT3oYErxQTfTbsZU4O3EwYrcsTXfZibFizL+plGWWygpYd2jWodGKXy5ta8woXRw
         0gPgztLbZDYYtyvdSgHbhlfAXKXw3wtbR8HJfP+/1El4Oyr+7Nz+joCbg3QotjCfDeky
         XaDwY9y+Jf/lURddPJjftn/KJuFdAEWuDQJ2H3KN8z2gzJ58GQZqwC/9hkNgDLnJCYZ0
         V4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746907658; x=1747512458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LOKIo5n4BJ0Wdw6jzediioPNIXE/UH9+oGVgzvOdVI=;
        b=Px/L6a1b5SnBkK08F/W2r/8kqqPL75VXJT0nw8V1U9RWpofapMAJMHJlC9wt+xrUol
         12elUuqIGikLNj6jEtXjgd+rKNVmKIF6wr5eBgMSrrSXHkeIy+iuoZ4QRW+U0TNYWqD1
         /xlPcsk60OkGQ0gSISDFjzyaVC3I/BwMRYY8v2UTCS9yCYDCY166sI4Yo1AecXO1iLLG
         XPF/wx67QHcXXcvqNr98/ZR19H6gePaBb5OJjwLsDV5McnsZ0tkxLUYmkcJTIviPVbTI
         +qWcvd82xmMZaYif8dK8olUemWV4VHRR4SIFrXPtG1or0ibydb9wm11cV+TMh5FjZT9A
         n0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpggnGeTVdObvtiPWH7kKjfbPLA2Rkh/mVzU0fX2JphJt1FPUqvw/HPW8QY/0yRWCKO4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQJRNX6bROVbwuiCBMsJ+q02pG1mHDvVY/F/pUJggRK5BWw7s
	Rieq1b8bEPjH7wMoM5nPqkFG5gmKtwkArWvZwyAYAZ9uXB8RQibQbV7q+gMjl2eIJ065nQ8bXXO
	nE6iIUtjw81+ND3CrCXf19ARbyjI=
X-Gm-Gg: ASbGnct01zcB3jc7cflWf1doVuy4otSz9fGtl7Dnk3BtnMoTAZ+SwAmYdhFmCpWnEan
	Ja6u8+OpYGHnQSvR/WZjZhULSMfTRxRvSk55tPhUF3LhdP4kWTIJ77fBE/fQbRrgP+xlsTr/qtT
	T/F/JDMYCZqFDwFaDvm9MZhjpN6q+Vor2qHPGEqg1E8LaRakbu4BEa4+6tC7QKpNGmQtzjtDyvV
	cw5
X-Google-Smtp-Source: AGHT+IF1ZVZs3Zvr33m+TUefQkyuJ44mKia5qoNqD6sNX8XmSSGCYcVJhfTn65OmnDRy83c5QC9kt229MvtHytOps3Y=
X-Received: by 2002:a17:907:d109:b0:aca:aeb4:9bd6 with SMTP id
 a640c23a62f3a-ad218f2d4d6mr704121566b.10.1746907657795; Sat, 10 May 2025
 13:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <xmqqmsbph3lw.fsf@gitster.g> <CAPig+cT6XbdzeOFoeZUmX+ozPa2XNOv=H85xQhY4y8NYmJZ6-g@mail.gmail.com>
 <aBq4J6UTZVPF8rb4@teonanacatl.net> <CAPig+cRxDQBmPu_-ci5vEuwtsAHadfCiFOccdYseBSj2F52JGw@mail.gmail.com>
In-Reply-To: <CAPig+cRxDQBmPu_-ci5vEuwtsAHadfCiFOccdYseBSj2F52JGw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 10 May 2025 16:07:26 -0400
X-Gm-Features: AX0GCFsC_xymUp4QHziAlGNxv2Ar58mOXK4Zt53Gl6IErkCrutloiabRKXOEGEQ
Message-ID: <CALnO6CDp3Kr_Ma49jzftN_sMkOU95xGZ0sMe2J2boG2pWggCzQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Spring cleanup of "contrib/"
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 11:55=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Tue, May 6, 2025 at 9:32=E2=80=AFPM Todd Zullinger <tmz@pobox.com> wro=
te:
> > Eric Sunshine wrote:
> > > Although we periodically hear that someone uses it, git-contacts
> > > probably falls into the "tool has a clear alternative" category. In
> > > this case, git-related[*] is a separately-maintained more functional
> > > drop-in replacement which people could be using instead of
> > > git-contacts.
> > >
> > > [*]: https://github.com/felipec/git-related/blob/master/git-related
> >
> > It may be worth noting that git-contacts is suggested in
> > both MyFirstContribution.adoc and SubmittingPatches.
>
> I think I knew but forgot about those mentions. Certainly useful
> information if Patrick decides to pursue retirement of git-contacts.
>
> > It probably helps that since 824503ce88 (SubmittingPatches:
> > clarify 'git-contacts' location, 2024-04-18) there has been
> > a note stating this isn't "part of the core `git` binary and
> > must be called directly." That is relatively recent, though.
>
> Out of curiosity, I Googled git-contacts but didn't find any
> meaningful hits. Pretty much the only pages found were renderings of
> Git's documentation (including SubmittingPatches and the man page for
> git-contacts itself), as well as the few patches to the Git mailing
> list which introduced or touched git-contacts over the years. I did
> not find any general discussion or recommendations to use
> git-contacts, so perhaps it indeed is not very much used.
>
> > I added git-contacts to the Fedora git packaging shortly
> > after 92a5dbbc22 (SubmittingPatches: mention the git
> > contacts command, 2018-04-11), presuming some readers would
> > want to use it.  (I never want to penalize users who are
> > diligent enough to read SubmittingPatches. :)
> >
> > All that said, I don't have any strong opinion on whether it
> > is kept or removed, let alone when that might happen.  I
> > don't know that I've ever used it, other than for testing
> > that it worked while packaging it.
>
> I've never used git-contacts either, despite the fact that I'm the one
> who ported Felipe's git-related from Ruby[1] to Perl[2] for inclusion
> in Git's "contrib" since the Ruby version had been rejected due to
> being written in a language not already employed elsewhere in the
> project. The Perl rewrite also included a number of useful
> enhancements which Felipe later incorporated into git-related after he
> published it as a standalone project. He has since extended it to
> include even more features, so it's functionally a superset of
> git-contacts.

On a related note, installing git-related seems like rather more work
than using git-contacts [1]: I have to keep a Ruby environment with
the right gem working since I don't see this packaged anywhere.
Keeping a Perl or Ruby environment working (at least for me) has been
enough trouble as it is, heh.

[1]: https://github.com/felipec/git-related#installation

Not that we couldn't drop the script, but ideally the replacement is
an easy install (since, e.g., some of us use git-contacts as a ccCmd
per the documentation).

>
> By the way, Felipe also sent a patch series[3] eleven years ago with
> the same intention of Patrick's series under discussion. Felipe's
> series was never picked up but did undertake the retirement of
> git-contacts.
>
> [1]: https://lore.kernel.org/git/1369986380-412-1-git-send-email-felipe.c=
ontreras@gmail.com/
> [2]: https://lore.kernel.org/git/1374403962-48361-1-git-send-email-sunshi=
ne@sunshineco.com/
> [3]: https://lore.kernel.org/git/1399662703-355-1-git-send-email-felipe.c=
ontreras@gmail.com/T/
>


--=20
D. Ben Knoble
