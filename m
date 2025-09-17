Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AD20E005
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151880; cv=none; b=Zwnu7U1FlkavKyw16DtsqeAv4nDEo3T+OugVoCGg5Roak6WhVE12YXtprUY6Tkouza2BTGgRgUfHb/3moA5w8q5OrqU5MA5Owr0lPRBw/ubH/J5m3Zti7C5v9yu5SMF2oEfFfb5xeyI1HL2HiAwuVXKb7fmOyj0WddwvguzO1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151880; c=relaxed/simple;
	bh=rnTW7C50su4N0Vc2yN2ZYq/0L7o7ACe+eHUAO6pI/as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2tuFAiEWXZkgK8aqOdyU7URZg2gUnTAMnsHbZgpMPMMesnXOH0VVobFIG99zgfB72Ba45tFIQ2JB1XOqyFv8xwtIyrXs+eqDlikK4SE8eauWvOKHEpOHdEiTBMk086TewmTfWDtx0rIoy6M7RJOuQogg8p19JkC8oilVT2hvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-837d73dddc6so678185a.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 16:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758151875; x=1758756675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzr8mQw2v/S0DoNlcPFbqMG8GW6t1YRPRNjF4irKCCs=;
        b=Y3eeXxcZ0eb+pEb1Z2mY0I6+q81+BcZwufnJrICmQRWo+e3hfVE6grT+N1PTlnIpkb
         ozwU/aQmFLpVNYu+EOGlrBHz8VAJkkOJ2ga1kNJjPsk2fWRtUHkcW4yJkImTsW+5BZgb
         zJFqc9ABVW81flf9yS64+lzLj2Y4/nTnf3QhdimMw/QANLZRJ7PkryHDNHLEtJMvbGZB
         u/U/K5Vs+b1SaZboEJpJcY3/tgJhhbcubWV0elG+CJeZ2giF2AbGLmjYrYdRClM5KYLJ
         FsovYFyX+kmDJ90e0cAWM8ZbCN2NMBaqumBcIK2/MfeSglwcBeSQmZbDd8EVgayJPNPN
         JwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyW6iJO8InmcDUtzIQj2tWc6/bnb9nF93gHiSB0aUVd+s6lDz+GNXCpXFyxxMvWGa3Ymw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8gS5HKtPpoBmZNZ9/2PqNG9Gom2HWAHLFiDzyYqrmgXhWHFk
	RH9P24uR4pRX/1gFPhDOwoEyRDX4+QZ9dq+y6eTzzJQCdE+DC6kFiUne6/e+nfowtlOBshFYQbU
	BSzmm9mDt7HvQGx+B+kAGhyfEgRvLwaU=
X-Gm-Gg: ASbGncui5lGyeslswmjz4Di9my+wBK5CKY3L8lKr7BaFS8ef383swU7g7/RL+8sSnVf
	WKHcNPLF4NDEhYN9+sVjksZyWSttiKUtaT18cI4H/krV72PcnOt9dNxOVqLQBSDwvKhv8RD7roY
	+mqtWNamxWU/nSB3poUOkuLPdtk2ZaPSmgK2380ulqdMo+7rprAwAeU4WSPByqIbSmj5la0wchj
	XPgH6jdE5xlV9B2KoSYNafLjFD3oLyot1OLZE54LQd7bV3B7vIKDuoY794=
X-Google-Smtp-Source: AGHT+IErxtVSijMTN6KTpBGHp1fe9HUakchvrLivBtx0+x9qL8i9m2hpSVGcruPj29/TvSJSWwzNv9k+QtbG3EiD7fc=
X-Received: by 2002:a05:6214:29ce:b0:789:e48a:fc05 with SMTP id
 6a1803df08f44-78ecef1865bmr29746176d6.6.1758151875433; Wed, 17 Sep 2025
 16:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6a27e07e6310b6cad0e3feae817269b9b8eaed69.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cTZch_pvfurtjBTNphMeRQL6jSBSjNY-4mffjoXZ4eqcw@mail.gmail.com> <CALnO6CAmNTAOj0wkkPoEMOhHB1bgM4xBKa1=4zuS1Cs=UAq_BA@mail.gmail.com>
In-Reply-To: <CALnO6CAmNTAOj0wkkPoEMOhHB1bgM4xBKa1=4zuS1Cs=UAq_BA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 19:31:04 -0400
X-Gm-Features: AS18NWC5OfM3N05AyorvpDUlbHYgpBCcg9soxunDI5rmx3NQiHGwuFINhqHOmpw
Message-ID: <CAPig+cTdJAjuekz6YXDkxTjTRxsPEzSUxhoD8nK9k7uA4s=rHQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] build-helper: link against libgit.a and any
 other required C libraries
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:07=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
> On Wed, Sep 17, 2025 at 4:52=E2=80=AFAM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > There are more than a few developers on this project (including
> > myself) who still use 80-column editors and terminals. As a general
> > style guideline, this project does recommend wrapping code to fit
> > within 80 columns (except in cases when doing so would severely hurt
> > readability). I imagine that the same sort of guideline would be
> > appreciated in Rust code, as well, by those who still stick with 80
> > columns.
> >
> > I bring this up because, although it hasn't been such a big deal with
> > the existing C code, assuming that developers run `rustfmt` on the
> > code before sending a patch series, then this may become an issue if
> > different developers have `rustfmt` configured to enforce different
> > maximum column width, especially since `rustfmt` is likely to reformat
> > the entire file rather than just the region that has just been edited.
> > So, if this code gets checked in as-is with these very wide lines, and
> > then someone else, who has `rustfmt` configured for 80-columns edits
> > the file, then it becomes a problem.
> >
> > As such, can we also add a project-wide `rustfmt.toml` which, at
> > minimum, sets the maximum line width to 80? For instance:
> >
> >     max_width =3D 80
>
> I believe rustfmt and Rust generally uses a 100 column limit.
>
> Perhaps you knew this, and are really suggesting we break with Rust
> style for our own style?

Correct, I did know that, and I also know that there are a number of
developers on the Git project who still adhere to (perhaps archaic)
80-column editor and terminal window sizes.

Project guidelines have long suggested 80 columns as a desirable
maximum not only for C code, but for pretty much all other resources,
including shell code, Perl code, and documentation files. This
suggested maximum works well for adherents of 80-columns and
(presumably) hasn't been too onerous for developers who use wider
windows; at least we haven't heard people clamoring to increase the
suggested maximum column limit. As such, it does not seem far-fetched
to expect that the project guidelines should/could/would also apply to
Rust code.

> For handling personal configs, we could try to maintain a config here
> that repeats all the defaults, but that seems like more maintenance
> headache than noticing unnecessary reformatting and reminding folks we
> use the defaults (except where we have config that specifies
> otherwise). Although the docs site doesn=E2=80=99t suggest the configs ar=
e
> layered like for Git, so perhaps a blank config is sufficient to
> enforce =C2=AB we use the defaults =C2=BB?

Sorry, I'm not following what you are asking. I'm simply suggesting
the possibility of adding a toplevel "$GIT/.rustfmt.toml" to the
project with the single line content:

    max_width =3D 80

That aside, we probably also ought to insist (via documentation) that
contributors run `rustfmt` on Rust code before submitting a patch
series.
