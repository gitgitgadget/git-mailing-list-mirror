Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF899391E4E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356816; cv=pass; b=TszzlS3iROyPX1VhFASDJVhY46fnrR2Pm2iM4HBejRVpXJ9xUZsoL2LkxrVAXqzYdGL8ra9HRHE7Bz+P5Nb/D03DaqS+kUwMmlWceLVUIaPyhgKYdqwRz8PGBtYyWUnbk7GhSNm/rL14CQtAht1qY18ZTn7KedxsjMOYw+3UAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356816; c=relaxed/simple;
	bh=FWI/dltXQaXy4Lk2biBVGI8XliEJbC6dq3TVS/0dhX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5UUwyjLTqditj0MJRuYfvg4Jz7n494IwE+J2VF9SYnN27/vAnUhiCN4jWgFJm0MkaC2l8jiNgA0ezCxyBB5FGEquIuC50sKa1Reid74SWS58cGxi7Dl5w6u7rjvoG6ksY2XW2TqQ+jW3B+tGCtOOWzD1vZjMqbBl/u/PfFh7uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEXnGABQ; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEXnGABQ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so1833160a12.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 03:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786356813; cv=none;
        d=google.com; s=arc-20260327;
        b=NISZoxV3jZLtDBw8xi05xevkmAgc+P8FAVQtrG4iX680W4uXURbVwvnmBjbQ8McDCP
         BCmGHZqzKdhPRfN35UaZnhwOY3hPlLhLAmYt1HeNYUCufmNAfX88O/VtJ2gPuzdfQEbz
         c0moBM/J+ObQZO/y5x6hRcy8heE23j16welL8VwV4AQTgGmS+xt1UpS6kQrCgp6LsF0H
         Ds8BgJO27B13NHsb/89grjhAFy/Lo9DuaFC7GQtRReuUWwUcpGMs/uuZoxJtbGXGwyJ3
         HZssL93v02AQ65H7F0NKuduVR9XNKXnyof7Ls171SClEgB2MOwd91qLxlNG8qv834Uik
         Ww8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5PnKpb6ydnB6G1Jv/7WDZNVA0MMH6fnNLmH3vwr8icE=;
        fh=i5lnNAMjnQOrR7/xsAUwRbhQeL0abd8gaKu1OpwaM7w=;
        b=Kn17O8KGUPomzPpNF0VhpEbquGQoEjUewvKox6E/4Vtu/wZxDvL0BrF3Od0/Rhj1pz
         eRQSMGQ92gnsbhJlfrQLHftEohpQgrPeUrPHJAyPdYxKPMOMNS04YmJNkMkkaSNIUr3e
         WV7N+qGDmsu2SZ77yC+dBRT09VEyUTwjnJ6JRLO374DhJdgDw6XyDw74mqrfyIGwAATa
         9vFA/Tpi2hxC052K6auF+ikKVfNhgITGm478MkkpXbuS3yBA5JQs2fLEo+E6zj3kK7MK
         PqGJpGcugsNumYluFUsiDRwaYc8VXJ7DivHhwpXIKrId+j5kAZR0CFl1LRRDisawT1kQ
         9ToA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786356813; x=1786961613; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5PnKpb6ydnB6G1Jv/7WDZNVA0MMH6fnNLmH3vwr8icE=;
        b=iEXnGABQa/l7DD8si3x4A3R6PhelTSTdxiYL4fQhTACYyiq5Pg8NDM+ZOCnTIGGFFa
         oKJYRvEBhPUf4eR0EeelfKoM2aZ5qhzBg1TzdHqu8MRrB5Q0sVew63ZSaWzsqxro/LFe
         KJ+y/B51rObQRHTbXccWILJ/vtAvRpJU9coFfss+Ywvhf49fhVO1KGMl/Y+OOiwSM3w9
         rc2YNOMG0Fe08rvOK6C+26GGlOlMOQ5WmxLC0FO4PkiFq9lMdl2VUThUTMpb3OLlNyaj
         7AJTv9aktT3qWy7Ai4VWfLfd2w20GMDyOMELPQ9JGKpIj5AoHrXYip0K/ou3MTXz87z8
         fnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356813; x=1786961613;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5PnKpb6ydnB6G1Jv/7WDZNVA0MMH6fnNLmH3vwr8icE=;
        b=rdkZ1oVFMiVVrVtEydLFd07R+QxTHoPoDB5z48eRmh/UQoAE5n2pDwuz6Dy+ardavt
         /izSL45aHzRqjD7YpE5xpXsfcyCHRr7u/xJQ0nyIpdW20mY2cRbRUsGuEJWPyoLbo5Gq
         rRpDijhgtR/MtO/YD1IMH57LjXLJ7NKrbi5tUGDWlL3xOjGOBbWzHhnF9HLpDAEWi000
         chb6dRtYfXMS05oZ9ePnmIEJ4cbQofi0Zz4nCG96JkhyWpKdaL73eX4RzJ7DnOvJWEVx
         fyGCWFIBUmLjqN1UeYZeFiXW2kA9OUKYf1XnDQG/w74U65ybB41tXCjby163cI7QEi2v
         7keQ==
