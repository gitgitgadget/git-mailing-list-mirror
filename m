Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4430FA1
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjP1PTgO"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA89B
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 09:20:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a55302e0so8050315e87.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699377601; x=1699982401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gFEWuZqN2Q03UTyXO7Oujuzy+ztBg8t4B06P6yFmQY=;
        b=QjP1PTgOmOva5fjC5EPY9Dg3ZV0tyjwVvVKBCP0Y7QOFQTBf0+HNoKYIIFVp7t4nyN
         fsw4gMIGb5vEi7w0rDJnfncIUIQGTXv2j5rRgeyR9nodpfZrq7Tlg4Cqw3wG/OpDuV2y
         QgUXIIVXkeQgCbttZxVIIbnIF8xW+pM50eReGi307gw8RSmrwhYhKn1bRcK23HRkwIM3
         3/9zMMNh+5sj5fwMfBCab3TvkReizJ5qfx1PvLVvydRv0aiWSeMe3wwaO6MIepT8n5fJ
         DBcbOmfYNMpJr6WTM88alzO+IwcCmvZ+c+rZkTrs+Iwq9m1qbacBEUIp0Rw2Jl2YRoAC
         sBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377601; x=1699982401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gFEWuZqN2Q03UTyXO7Oujuzy+ztBg8t4B06P6yFmQY=;
        b=jJ3xryyEcsD5EF0YTkiuuckAebgh6bqr1D+Sigb6lDatOYm1t/8A+D4WtX+c35BvTt
         wQfA9aHcz9Ib95y5nPq1O4c0Ak5QrXTeCNQ8ll/clQcbpwUREN+2cb24bHnR/shw2TbB
         KUvReRCvEKDEHk3RVwNs24aUp5VkSs9YC8zkyAGYTohEPy3LjZ0UKNhd3B+vZ+wphMRw
         S2vrUzYGYvRi/m8CNrjj8/yALQU9OZ5xMAv98Z0MYLQN12LFkxa/53vnUDWl9XEV3KCE
         xRSkzTR6rZs9oM4BiPjSGvVOOggdtgH04PrS6hTrtZRzyZuyELw4HzWJhEnhnVMuKXHX
         tl3g==
X-Gm-Message-State: AOJu0YyDXCbv53ca3UeRheXEZaOTlFDOQ2OXRrK3L7Lm2lwp49RaKBtZ
	qH6gq2TmzPvsd4Q7Cs+nho5idDudvA4zXNJoYd8=
X-Google-Smtp-Source: AGHT+IGs34m3HspY4TebXKsJUtxPuuvNZFCo834VI+/Ek88tpzEH9Nju52pLe6gKs9ufXMbtl6gO7qCX4SJ1Z3nCeEw=
X-Received: by 2002:ac2:5f6d:0:b0:506:899d:1989 with SMTP id
 c13-20020ac25f6d000000b00506899d1989mr21006426lfc.44.1699377600826; Tue, 07
 Nov 2023 09:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
 <CABPp-BEuvjduS4JiORJybKtoPWvJd+BbbR_JAvZdj4Px_v8H4A@mail.gmail.com> <xmqq7cmu9s29.fsf@gitster.g>
In-Reply-To: <xmqq7cmu9s29.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Nov 2023 09:19:48 -0800
Message-ID: <CABPp-BF9iUkF+g_w7wLATFTmjfJ3f1hsBr+zXxNZEcq-XiNOWg@mail.gmail.com>
Subject: Re: [PATCH] diff: implement config.diff.renames=copies-harder
To: Junio C Hamano <gitster@pobox.com>
Cc: Sam James via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 7:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Nov 3, 2023 at 4:25=E2=80=AFAM Sam James via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Sam James <sam@gentoo.org>
> >>
> >> This patch adds a config value for 'diff.renames' called 'copies-harde=
r'
> >> which make it so '-C -C' is in effect always passed for 'git log -p',
> >> 'git diff', etc.
> >>
> >> This allows specifying that 'git log -p', 'git diff', etc should alway=
s act
> >> as if '-C --find-copies-harder' was passed.
> >>
> >> I've found this especially useful for certain types of repository (lik=
e
> >> Gentoo's ebuild repositories) because files are often copies of a prev=
ious
> >> version.
> >
> > These must be very small repositories?  --find-copies-harder is really
> > expensive...
>
> True.  "often copies of a previous version" means that it is a
> directory that has a collection of subdirectories, one for each
> version?  In a source tree managed in a version control system,
> files are often rewritten in place from the previous version,
> so I am puzzled by that justification.
>
> It is, in the proposed log message of our commits, a bit unusual to
> see "This patch does X" and "I do Y", by the way, which made my
> reading hiccup a bit, but perhaps it is just me?

I think I read Sam's description a bit differently than you.  My
assumption was they'd have files with names like the following in the
same directory:
   gcc-13.x.build.recipe
   gcc-12.x.build.recipe
   gcc-11.x.build.recipe
   gcc-10.x.build.recipe

And that gcc-13.x.build.recipe was started as a copy of
gcc-12.x.build.recipe (which was started as a copy of
gcc-11.x.build.recipe, etc.).  They keep all versions because they
want users to be able to build and install multiple gcc versions.

I could be completely off, but that's what I was imagining from the descrip=
tion.

> >> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff=
.txt
> >> index bd5ae0c3378..d2ff3c62d41 100644
> >> --- a/Documentation/config/diff.txt
> >> +++ b/Documentation/config/diff.txt
> >> @@ -131,7 +131,8 @@ diff.renames::
> >>         Whether and how Git detects renames.  If set to "false",
> >>         rename detection is disabled. If set to "true", basic rename
> >>         detection is enabled.  If set to "copies" or "copy", Git will
> >> -       detect copies, as well.  Defaults to true.  Note that this
> >> +       detect copies, as well.  If set to "copies-harder", Git will t=
ry harder
> >> +       to detect copies.  Defaults to true.  Note that this
> >
> > "try harder to detect copies" feels like an unhelpful explanation.
>
> Yup.  "will spend extra cycles to find more copies", perhaps?

I find that marginally better; but I still don't think it answers the
user's question of why they should pick one option or the other.  The
wording for the `--find-copies-harder` does explain when it's useful:

        For performance reasons, by default, `-C` option finds copies only
        if the original file of the copy was modified in the same
        changeset.  This flag makes the command
        inspect unmodified files as candidates for the source of
        copy.  This is a very expensive operation for large
        projects, so use it with caution.

We probably don't want to copy all three of those sentences here, but
I think we need to make sure users can find them, thus my suggestion
to reference the `--find-copies-harder` option to git-diff so that
affected users can get the info they need to choose.
