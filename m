Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823A38F646
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999413; cv=pass; b=mBFNl3zwJd5/6xy+I8JWjcOQvvsLsuflSg6a3bPwI5/D/wtttR0SsT6y/+kUDyHSygyEo7oQS3Yf6OMxPnvdKfFZAGywqWvkof36YVnxhgEkouoRDMSPavka2Ps1cjIo2anVpC8ETkyKQdQV91UCwucD1PpFz/lIzvTmtzy1YHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999413; c=relaxed/simple;
	bh=dVZ7HzhqFhb7Uo5wiyhT7gFZ98XlHKrT7P9DF++GRH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQgW/Cy5JdByY37Tx11+XEkKdor99z6FvCtsQG/msdG7ANuJcJTDxxt6Fr3dQdniDCBpHdxk+IvRlyfJg5uk3t0zkHFr5Lft5RYM303Zu6FLdSOzrMH7W/Ku1OAbh0GVFnDx406JhDYQKBC3lCGWPgA+eS+n8ZYkruMDyt15y9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7SaiPKu; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7SaiPKu"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-660323f7b27so5602497d50.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780999411; cv=none;
        d=google.com; s=arc-20240605;
        b=YugF/JD5Mjx+eXoFSQ6bci4RMsHEFBcr0JMfZz5ADD3HIGamkq5tfXvc3tDj16tkiP
         x4+j4ecwvy9+onajkBfi89T0tuph5wWSifZBMgaZqDgZ/1xK7GvveSxywam4/pqK7eUT
         aqNyj/RlH9IoMCIpdppzx4ZUGEfSIdCJgDM7mP3cAiQyMr+22pNSZA5tc3JXUrzdFP0F
         a3064nTnUdeXlvchhEr8xRNGtufqAE3dao0+alUYs/hEPF0GjLM9k5kefJn6O3MVUSjH
         XWvWtJawLkESqIGxydMUkfwrldYxQDRHPf+ch3ojMKmfK/0eHCNdWAAw0i1VYJuQ4Td8
         RZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/M/tf9BM2+QHfrBfXwyodDsglUEzOSk2Z+i3o7j2aHA=;
        fh=Du+9amIMHXW2phzfBfcQzxENYwbtgwJa8BRZEHy/jlA=;
        b=GiAkK31MR0lhhFa40fMr60XwzpXNoZGWid4upOgbN3ag6RKSij0Z8RSNTpXC8UknuE
         Lp8DJ9dqeYKKM19DMDFB0F/+GMHL5oJkJ6siMyzqHRLec+lSPO1acOL0yUwoNsPu82vt
         eY6zgWfFVKQkDtHCa9Ndv+aRY2CNMgeyIqxD5B57AQ1y6+aqeLv1N0Yj5QcxscAynCP6
         Py2V0GMXD08L23bE0WdoItuYBCtq18O7rl6HQ2yrt/b1P5uqdGlc21B+hZ4zkD6qDN72
         XCe9P2/nOo3KVrVhCyYIR2BCkUUjQeLr4wZ8cLfQazFsoCD66PmD9acE/oVFqHuI1C+H
         zDYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999411; x=1781604211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M/tf9BM2+QHfrBfXwyodDsglUEzOSk2Z+i3o7j2aHA=;
        b=s7SaiPKu3SHtvElURkdhmbg9Uj3BZ+32V3LN42aF4VoD32sGAQpGNDKQ3yRCmvU5TK
         5s9utFYiYVE4UjnXPLBPxiHgv0hO3SNrRPHBJgC991kz/H8Av57/g7SrT17cb8U2ozjT
         DANtmS5ci/hG4+xKd1dL0kCBos2hpxwkQhLvY1jeYPvrPMyfy7p93y5MN5x5XAxR9nlE
         Lb5IpNbmHr9N2+IbCn8SxHQXlYHjsiyjScRtF5wD6OtCmrVgT3ZR2N8xFnDAM4HFvOlm
         l4qNZsa1dwJOeVC/hR5FlpWSasyVM5A2X109OVt+D4fFfsp75+4X8e/LL1TfLNJa7wr9
         W5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999411; x=1781604211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/M/tf9BM2+QHfrBfXwyodDsglUEzOSk2Z+i3o7j2aHA=;
        b=QZxBGlpidZa3aQ/cskkt2VHAizugNjr59pCWPszGw11WN2xphicpes4BY7oKvdJ4E0
         /3HS2VSSkEO8DnooDKV7cM9E4yJrZPPB2SOpgRG/J5Kkyyv3ah1tIl11S+8pVSmwMzcy
         H138Z1+qCqGEeomNhsVSTd+by12+eNpJDLUL+zdvlBsBBn6aUbKn1Pm53cEvy0j3ySMf
         O5EDpckqaJE1lEgRabSj7u1ylBRLZjKrE9SmfdxL7h8JxMbLVBVNHi6K0NALGOIm9v+9
         7pmNnubKO7M+j1Ihy4kpCvfF0rPrQcyCVpEO4H42m5SR79nRnsX1JFcYh3eVuLJKT9I8
         P4XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XTkQ4WAaB10UKRzZvnr+ZUSxnTp+V+09Hk5+/OVOBl1fLoIeG4Bu39isCStZrgF3J8XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxuaxXGDgl1Tstl/KPQnwqLTUBmSiTlR/97JulbgJVBMeSbde
	8xUKEJpSTYvErWqGPV1c0xKJk447ruq5COPwClIvqeE0kzHwA08aM80JXr9EvlmWy34g6vsnVG9
	fc/FcmMPJDpohLgDT7YZUQOGof0c7GAE=
