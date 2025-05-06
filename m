Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4A21CC62
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553825; cv=none; b=j622wr6G0bR/jGimEwrVEsnzkXDhiVoXvuwgAHvrS3ieNfrZyhUCPOcO7rUeiTqRL+q1c/tIdPBXi2Ul0p2Tj6BU7pgYiY4v0csAVFNKHZ1Qexg2ZmMltSbttLnP0WoEPLuQOGeAzY8kaD0nnCWf0CiL7QVyNWCcMic9EX2PoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553825; c=relaxed/simple;
	bh=Gd9tIB7nMgTcYMvgkDnpA+QJVwpx1pWhQQBB82rLGbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVzb4HZ5Tq06w3Qez/q1l06fbfDgk3fFm1Nu2bSsnPL51ALCq3/fhMTz625naFaWxtYnqZdL+5BcUu6WW3VkyYS+mQiEdJVRkh23jzM1CDTKlWs6ks2dZAfDpfQUL7QBhg6ddoL/MRlwiv26YVH6uK7IzRricr3a2tsV84rmfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-48d4e47eec8so1237761cf.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 10:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746553822; x=1747158622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fs7CMp/GJCnXalzuv8EvQnsvnKbeBZcC9Fi3WSkBqk8=;
        b=gklqccffgOd/uxUgP3KezwNdydsx5zK22EES2TOi2W8QZMIWdL9lvhbYgZsOQuba+C
         qjyYnItPuN6XhBfcErMsg+NwygT5JBnGWnmf08yVTXSnGRXjvwqZKokgQz16QMWL+e1d
         v6+WY6eZMUu08v2psTTi3YexOMczAiLJ9/KkniDLB2uGFrbSj/xK7Ngmkepx53/6t1Xi
         vq60GsZuNLuKqOmFUlVgTdABXOuN8DSlmEQo8aVJ5vqP7xdZqtQBnURkabBirqFUvCdi
         8zCaR4rL8wUvcutjtmruGGJjSEeabLveKY4OYE/haZhO4+uBOonp9VLPQS04r/T86ea3
         5Tbw==
X-Forwarded-Encrypted: i=1; AJvYcCXrk9WH/iBSvqv/vRrLduQU7hN6/hZQMG54Pqq6osv/iKf2UplHtI/WGcKDtUw/pXdQku4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYElYIYC8e+zTOg3nztEFmOI9PKS3RW4zBmv0xCtaJgzMVzNx
	x/AYLs720QBm95Pj4rKJUdDV8L1YachnDJ4BJ4bljbTwUvTt83nL/uHD1JIBVDPMEOGZRetRz8M
	4FZkhX5YjKLvQxKpJi/PytGKQB5Q=
X-Gm-Gg: ASbGnculr1I1BwNBK3/55o8S8PIKV/I4H8H8IKYQvVYmNYU6DQkWcUL7skLqag9S3oA
	ZY3oFT/tDAWYy6/iTIVsNdSezDoU//G15gAE/CNSAl4upAQuYS4TrAm+E6ATJPMP6Rrfe0/I65t
	pkrIT+Zk/tTE3pZoamTcczsOepI6EANFTjZp1aQFk8bj2eftyVuAGhmsU=
X-Google-Smtp-Source: AGHT+IEfq+RwKaDdZemdpUk3aVRzHu+pqzuomYZFwzWP4k/EMEULAhYCSHKUNOE4usFDBKG2tqA4RIyC0kXCwlJgYJY=
X-Received: by 2002:a05:6214:1c07:b0:6e8:ef41:a0eb with SMTP id
 6a1803df08f44-6f5156384bcmr93803586d6.11.1746553822605; Tue, 06 May 2025
 10:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcycmlelr.fsf@gitster.g> <CAP8UFD3=SJp29+QaUZvqWhjx_53P9tOE05j9TgP-sEvNRZW-oA@mail.gmail.com>
In-Reply-To: <CAP8UFD3=SJp29+QaUZvqWhjx_53P9tOE05j9TgP-sEvNRZW-oA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 May 2025 13:50:09 -0400
X-Gm-Features: ATxdqUEBjHO3nOIXIVwmPWS7G9iYE8lcdrk0I7HnZMwVCXZRF6-PWK9Ws34HmGs
Message-ID: <CAPig+cTnxJ+ff2jygfsuigQbSa9QMdA1dWN+Wp4xXJQRXOvwOA@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2025, #02; Mon, 5)
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:35=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, May 6, 2025 at 9:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > * ps/maintenance-missing-tasks (2025-05-05) 7 commits
> >  - builtin/maintenance: introduce "rerere-gc" task
> >  - builtin/gc: move rerere garbage collection into separate function
> >  - builtin/maintenance: introduce "worktree-prune" task
> >  - worktree: expose function to retrieve worktree names
> >  - builtin/gc: move pruning of worktrees into a separate function
> >  - builtin/gc: remove global variables where it trivial to do
> >  - builtin/gc: fix indentation of `cmd_gc()` parameters
> >
> >  Make repository clean-up tasks "gc" can do available to "git
> >  maintenance" front-end.
> >
> >  Will merge to 'next'.
> >  source: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.=
im>
>
> I am reviewing this series and it seems to me that it's possibly
> missing a fix for a leak that Eric Sunshine had found in a previous
> review round.

In addition to the leak[1], I also have reservations[2] about the
"worktree: expose function to retrieve worktree names" patch.

[1]: https://lore.kernel.org/git/CAPig+cScor=3DE2i4w99NCrsaUd-Po=3DFqhkrLSy=
T69PSo1+h2dRw@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cSDDbhGrym8j=3DPFKBCUxBQhZPzAHXGvKy-=
Z6POA4Ju3sw@mail.gmail.com/