X-Gm-Message-State: AOJu0Ywkzh2KhS82vAYgYpBkHaXTfHs4sUhmxYuVmm6w2DRuS7EhDa4i
	FaZRCp3Ex1fLR9mZ6aHHg+hVNR7g2gT4T++6MBeNMzhiN/+QHPxpM33ZXmDFwFqtGqgJSxgppUu
	61oWhK1B69IdWlK8IxprCPHBBo6lEYG37JNIKNZo=
X-Gm-Gg: AR+sD12FR8heXMeGZAyJkoIkXJtvKKydyYGdbNiBRlUocwzlGkYvX5LMmc5qn2PLTK2
	4KJUczpKPZ7+NLEOoS+VDNJoRxAmZ27KMnG7vFKOamvhoF3uAeXAioaWXdN97FzbfpKtF40GUbE
	G8WLF7Y7ysLaFu9XBtrAe15RzZTweS8k/JWZlAtGLB7Jv/My2m2QfbCMCproSZFf3sYSl9GNkPt
	DXVBTfvmpBdv1bFre7ymjl+9kX1G1AdYIrTElwv8SNNcotTQcaHo5qzJL42Vqe2U87CljOdUSR1
	MNgimFCf0xE7msdGRPHg7tfGF6tczahhX1MUavzvRyr4khUl1EodKiw=
X-Received: by 2002:a05:6402:a512:20b0:6a2:b3:4ef9 with SMTP id
 4fb4d7f45d1cf-6a200b35239mr3919237a12.19.1786356812746; Mon, 10 Aug 2026
 03:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6fc9swz.fsf@gitster.g> <20260809074528.5189-1-haraldnordgren@gmail.com>
 <xmqqfr0n9mxp.fsf@gitster.g>
In-Reply-To: <xmqqfr0n9mxp.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 10 Aug 2026 12:12:55 +0200
X-Gm-Features: AUfX_mx_ReD4K7NpwJhZS1_2glHnhNtLBJBvPcS73YY_9jR_9lw0eAzGhU2ZlKY
Message-ID: <CAHwyqnXGOCZM6iMg0B_2Lxbyp9ux5Vsj67C_u71o0ZivBQ-w0w@mail.gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, yoichi.nakayama@gmail.com
Content-Type: text/plain; charset="UTF-8"

> When expressing your opinion on what another said, quote a bit from
> the message you are responding to so that people know what you are
> referring to.  I cannot easily tell which part of what I said you
> found interesting.

Sorry, yes this was about:

> Telling them that
> they may have meant 'origin', 'upstream', or 'home' (all of which
> are remotes with the named branch, though we could not guess which
> one of the three to choose) may be much more helpful.

Harald