X-Gm-Gg: Acq92OG7vHiRdcQjWllqC0VSE46jOqoQx8HsW9D+uWpwlWJOvgmCy6hKCjAMjC2ktBz
	G1Vhc8GmZsaWYBhsX1Y2TO1fO4r0OIJRELNBz1NwTIVlPzz5lqGvHPvpV9MYOdyrqnj4rTOw+ht
	m+73RNv7LI+aBApsUP2ES/XtzgfdUeCVBfGrrMrlHxLyx+124ZBQbcoD1appS8503CC+tJpnlVn
	CIDqvfv6CopiJGq1T5jwzbe8D8ulAWWQzRnVGQlRF02wnRjz2IhA6u7m4hnOyfMS+4K1+H772bC
	XjnW8ijApePsXjoh0DSRgKASPD7HwUhcZTt4EdIyfh2kb697EgvSx495HbAbDkYuxDzh7B/8t9H
	x+Ug6vY6BeEjBPiMMtmJg11n3fWSe1COyn19Qwtd/gq8blaVEhAYxiIG6x7qNaZ4jOFx+qUv7nJ
	6hoSyKcdbF3PrQ
X-Received: by 2002:a05:690e:d50:b0:65d:8f98:6bb4 with SMTP id
 956f58d0204a3-66106e64201mr14679745d50.29.1780999410774; Tue, 09 Jun 2026
 03:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmrx5z0po.fsf@gitster.g> <3D9034D8-C38F-48A1-B637-4342BE4954AC@gmail.com>
In-Reply-To: <3D9034D8-C38F-48A1-B637-4342BE4954AC@gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 12:03:18 +0200
X-Gm-Features: AVVi8CelssaLq2xHvt_EpnW0HY2781_fMLaVBl5JnVyuqQ_gh5mKc--Sk3XHdWs
Message-ID: <CAN5EUNS98DYTKNCYjSFRSLvQv-UgewyV4PnafcDVROd0MvdmBQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 8 jun 2026 a las 18:44, Ben Knoble (<ben.knoble@gmail.com>) escribi=
=C3=B3:
>
>
> > Le 8 juin 2026 =C3=A0 08:23, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
> >
> [snip]
>
> > Having said that, I personally think that the current behaviour of
> > `commit --amend` and `history reword` are both _wrong_ [*2*].
> >
> > You may start `git commit --amend`, and after staring at the
> > existing commit log message for some time in your editor, it is
> > quite natural for you to decide that leaving the commit as-is is the
> > right thing [*3*] in your situation.  It may have been a better
> > design for the system to notice this situation and leave the commit
> > as-is, with an override option `--force` to allow users to forcibly
> > update the committer ident and timestamp in the commit header.  I am
> > not a `history reword` user (yet), but from the motivation you
> > described for this patch, I sense that the story is the same there.
>
> FWIW, in this situation I abort my editor (:cquit in Vim) so that the ame=
nd gets an error-valued exit code from the subprocess and aborts itself.
>
> Perhaps there could/should be a better side-channel for communicating tha=
t, though? I do not know how easy it is to tell other editors to =C2=AB qui=
t with errors =C2=BB.

Well, I didn't know that I could exit with errors (:cq in NeoVim),
can't say much about other editors, but It would be better to abort if
the messages are the same and forget about editors.

>
> > [Footnote]
> >
> > *1* Besides, doesn't "--update-refs" in "rebase -i" allow you to
> >     adjust the branches?
> >
> > *2* But it is an established behaviour people _rely_ on, so even
> >     though it may have been better if these commands behaved
> >     differently, it probably is a bit too late to change it now.
> >
> > *3* This includes the case where the original author is especially
> >     difficult to work with and would complain any change to their
> >     commits, even if the only change you made for them is a
> >     typofix.  Fixing a small typo/grammo may not be worth your time
> >     and unpleasant exchanges with them after touching their commit.

Thanks,
Pablo
