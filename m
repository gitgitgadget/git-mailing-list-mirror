Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60D2DEA95
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526562; cv=pass; b=VuapiSOrY92e4CG4OocBBsufWNKm67vHwISNIPAFInOVwiX3iRyrgcdUk4v3moC+tkRiKXhcNSsZNHQrAZFBmbbhVqe1YOx9iqLfdp1tUYkr4eSov6wuk6ArXkRHAk+D3KuvHL0MOp8iHHejDgqaokvN2ITNqsavJYirtTZVufU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526562; c=relaxed/simple;
	bh=eOJFMoCFsmFS8YX1wj9972bbxOiVHLo4J9jN4XmsNqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF3wk1NSqWEGn6+qSL10Uz/IS0YNDX0AZi0Kco/GNipWQEaaPYlaTcVhMNarFilBtbdvPkNSDQYHm+8A5z5z2RWc1E/XIh7gHQ/gtD5pOntb75JwSbdKu4fsvegjnZ71YXUnh6iWxojRuCZ8oA30fG1nW0Lg6am06lCyNTcjCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8e6dw6I; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8e6dw6I"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4638e6bb8a5so426856b6e.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 10:42:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771526560; cv=none;
        d=google.com; s=arc-20240605;
        b=JIq65j5ingLkTmtV+3tQNAGenABO68CbfUdeJet42HvmY3egnwUBj8HyCiKhQJbnRh
         hFpFz4x11WkhScPofZdd7WFgRw9wSu6h7owIdmc06fjCQHzFzXhXqj9SaH9DkqG+J0d/
         9ffq+xff6RpygGPQLH7UGhua93/htu2FQLBCq77XSwuzvvxF7KEfdZ7AxzP/ozAW3LFu
         GvwpxB7QpD7zSh5/0tNt/bfLjJ5FF8PRATmIoS1DYIKsk8bISIg+X5Vw4xUHm/bvzXr/
         K2gsS6EwvtCwl5Sz1IIXcOFiX9oGy62IBglduBsttNf0REU1cQCaE4V0J4+kDHjvim94
         sZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tTSc1UMikyGpDcvSG7HXCh1I2ZFdDRRK6GHQWHSUBCg=;
        fh=ghs/qAh3AusF5QVYXwgg9DtUY38ECaVVIqXD+Qn48Hg=;
        b=JOUP6ivAaf/4Vsb0x3zHpHP/qucUpwIcd2YhIRTEORwpeQwPU+9IS0f4fX8OEBvQ36
         bn9ZTOL1oOuoaX9spuV7c5EwVBJMUyd4YtSKrLXNKnN10s3roPo3Xbc3CLcIZK4n4IaA
         Hj/naWov0cT6uclAmLjerHSej/Y1Qq6ITQukmb6e0W7LaM188KgHS5BSgQxdAbJEkIOc
         B3zGKL5zDSOUXaN1J6sscDNkZvebZFEa1idzzGb68CBX6Gy3EMC1KjZr5ng195vearap
         Nig/dQLZQye4BJBhenpxS1950lZpMBfmtNZIrkXg0fEpu5+CUQmQZ8OjBKr3nIB9XI4v
         LFkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771526560; x=1772131360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTSc1UMikyGpDcvSG7HXCh1I2ZFdDRRK6GHQWHSUBCg=;
        b=j8e6dw6IRtJXn3EYeBgPPaAAXMMQ0lxWo5HqVaCuIX+JflVJ2XJ2JHkzvAoyKl0Ouz
         u9uSnG1q0q4bDykRmo50/CASZ1TjOxqn0p1nvlnfV9R06vBmz6lvwkcdKdAGuZVDFPLu
         XB+2+n2t8t6d8YN4hEq++ibYGziwAghg7Cfi6kQv7bf1R+gpoZwW6lej6+DrqnsSJbma
         0AFjP4/djoTHDLbOA3u7qbHhVmUwkaAprDf3YGodtRBWqKg0ioGlxLdlyUoExeO4IPVd
         7kHm8FjwKGnHaUQcUoCvq4DoKrNvoAYUR8bcBblB9XTvfOnErgCGne02EtBwKYNb3jrN
         ivig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771526560; x=1772131360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tTSc1UMikyGpDcvSG7HXCh1I2ZFdDRRK6GHQWHSUBCg=;
        b=dQuY1S1NNrMBYZHW96zTk6Iv+Hk2HJoiCmKuorLB7TWF3rrFRFaIkFSZ34F5S52fw5
         MLXneZPoJaUqVAa1pH188sfJL49Lj3vHZUwCTQ6zVoAJSbmlCZAsM1HeSae/eA1pB/2X
         mNVzDsbrmXOQZhECUwLcgmdAdUgh93TYcdRYAhQXocx8RBPd+1tHzf8iHxLyz/JdMnzc
         s939rNkenWxEPmR5LuXeR7wNvBx2054eHl4/KSr/OEazyHz5CtDD0Z2G2LEp9bnQv3AJ
         40shXsCAfCQYI18icORTpp3rgga0HUh5TrKuZJ1OMr/4jkJyAWi3KFfXIW2FjkfrYhsD
         TN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSl+stvw31EjEab0rC4LZcGgRerDbvBr2u6kBtafgMZ4AHfJZLqJjTm2OwCJhyNzkSIbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZKGN9JSN84JOGNhnJSUC5EqaVIfSGu02hiwDgE1pXLnNorYY
	FfwEajkybmwPucD1kIKVh795uBiM4sudZo0rJzGG+Wn199Ik8ZSMtqMpLFaMN/bvymyXazVgCB1
	eHcL5YoeKI4boQ9+JjwWLK/idvGJlD+Y=
