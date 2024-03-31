Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD02905
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711867766; cv=none; b=ozC8mv0v+NfFsG6qwmSglKSpZb/+qH0VYc3lzfI9Zy6plaNCmRczSkConu3LNvbHQ2gUZ6Kk0BokO/IQYoXsqsuyAPqwitu1siMWUg8GFEpNMgLtf5glgwCZ/QFayZOGoR/wlMDH6abMOFtn/kVuDOtg7UsgfoDO50TkMJ2qonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711867766; c=relaxed/simple;
	bh=upfKnI4IE9Jf3vaU4qNbFg+im421qDhXrUhzPZQq22M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljLK2GpmzIlD/RtdWntOMaey0aB187wd34NqubaO/uSEcv77jxSaHdWlnM42vnF/FWCUSo2ZF7cr+1NpjU4KWJ07KuOHk8HMs240QiP7E+11YPkm3hnMrpR6inVsmdn+adSlpNzxKHecDUF5IBfIClCJRU+qZAslplMJNbAdprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69625f89aa2so25171386d6.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 23:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711867763; x=1712472563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ibw84ukGrFCDuFskzzUfLhvNTshksEeXlQE8T0sR/+A=;
        b=Em6GLq2yn3XGDqWvQ157nr06BOI1nKplZCv35sqs2dZh6uJFEUuT2wtUx6WAkq7bxB
         +v91GSXR+M9q6IXYSCg5Kh5ndp8/fvsLNA54AhG6GUxBLoSH7mDDh9teN9R3PkWqcGUY
         9JtkGDhyYYnvt+4vYk1v1EB0QQWkm5XVin4zu32P4mQiVD3kU4N2lw2y8TV80orwVush
         Gf0d7ZMuoxGq8s+7958zndNHRYIp2qtbPRtAt+RL9aJmQVZ7cx0BGYrZC3zcFgvePxzT
         bdyfdJ+dojXW5vVaNINZC5vjA6YhVXaMoZlpydDVSsBHlulitu6k+4ydh7Ib+taxjCdI
         zSlA==
X-Gm-Message-State: AOJu0YzfzzwpdIAAVoLGKD9obDuxJws3yZ3s8TU9u3/jVxfPIVJafdNG
	l/6Zc36/yeX/A93NUdQ+hsGVmHOKj4mKm9OWUv7MrDhURtJwxdjGQR7BqNyDdpKQiBy+6tRK5FL
	rAauzHnom+HhFKT5IEx20bq5AvhA=
X-Google-Smtp-Source: AGHT+IFkywMT67rYorxRBwz2YhLNaSKYyoXLhZad4M3zgQO5C5Rl5ebG88dILr7adrv76DaiuLabmNapmSjv6Su94Fg=
X-Received: by 2002:ad4:5fcf:0:b0:696:b0e4:1d55 with SMTP id
 jq15-20020ad45fcf000000b00696b0e41d55mr6976018qvb.14.1711867763328; Sat, 30
 Mar 2024 23:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com> <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
In-Reply-To: <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 31 Mar 2024 02:49:12 -0400
Message-ID: <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: Tamir Duberstein <tamird@fuseenergy.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[please reply inline rather than top-posting; I've moved your reply
inline for this response]

On Thu, Mar 28, 2024 at 1:40=E2=80=AFPM Tamir Duberstein <tamird@fuseenergy=
.com> wrote:
> On Thu, Mar 28, 2024 at 5:24=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > On Thu, Mar 28, 2024 at 10:54=E2=80=AFAM Tamir Duberstein <tamird@fusee=
nergy.com> wrote:
> > > % git branch -d cleanup
> > > error: cannot delete branch 'cleanup' used by worktree at '<my source=
 dir>'
> > > % git worktree list
> > > <my source dir>  dc46f6d5e [main]
> > > % git branch
> > >   cleanup
> > > * main
> >
> > Is this error persistent once it arises? That is, if you invoke `git
> > branch -d cleanup` again immediately after (or a little while after)
> > the above sequence, does the problem persist? Or does it "clear up" on
> > its own at some point?
>
> Yes, the problem is persistent. The branch is never deleted.

I'd guess that there may be some sort of "ref" still pointing at the
"cleanup" branch which presumably was, at some point, checked out at
"<my source dir>". Digging through the code[1,2,3] suggests that you
might have some stale state from a rebase, bisect, or other sequencer
operation which still references the "cleanup" branch.

[Cc'ing Phillip who is probably much more familiar with this code than am I=
.]

By the way, it's not clear from your initial report what you mean when
you say "then the remote deleted the branch". Also, did you fetch
and/or pull from the remote after that?

[1]: https://github.com/git/git/blob/d6fd04375f91/branch.c#L454
[2]: https://github.com/git/git/blob/d6fd04375f91/branch.c#L386
[3]: https://github.com/git/git/blob/d6fd04375f91/sequencer.c#L6551
