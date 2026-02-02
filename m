Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0F22156A
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060894; cv=pass; b=WTSAU4yc0MEWMz17qIiWITBWVF6YNqCzwMdjwm9/vyUUUxk/DYLqIT7lOpkcTksShTfTaAZJiP5lDmV07+QXOwisV0TRpKGKiu2cTnldBqGjsz3IqSp2k6o/VW80Gf9wbuXBl0kfplBG+Q2y9lrE01llwkxtU4FOMfj7wCXqK4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060894; c=relaxed/simple;
	bh=9YMuc73AVGsgTsiV3B2cj6Hon7mMRPT7UAGyGmedZdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rD0HLbNC5fcvgKCJLcORLVqKFifxZO5QShjueXfmY03wX6gSDHrqlmZV0u+xveeJkniJLGkSbWBBGh8c4VZgHfDuAgjwzkLFobs7b5x4viQ0CzOJJT3ZLAe0MqEGFHpvfIXzG8oY4RXwpbeoJ7z6X0gZsQ1DGYDM2+64ajfx3Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV5XaIpr; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV5XaIpr"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-382fea4a160so41633241fa.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 11:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770060891; cv=none;
        d=google.com; s=arc-20240605;
        b=RovUIOebNTBAwsqsoJZYcM7jlMKhqQ/rtfpd5Ijipy2VUvMLflit741gCSmhGGuCP4
         8WgwRizEpTOSM8whjD28GzBJY+jcPtRyrMR4poz2l6XANaiazDzkC+uOQyvpxlBjE24F
         S7VyvzdTCmWGuOXSuMI6LCx1LwFGU60E9pvK+GPnPgwZZkX50QM0NaoZ0kev3ebysCGg
         ba9kPsFDm7W87ufS66q8dgk8CjmpWViG/k2NzyxlGZRPGuz44rxWN1P4AElP34WOdKoC
         ZZYJe4tu2Mi4HIXju18NHuvDdJS2rO4R5ZedH8UyxeNriBiGOo5M8/HfpKfQg/60ZuQc
         eYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ueFLOirjKrYEK7sKvrPfUgmOSaMNRAIAK77313Hjlwg=;
        fh=1aWe9bzchyqcVTXbC1Njd/6pNr9o5IsTVYIQ6P91164=;
        b=Pgvi0FaAPzdAol96FYV/NYHPSHs0s9UIT3txvhpyFTL6t6LvqWkufykygz8rej875U
         ZU/9A9gL+wTRFkU7zw6Xl/PuaZvFPcM8ALsnxRePatx0InxKZ9l2ncV0Lebcpcm3UxmB
         exVAENNEG+4wITyn1RJOnmPkz8ZpNB0l8INFqq1YwSOgxcTSrc7GDEpTsSa4RltyOEvH
         1d3V1atVmCl6AUsg1YcLXpvSPlcdWFKP2gTOHB75dwVzPHJ4iXNbgaxo8c8DSQQMyObh
         EUljdXWMUEqL42nBn7EBeRqxDUukO/3dyB3FyjTb1A6jXOIyksh2oWsNrT3owjMYdbz/
         8hNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770060891; x=1770665691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueFLOirjKrYEK7sKvrPfUgmOSaMNRAIAK77313Hjlwg=;
        b=YV5XaIprOL1NQ1bxhlVNnBblAc6gK0HeDygj/+MR0F/YQHZKEoUg3sUQ4wAGnXXTCU
         xTOaxUjSPvMQKdZTFFl2MGEOOwmSiGLPIWJkzTuHj8fTgLD6HTPKJ5b3r6z8LELtTPxF
         WysMw2Ig6d6mjCNeYNnNvRMpkmuvo5pj2SzYtJN8kIdAYeJjhaexQtLkfmKy8Vhm9F1N
         XRhqY+VIXmclGLIemYk7y/REzA2C5T+sDhzihxZd+QIPuS20hvBllMO/kzTVHlsulDer
         pBZpbmmp7EaEq1+Ma9vpRRTA/3+/fxgmPBi1kU/h1GJESLjkRFIE5e8O9DrvLqZBVCC9
         lXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060891; x=1770665691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ueFLOirjKrYEK7sKvrPfUgmOSaMNRAIAK77313Hjlwg=;
        b=CxEGpTeqp1SBUADcEHqWdamv27iAvY3aKGyMtqZTHgTBn3/Vw/ESPyEBWQWaP3033P
         w9JM6kFQO4RISP76PdPzBfX8HN1JE36sim5ffaYHRYhe2exXN3IH+Grp7ydtz9NpL0JA
         La5HlRPdgGySPlF2eWwz6uDGTXIFXkEk+9w21Y7LUOJdmSDD0RvffmLx+9m5zcNYXCpP
         xLg9WgVQw759pTCTDFP53FRNq72yLrPtTrTwu59RH0NKHr4x43Z6LsIFQcESy0ooq58N
         2Y48XLbrt1zr6Zt+cfEIY8kkcSG79SyPU+liblRP7ymQUSWdkL3VUr0RsFYvAUUT3AdQ
         7WgA==
