Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C91B85C9
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614804; cv=none; b=MLTpp3ueHuVVnlTZ66KtkR4+DVijrYEzwiFzTAPywUx/sPZtsbtqHOEZTy1ckU0ttMhsgPe0owkvCnMgcMz/V7vxwjnn3oOUpFj27Odz4HFE1xMfDzbB/MaQ8reXJZap0k3voPOkC/UuSbDMOYayTKPpq4SHo7j7Zn5v21JcS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614804; c=relaxed/simple;
	bh=sxfhxPixS7SCmyVBFSI/pARit2hBvxsrgNJzmuegdWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgC4xxZfU7rYHmBqpkunEvEbgCkL4EG34Uzzzo5aoW0HgppmPI2rKuljdZ34C60/KDwHnKQbWLeuXzd+HcbEBd2Pbo5hDL8y+RWKoASdt+Sp0mebeQWzELYsJh1CMr7jKkIQiVniDD7DcGREcVSMkA4cT2HYvjdAK4z/GTul0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kMEmYd3T; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kMEmYd3T"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e59a9496f9so66032627b3.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729614801; x=1730219601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sxfhxPixS7SCmyVBFSI/pARit2hBvxsrgNJzmuegdWg=;
        b=kMEmYd3T3/EFgJFh2Eb5hsyHd8xwa/U04U/DYA4/dpt/NUdjExjT855nFdNHL391NF
         P+13wuMM+CVdciiYUw/CisJqf/ngB7KV4qeQ1bhXFqux7bRgssgdWS5l0KTi4FWFtubu
         dvjF2M3eq+R2Zr3DmGKg7psBF3lV7n18FVp9gKWGqLRhj0vS4Q+VzwzY89Vdx30KWxUO
         k6SQ8b1bcrqwwLInatlG9B3SU/FhmfOxq2Mkalc3NIc7q7w44gFNJDJjyTCMZ1q1jyaB
         FTKerZtOBbJ5tIBIJb8ZS1xTI1n9aPXT6kTC5MdYs7nTV2fsOji2ukBbELo1KohVi9GY
         s/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614801; x=1730219601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxfhxPixS7SCmyVBFSI/pARit2hBvxsrgNJzmuegdWg=;
        b=Byzqk3Vx8gVL+zSIdKcgB2gr7EeGAUmTnJRKfOpmkV9l3W0hA2jm4JqYZyIfxLvdVO
         mwXSI7lCNTAS8a5qGqAeRN3FlrEp4NhTK2Wd4jLI2iQGW+e/J5llC8nWjEzN/jtqZXaU
         9yPcQD4ppEyBSBNdyhAYQMLfC36jWdb3aL4nzxSf9QZUwJ8ch3xLc2vt9agfoUGmW3kF
         ZTwNoY5SWyuTAEoPVhBGBa9LyShyEa48FvKQ7d+y26LvXuRU2N6GCBU2FdjVlYK6dS/H
         oK+GF1PCJLSTyUlPFsAza+8DECglfzGVJBMVWkD48Xf4cFBqvx3YAp4+T0h5WYjBjp3O
         WPig==
X-Forwarded-Encrypted: i=1; AJvYcCUH0ogX5bPjVql8whMnkzLgf8h0p/RRUvJOCbzhDpwD7R4bI6ddl8K5FKlsopq74RMg1M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6taGuB1MVleahlXKjj13qJzPWBNKGp6YpTQm3j5Yu6m4yB6hH
	3EfdgEo5MXT0ayT8O3VeFERbUVDPKoUb2Nycs8OC0O/QTRuf+aJeRyYpxl0rmec=
X-Google-Smtp-Source: AGHT+IHrk2TUB8NB/T5B2XdxmOLV93N+UlodlX6ja8PysyBpgu4/4iPSnxDR3IErtJaCsxIncRE3eQ==
X-Received: by 2002:a05:690c:dd1:b0:6e2:ad08:491f with SMTP id 00721157ae682-6e7d81ceeecmr34650017b3.7.1729614801617;
        Tue, 22 Oct 2024 09:33:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5cef92dsm11371557b3.113.2024.10.22.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:33:21 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:33:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Calvin Wan <calvinwan@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Enrico Mrass <emrass@google.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: Question about `git gc` locking files
Message-ID: <ZxfT0J8FokQhSdQ2@nand.local>
References: <CAFySSZBCKUiY5DO3fz340a0dTb0zUDNKxaTYU0LAqsBD2RMwSg@mail.gmail.com>
 <ZxeilMDwq0Z3krhz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxeilMDwq0Z3krhz@pks.im>

On Tue, Oct 22, 2024 at 03:03:21PM +0200, Patrick Steinhardt wrote:
> > When this bug was fixed, the maintenance runs that triggered during
> > usage of the external tool, repo[1], would lock the HEAD file in the
> > Android manifest repository thereby erroring out `repo`. Additionally,
> > long running maintenance tasks would also cause users to frequently
> > run into this issue when using git commands that are written to HEAD.
>
> It is a bit surprising that HEAD would need to be locked in the first
> place. As far as I am aware, the only step where we end up locking refs
> in the context of git-gc(1) would be when we decide to repack refs via
> git-pack-refs(1). And that command shouldn't ever end up packing the
> HEAD file, as that loose reference must exist
>
> Digging a bit deeper surfaces that it's `git reflog expire --all` that
> causes us to lock HEAD, which is... unfortunate. Seemingly, relfogs are
> locked by locking the corresponding reference.

Makes sense.

> > We can fix this easily temporarily by pushing out config changes to
> > run in the foreground, however, I was under the impression that `git
> > gc`, whether invoked normally or through `git maintenance`, would be
> > able to run in parallel with other git commands and therefore not
> > lock. There is no mention of this in the documentation for `git gc`,
> > but I do see it in the `git maintenance` documentation. So should `git
> > gc` be locking the HEAD file in the first place? And if so, is there a
> > way for `git gc` to have less of a dependence on HEAD.lock?
>
> So what seems to be happening is that you have two processes racing with
> each other: one that is trying to expire entries from your "HEAD"
> reflog, and the one invoked by the user to update "HEAD". By default,
> Git will wait up to 100ms for the "HEAD" lock to be released, but it
> seems like expiring the reflog for your "HEAD" takes longer than that.
> You can work around that issue by increasing "core.filesRefLockTimeout".
>
> But this whole thing uncovers an issue with git-maintenance(1) itself.
> The above commit fixed how git-maintenance(1) behaves such that we
> detach at the correct point in time. But what it neglects is that some
> tasks are more special than others and should be run synchronously
> whereas others can be run asynchronously. Packing refs and expiring the
> reflog are tasks that should be run synchronously to minimize the impact
> on users.
>
> This all demonstrates that git-maintenance(1) needs to get some more
> love. You have uncovered this issue with git-gc(1) as configured task,
> but we have a similar fundamental issue with the git-pack-refs(1)
> subtask. So I guess we'll have to classify those subtasks into two
> categories, where one category needs to be executed before detaching
> itself and another category can be executed asynchronously after we have
> detached.

Perhaps Stolee (CC'd) has some thoughts here?

Thanks,
Taylor
