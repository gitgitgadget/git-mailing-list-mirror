Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81218E362
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075078; cv=none; b=nDLBpLlQcTBKC0mceHUvsVZbY9K+MmjWQwONdSRpFMY8q7kpWOBCw0nG64pM93i4lW4jgEEtfC/ImIZixjn9Iz2wBj5EnDOyvwpyHumGQ0v7HH96U2SOlMUeEwxsaQuX+ZdQoFbn6c3SuN7I4HRanC2z/PbCRNjjRaZ+bEpg7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075078; c=relaxed/simple;
	bh=39HNp3s11k8iTADZMuN0iL0lmaE4jhqfSPhX1neXjt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWE6T9ZfA1GhfU/bzp9bYPZ9wMwm6fOeK5sxqf4WOVLYf0U50Eol254eft41Gzt8alo8l2ew+8yHNShExI1jzmRJrEjKfAGaAm3t0eXwJ63UTzXdFbxARJ1kVsBJu2DzXNjpZ6SiF2PXhZ1rkD7PpDa57p0C1UM6VTKekxtCd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu5Ht0m4; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu5Ht0m4"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-867355d9c4eso103894539f.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747075075; x=1747679875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQZf5vO8Puzu6jh3M5K88wsBAgUhNcGPABMiaO+tDh8=;
        b=Bu5Ht0m4IQ3UUwiS58qIDURAbHkhmGXN1PgdKh4/I1+sYngzg71M72g8pNhghlRI+i
         xfT8dTLrHbrhfGFtvh4o8KwQ14q0yLmb9gQvhxAMxCy1zyotdMWveU6mFzDuqGyLd50e
         UyC/ozsxJrNyEc1boJEpNjqS0Gl6IsZJO1ij8w1qE0hFaagRF0lvwBVh2d10auBvygdJ
         bFHpdLenizxB1wCRVY1mVfmmT6esgBLDO2FLBHrkadLDLLDsUZNaug/R9jyd7ZidBrmn
         fXxiE3StGLEVuWVrwS+83ov1P9nqkMpPKnqNul3ZOgjyU0IQCK6ngFHvKMvZ6jO1sjrt
         fpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747075075; x=1747679875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQZf5vO8Puzu6jh3M5K88wsBAgUhNcGPABMiaO+tDh8=;
        b=SzxNU+F5IQNXuS3cfRV9nwjM7O1OridKuzti68ymvojYg3R2XsrYvwT01vUdBPt7/3
         0oO1bav54F8QkqFTkbVmX7Dpb+g7DhHB+kllciYKiDE2wp009gopd6WbfBwm0AStjmOp
         FQDvbLPS7h2x7dfvL1bws9ioQr5UNggFQAcmfuJJXIbGBoEgo1UEsKdRte4JpGTdZQq4
         GYMKm+2o20JkHT+vsny8GPUyMq/4QV1R0JgAdyZETR9cjfjL0bSn92IPWgIfxJWHLOjN
         dXuuN1i9Eh2+3kuT+W/xYQEiB+QcgP6tT+y4cjzTdyVUy8ub0DZAOgVM6OIdEeyJFDih
         7Hlw==
X-Forwarded-Encrypted: i=1; AJvYcCWY0TkWuYw7fTQhH0DYmH/OoZHK/1ZZ4dpfyj//59dGqAy197mADZDLyKQRA+IQy2J65W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4esy7JnQmgX3ikllpVFpICoAdcR8M5hJnYJm2J8YCIZB+O/N
	hL0/ZTD87UuvWZiuk/YlyDgUwuOXzxeKV5N4eBaitGn/SWRpHtKKyvWpIMTPrO6666yxpYZx8Gd
	oPLaB/WNeQAvzFYmkkqQ3XaXbDTV0WzBT
X-Gm-Gg: ASbGncuY2UsJNMntV3XRLmIZDWitBycX3d6VuAxoWXZoc1wnV4iS+zxW8PN/9yW1chq
	WS2bh8OqeSruwNaT6mYHTEC5p89AFJJ2C/KU9LBEEwht/Ga8h8mAEQqGzM0Y5MWWWB6uuttlJa/
	cbjFnYyp4UIHnYx6iVajgcEOtCm9O8/egF8nVYxVlT9Rqgc1yKmyID42MpBGM14NnY4g==
X-Google-Smtp-Source: AGHT+IFNf0HRZfCZ8XoE9B4m3KpO1+1RHqDrYZ49S1HrgD66eXCh9aeaWZgNZT4FKHeLLvme5uCjgPlAehBDPsusPns=
X-Received: by 2002:a05:6602:1588:b0:864:740a:e81f with SMTP id
 ca18e2360f4ac-8676362421cmr1464924739f.11.1747075075461; Mon, 12 May 2025
 11:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
 <xmqqplgdu5ex.fsf@gitster.g> <CABPp-BEJrkq4A715pV6WY-t-M205oheNABdGHy6HLmrxhNrk+g@mail.gmail.com>
 <xmqqldr1sn0j.fsf@gitster.g>
In-Reply-To: <xmqqldr1sn0j.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 11:37:44 -0700
X-Gm-Features: AX0GCFsbao7pFQVQ_0ITK_BPRGbdcslpv1677hKwwszV07CRVoN0Uc6-ithwpX4
Message-ID: <CABPp-BEP9Uj4o5Hd6w2N8zH3Te7tBkVWE_9ytd6y1vkKGiHZNw@mail.gmail.com>
Subject: Re: [PATCH 0/2] merge-tree: add new --mergeability-only option
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:27=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I thought about that, but I was worried that folks would expect
> > "--dry-run" to not make any changes.  This mode does not prevent
> > writing objects to the object store, it merely avoids it in the "outer
> > layer" of the merge.
>
> I think we have already precedence to call something that creates
> new objects in the object database, as long as the resulting objects
> are not made reachable ("git fetch --dry-run" probably falls into
> that category).  The idea is that it does not make a change that is
> "observable" by end-users (and what "gc" sees is not part of what
> the users would be observaing).

Oh, I was unaware of `git fetch --dry-run` for some reason.  And its
documentation even states "without making any changes" despite the
fact that it downloads more objects to the object store, so it indeed
sounds like a good precedent.

I'll switch the flag name to --dry-run.  (I have a suspicion, however,
that the primary users of this new merge-tree flag will care about
whether objects are created, so I still want the documentation to call
it out, unlike git fetch's --dry-run option.)

> We have "--check" (in "git apply"), which is an exact counterpart in
> the patch based workflow to this thing.  It reads
>
>         Instead of applying the patch, see if the patch is
>         applicable to the current working tree and/or the index
>         file and detects errors.  Turns off "apply".
>
> I feel that `apply --check` should have been `apply --dry-run`, so I
> would not recommend calling it `--check` for `merge-tree`, though.

Makes sense; thanks for the pointers.