X-Gm-Message-State: AOJu0YwCPD8dqd64xnUxU8pzCNW1+r7p4i9bNHdk50c3vHkTyXXhERx6
	kNSbf5YbJJAwzM0clo25xu713qIrvBqKHJtUR0knQYuuqBz2fDZwbZRU96+kF4X5S8g9J5rZolk
	v1QTgr9+Z1QqUWYsvdE7xfYU/yuvD45E=
X-Gm-Gg: AZuq6aId31mU5aYIzVdCUBPeWrFYWD9alNlLykoEuhgQHvXelegrCXPmfF9/X4m61Dj
	6LIyjNBqFpH/vPL0i70rvxA0OB/4Sczvo1B2XLbc65EhjlLyrqRVBOm5K+30zUskdsa1AUxCzXS
	cV8JIPsD/8bbj4UeXcitprWkLVskhInlZz1cmOBQ1I7dozVkcXTwoI1ENskDMjsQZJHkYXEru4R
	YtPBTfADJN7tbFoMUG3wCBi70jke3Y1fkB6K/MdJ678Ptm0D52Q4LvqahM0++iWEmY/85s7UNO+
	mLvwOIA=
X-Received: by 2002:a2e:a9a8:0:b0:385:ce80:a1d4 with SMTP id
 38308e7fff4ca-3864662a3d2mr44750881fa.28.1770060890801; Mon, 02 Feb 2026
 11:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2160.git.git.1767625195071.gitgitgadget@gmail.com>
 <20260202161759.84355-2-hoda.s.salim@gmail.com> <xmqq5x8fynqy.fsf@gitster.g>
In-Reply-To: <xmqq5x8fynqy.fsf@gitster.g>
From: Hoda Salim <hoda.s.salim@gmail.com>
Date: Mon, 2 Feb 2026 21:34:39 +0200
X-Gm-Features: AZwV_QgxdbFdTOsIXjROomSTxidf-qrkH2cOdlcvYkgCe69ahqHvSqdcqTpXH18
Message-ID: <CAAGT0iJuV+L52Fnme-LbNXUtUpSqmeX6+5SYKGZE9fxzHEuNGg@mail.gmail.com>
Subject: Re: [PATCH v2][GSoC] t9160:modernize test path checking
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Will queue.  Thanks (and thanks for all the reviewers who helped
> polish the draft to get to this v2).

Yeah, sorry about that. The patch was initially submitted using
GitGitGadget and I didn't really do a great job in the beginning to
reply to the GitGitGadget email.
Pushkar was the maintainer that kindly pointed out the misspelling. I
added him to the CC for visibility

Thank You,
Hoda


