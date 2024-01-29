Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955373C49E
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524389; cv=none; b=sbSdjZubeVFZLNLiAGz14eWoSDkBynUTn0hlvz4dHF2RxeWDzwhZKF+YOgHg7FIIFtczZD4Ys8O5o/WYTNUhdQTvu9itg+g2fIvI8yMrBFrNB9YnbUswg+lPJWJQJMiKbKZfQ2WYFocNR+Cc+z2Hl/pxFsrCN4TGJApOp02N8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524389; c=relaxed/simple;
	bh=k1BohBANTdQ4VwFSewqlVrkcnrDAAF73GiGsQiaacJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjKQ9UfZaYNT0FijrRgZaK8o6ncDHBGYH7D8yCLxfFMEfvY7e9BjHdiUvBHoTfKhkg7WqHXngEa56+kWlcdkFxg81DflgltxNTksFkLtL9LScvGwWqh8xBtTElqLhRK6MVS7V+2cgFQS5UqbjKzaHm4BY8j7Ptmh8PUzP9D1eoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX7FOi9D; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX7FOi9D"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26f73732c5so274714166b.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 02:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706524385; x=1707129185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vw4NkdbQnm2vihT0MFapG4RGBxG5hm7JnUzqJgA5r8E=;
        b=GX7FOi9D/4a0wj+VVpK0oxg6bLfaswAkju+2R653/+AnCQ5F7XdBOTzp7bNfSICbYJ
         2ppT5yrEd9CBuMSdPrguX4VwCunVlRYs6kaxabQMW0PezLA8OKumVyg02r4PJm2f2xH/
         rDwtyNNYZG7hr7XBSIeFDzts2uksJSMEfpBNcgQgdKmRf8JNpe1s7E4LCMyEOE2Po1q3
         9jvi5h9lIuhKO1av1JaqlD8s5EYRnMS1ycAq3Mu3t+eEVfE2xB0NjQsmSTmnAB42OcAO
         1Uw/IueQn0ZJVivczSKXFoxUDN/80oxqBjSCiEjHxdJ7MgRjLPS1junPn7ImiuHsk6gm
         QMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524385; x=1707129185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw4NkdbQnm2vihT0MFapG4RGBxG5hm7JnUzqJgA5r8E=;
        b=SiA24Yf8gjw3meMtDuq1Jq1JWYrOhMsUq2BEAcMy2YVnobrRyCcmQ1Xfdrex3DaYl9
         wHhBYwXcZVqT3mlKDRxeF+9Jg4ezdjw77IMbK+2bPHsTNEeh54CagORc5Rjo/1YMzNN0
         oUfEOZmPlv/mD4b0HlSQMadGy4IjB7vvy3Ya+yFOEjeuOwLldkJx2E+uTa4xLikhByqR
         v70cqmPbswgTgtqpMXZMsgPqTBm9BRwX5njcaEJB16YCiRypmT/GL5p3elWDEpsZRPuW
         OcfU0nG2URO7wSatBIt7OWNMBH5yoYYMci7UEMiCKm76BvtHN0dq2wk8FgUVxIUjLSqo
         arxQ==
X-Gm-Message-State: AOJu0Yzdy0b9Rg6TN/gfP8cIpLKa0U9e3T8bAIdDC50+8GDTxxqcFsiM
	uk3+bCKjj0is4kxVI/rKctpQhexq70iKnMjvFsvEQ+15qFGi87H5UxLC59py+rlPkeUR2ycA+I4
	/HcQQvZvUTN0f8Ol0r7zAWNdqLDy6gy2M4oA=
X-Google-Smtp-Source: AGHT+IG5BYuv62Yhw/2Nq87QT8/BHBJ04yMioEbsA3ShefkhD/ecPkv4ER6TzdHgJ3/Wk8yb3BtTLyAKLXLYefxFjAY=
X-Received: by 2002:a17:906:d146:b0:a23:493a:d355 with SMTP id
 br6-20020a170906d14600b00a23493ad355mr4304443ejb.27.1706524385296; Mon, 29
 Jan 2024 02:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <cover.1704877233.git.ps@pks.im>
 <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
 <CAP8UFD0p-OqYuTrB5m2uq7BRFko887bKszOLtP5peP-A79g=BA@mail.gmail.com> <ZbDP4ntRqrxX08yk@tanuki>
