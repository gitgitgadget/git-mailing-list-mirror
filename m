Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B07535DC
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765951; cv=none; b=gN39nAtDH0nMIMXaHPZUjww1mZnqh0Yse13LbylR8PkXW2bnz9IvzoPoPSutyfF3jABbnRup2inRxdBpU98Qg4HYx5O9v7PAjqo8OqvVBATKMmywAmJBpELPwMRJ0HI5B1FzfXfRe8/4FrO8d1o5dpMpDs+KJMS49YF8wHVg948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765951; c=relaxed/simple;
	bh=S2YIIYy38S2kty55/c6fL3RbAy/K97up2j92be+m1Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osQoZHWK8o982m0SSZkm4Vwm9y0sYCzaiZeT4Qn4LKkadlO2AzDScbzpzQ3sNqjP9pzAtv0Al2hSZJ1bWjfruIjIGw5sJjYJyYkBApihnCtmiOwyZHWcJ14JxcKRiri96+aBa5L2q3MfSfpb2Fo1DJYxz5VHZEe1nlbQ4jXXyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9K+JQ2k; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9K+JQ2k"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7eb85e80661so254778639f.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718765949; x=1719370749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn8kYjL54nz04sLpMNrryZMqQ0+4Fuv3vXC/okackPQ=;
        b=j9K+JQ2k6ENtOZ+ncWpRX8xvku0q0YCmAm+Y2NHocp0NOYW1cA3sWtrAtG/cANaK4V
         tQ7L8Rqu96WRJGbWnn04K8t1Emahy3gD+8vwCnkH4XjSEbVqm1n7yCuy/fdoeczsJFR8
         /JDD5COOMiadEEipBw/YzxQCSCt+9kNAcOlWKF2+eQcPKcCdNuq1h7JNOWWG9bg1kjzG
         bh2MS03tlarGgEyU99ZoWX+tQryaV1J3FvZcJUsFAUz8tN3qOJev/rGcv9d+lyiBfGVM
         cKhiB+YUBQnac9K7RNJFYkEW+TB+Y4zEZrPPGdYMaNJG8wXDHGWmGgOkpH+qbxScUHlI
         OSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718765949; x=1719370749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn8kYjL54nz04sLpMNrryZMqQ0+4Fuv3vXC/okackPQ=;
        b=UjZxUiF45C7YRd3j/VoRKvaiEhcXa521KoaaV8BOBL2VuhR41yz7DbAfNtoRxUSEaU
         iN9XwyHv7kPd8KOFnhLVye2x3ko0t5sN/0PdjHHFPYCd3UfY1sRHuJ3bZuF6GVTF2mTw
         pnvA+ogdslHifhLf66LM6QVKcAZTPJouSCW2uuHI/lH7/0CKhGSHTYmB7fdNNNURxBRC
         Db6lwIOBDd/uLIwILiCVfbMUZ03SQdKXrgqlYGeDLaAG2a0Mh7Z2RI7CdCIh6BsRDgM+
         8aAKjPN5CToLFdGytm/QKa75sH/LA7Wy3kB/CDKeyXhgB7+fskvUxq3s0FGoJZzuZ9CR
         3sxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5poKx98w+Do9MfUECgxbN5IQS3hpW1B/yRfNStOOOwU55OgrTNbQG1IjTZPvRktU259A/tUfd8B2cT7zbciouzzp0
X-Gm-Message-State: AOJu0YxFsvvd8/G0x2tnd3zPtF2HfzdSczPFKCdP5EjpsFiU0Z08BF2o
	nT2IA73qoLb6coTda5ODOU9NTTrkY0/TE4xjU9DLv40SDfsISIEop60B/a9q28GnHM1q8zPeZqW
	6byyJilDoJfpEwIGZfZUo6eZajQ915Q==
X-Google-Smtp-Source: AGHT+IGkyQDrlZrRWeDTKp6vN4cYVyP1iR2dn/H5gDqnp0F7BDTQc9h7Czim8UZ6qZBEZ3WLEYr99oWMnvdud26PI84=
X-Received: by 2002:a05:6602:14cb:b0:7e1:e022:9e46 with SMTP id
 ca18e2360f4ac-7f13ee9635cmr157351139f.21.1718765949530; Tue, 18 Jun 2024
 19:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <71391b18c1a711fee1f5aff6eedbd3f631d37ded.1718310307.git.gitgitgadget@gmail.com>
 <CAPig+cSZPC=41w8kG6n5hdSCUC4+jYJ6cM8UC-WCO3Bcmb2iNA@mail.gmail.com>
In-Reply-To: <CAPig+cSZPC=41w8kG6n5hdSCUC4+jYJ6cM8UC-WCO3Bcmb2iNA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 18 Jun 2024 20:58:58 -0600
Message-ID: <CABPp-BHAcXG=C5i0anuAxm0qb0i-i8AcbQXyQ4Rz4azWA0SU1A@mail.gmail.com>
Subject: Re: [PATCH 6/7] merge-ort: upon merge abort, only show messages
 causing the abort
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 4:19=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Thu, Jun 13, 2024 at 4:25=E2=80=AFPM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When something goes wrong enough that we need to abort early and not
> > even attempt merging the remaining files, it probably does not make
> > sense to report conflicts messages for the subset of files we processed
> > before hitting the fatal error.  Instead, only show the messages
> > associated with paths where we hit the fatal error.  Also, print these
> > messages to stderr rather than stdout.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/merge-ort.c b/merge-ort.c
> > @@ -543,10 +543,24 @@ enum conflict_and_info_types {
> > -       CONFLICT_SUBMODULE_CORRUPT,
> > +
> > +       /* INSERT NEW ENTRIES HERE */
> > +       /*
> > +        * Something is seriously wrong; cannot even perform merge;
> > +        * Keep this group _last_ other than NB_CONFLICT_TYPES
> > +        */
>
> I'm probably missing something obvious, but here the new comment talks
> about NB_CONFLICT_TYPES...
>
> > +       ERROR_SUBMODULE_CORRUPT,
> >
> >         /* Keep this entry _last_ in the list */
> > -       NB_CONFLICT_TYPES,
> > +       NB_TOTAL_TYPES,
>
> ... but NB_CONFLICT_TYPES gets removed here.
>
> > @@ -1828,9 +1845,9 @@ static int merge_submodule(struct merge_options *=
opt,
> > -                        _("Failed to merge submodule %s "
> > +                        _("error: failed to merge submodule %s "
> > @@ -1848,7 +1865,7 @@ static int merge_submodule(struct merge_options *=
opt,
> >                          _("Failed to merge submodule %s "
> >                            "(repository corrupt)"),
>
> Do you also want to apply the same "error: failed..." transformation
> to this error message as you did to other error messages?

Doh, I tried to re-read through my patches after making numerous
additional tweaks to try to catch stuff like this, but I clearly
missed a few cases here.  Thanks for catching both of these issues;
I'll fix them up.
