Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82A12E1FF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451988; cv=none; b=koZm8dWv0CzJVwIeph2x8+ge/CtltRYx/2jsrD8aQK2AL/ILVVpYIHNO0xtGAXAyOFa3HDlLy84wBJ1sZJjcOEZTQh3Xt0id4Nmoq7SUZoWwkV0gGgKQnfAOvkVL6tevlNYqk22AeP66nt0G5FA0lsxuUjUuOOaKuRvvbQH1CaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451988; c=relaxed/simple;
	bh=fo6NTlVhtUZ1IQ0G1v0ypDu1t4hCpOPYFdM26RON+Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHBn2G7YKr4C1hloPY7qsbaTaAu6QAElBn1wBU5EG3gOgEy5jQvQJCIbZsq3vmhBvvFzBmcO9rjMvTWjkkSF4rHtr94BNQRZ0C5DPcX/ol/sUgEmNRu39yr/i7xsRB6hJli8C1lrSJ1M1e7HTafIBb9HfNj5EOcbaj1WABKj2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ae60725ea1so2589466d6.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 14:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717451985; x=1718056785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWyjelETxjsME5ladIACsIu0q2DCntUUHBvHQSJR9JI=;
        b=MT/0XRQyja1iHWyYc9FyLulEXCR6xYrqOK8Fvqk4n4xkxDYzr8k0wxt6ztYETyuGl4
         HSzEdkBNzMDh0j5Zd+6TEgORfASRqeRtdhjPlqlKq5qrsq4kLVeoQ8tSswpbTDDvnIri
         oYAo9lyP0Zb8b4PxQGAEUDjjx2FpmAbqR20TbNlRO5RynO2nhUURiraS5JzfOaV5A6po
         /XomXFJRQoR313BpK6SI0cf9pobj7VWYx2tFKYaLO8NVFL8uA6zqPoWcLQEGkA5enNnv
         RqoEQnXV1TfJv+I2Lk+/HErCNJvk9VSgiebZGJ6o2FpDAK22Zup81WubwcdX2d/H0IRH
         5YUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3bOO8DR2xJJXb72pCi+KBGbxl+RtyKIcU/VUf1q09BKgqX++Z3peKXEUiGXXDdPLmpw8O4Waq5b99Tn7JUxmXU0v7
X-Gm-Message-State: AOJu0Yw8DBCBvTiF7iwvPAvD+i39ZoRgBaj8ch4amEtyvmFPPmOpGN21
	Aio0Oig7VqthbAodRFLWnQvFI83nr3RYt33oN2Mwgrzkoed2DghTEIHbfU1+fpI3YZiDouJX+7x
	nNzjo9rr5bH1pQ80RJYyJsVsCzwc=
X-Google-Smtp-Source: AGHT+IEy5gG6MYqDUNlOou68X/sZyNYaoWI9Cp4KCPnvek6sWCY3Kg9rihDwNM1CnjkqgF4+LBQDCkaCElIwVpo58Dk=
X-Received: by 2002:a05:6214:2e08:b0:6ae:d327:bd8b with SMTP id
 6a1803df08f44-6aed327bdbamr97691366d6.26.1717451985087; Mon, 03 Jun 2024
 14:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADg0FA_9shzJKN=dBfnavu5eTDNhbz=g0WP2sehAjSqHP4WFkA@mail.gmail.com>
 <CAPig+cT1pTkKd1A0o_qjP+Oyx+zyCevV8EAg5Ub9guAyd3UjgA@mail.gmail.com> <e0ea930f-3d43-49de-b2e7-c057d95fd7cc@gmail.com>
In-Reply-To: <e0ea930f-3d43-49de-b2e7-c057d95fd7cc@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 3 Jun 2024 17:59:34 -0400
Message-ID: <CAPig+cSzY1YO6KByb3fG0P1jWHbEu_a3s_7QBieDoD6un-MJXQ@mail.gmail.com>
Subject: Re: [bug report] git diff --relative not doing well with worktree in hooks
To: phillip.wood@dunelm.org.uk
Cc: Antoine Bolvy <antoine.bolvy@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:30=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
> On 31/05/2024 22:42, Eric Sunshine wrote:
> > I'm not sure there's a satisfactory resolution here. Your hook is
> > running afoul of the environment variables Git sets up when the hook
> > is run outside of the "main" worktree.
> > [...]
> > The relevant portion from the "githooks" manual page is:
> >
> >      Environment variables, such as GIT_DIR, GIT_WORK_TREE, etc., are
> >      exported so that Git commands run by the hook can correctly locate
> >      the repository. If your hook needs to invoke Git commands in a
> >      foreign repository or in a different working tree of the same
> >      repository, then it should clear these environment variables so
> >      they do not interfere with Git operations at the foreign
> >      location. For example:
>
> Maybe I'm missing something but in Antonine's example the hook is being
> run in the same worktree as the "git commit" - we're changing into a
> subdirectory of the worktree, not changing to a different worktree so
> why doesn't it work?

It's been a while since I looked at the code, but my recollection is
that the hook-running machinery unconditionally sets the environment
variables whenever the directory in which the hook is being run is not
the "main" worktree. This is the case whether his hook runs at the
root of the worktree or in a subdirectory.

It's quite possible that this behavior is entirely accidental since
the hook-running machinery existed long before multiple-worktree
support was added, and it may be that the hook-running machinery
simply wasn't revisited when worktree support was implemented. So,
perhaps a "satisfactory resolution" is to "fix" the hook-running
machinery itself to avoid setting those environment variables
unnecessarily.