In-Reply-To: <ZbDP4ntRqrxX08yk@tanuki>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 29 Jan 2024 11:32:53 +0100
Message-ID: <CAP8UFD2ZoV74jx3B_adwYENGtp9fCH_oVjW4QJXTZQJ0=_aeEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] t1300: make tests more robust with non-default ref backends
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 9:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Jan 23, 2024 at 05:15:48PM +0100, Christian Couder wrote:
> > On Wed, Jan 10, 2024 at 10:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > >
> > > The t1300 test suite exercises the git-config(1) tool. To do so we
> > > overwrite ".git/config" to contain custom contents.
> >
> > Here "we" means "tests in t1300" I guess.
> >
> > > While this is easy
> > > enough to do, it may create problems when using a non-default reposit=
ory
> > > format because we also overwrite the repository format version as wel=
l
> > > as any potential extensions.
> >
> > But I am not sure that "we" in the above sentence is also "tests in
> > t1300". I think overwriting the repo format version and potential
> > extensions is done by other tests, right? Anyway it would be nice to
> > clarify this.
> >
> > > With the upcoming "reftable" ref backend
> > > the result is that we may try to access refs via the "files" backend
> > > even though the repository has been initialized with the "reftable"
> > > backend.
> >
> > Not sure here also what "we" is. When could refs be accessed via the
> > "files" backend even though the repo was initialized with the
> > "reftable" backend?
>
> Yeah, I've rephrased all of these to sey "the tests" or something
> similar.
>
> > Does this mean that some of the tests in t1300 try to access refs via
> > the "files" backend while we may want to run all the tests using the
> > reftable backend?
>
> Exactly. We overwrite the ".git/config", which contains the "refStorage"
> extension that tells us to use the "reftable" backend. So the extension
> is gone, and thus Git would fall back to use the "files" backend
> instead, which will fail.

Let's take a look at this test:

test_expect_success 'check split_cmdline return' "
    git config alias.split-cmdline-fix 'echo \"' &&
    test_must_fail git split-cmdline-fix &&
    echo foo > foo &&
    git add foo &&
    git commit -m 'initial commit' &&
    git config branch.main.mergeoptions 'echo \"' &&
    test_must_fail git merge main
"

I don't really see how it overwrites anything. When putting some debug
commands before and after that test, it looks like the config file
contains the following before that test:

---
[section "sub=3Dsection"]
       val1 =3D foo=3Dbar
       val2 =3D foo\nbar
       val3 =3D \n\n
       val4 =3D
       val5
[section]
       val =3D foo \t  bar
---

and the following after that test:

---
[section "sub=3Dsection"]
       val1 =3D foo=3Dbar
       val2 =3D foo\nbar
       val3 =3D \n\n
       val4 =3D
       val5
[section]
       val =3D foo \t  bar
[alias]
       split-cmdline-fix =3D echo \"
[branch "main"]
       mergeoptions =3D echo \"
---

So it doesn't look like it overwrites anything. To me it just adds
stuff at the end of the file.

> > > Refactor tests which access the refdb to be more robust by using thei=
r
> > > own separate repositories, which allows us to be more careful and not
> > > discard required extensions.
> >
> > Not sure what exactly is discarding extensions. Also robust is not
> > very clear. It would be better to give at least an example of how
> > things could fail.
>
> Hm. I don't really know how to phrase this better. The preceding
> paragraph already explains why we're discarding the extension and what
> the consequence is. I added a sentence saying ", which will cause
> failures when trying to access any refs."

To me the preceding paragraph said that we are overwriting the config
file, but I just don't see how for example the above test overwrites
anything. So maybe I am missing something obvious, or maybe you don't
quite mean "overwrite", but I don't see how the extension would be
discarded by the test which only seems to add stuff.
