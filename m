Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435991AC43A
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000469; cv=none; b=t714SDhD1/YY+a3nHfRofILe587zJSpkypa52AdXgUikEeUKfa+hffS8zyukPDtVbEqUgSJhLLNB7XPFHhWUdzVZ1as/QnxIISlGAuhhw3agjD1qKr+PBb1pYt49vxX9tSu5J5T3hLYJJhyi1RWU4YqRmVVB4TIUejPBm/KTpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000469; c=relaxed/simple;
	bh=k0i7GubfgMx87VO1sbTxRyQx/byvG1egTYxQknPOdqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9GaT2kw/cY7WFfSN5f0cbTfPeEynIc4Terh4TcjbZu/t7nKj0PzHhrYXSuxD5yZzj7bYQbvCWj87CCM3FA0G7UJIfkZiVeI0PT+8cHZkKEdyro67DWCZ/XpEs1ap7M76ovd3JGLjVfR8blB7LxDt794feRdGBRf3N8V3u/fGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnSe+lu9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnSe+lu9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae361e8ec32so581011866b.3
        for <git@vger.kernel.org>; Sun, 20 Jul 2025 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753000465; x=1753605265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzRwhN21dly1/t7yXVq07vGRuPw77JJPbSc1QiRVNtM=;
        b=XnSe+lu935QyugNDaLU5/vA/xAK6rUuXhgCMxRNaUaZwdMgZDKUJGjqlSqOZmRJDHv
         lffTa0GsweYTiTkgj0GIm9Y+NyUuuKaYc0n5iMiaQvFHEjUTeouUF50FJnIJPmEdAjVu
         DiX/HAOuYrC+78myb/85dH4FyNA8B+jJLwJlIHwOGkraTptTVxyuaBZCIrOzggcWyrmW
         2fF6E3mmCOsZzcPtIpxyAfy14rvazCEcunrwFjMoozMInu8UT9OLmMwFOvXiaeMmw+7e
         kOVGLgjmG0iwUxxWYwdeKgBV/c5ba2zPiJt/56KII81gy6LBH0Yexq78lyKFl0XBr6Aq
         YOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753000465; x=1753605265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzRwhN21dly1/t7yXVq07vGRuPw77JJPbSc1QiRVNtM=;
        b=RJlapRzcvd+BLS4XLFSvQNSxKtNCwWeLEAZBMqufxQEVYqjrM5+AmLIVY4gRW5X+lT
         /QeEBH5PGsNQllhNpR35wHZtKGbj+IbXUBkkmVMuIq0IMvbu6cnGT86O2NSQDFQM65w8
         DmxJiPgSV8wV3I1zcN+FnK0gUcS3iyCyxSerytnwJPnFh7Qx/RS6B9ATFpyLRtQ8Bxnw
         qlbflqk4JqUN5/NpwR3SK+KvNLBsC/TasQD7lcZbJ7vK1XhZyh3SCgN2xP9My9aDyYJw
         EHFwX+np/MGuOc0Hq+TTGWCm3J5DhOuoSTSd2JMtUhmbj8JkGbQAF6z8dl9kPWTBFvgV
         sySg==
X-Gm-Message-State: AOJu0YyXaGzgDKYD91QrL7EQPuGlaA1eXGkZuBQbenfOAHm9an7sKg9s
	npAZ0i2p7UMweecFQ8fzccSMbgj3EmD2M72KOPFaIlEa7N7kapA/zrtRCPqGRiZ2JSpWrwiCTwT
	sDA7AV2Tut39NrsDVmgsMsvTuW2drDHljrWRK
X-Gm-Gg: ASbGnculWUuK0ZKI5QHUWVtGNDy758m2bS6KNLA6wdg11po3H7vtsZzaACq7tUKssXf
	QESngotQzRf9tivQrcPjbEj2Fyxh3X7lOtiHChPO+vpQpeMyN4/N2dCk4eyDDgLP1x0qyJ9q2P2
	OwFWo7MASReQlx5sqZbJwvZhX8aFNXKheCuM+GusDgmQQ1HVh2hCkXTeqbYNVzUEOBLh35BBP/0
	u+rupQvzw==
X-Google-Smtp-Source: AGHT+IHSjWH/8cUeOkyKfDXDYvLuanK76h8fEUoZkyAbb7fEP1H8hCjCSNvhDle888nSeS8kKRka/c8SE76kXRWY8fM=
X-Received: by 2002:a17:906:d7e0:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-ae9c9b14a24mr1656007866b.29.1753000465075; Sun, 20 Jul 2025
 01:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACy3CeRjyGb-T=hJURJbXXcR+_KtCsRsMzyw0EvusCZOpWb4Xw@mail.gmail.com>
