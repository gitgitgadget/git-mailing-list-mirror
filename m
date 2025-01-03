Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE11386C9
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735947828; cv=none; b=VmXGLi9W2VCAsTtHyZqA+tONHLsOhkqUXyYZzxThnYkPTVJ5PYFVvRI1qizJy1R1hpFKWvB3W1kioDrAc4rjq8Sifl9TcjDQ+iKO9wcpKHZy6uZbNEMbDFPH79zkaemG60fJZCzZRVSfwuMcs8cesIjtO5h1vK7n8EKOyxE6nsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735947828; c=relaxed/simple;
	bh=sHCp1YKAcOWVj9K3o0lqO5bLOuJGfC+MQwPqzQuRfXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNWjSfe+iDHgYgX5+45JcUU4gLjY2zO80gTTJM1obbFbqG9W92RapH5EaXWZnRaWEOMecfubnntP7fCFZWdX5qV2z3G6z0ea07aQUBOEMrmjNUbyFCfi4rVT0hyu1C7YF7ioSnZdMOA8CBWEFMSskI6H91Vhv4M74JMJyeSeClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9txG8QK; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9txG8QK"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844bff5ba1dso1013836439f.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 15:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735947826; x=1736552626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiTOduYF2Kyy6MiaiMQIkHp7mHj86e2G8xPGcr5Wghk=;
        b=m9txG8QK3/wTFgvXe2cNQShO6gpf/Mqd5lp1jQMXNtXaT5mzxl8bRUOalxDRsYsmBr
         cLg58FV1cBITDbrBnjey01D6zV629eE830KjdKUZUuBUg3AzP6xyjls+aNb0m96os2Kw
         5w1vDURm/ZqtPiXsLWBaxopwKq6zBWNxWDudhJnwK7m/PrLc86U4JlHuYzz66c8RpYs+
         V6ey3gJQ1Dig7PvxdzgAOJWKg7EVZEI6hF8GnuoD81I8HMFPbNK6ZFaDICaw/TEb/6hJ
         dldz+GsWrkmzA7WTz1uL3JGfkt61RYqI/0SrT3gB7tJMKiV+9TkIXmuX5SWdmb0I8e9C
         UeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735947826; x=1736552626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiTOduYF2Kyy6MiaiMQIkHp7mHj86e2G8xPGcr5Wghk=;
        b=l91dC5AsBdMnN+7F9Iid9pRZtZtJ30Fo2JymPXX2dWMJ3re1+6vkAklYOqJPs8YtoJ
         CSe+LReAZD36In54KAiyS9aWm/eW4PefXT7o4UqDaKtpKnTBxiZQ5nJBRbg11gx16Fu7
         SKjRI79uIG9FiAz5+qXLIyx4NEZYL7EULC5mGz58iN+myIURYnad0Oy1ezgcYvBgyBkQ
         JLSfjn0ePqOvfi4RXLQFA8s7knwaUQhvFChFoRYgKnDxy6SlkYd+stenuLKta59jVecu
         knMbdGo7WyTW0BidLBv/8+oncfD9HYufHD6C1KiN6Mf8+iWfIVvE21XZ1AnlIAq+9b9v
         JLrg==
X-Forwarded-Encrypted: i=1; AJvYcCX8HRcqgRG/S6UkMqJcFEEeWC5ey4bIPNjTixc9PaXits3aTlJijAoMZNPlOl5uSAbZ6Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuamERUbhfWnsD92cViMZSv571tXsq5X0nSCm0RkZgflzDZSG
	h52C03/N1FghQqNG3A6GreIXmGMJsOeMRhY1B8q1kOze1IwFBGWtiC48PDEonSaJnL0IFPCRwfC
	M8LhEzgMBVDTfLd86vtnV2B1laDo=
X-Gm-Gg: ASbGnctGCUlcHvB/jcZNRI8lkSJD2ZdDON8TYormQAk4ETwP5LYvIzCP6/zk4VXf5S3
	E7PHnRUf8uvZUpbH6SHcuIo+ieEAmzcm0PYvaPlcnCIU76ef+bgsJ
X-Google-Smtp-Source: AGHT+IF26dMihh6hukLiBM6BcBRAuco5Qv8kuO991mUiF6Hq0oLAOdkHsLf2PGZpI3totzX/jLHlBxduCTYm7m3aX0Y=
X-Received: by 2002:a05:6602:1495:b0:83b:2b89:a14e with SMTP id
 ca18e2360f4ac-8499e67a005mr4000811839f.13.1735947825990; Fri, 03 Jan 2025
 15:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com> <Z3ec0768O64j-JeJ@pks.im>