On Mon, Feb 2, 2026 at 9:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Hoda Salim <hoda.s.salim@gmail.com> writes:
>
> > From: HodaSalim <hoda.s.salim@gmail.com>
> >
> > Replace old-style path checks with Git's dedicated test helpers:
> > - test -f =E2=86=92 test_path_is_file
> > - test -d =E2=86=92 test_path_is_dir
> > - test -s =E2=86=92 test_file_not_empty
> >
> > Fix typos with the word "subsequent"
> >
> > Found using: git grep "test -[efd]" t/
> >
> > This improves test readability and provides better error messages
> > when path checks fail.
>
> For a small change like this, the above is sufficient as all the
> necessary things are described, but for future reference, we prefer
> to explain things in this order:
>
>  - Give an observation on how the current system works in the
>    present tense (so no need to say "Currently X is Y", or
>    "Previously X was Y" to describe the state before your change;
>    just "X is Y" is enough), and discuss what you perceive as a
>    problem in it.
>
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
>
>  - Give commands to somebody editing the codebase to "make it so",
>    instead of saying "This commit does X".
>
> You are going backwards ;-).
>
> Will queue.  Thanks (and thanks for all the reviewers who helped
> polish the draft to get to this v2).
>
>
> >
> > Signed-off-by: HodaSalim <hoda.s.salim@gmail.com>
> > ---
> >  t/t9160-git-svn-preserve-empty-dirs.sh | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-p=
reserve-empty-dirs.sh
> > index 36c6b1a12f..de32cf2542 100755
> > --- a/t/t9160-git-svn-preserve-empty-dirs.sh
> > +++ b/t/t9160-git-svn-preserve-empty-dirs.sh
> > @@ -61,15 +61,15 @@ test_expect_success 'clone svn repo with --preserve=
-empty-dirs' '
> >
> >  # "$GIT_REPO"/1 should only contain the placeholder file.
> >  test_expect_success 'directory empty from inception' '
> > -     test -f "$GIT_REPO"/1/.gitignore &&
> > +     test_path_is_file "$GIT_REPO"/1/.gitignore &&
> >       test $(find "$GIT_REPO"/1 -type f | wc -l) =3D "1"
> >  '
> >
> >  # "$GIT_REPO"/2 and "$GIT_REPO"/3 should only contain the placeholder =
file.
> >  test_expect_success 'directory empty from subsequent svn commit' '
> > -     test -f "$GIT_REPO"/2/.gitignore &&
> > +     test_path_is_file "$GIT_REPO"/2/.gitignore &&
> >       test $(find "$GIT_REPO"/2 -type f | wc -l) =3D "1" &&
> > -     test -f "$GIT_REPO"/3/.gitignore &&
> > +     test_path_is_file "$GIT_REPO"/3/.gitignore &&
> >       test $(find "$GIT_REPO"/3 -type f | wc -l) =3D "1"
> >  '
> >
> > @@ -77,7 +77,7 @@ test_expect_success 'directory empty from subsequent =
svn commit' '
> >  # generated for every sub-directory at some point in the repo's histor=
y.
> >  test_expect_success 'add entry to previously empty directory' '
> >       test $(find "$GIT_REPO"/4 -type f | wc -l) =3D "1" &&
> > -     test -f "$GIT_REPO"/4/a/b/c/foo
> > +     test_path_is_file "$GIT_REPO"/4/a/b/c/foo
> >  '
> >
> >  # The HEAD~2 commit should not have introduced .gitignore placeholder =
files.
> > @@ -102,14 +102,14 @@ test_expect_success 'clone svn repo with --placeh=
older-file specified' '
> >
> >  # "$GIT_REPO"/5/.placeholder should be a file, and non-empty.
> >  test_expect_success 'placeholder namespace conflict with file' '
> > -     test -s "$GIT_REPO"/5/.placeholder
> > +     test_file_not_empty "$GIT_REPO"/5/.placeholder
> >  '
> >
> >  # "$GIT_REPO"/6/.placeholder should be a directory, and the "$GIT_REPO=
"/6 tree
> >  # should only contain one file: the placeholder.
> >  test_expect_success 'placeholder namespace conflict with directory' '
> > -     test -d "$GIT_REPO"/6/.placeholder &&
> > -     test -f "$GIT_REPO"/6/.placeholder/.placeholder &&
> > +     test_path_is_dir "$GIT_REPO"/6/.placeholder &&
> > +     test_path_is_file "$GIT_REPO"/6/.placeholder/.placeholder &&
> >       test $(find "$GIT_REPO"/6 -type f | wc -l) =3D "1"
> >  '
> >
> > @@ -133,19 +133,19 @@ test_expect_success 'second set of svn commits an=
d rebase' '
> >
> >  # Check that --preserve-empty-dirs and --placeholder-file flag state
> >  # stays persistent over multiple invocations.
> > -test_expect_success 'flag persistence during subsqeuent rebase' '
> > -     test -f "$GIT_REPO"/7/.placeholder &&
> > +test_expect_success 'flag persistence during subsequent rebase' '
> > +     test_path_is_file "$GIT_REPO"/7/.placeholder &&
> >       test $(find "$GIT_REPO"/7 -type f | wc -l) =3D "1"
> >  '
> >
> >  # Check that placeholder files are properly removed when unnecessary,
> >  # even across multiple invocations.
> > -test_expect_success 'placeholder list persistence during subsqeuent re=
base' '
> > -     test -f "$GIT_REPO"/1/file1.txt &&
> > +test_expect_success 'placeholder list persistence during subsequent re=
base' '
> > +     test_path_is_file "$GIT_REPO"/1/file1.txt &&
> >       test $(find "$GIT_REPO"/1 -type f | wc -l) =3D "1" &&
> >
> > -     test -f "$GIT_REPO"/5/file1.txt &&
> > -     test -f "$GIT_REPO"/5/.placeholder &&
> > +     test_path_is_file "$GIT_REPO"/5/file1.txt &&
> > +     test_path_is_file "$GIT_REPO"/5/.placeholder &&
> >       test $(find "$GIT_REPO"/5 -type f | wc -l) =3D "2"
> >  '