In-Reply-To: <CACy3CeRjyGb-T=hJURJbXXcR+_KtCsRsMzyw0EvusCZOpWb4Xw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 20 Jul 2025 10:34:12 +0200
X-Gm-Features: Ac12FXycRgyercUzq8MSSOu0iB-12Z88t0CL-0coqxQb1fcPEQlyc8l1mQ5XaP4
Message-ID: <CAP8UFD1bwe92zbXHWe-LiMSJZtcTJQwi9mtgNCm-_kTeyFk08w@mail.gmail.com>
Subject: Re: Possible git bisect behavior issue when skipping commits
To: Begad Habib <begadhabib989@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 19, 2025 at 5:32=E2=80=AFPM Begad Habib <begadhabib989@gmail.co=
m> wrote:
>
> Hi Git developers,
>
> I've been analyzing the behavior of `git bisect` when dealing with
> skipped commits and noticed what might be an unexpected result. I
> wanted to share a minimal reproduction to understand whether this is
> intended behavior.
> --
> ## Environment
> - Git version: 2.43.0
> - OS: Ubuntu 22.04
> ---
>
> Steps to Reproduce
>
> ```mkdir bisect-bug-test && cd bisect-bug-test
> git init
>
> # Commit 1 =E2=80=93 good
> echo "good" > file.txt
> git add file.txt
> git commit -m "Commit 1 - good"
>
> # Commit 2 =E2=80=93 skipped
> echo "middle" > file.txt
> git add file.txt
> git commit -m "Commit 2 - middle"
>
> # Commit 3 =E2=80=93 bad
> echo "bad" > file.txt
> git add file.txt
> git commit -m "Commit 3 - bad"
>
> # Start bisect
> git bisect start
> git bisect bad
> git bisect good HEAD~2

When both one "good" and one "bad" commits have been specified, then
Git starts bisecting, which means that you should then see something
like:

Bisecting: 0 revisions left to test after this (roughly 0 steps)
[df357f37981b7f1e804684cc09842d02fd012146] Commit 2 - middle

and Git should have checked out "Commit 2 - middle", so HEAD should
point to that commit.

By the way it could help if you could show git's output when giving
steps to reproduce like this.

> git bisect skip HEAD~1

This will "skip" the commit before the current one, so "Commit 1 -
good", which is already marked as "good".

I guess this is not what you want. You wanted to skip "Commit 2 -
middle", right? In this case `git bisect skip` (without any additional
argument) to skip the current commit is enough.

> Observed Output

(Note that I see the output you show below only when "Commit 2 -
middle" is skipped by the previous command above.)

> There are only 'skip'ped commits left to test.
> The first bad commit could be any of:
> <commit 1>
> <commit 2>

I am not sure if <commit 1> and <commit 2> here refer to "Commit 1 -
good" and "Commit 2 - middle" respectively or not. To avoid confusion,
you might want to be explicit about what they refer to.

Anyway when I try to reproduce, I see the hashes of "Commit 2 -
middle" and "Commit 3 - bad" which is what I expected.

> We cannot bisect more!
>
> This output is a bit confusing, since the bad commit was already
> identified (HEAD, i.e., Commit 3),

Git's output talks about the "first bad commit" not the commit
currently marked as "bad". "first bad commit" has a special meaning.
It means the first commit in the commit history that would be "bad" if
all the commits could be tested (and thus no commit was skipped).

> and the middle one was explicitly
> skipped.

Yeah, but that doesn't mean it couldn't be the "first bad commit". The
git bisect documentation about "skip" says:

"However, if you skip a commit adjacent to the one you are looking
for, Git will be unable to tell exactly which of those commits was the
first bad one."

This is what happens here, and that should be expected. Git cannot
tell between "Commit 2 - middle" and "Commit 3 - bad" which one would
be the first bad one if all the commits could be tested.

> Including the good commit (Commit 1) in the potential bad
> list could mislead users into thinking it might be faulty.

That's not what I see. I don't see the hash of "Commit 1 - good"
listed there when I try to reproduce. But again your reproduction
steps have some issues, see above. So I am not sure I reproduced the
issue you saw or not.

> Question
>
> Is this the expected behavior for skipped commits? Or could the output
> be more accurate by excluding commits already marked as good?

Commits already marked good should be excluded but maybe if you mark
them as both "good" and "skip"ped there could be some issues. Anyway
we would need better reproduction steps to be able to debug this. And
yeah I also tried to mark both "Commit 1 - good" and "Commit 2 -
middle" as "skip"ped, and `git bisect` still seems to work correctly
to me, especially it still say that it cannot tell between "Commit 2 -
middle" and "Commit 3 - bad" (without showing the hash of "Commit 1 -
good").

>  Thanks for your time and the amazing work you all do on Git =F0=9F=99=8F

Thanks for the kind words!