X-Gm-Gg: AZuq6aJfGGpbPy5PogVMeqBgMtaef0BI5PW30jeu6tFyZJX16U3chEh3vmtUTzt+NBb
	IcmojEH04EzxfmUDs14pnRjpjvH8uPpbijMONf8NwGJAwu/6ovGmHHQhIlOKwc5lpke6gIKrB2S
	cKXkZeAUrOnx2TTv26xD9pMxzPc1g5Q59yMYeCbV/U2NURqchSlk6oIfhX6mQLI6YHESH0rKIJd
	RDZmw0CwauT/M7uEDjIkktHxWi1ykzlp5jGLeuz1S9yiBdGFJsqCMZBeMgB+jEbDQKq+n9Nnzj0
	tRmYNhDho+4OV6XfNa9LuD925/y928J0CE0C2Gd4
X-Received: by 2002:a05:6808:3509:b0:45e:d111:42bc with SMTP id
 5614622812f47-463b3e6913fmr10392512b6e.13.1771526560114; Thu, 19 Feb 2026
 10:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>
 <aZcr7DiIteTS9udR@pks.im>
In-Reply-To: <aZcr7DiIteTS9udR@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 19 Feb 2026 10:42:28 -0800
X-Gm-Features: AaiRm515WpEyMkenJCJCnBp17KKQxkpBIvn9VfcXJKQudw-bzAV6myz64u1WIaA
Message-ID: <CABPp-BF5jLfsndbinaPO_18fxvdUuVOYC8j31==jMXwK6iP0QA@mail.gmail.com>
Subject: Re: [PATCH 4/5] merge-ort: prevent the_repository from coming back
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 7:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Feb 18, 2026 at 09:15:14AM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > There are two things preventing us from removing our usage of
> > USE_THE_REPOSITORY_VARIABLE: one necessary use of the_repository in
> > prefetch_for_content_merges(), and the use of DEFAULT_ABBREV.  We have
> > removed all other uses of the_repository in merge-ort before (multiple
> > times), but without removing that definition, they keep coming back.
>
> Unfortunate, but I think it's okay to be pragmatic here.

Yeah, also full disclosure: I do not know why
prefetch_for_content_merges() needs to use the_repository.  When I
introduced it back in 2bff554b23e8 (merge-ort: add prefetching for
content merges, 2021-06-22), I was just looking at diffcore_std() and
trying to mimic how it did the prefetch.  I don't actually understand
why the comparison against the_repository is there for either of these
functions.  Maybe someone else knows and could shed some light?  (cc:
Jonathan Tan for the diffcore_std() case I was copying from...)

> > diff --git a/merge-ort.c b/merge-ort.c
> > index 40a11dca73..ae19118550 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -53,6 +53,8 @@
> >  #include "unpack-trees.h"
> >  #include "xdiff-interface.h"
> >
> > +#define the_repository DO_NOT_USE_THE_REPOSITORY
>
> Do we want to have a comment here that explains why we do this dance?

Sure, will do.