In-Reply-To: <Z3ec0768O64j-JeJ@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 3 Jan 2025 15:43:34 -0800
Message-ID: <CABPp-BF7QQ02OFOzSaUsSU57yB9SZFRT=KnuDx86ABRAAob4Pw@mail.gmail.com>
Subject: Re: [PATCH] object-name: fix resolution of object names containing
 curly braces
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 12:16=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Jan 01, 2025 at 02:53:09AM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Given a branch name of 'foo{bar', commands like
> >
> >     git cat-file -p foo{bar:README.md
> >
> > should succeed (assuming that branch had a README.md file, of course).
> > However, the change in cce91a2caef9 (Change 'master@noon' syntax to
> > 'master@{noon}'., 2006-05-19) presumed that curly braces would always
> > come after an '@' and be paired, causing 'foo{bar:README.md' to
> > entirely miss the ':' and assume there's no object being referenced.
> > In short, git would report:
> >
> >     fatal: Not a valid object name foo{bar:README.md
> >
> > Change the parsing to only make the assumption of paired curly braces
> > immediately after a '@' character appears.
> >
> > Add tests for both this and 'foo@@{...}' cases, which an initial versio=
n
> > of this patch broke.
>
> Curious. I was kind of surprised to see that it's perfectly legal to
> have branch names with curly braces in them in the first place.

I was surprised too, but apparently they are valid and we have real
world repositories where people have used such bad names.

> Even
> something like `foo{bar}` is legal, even though it might be confusing
> when one knows the above syntax. But sans your finding, this should be
> fine given that curly braces are only interpreted specially when
> preceded by '@', and the '@{' sequence is indeed disallowed by
> `check_refname_compoment()`.
>
> > diff --git a/object-name.c b/object-name.c
> > index c892fbe80aa..e92f26b3256 100644
> > --- a/object-name.c
> > +++ b/object-name.c
> > @@ -2087,12 +2087,14 @@ static enum get_oid_result get_oid_with_context=
_1(struct repository *repo,
> >               return -1;
> >       }
> >       for (cp =3D name, bracket_depth =3D 0; *cp; cp++) {
> > -             if (*cp =3D=3D '{')
> > +             if (*cp =3D=3D '@' && *(cp+1) =3D=3D '{') {
> > +                     cp++;
> >                       bracket_depth++;
> > -             else if (bracket_depth && *cp =3D=3D '}')
> > +             } else if (bracket_depth && *cp =3D=3D '}') {
> >                       bracket_depth--;
> > -             else if (!bracket_depth && *cp =3D=3D ':')
> > +             } else if (!bracket_depth && *cp =3D=3D ':') {
> >                       break;
> > +             }
> >       }
> >       if (*cp =3D=3D ':') {
> >               struct object_id tree_oid;
>
> Makes sense. Only the first hunk actually changes anything, the
> remaining changes are only required to make us stick to our coding
> style.
>
> I wonder though: does this have any impact on '<rev>^{<type>}' and other
> syntaxes where we use '^' instead of '@'?

<type> is pretty limited, so I see no problem there.  However
<rev>^{/<search text>} is problematic, as Junio pointed out.  I've
fixed up the patch and added a testcase to cover all the '^{...}'
cases.

> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> > index d36cd7c0863..252485dac78 100755
> > --- a/t/t1006-cat-file.sh
> > +++ b/t/t1006-cat-file.sh
> > @@ -603,6 +603,23 @@ test_expect_success FUNNYNAMES '--batch-check, -Z =
with newline in input' '
> >       test_cmp expect actual
> >  '
> >
> > +test_expect_success FUNNYNAMES 'setup with curly braches in input' '
> > +     git branch "foo{bar" &&
> > +     git branch "foo@"
> > +'
> > +
> > +test_expect_success FUNNYNAMES 'object reference with curly brace' '
> > +     git cat-file -p "foo{bar:hello" >actual &&
> > +     git cat-file -p HEAD:hello >expect &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success FUNNYNAMES 'object reference with at-sign' '
> > +     git cat-file -p "foo@@{0}:hello" >actual &&
> > +     git cat-file -p HEAD:hello >expect &&
> > +     test_cmp expect actual
> > +'
>
> Do these really need the FUNNYNAMES prereq? The prereq seems to only be
> about embedded quotes, tabs and newlines and is disallowed on MinGW. But
> I think both '{' and '@' should work alright there, shouldn't they?

Oh, I misread the failures.  It turns out the FUNNYNAMES prereq fixed
things in CI on windows for me because the only commit ever created in
the repository is created by a testcase with a FUNNYNAMES prereq.
Since the setup for my tests relied on HEAD existing (because I run
   git branch "foo{bar" HEAD
in a setup test of my own), the tests were failing.  I didn't look
closely enough and assumed that command was failing because Windows
didn't like a branch name with a curly brace, but the real reason it
was failing was because HEAD didn't exist.

I'll tweak one of the earlier setup tests to create a commit so HEAD exists=
.

Thanks for pointing this out.
