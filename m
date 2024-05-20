Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABE481AA
	for <git@vger.kernel.org>; Mon, 20 May 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199097; cv=none; b=Ym+P2ZfOZriEPr+Npum+n33+H+w9ypWRYn+0VOXe1FAwYSsDBe9MkP7wDbeMMQsgT8dAZB7Q3YfGfwnDzKT9gt+PInzgdJLWo9FcTt7QxYhGL33XQH7bmuejZwC3lSGKk1+okGBACao78pHc5x6l0Lfqb9EtHCaV9Z1WL/3QwT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199097; c=relaxed/simple;
	bh=QP9ifzrau5mJ9EAbyz8Tz+Y34fP2bc6Od9ZZCP8Rhhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g72yxCB6OgtFCKxGeklBNo/wldTxwzhnBrY9z4LyjvLY/AD5ntzc6gMhxGLGfiqe2geixF3druCzW2qTQDsyhc9NhXAnQZypMh+mVIAR/dLs9jcOoELfP5NG3D78qKCSglgELN6MXkLPg4NZuvF4X0CqfGKAzk7AwQq6J2m6JYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-deb654482bcso2321050276.1
        for <git@vger.kernel.org>; Mon, 20 May 2024 02:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716199094; x=1716803894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrmQdbye8DZ/iBMMX6B0CtmQc5Ab/3ht11Fzhm6Nv6g=;
        b=cAQ9LPMLNM9u+8qW0wobt9owfaqjCsmUgSbflvZ4UQSuA3kd7thJTheQUnDMtKmXc5
         mg5y3P0SnL4cdFmUnFp2AXFHyFhygzVr/6SThea0ija9kIrDiOFx/xaKO2bvLLTz7a4m
         FfQRR8OzDrY0/HpR86z+ftMU6Bj/qgriKEUGUdpTyeq+cPQiJgZA8fUqhO/oY9cDC1ht
         U3tj+/nUTYwvTa5qz+A0O7us2y/YxVTEqfJDuJSDA32DjE6bGhAuoBGTwP949Bz37MBy
         6LDYw8AHkzkbc7I+7EdL38c3/MI+KjhKFtnE6RriDIwiseO9+IjugG5LQOXkZOE3FY55
         42kA==
X-Gm-Message-State: AOJu0Yz/s3jt+VABpCHtMAWYf+2cRa77ATKS0rZb8B++dXi2O6uqIxbr
	xr4YEXa4taBzIhs/MaCgCjEHNg/imgPbAcxPn8TPXtpLWt0WdI3VGK25ZzaHEOQhgAMb5NeM83D
	gB/S/sJjj33Fs3VWlP/ljR4+pTKFjmA6i
X-Google-Smtp-Source: AGHT+IG23hko7Aql8hg881EgR3tkiE7nC6MwNRSXMPQdbNQiZJ98zlaujMlLOWRWFwPZKVMIUsBAUdltuXDimhWYBXw=
X-Received: by 2002:a25:ad95:0:b0:de6:107b:6557 with SMTP id
 3f1490d57ef6-dee4f2e424bmr25963401276.27.1716199094400; Mon, 20 May 2024
 02:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
 <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
 <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
 <bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de> <CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
In-Reply-To: <CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 May 2024 05:58:02 -0400
Message-ID: <CAPig+cQLsUTpjiZ_TXh2GJAS=tJScUWYxiuR87rtwdTu8H9PXw@mail.gmail.com>
Subject: Re: chainlint test failing on Linux sparc64
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 5:36=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> My suspicion is that "actual" will have size 0 for you. If that's the
> case, I'd suggest running the commands from the "check-chainlint"
> target in t/Makefile manually one at a time to see if you can figure
> out which is failing. For instance:
>
>     % ./chainlint.pl --emit-all chainlinttmp/tests

This reminded me of an earlier report in which chainlint.pl was
producing no output for "actual" on Linux for s390x processors. That
was due to /proc/cpuinfo producing results which the script wasn't
expecting. It was fixed by 1f51b77f4f (chainlint.pl: fix /proc/cpuinfo
regexp, 2022-11-22)[1]. At the time of that patch, I noted[2]:

    A separate problem is that chainlint.pl doesn't fall back to a
    sensible non-zero value if ncores() returns 0 (or some other
    nonsense value). That is, of course, outside the scope of the
    well-focused problem fix which this standalone patch addresses. I
    may end up submitting a fix separately to make it fall back
    sensibly.

which probably explains the behavior you're experiencing. To fix it,
we'll need to see the output you get from:

    cat /proc/cpuinfo

[1]: https://lore.kernel.org/git/pull.1385.git.git.1669148861635.gitgitgadg=
et@gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cQ6_7wf6C280Rqi7mcTCiQp-n5GiLWTPazfc=
UcGFeZi0g@mail.gmail.com/
