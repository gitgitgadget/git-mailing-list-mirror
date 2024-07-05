Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8032613ADA
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216070; cv=none; b=fw76wuBge/9ktSjgNL90KAKpLwSGsiuZfzcM5ASUGK0u1E964xvqNlgUynSVM4cGMSVfJzcBsXdDCL3f6L/sskTDLCzmblI1CyKD1crAJ2Y4qnZyjgB3rwXhI928quDbcPozrbQ98b9rNvCOsVhfG9k2mEXvV3mWWweCgvuKOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216070; c=relaxed/simple;
	bh=SUR5K3ixWqfNT13Fmd67lxGkn+JoJwYCgPKSbnDEH1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j89TSN4wgs6r9tCPmbtV6bV6mdvD8pIZzEOV0KoHv3OFqP5Oryaol6CfwYQJ+o78Sx4LGw2SUSoQoJkd2keTunplgg4XXjORqQp8FUBYTE8VoCJtvLQg5+mCfiEX8gHIu5SmwcOE9TweVT6vCnPmUmLxBI8MjzIVraZIYyFfhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6a3652a732fso8869886d6.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 14:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720216067; x=1720820867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8JkKr1IUbNGXYHhj3qzwSMMHiANejrIZV3Nwa9XNSk=;
        b=JSUKD6KFC/X+KMHPZ/U0i2hGdKVxlimURAs3sQBqQDwtLYwC92g8lPOSXmqnZNfh1U
         Gks1WIhg1whh7HiZy2lCTlI6IiH0H2IduwvYdIviyblBMz5cT0MRgBBDqa4MGNOL6PrD
         v8/0gJ7YRwDGHbE8T0j2I9myQmLRDBtG/v17r4oJu5fZ+qlAMojTHHl3Ejj2ErynzOGB
         tHnwsuxkuR6bXqWonvjcI9CS/0flwOYvdRm8zk0mdRgFNwKgLP6RbPhePTX1mWPFW2gg
         zjxSdrXq6XEYF1X2vJmtXLo/Tco7+XR2vjzDyZy0tHeZkr7Hl6YLczfK9hnvULHfzUjQ
         3cAQ==
X-Forwarded-Encrypted: i=1; AJvYcCURXzl2AM9IA70FqKUufdnN0J48xnGgTCi6hfsNTfNV6K9Z+ml78rKPF5OcuDh+Zq6YQA9+GhWKehQbFoo8Ezu7P3+z
X-Gm-Message-State: AOJu0Ywy5tRrVPYMJhRyn+zcsghj5oYcAEXax7Vk+zHUfp6z/boStKGn
	YG6lVa3FDk17+kIULmtF/7QujJEjgeyJTXkbHnzp7hMYXx2U8fHyUacZ/7s8DE+7y122XFbQpx/
	ywM/cd5aiyXa+l+PtnVtwQ78n4ds=
X-Google-Smtp-Source: AGHT+IFMLUFZ9/LYwdJYaMCOeOAN8K9uySiyLuWBZJfw/xU/B6VLZYj6wnBfpXMexzYqWSZ4FKZWGP+XDeKXVfURUG8=
X-Received: by 2002:a05:6214:cae:b0:6b5:24b:f430 with SMTP id
 6a1803df08f44-6b5ed025346mr66945476d6.40.1720216067408; Fri, 05 Jul 2024
 14:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
 <CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com> <m034onpng4.fsf@epic96565.epic.com>
In-Reply-To: <m034onpng4.fsf@epic96565.epic.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 5 Jul 2024 17:47:36 -0400
Message-ID: <CAPig+cS2r-b22ikZZ6QHpzfneQ07n6s=E40Sb+QYmCnezVFAww@mail.gmail.com>
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
To: Sean Allred <allred.sean@gmail.com>
Cc: brianmlyles <brianmlyles@gmail.com>, git@vger.kernel.org, 
	Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 4:56=E2=80=AFPM Sean Allred <allred.sean@gmail.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Fri, Jul 5, 2024 at 3:23=E2=80=AFPM brianmlyles <brianmlyles@gmail.c=
om> wrote:
> >> - Have git-gui create the commit in a way that causes the message to b=
e
> >>   washed
>>
> > A patch to make git-gui strip comment lines had been previously
> > applied[1,2], however, it badly broke git-gui when running with old
> > Tcl versions, such as on macOS[3,4]. The breakage was not
> > insurmountable, and a patch[5,6] was submitted to resolve it.
> > Unfortunately, the then-maintainer of git-gui lost interest in the
> > project about that point, thus left the issue hanging. Thus, to this
> > day, git-gui still doesn't strip comment lines.
>
> There is a third option -- new plumbing in git (a la
> git-interpret-trailers) to expose the logic of `cleanup_message`. This
> comes with some nice flexibility, but introduces complexity around
> transferring state (e.g. passed options to git-commit) that would
> probably be best to avoid.

Could the cleanup_message() functionality be exposed as a new option
of git-stripspace?

> I haven't looked super closely at the patches you've linked, Eric, but
> it seems like those are specific to stripping comment characters. As
> I've noted elsewhere[1], there's potentially more to strip than just
> comments (like patch scissors). I suspect the only paths forward to
> guarantee that message-washing happens would either be an option to
> git-commit to explicitly enable it OR (probably preferred) have git-gui
> invoke git-commit with an appropriate editor instead of using -F.
>
> [1]: https://lore.kernel.org/git/m0h6d3pphu.fsf@epic96565.epic.com/T/#u

You're correct that my interest in the issue was strictly due to the
annoyance of git-gui failing to strip comments (in particular, the
list of conflicted files automatically inserted into
.git/MERGE_MSG)[*]. The subject of patch scissors did not come up in
the linked discussions, and it wasn't apparent from Brian's message
which started this thread that he was also concerned about patch
scissors (his message mentioned only comments).

I responded separately to the message you cited above.

[*]: https://lore.kernel.org/git/CAPig+cTQaPTNnGcd583B=3DxoVUR1qPb372Y_x9sz=
ROfMcA5h+tA@mail.gmail.com/
