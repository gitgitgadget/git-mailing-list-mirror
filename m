Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AD15F311
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841304; cv=none; b=SAIn7KWrFGAbZ/RfNGrJws5GT9evO6vMKKcIn1YstOPKvUwu913R689eZ4eloiNiM16AA4GRTkw+Q3iMt3yRWSTt/LKfdRlvR5cltZjJ4P4t+ozfOKUdHy8fLfV24NwW+SfLrPQ3JOP1oiX2BcCLsru2m6TBdw9+2Cm9r2FtBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841304; c=relaxed/simple;
	bh=NpypqBZK+hZChB6PQk5xwgNYVY/Lb9irVEM7TFcZa4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P34iuChHIQT2VUszNc2BnTFlFFaLEMq+5yi+9TVVkGzaUK3oEqOK5oNVNInlRjTYvx8tpKJeTV2Yk3HJRpJbVRl9xXn80lfnkbg/0GXutPiEWV1ezyRV+FH8Rjm3fGz/mNALWI2mUNVw/ZpDMLsgmGCVxeaFp9LKdEwX09KT7i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a0ef0dfcso307096d6.1
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 10:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841301; x=1722446101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iqO5t3isdPH8JicjdFDHxdU+QQ35OsovWvxszyakHk=;
        b=XNWbKIbHl31xbPr0+Y3etEMioOT0fjczuSX8pirPYkGrAp8as/nIzcDJyxHwdpisHo
         jKjUsy25EkFhLLxOksA/jW6fZprX1BFC+jWtezw59MUwwJ1Oi96FOCJxsbSHjZZZy7KX
         ePcAxmK+7D98OFiVI+cYpESxeXlP+lNBRooJdemGMQh0BvMSHCTxCLL7M0F8tDs2tC4h
         NTXD2tuh/ymhfI6bYKlW1H1kW5OAa4IhlQs0bRsqcwOy9WNxyDl5xbAPbD0iWYNp7tZD
         eIT3TkMWQvTMKqBNrfBQ5noYySZGp6It5IREuiz2SNh7xgzmfGIfIP5FKoaOJul7YHIG
         JdQg==
X-Forwarded-Encrypted: i=1; AJvYcCVRRTo2SPAM3zrtDJh0yGIpMFIk7k8wwoGufxPeNQgF0c7nH3CFR+bhn6BUFhOU44oCeHVelEwh3C2BXE7ulXknJtoh
X-Gm-Message-State: AOJu0YwkTeDTpt1Ou8PJmnb4w90Nx/v+fPAbeDfXkhJgrzxV94GlW2KT
	VlpWowmGN8foF9UbD39jAlOciD2bf5Xqm0cbL2ePyEamPda+gc6MU80G/b7wVtYWqWlbTefN8vJ
	bvy+8/JaDlWK3uTjsvNJBix4jUBs=
X-Google-Smtp-Source: AGHT+IFsmXl7r/JwRN8Z57SH9DMNtq0ck30rTPx71GQ/BpCNR8h+mD9Jf6/IlksvRT+ZvFN+lPo0ZOsGOhX75oYK5A0=
X-Received: by 2002:a05:6214:411:b0:6b5:e60c:76dc with SMTP id
 6a1803df08f44-6bb3ca0a241mr3517876d6.19.1721841301418; Wed, 24 Jul 2024
 10:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKOkDnMGRfQoNygYLiAxPZB2q=VMYvw8kyu1dM=pM843-FH41Q@mail.gmail.com>
 <xmqq1q3iztmi.fsf@gitster.g>
In-Reply-To: <xmqq1q3iztmi.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 24 Jul 2024 13:14:49 -0400
Message-ID: <CAPig+cSJKA5+iU6TfRZev_b+ePLJ=wRm-8PLw3wKqJYEEonOVA@mail.gmail.com>
Subject: Re: EXDEV when re-init with --separate-git-dir option
To: Junio C Hamano <gitster@pobox.com>
Cc: "Jin, Di" <di_jin@brown.edu>, git@vger.kernel.org, 
	Nikos Vasilakis <nikos_vasilakis@brown.edu>, michael@greenberg.science
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> "Jin, Di" <di_jin@brown.edu> writes:
> > We discovered that re-init with option --separate-git-dir will throw
> > an EXDEV when the target directory is not on the same file system as
> > the original directory.
>
> Yup, it is hitting the limitation of your filesystem.  The code
> wants to move the original .git directory together with its contents
> to a new place, and it makes a single rename() system call to do so.
> [...]
> The code path could probably borrow some code to recursively "copy"
> directory from the local "git clone" code path, and then invent a
> new code to recursively remove the original ".git", and trigger that
> new code when rename() fails.

Re-init with --separate-git-dir isn't the only problem spot. `git
worktree move` also suffers the same problem for the same reason.

> But at that point, only as a fall-back measure, it might be simpler
> and much less error prone to spawn a "mv src dst" as a subprocess
> using the run_command() API.

This wouldn't help Windows users.

> It would make a good bite-sized #leftoverbits project for aspiring
> new Git contributors.  Any takers?  ;-)

It might be a bit more than bite-sized, though, considering the above
points about `git worktree move` also needing such a fix, and having
to deal with Microsoft Windows.
