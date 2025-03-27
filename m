Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F364C74
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 05:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743052879; cv=none; b=TQWr5R3pZycgZuUnP7OHGhQSJHgx0CZoNQKFPV+giFjmepviCYiniiHxjGNyrWeTCw6zt+QRuu/4tdHrckZwf77LGNpf0q9RGbt24+A7DNVUSMNsomBgNZGnCf7IbJAtnPzJ+/1RxC5sP3yTXEVSGCT9U78oHedXp2Uq0TyMVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743052879; c=relaxed/simple;
	bh=CEkF5hBcBrG6yM2fuXRZKsJwZ6VBfLc1jIlkjnYt3iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSo3/HTLfXPR1wBoMqqRPRVG9nOAmz6g/6rT9sjWtcupG9L1AsoYSiLaAmBCbKscJ5hzItT39eTE17LlPXFBgf4/vzRthgG4/sNlKrPzx3V+t+0qaoMZIMAM2vB7zGDR0RkT21eSAO0fS4vFxoU3uoAB7TvaSoXjrXA3chTV1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8fa2d467fso929996d6.2
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 22:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743052875; x=1743657675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICnDw1IvrxE0H9EfasILhSr4HmGPb5gC0HupROvirJ4=;
        b=hRrHWcZ4tf18MfMosy2OQ82Ll41FHP+Ij0aYFwKCpvqTlH/dLWkmyhZEdyfvvYS3LO
         7Va4tFhJryVXnVUzXeXlc9vf7WevlxVTwd1v1jYch52CAVN+ppbIKd5B0RCrnma86iJ8
         MLduHb6WkFBzAki8bXh+37smTYxJve50mBkL2bMdeKDaIYt5UTla7UYXjkoN7LAuBOnR
         8dM5heCI1vBRC11NBMjG5bDzgxoMO85Swx8lWpLplGhF8/JRWnMtkGgvHErxBOysnaTn
         jkem90iYt/0vnbsNwx/5JOz4UXO5DwwNZSVB6fWC0DmCRL8E1kPjNWfDGt+SLxzpI+fI
         FVGw==
X-Forwarded-Encrypted: i=1; AJvYcCVs87JavfmDk1spJvAgslSf4tm5qxm+zIxN9Ly8BJIwsxAUW87DWDfmgZzmJ2xwfT9sGcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rLFlXTuXV+qmaz2VmCOK4cyn1NkyIwdFS9SsjHnHiit+2zD4
	sJx8VUtWuDyF2jWOjrq5L6EvdiZ5EMtgW4pHHxEGzQPP+VJxTW4QsnkYVRCFp+p62UUlXmqh2RR
	PtDWPmWIfIfj9A3UVkSeVF5A4EnU=
X-Gm-Gg: ASbGnctgGDh/4RQ3TjQ/Mfd/BPOWXhoOpvSY9qfuzVTT62o6Rhxtv/Ii1p4nKW3d6vN
	aMBLKoNIjAbetti6CoBUmFb2Nz+suHxUyu/g/zRCFIsFApkcW0Bkcn9277t8/BS6NAtSnvuWU4L
	fdJUuFxmVtbzQIw5om72Kpfw0PkLUJfC0zwBMazH9Jr8Nn7s06FDm5rdQDBg==
X-Google-Smtp-Source: AGHT+IEm9D1kzTMBH9A3+8NQbdUO7zz+dSuGOZ9Jyb8Wqm62uGJ+RON8ZU8MMl6FX1ydjyyqymEFbstvvxTEmRmKGNk=
X-Received: by 2002:a05:6214:1d2b:b0:6e8:fee2:aae2 with SMTP id
 6a1803df08f44-6ed238ff31fmr10943666d6.9.1743052874671; Wed, 26 Mar 2025
 22:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <2f6f31240fe6ce5f8efab662af477540a0f966ca.1742945534.git.gitgitgadget@gmail.com>
 <20250326174127.GA2508080@coredump.intra.peff.net> <CAPig+cR+ESNg4tV1G6jbKKeRKABD053qZcG0BoFuQ7aC+1tGYw@mail.gmail.com>
 <20250327051419.GA3042475@coredump.intra.peff.net>
In-Reply-To: <20250327051419.GA3042475@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 27 Mar 2025 01:21:03 -0400
X-Gm-Features: AQ5f1JoUllrIbsZTodZIsF7ySsuF9ZplJg9at2cb3pIiJZ8X-GlANm5YxxJfey4
Message-ID: <CAPig+cTmcPY9XDJcYc8s+O+a78x5vwBXV76tw7+S2wbOaMAMyA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] detect-compiler: detect clang even if it found CUDA
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Philip Oakley <philipoakley@iee.email>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 1:14=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Wed, Mar 26, 2025 at 02:07:10PM -0400, Eric Sunshine wrote:
> > It's probably an indication that I've done too much `sed` programming,
> > but I find Dscho's version more obvious. That aside, your response
> > made me take a closer look at what Dscho wrote and I noticed that it
> > is syntactically flawed, at least for BSD-lineage `sed`. Testing on
> > macOS reveals that this is indeed so:
> >
> >     % LANG=3DC LC_ALL=3DC cc -v 2>&1 | sed -n '/ version /{p;q}'
> >     sed: 1: "/ version /{p;q}": extra characters at the end of q comman=
d
> >
> > The problem is that the `q` function takes no arguments, but
> > BSD-lineage `sed` thinks that the closing `}` is an argument rather
> > than a terminator. Fixing this requires inserting a terminator after
> > `q`, which will be either a newline character or a semicolon. So, the
> > correct form is:
> >
> >     sed -n '/ version /{p;q;}
>
> Heh, I think it was the braces and semicolons that made my spider-sense
> tingle, probably because I've been bitten by those subtleties in the
> past.
>
> I think just "/foo/p;q" works on GNU sed, but no idea if it does
> elsewhere. What you wrote seems the safest.

That's not quite the same, though. The patternless `q` will cause
`sed` to terminate upon reading the first line of input, not upon the
first line which contains " version ". This matters, for instance, if
the first line output by `$CC -v` is not the version string (i.e. it
might be a copyright notice).
