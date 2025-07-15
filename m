Received: from a9-22.smtp-out.amazonses.com (a9-22.smtp-out.amazonses.com [54.240.9.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81327610D
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557473; cv=none; b=pPzr+9+oOiZF/vxK2Pj01Kh+KixPIH+OdFGLxqDdnj3n2zmdvJUEjsMEzAfHy3c0pg5Z2E4Qqf64kvxvU0SJKW2HQEiAety4Vqvx+jQMjlctOfrB0uUTUlSbnxxjbVfmKBFZ8eI318sIr8+a2yiXZ73MDOPgJ1KrezflNyMcrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557473; c=relaxed/simple;
	bh=t31RVEtSQVf+fzXOKAOXqcrk9AH/p9CGSsmwvXrp7GQ=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=METtgaNTlvLGF4XRxC2+3zehl1DPDGQThHACoWdej0KlDMUEVbSVuRYG1/sjpfOhhW8EAb6Zq3105/bpcKZPadzumFrYTf3GzCUbgFVmnmIJWNG6gC/fXC+/Wii/Owsv9Hm3fhiGvNoGcFNol5YO2pode4u4roBZuy3JgQAaOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=looping.me; spf=pass smtp.mailfrom=send.looping.me; dkim=pass (1024-bit key) header.d=looping.me header.i=@looping.me header.b=2khLc1N0; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Fz0YkWwF; arc=none smtp.client-ip=54.240.9.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=looping.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.looping.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=looping.me header.i=@looping.me header.b="2khLc1N0";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Fz0YkWwF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=looping.me; t=1752557469;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=t31RVEtSQVf+fzXOKAOXqcrk9AH/p9CGSsmwvXrp7GQ=;
	b=2khLc1N0CpecwdqHwky+Gdnzl9BgPuMQg/udsM6GwThj+gNLHDUg+n42BFVdjAf8
	k2ew2mb4w0X2dfKxgbJ8nD9hpGW7awNDfiKF7uNEnAc0Od2CnpBDveu0r0OotcZjFUD
	qnBqIAGUrKzsM2tDkS6SggOfGRdeRWEkXN5dFxDM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1752557469;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=t31RVEtSQVf+fzXOKAOXqcrk9AH/p9CGSsmwvXrp7GQ=;
	b=Fz0YkWwFyupr6vo/9sGhe6JD4TQ74pk9HIZmdrKyYTfBXSXm82E/Hzucjm+34MpN
	zkOvcwOPj0IQSOfHF1hYZw/0Jmhz/u8ZlBIm/W2q748L8hDxN03l+fy2x4VPXp0ThEQ
	7tBRjcjSvxoF/Gshqfs1BWoILGQXdtvO4ji22hIs=
X-Gm-Message-State:
 AOJu0YybQdVs95Fj3Vx+j0ngqJb/tLidfI6ut2kaXMEXEgZOjZ1/PsDi
 iFQt++EG5Kk7SYQzhSRBBRn+c0SmGcTXkbewy+qly9tqLtxYvu0tR/UZ7UXAewJsK7eUZCuUOIf
 oVviVG7TS7AypNEfYXazU8bPJSUXRm5A=
X-Google-Smtp-Source:
 AGHT+IHgOQefS3uU8poFvXcSpUuYEQ2LCcRI/MonuCNxourn2a33aj3t+lPSVw85HLqwb/3I6Ov3ksI3C1Qs99JDSSA=
X-Received: by 2002:a2e:a551:0:b0:32c:bc69:e931 with SMTP id
 38308e7fff4ca-3308744de8emr536761fa.9.1752557467659; Mon, 14 Jul 2025
 22:31:07 -0700 (PDT)
In-Reply-To: <BCD357B1-39B1-4B00-BEB2-EF2C20A0E4AF@gmail.com>
X-Gmail-Original-Message-ID:
 <CAL_3E06EH4Dehmk245zCkz0Dn-oJUvY7iWtg-qQ3XRsMDni2Pw@mail.gmail.com>
X-Gm-Features:
 Ac12FXx7F2TBuzsy6u3Q736hSxnjnO2mMi7lEhcKYDMAtPfLjGmKsIj-DheZYJU
From: Bryan Lee <hi@looping.me>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when
 used with --git-dir and --work-tree flags on a bare repository
Message-ID: <010001980c90be66-2401a0b0-5c86-4135-90e2-c325852ef168-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jul 2025 05:31:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: ::1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2025.07.15-54.240.9.22

Lidong Yan <yldhome2d2@gmail.com> wrote:
> Maybe you can try `git config =
rebase.autostash true` instead.

Thank you! You're absolutely right. After =
testing, I can confirm that:

1. `pull.autostash` is not a real Git =
configuration option - it has no
effect whatsoever
2. The correct =
configuration is `rebase.autoStash=3Dtrue` (for rebase operations)
3. This issue is not specific to bare repositories - it happens in
regular repos too

Here's my test in a regular (non-bare) repository that =
proves this:

```
$ git config --global pull.autostash true
$ git config --global pull.rebase true
$ echo "test" >> README.md  # create=
 unstaged changes
$ git pull
error: cannot pull with rebase: You have =
unstaged changes.
error: Please commit or stash them.

$ git config --global rebase.autostash true
$ git pull
Updating 9571176..5125236
Created autostash: 9ad0490
Fast-forward
[... changes ...]
Applied autostash.
```

This raises an important issue: =
Git silently accepts invalid
configuration keys without any warning. Users =
can waste significant
time debugging "why isn't my configuration working?" =
when the
configuration key doesn't even exist.

Would it be worthwhile to:
1. Add a warning when users set non-existent configuration keys?
2. Or at least document common misconceptions like `pull.autostash` in
the git-config man page?

Thanks again for pointing me in the right =
direction!

On Tue, Jul 15, 2025 at 12:09=E2=80=AFPM Lidong Yan =
<yldhome2d2@gmail.com> wrote:
>
> Bryan Lee <hi@looping.me> wrote:
> >
> > 3. Set global Git configuration for automatic rebasing and stashing:
> >   $ git config --global pull.rebase true
> >   $ git config --global =
pull.autostash true
> >
> >   Verify the configuration is set:
> >   $ git config --global pull.rebase
> >   true
> >   $ git config =
--global pull.autostash
> >   true
>
> Maybe you can try `git config rebase=
.autostash true` instead.
>
> > The difference is that Git is not honoring =
the pull.autostash=3Dtrue
> > configuration when the repository is accessed=
 using --git-dir and
> > --work-tree flags. The autostash feature is =
completely ignored, and
> > Git behaves as if pull.autostash=3Dfalse.
>
> I=E2=80=99m not sure why this difference happens either.
>
> - Lidong
