Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E550249
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765936; cv=none; b=p9pGE1Hp9RsoTtOpQnLbV6y1ynC+mrxwn7/J5JNU137/XgQV0ZoLxAkkrB1plNSgZjYjdbno6rdJoao0zeMVxX7sJVmFrlPj/da6bhHKB+a4IcKtYQGvChf/lvo/Z8Z8qIENJZeozb5mRgIWszdYpPB4guoWJ1ImfdxoX2VrQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765936; c=relaxed/simple;
	bh=qiZUNQk8RlylIs3aw6DBZPyQWnIWvIxvx+XMu5anW4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewdawPZ11XZlnBdOH3XEnItORZjMMKoq4gU3/OPIO5mXmA0K3btZ2Ohuwd8rIyog+PUomL3+ZNN+pf/cPdEgPRhrW2+d5MSE4E1khpetQ+oSwDIzQfiHmAn9XZhZ7gUee4QqMEKtgj6HgKdJrpl8BQVXQB4sMU4rPi5ugzCpTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3ZGPEiE; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3ZGPEiE"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ea0b5e0977so287214639f.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 19:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718765934; x=1719370734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWhEmcXYmVOVupqL2wC4AlsgBJcrSB19YnCJa2iFURs=;
        b=L3ZGPEiEtm9RfStPWilG+iCXCmwjj0HCyXOi84wWDk1DlrHOVoon2Cr3TO/0lANXlk
         wQxbt0b2/aFnifuEz5p0HCSXO+/zRhxWoJznaE3BAAw/oftobaa6eXnPSKf39BjYTDAv
         N5JDxd9zoudG5R/526EnZgJs6fwZgiblXQhAqqcd/r09XRBEhsccW5X0CnP3RWpzGWuk
         avMzSPt35OQsxak/osGCTSmGGZbW56bg2iBaRb4syDO73r+SQRyBRdspiB7tow6piTLa
         fqcpF/AOSqy0nnbftOfJtW4f6fzJoPwg7XyeM7VJxn8b7QPjwUXtfdSR06SpkGpTOd2t
         pd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718765934; x=1719370734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWhEmcXYmVOVupqL2wC4AlsgBJcrSB19YnCJa2iFURs=;
        b=iAQ1RefCcoz6tEakWcpyT/FC3N+bYJmpGGGb4lwXVIOsUimH0/jtUK59ndyUtsCs7U
         Jg5V4M5kDdneOFoyyGvKMb/CkEEp1JtRLtOMKhbpZgFP2+YzGx42Jqw8tU1/zLx9ihCt
         Mo26QIITWCnk2M+RVFD0ZaE0Zbq76IBKkHDpfZT/tsK2iwZiwNinqGg1kKj8itFGjTW4
         p1aRJZCpPtIxJepeEbOODG2KplLvOx0cdy5+bONvExq4wF+cAW9M2zhuyewbHUVd38vN
         1mXCioECK4y77Z0V6ePqQVrZprB6Ozg8p+AYndQoRLhxcXszgBAZHf2cQnStNXC/C1hJ
         6IMw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Zs9aR0ohlb0wzYFkpDWcHiKph1wSNZqOmwqHfTBkBP0poSvaUTfsrBRbOGygt+KFXzLvgG3gLmxpSAaCrT763u/6
X-Gm-Message-State: AOJu0YwVkvLmkyuZwwfRVMRCrTnU3OzhENuRYbUkPH98fH9upInL0VWR
	ybnTk0QA9tZZHLiMm+1lAWhPdW947Oo/2RbqqxHawQ1mU195I5cGzj3eg56EBJEwLW+yqF9nh9C
	Ff5LxR4cwr14uSUrZdkiFTvsyTwU=
X-Google-Smtp-Source: AGHT+IGejzCwebXuPruM40jZ7lX62DyJtdw9qucblbSNXg3z8v3QFhPeV8Z33VKlqqrEoOfuONYnhiRWdzmfIQTD/8g=
X-Received: by 2002:a05:6602:1685:b0:7eb:8c69:86cf with SMTP id
 ca18e2360f4ac-7f13ee80225mr198768939f.18.1718765933848; Tue, 18 Jun 2024
 19:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <17c97301baa829a993cf8838deb9271add5bd1cd.1718310307.git.gitgitgadget@gmail.com>
 <Zmt5tiuGIpTHLHRC@nand.local>
In-Reply-To: <Zmt5tiuGIpTHLHRC@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 18 Jun 2024 20:58:42 -0600
Message-ID: <CABPp-BGhWkjdd+9oa_RuUA07exVRtMHWqg8Ri_Sg1twUBkdxWA@mail.gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: maintain expected invariant for priv member
To: Taylor Blau <me@ttaylorr.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:59=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Thu, Jun 13, 2024 at 08:25:02PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > The calling convention for the merge machinery is
> >    One call to          init_merge_options()
> >    One or more calls to merge_incore_[non]recursive()
> >    One call to          merge_finalize()
> >       (possibly indirectly via merge_switch_to_result())
> > Both merge_switch_to_result() and merge_finalize() expect
> >    opt->priv =3D=3D NULL && result->priv !=3D NULL
> > which is supposed to be set up by our move_opt_priv_to_result_priv()
> > function.  However, two codepath dealing with error cases did not
>
> s/codepath/&s/ ?

Indeed.

> > execute this necessary logic, which could result in assertion failures
> > (or, if assertions were compiled out, could result in segfaults).  Fix
> > the oversight and add a test that would have caught one of these
> > problems.
> >
> > While at it, also tighten an existing test for a non-recursive merge
> > to verify that it fails correctly, i.e. with the expected exit code
> > rather than with an assertion failure.

It turns out my logic here was faulty; if a
   test_must_fail git ARGS...
command is run and git hits an assertion failure, the test_must_fail
will fail with
   test_must_fail: died by signal 6: git ARGS...
similar to how it would fail if git were to segfault.

However, I still like the idea of testing the exit status here because
of this comment in builtin/merge.c:
    /*
     * The backend exits with 1 when conflicts are
     * left to be resolved, with 2 when it does not
     * handle the given merge at all.
     */
and this is one of the few tests in the testsuite where we are
explicitly testing a case where the merge is neither success nor
conflicts, but failed-to-handle.

> I suspect that this test was flaky, too, since if the assertion errors
> were compiled out and it died via a segfault, the test would have failed
> outright as test_must_fail does not allow for segfaults typically.
>
> So I'm glad to see us tightening up that area of the test suite.
[...]
> > +     test_must_fail git merge base-b &&
>
> Here and below, do you care about the particular exit code of merging as
> above? IOW, should these be `test_expect_code`'s as well?

Both of these comments led me on the path to check something out and
discover my error above, which will lead to slightly different changes
to the patch.
