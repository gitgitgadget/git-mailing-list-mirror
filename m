Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF258BE2
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711871170; cv=none; b=PpGJfctZAxoDR9oJh/6dzjeyx2rPZM/V1/zIThfzWWu0WNSHVtLgT0o/5ytC9lFso9jB0t47m3SFeQoZz8rFk64lu3Z/p89hn60pEpzhrg4k9AWeJ+cgcLiMDgv32034P9td0KTxOrlF6IpSwtpQtzn/Xv0Y+ybJUqlK5WQwJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711871170; c=relaxed/simple;
	bh=gq2/dOBkbjuxrXGWCLsB/xfNT37fbHDRbtzVmJI8Phg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FydJLGaZxFS7Ba3Z7TaU0Xg7tYidA1yAWCE3fslTtY47eZ9QEtwBwfoWWxqmHpdk8+tUuuUY4PPYtLGneqSHNLxonZKEKO/nzH6FjgnmhU1X1PIqW3/YhDYSho7pQQzJpjoUVawFPFZGP2TKFAzffEEnEOcu4lrFW8iANLOsoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com; spf=pass smtp.mailfrom=fuseenergy.com; dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b=xTAlsFwq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b="xTAlsFwq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56dc70d96a9so929778a12.0
        for <git@vger.kernel.org>; Sun, 31 Mar 2024 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fuseenergy-com.20230601.gappssmtp.com; s=20230601; t=1711871165; x=1712475965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH+TgPgF2uAplfVb0W6cU0bYehPqKANSTDizZCSStzI=;
        b=xTAlsFwqsTKvfF13gdGd4HIKDlOjH0VncUdEyrdgE2wCg2/wmbYZ9JqMIVBzqCXu2b
         Wxgfgp29/Ym4IEFjE6DJ5kZyQ7bkEOnRqJL1Y6DmoKYEJLM/49mGBgW6JmvXrUrFGF/l
         Wt/DOUVT5G98qDlXQWMQx/6M3mBAGeZiqb1XSyBN/ByLeDqQqOqv4Ei1tiVSYkQb6n04
         PY2mj8Oo0r73o1k3XCGtwB1p6qqaKx+q2oCvBzfaxFL8lK1haPAEf2aqy4zvna5IqWAq
         NIK/EH3rkLIjCWf0d0Mz/SgqkPfZCpbJ21LvqXmuhAs/F5NEEnky5Kof7PzmPd63KCvf
         6Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711871165; x=1712475965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH+TgPgF2uAplfVb0W6cU0bYehPqKANSTDizZCSStzI=;
        b=ou6nBbI10ffeQwVEKgrk38P5fNZugDEnX0T2/NlUAs1g3IxGYuqWuKoHgfopi+ZQ48
         s0FM0JWO1dICewLrY8ceyv99rFcsPETHD8pZk9FaN4BOMwixd38m4YBN5ITs2H0wVrO9
         stKlZwVYeUAnpa5HFGnJ/i15ylbtrRVya9ADbyIKTPXG18StvxZLxCElGsyWb98I8VI9
         Ah4PhYf0HU5fbRxFEBL/+UXsYhRKg1qwDint1JhNpO6X46f/xpewLLA/EOZrxnLnP/L9
         yUZTKEc/eQGqng+entYvPESfq0cVGOycSAKTa8a/X7YGNmap3sfVYO2esarPuaZHf+PL
         zxoQ==
X-Gm-Message-State: AOJu0YxcjhOR32tDfH/nm4A0njiPEI61xgEVs63C4xO52NFFc4ItbbQ1
	7dA+kSAQrOJDQ0enomJCH/Ufg5A8ZPGwnDJVLVZedLMSPWZZkUxMXTNLBEMgiKxhBU1s86V+d2w
	8204hePbAPNE4g5YQ9yG+ERe515imisrELH7boqIhAa07rH4nDXNStw==
X-Google-Smtp-Source: AGHT+IFRBRbebkt1N9Vg6MoqrV0/07unqONc8q8X6nZnhoEBihB2gRwvIHL+RZO+F3cVmSlgSEKVShZfcllnYbWqQp4=
X-Received: by 2002:a17:906:f591:b0:a4e:3841:8da9 with SMTP id
 cm17-20020a170906f59100b00a4e38418da9mr5792338ejd.23.1711871164898; Sun, 31
 Mar 2024 00:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
 <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com> <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
In-Reply-To: <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
From: Tamir Duberstein <tamird@fuseenergy.com>
Date: Sun, 31 Mar 2024 07:45:53 +0000
Message-ID: <CAEYvas=baW9DWQY4_MJ2-Hh0=yYwH2tGeOOwkcJr3wETCKpy4w@mail.gmail.com>
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 7:49=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> [please reply inline rather than top-posting; I've moved your reply
> inline for this response]
>
> On Thu, Mar 28, 2024 at 1:40=E2=80=AFPM Tamir Duberstein <tamird@fuseener=
gy.com> wrote:
> > On Thu, Mar 28, 2024 at 5:24=E2=80=AFPM Eric Sunshine <sunshine@sunshin=
eco.com> wrote:
> > > On Thu, Mar 28, 2024 at 10:54=E2=80=AFAM Tamir Duberstein <tamird@fus=
eenergy.com> wrote:
> > > > % git branch -d cleanup
> > > > error: cannot delete branch 'cleanup' used by worktree at '<my sour=
ce dir>'
> > > > % git worktree list
> > > > <my source dir>  dc46f6d5e [main]
> > > > % git branch
> > > >   cleanup
> > > > * main
> > >
> > > Is this error persistent once it arises? That is, if you invoke `git
> > > branch -d cleanup` again immediately after (or a little while after)
> > > the above sequence, does the problem persist? Or does it "clear up" o=
n
> > > its own at some point?
> >
> > Yes, the problem is persistent. The branch is never deleted.
>
> I'd guess that there may be some sort of "ref" still pointing at the
> "cleanup" branch which presumably was, at some point, checked out at
> "<my source dir>". Digging through the code[1,2,3] suggests that you
> might have some stale state from a rebase, bisect, or other sequencer
> operation which still references the "cleanup" branch.
>
> [Cc'ing Phillip who is probably much more familiar with this code than am=
 I.]
>
> By the way, it's not clear from your initial report what you mean when
> you say "then the remote deleted the branch". Also, did you fetch
> and/or pull from the remote after that?
>
> [1]: https://github.com/git/git/blob/d6fd04375f91/branch.c#L454
> [2]: https://github.com/git/git/blob/d6fd04375f91/branch.c#L386
> [3]: https://github.com/git/git/blob/d6fd04375f91/sequencer.c#L6551

Thanks, I wasn't aware of the etiquette.

I had used the branch to send a pull request on GitHub, and then
deleted the remote branch from GitHub after merging the pull request.
Yes, I have fetched from the remote following that. I've also manually
removed the remote tracking branch. Symptoms remain unchanged.

If you can suggest where to go looking for stale state, I'm happy to
provide more information. I'll take a look at the code references as
well.
