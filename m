Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F0D268
	for <git@vger.kernel.org>; Sat, 14 Dec 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183698; cv=none; b=n/2lcaCbckdyYHACTjn++sFn/Wt7dZGBg5TDlEp7UWrtA4nKp6Ny1xNSblCTkNn9WY9y9ojMYhZxfeiLtjtZ2c6e3j/lBx4OBquKdYlVux/8RN7k/cMlnk7vNfRnRyB+Of3DZVTC5J8ASzRi67QL4zXjLH5xXwPitUmu8xdmmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183698; c=relaxed/simple;
	bh=P0iaTccmPJ/dBb3uupnb5QdOhERcwry1wKMUfbQFQxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZYvd5rezLBebIxI4xbrXY122sdP+E9Ih8TMT5r3wPqCoQzvb0WdYH8YNec74eYYXQBXEwSm+0BGT+B1AmH7pNIySzSU8Q1/ts1OajdSF4p0G90eFubzvlV+mlgCKLEaLF0Qk19mdWsJFKQ1LO5TpGFyqL6N0c+5mnKjzHFIzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPURBaql; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPURBaql"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2efdaa02378so378426a91.1
        for <git@vger.kernel.org>; Sat, 14 Dec 2024 05:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734183696; x=1734788496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0iaTccmPJ/dBb3uupnb5QdOhERcwry1wKMUfbQFQxA=;
        b=SPURBaqlqhzIlKRP10ek8nTl59WUbj1D3ombzDLVMh83W+X2iuBZLf3doaFZ4OmDpV
         8N69rj/TGFXyrO1cRpglj22wLURFnyjfNHnQeOU1XxyQ/OhqC1Xp5suFGpvrRs1wMycq
         OvncXQj9ZAnlphFqgLfWreejXWaJC89lPW6TEPMZp6e3WblC5RVGTtd41OlfZe8AtXum
         8xDtTXveewNgdEJGyhq81O45vyRG6ar3tNCIb0fp5NPqsbSaSggpjEnBKQe7im/N5YtJ
         ipXrxsB5e6itMWg4Eb+krUAxO9hyNHQXbCg5BR0kV4GMnKOSxgJb6tMVErCuJWZZMyez
         jkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734183696; x=1734788496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0iaTccmPJ/dBb3uupnb5QdOhERcwry1wKMUfbQFQxA=;
        b=vMts0awpgk14Ju9TKhx2M/Z585/7PtKeUfOJzCj0xch9yAdJZBJEAx6s9diLxPVEU6
         0ESHDxLoiF8oqRYQC2N9+5I+/+GkJ/T0T9dpyElVOs6n5MWqKOr6V1stejmNQlxP3C6E
         dpOGi32JfzLl33vGKXBtUucHmoPjdxl5iVJ0GsOqN9OEmdRlQgO3gdoxB3AGearwa02p
         s26Q6Bd26KjodHLYxSfIW828JwQ67pC4bYf/4MyWouk/+k3Fr1K6OaQyJGTwbtkx3MDg
         Jb2bWsSyqPivkFu2SCZZCdwhFOXmh1rJc3B54rb9kZL7u4KGKrVjS44/t86Di3UcAdD/
         bojw==
X-Gm-Message-State: AOJu0YzsoFzU7Dg86VOaJWTJoH6eYTyaC27ys8dhCFwYBliFx9GZD2jE
	d+6X6oHV4MvVmRIxsLaXtDO7E/PrIl2HC5G3UqQHpA+WGFFmS5Eo6+c8uiFZgokQhLVI2GEQLS4
	mIpLCTp34s4AYrdflJ26HvvHcj+H7UA==
X-Gm-Gg: ASbGncsCe+knv/RHqnJ/BphYokHCti30NOVUCRGCvrX38gKwo2uh3DDGZMRq0KkiI24
	XkwCozSoouW+ZVBsBSw6l9SaT9ulkDbmWZLJfYZ2T27v+as+GZBp4P17AdjCeYmKzeTI=
X-Google-Smtp-Source: AGHT+IH6R++LMVotIut387bAw7rym0jsQlTlK0F/PIcfRPmM6ZzfH4EYtTYHfJgNLmIDmXu1JLwOhU4MhPFfjxuZyXs=
X-Received: by 2002:a17:90a:d607:b0:2ee:35a1:c291 with SMTP id
 98e67ed59e1d1-2f28fb6d166mr3602601a91.3.1734183696439; Sat, 14 Dec 2024
 05:41:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJUwWUMQF_tN_hyBMh+F4NtAHVAx1z+g0HYY=PD9-jd5RdcR9g@mail.gmail.com>
 <e56b3047-3af2-4353-a0ac-d3af65fe70eb@gmail.com>
In-Reply-To: <e56b3047-3af2-4353-a0ac-d3af65fe70eb@gmail.com>
From: Brendan Jackman <bhenryj0117@gmail.com>
Date: Sat, 14 Dec 2024 14:41:25 +0100
Message-ID: <CAJUwWUMWq6MA8YFYWk+B0st79gGRyud8PGx5ia5AkuZwVnrdMQ@mail.gmail.com>
Subject: Re: failed to read .git/worktrees/test-worktree-xdrphX/commondir: Success
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 3:53=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> Unfortunately with the current implementation of "git worktree add" it
> isn't. When git tries to add a new worktree it first checks to see if it
> already exists. As a worktree may be on removable media it cannot simply
> check that the directory does not exist, it also has to check that there
> isn't a locked worktree at that path. To check for a locked worktree it
> has to list all the worktrees in the repository and if another process
> is creating a new worktree at the same time the process trying the list
> the worktrees ends up seeing an corrupt wortree because the other
> process hasn't finished creating all the required files yet. I think
> this is fixable in principle by teaching the code that lists the
> worktrees to ignore ".git/worktrees/*.lock" and creating new worktree
> under ".git/worktrees/$id.lock" and then renaming "$id.lock" to "$id"
> once all the files are written. There are probably some subtleties
> though as we would need to ensure the processes that are spawned to
> setup the worktree use the temporary ".lock" directory.
>
> > Anything I can do to help narrow down the issue?
>
> If you're interested in fixing the problem the relevant code lives in
> worktree.c and builtin/worktree.c. The easiest solution is probably to
> try introduce some locking in your program so you don't run two
> instances of "git worktree add" at the same time.

OK, thanks very much for the info :)

So I think the right approach for me is:

1. Do a silly retry-based workaround in my application to make the
tests stop flaking (doing proper locking is actually nontrivial
because the git commands get run across separate processes).
2. If (big "if" unfortunately) and when I get the time, contribute a
fix to Git as you suggested - thanks for the code pointers.
3. Then I can just have my tests depend on an updated Git. I've never
actually seen the issue in real usage of the application so I think
that's likely to be good enough.

Cheers and thanks again for the help,
Brendan
