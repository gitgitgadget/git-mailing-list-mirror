Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC821E1A33
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391982; cv=none; b=BkfQ8bVp+3HQRUvCaySK/WoMxI5P+6FjdUW7c6xdXbF43Dt7s/VE+V/iD1mQ90vHt9XyXJJwBnYJ8I1xZ5tJUdYUhk+6pvgEo/6nqK13Fh2vVWrchgsB4wYymmBN3hp7CD7TqePhARqjpRBmqutzJa5Y+Tr8/73AteJHBfRdZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391982; c=relaxed/simple;
	bh=w1Hsn3GVJm1iAO21/48CGxM5HFWlrVglv6kWFvCnx6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmCzErleMoHtyi80od2eXQw7sVUQsSDedzXVoeu2itK4ZRSdkZ18vMaR8p+ZoKyX0hrHqwOl9zlPdbfN2HPk+/z6Hw5h3+ytdhCnvuPsEgYl+nJtjVb2tz2PTUIFT7aNg3qYIiAp6JVojVVTm51W9WSM1xCWVIC8BUtIqlmgJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/DUlqRV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/DUlqRV"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so7583666a12.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763391979; x=1763996779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMiucvO4xm6L69I9lHhs8WBG9itejB/rK9IhbzhlZ8I=;
        b=d/DUlqRVxkrdQDuZgL3YLIEX97Ng2Rc231p10kuRnOBqfexDh9upPV3HIIJNSCeBPY
         tPMM+GnFOCG5++MZaUanOwjQpCUlzxKuRZBZLDVkSwHA+V3pwajy9oVukRSp1kgDqxkE
         xltBySVlpBp1ulDltUK9B43qWt6Vs8m44ZfNDEUUTOAUXoGq/aIb49gcHj7Ifz5SxNpd
         HTbVZuyfLP+DWHFJYKPaWDj+lx/az5GPmoiFYrVhHd1+y5M02NnBxhCYb9Wu9akXhDMh
         P+2322BnKDwvlbkmlQUEkpYFh4Cz8lhS74VRcUop466ACeDm3B9swqUxbrGGungvR9wk
         dsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763391979; x=1763996779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMiucvO4xm6L69I9lHhs8WBG9itejB/rK9IhbzhlZ8I=;
        b=NXECJ0n7gk9bcvxb5Gi9JooqRYWn7d95wGwdbKjUn3le5V1bYoHTtYJcolwj+u/RCc
         fYqLncB5MilFnlq3eBtByzgkN23/qbrAJMTuzxeU5fgZ2dY+Fbh1uh7bYCkNGnF5DQzI
         bR+K46ehhPfh/Vfe5JwCb3ynh7r7GU9B7+Sxe/MQXYK0FONVC8rTkjCkCWgnLTS5Sjov
         WFA4RxA+6nSeqKqNb9AxezxMATc9sTJjpKqDjKsq7gYgAue2To+6/tLFiQp0yBo+poln
         u8UttKCqnlVnk4+asv/eO9GJCPcKbddAe7B/9aabOyEItEK74tErh3fGvJYBcngK4mGV
         3Cug==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2vVNwg8DOaKLihE8IqqOxTEnd9eTnW3mRo3EJpCLZpmYQQb8lP1TJd1MOi4s9U725v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDpk9NJbtYXGMxeFdj+OLzcBinf+HEsMDfkEGpyHjUNtsWah9
	dwuZNCkdyydLOnkpXGZR4H+MVZrAcP5VKZlH9AEcjNL9ld7cRXjrNbw7mw9MmiWns6v/nOPzxAd
	kBlXjeUNx12/ZZFYZQXJdUwO4O0WSN2g=
X-Gm-Gg: ASbGncvSbggn2SBivTZnJ+XvKqYwRynBzhnNw9jKUOXRZz5Fx2Tufms1hW6FmndjzO6
	oKpEdchdKBv1UmUeTfNC0hYB2eCQRQkF1nfqIv/rL3BqGGrDqtAv0dfJviyZa+yMoxgCIRpPPQA
	kMP5Zqy2iqhKZolkCbVIK7IUnX87pMLwPWq7+BNVr2T7Rr5nqpeMAUZq1cPSgKBnr/M9Z6XqAMO
	bPSSXB015eUOKHF5u+49bpPHDzcZhR0SQxMbC5L1YX4s8Utoypqd/dzD3gUMlIY3DiVCjajCjZ5
	zKSpZC1B86c+fRw4K9UnVxw=
X-Google-Smtp-Source: AGHT+IFbBxviSAOmuZyNjQiCmrCE64d4FDg4ZKFEusZidoIpwfQt+et8H2ONM1BbmIy5u0Rk9+BobJ5MnJWHz/LmORE=
X-Received: by 2002:a05:6402:35d2:b0:640:be87:a858 with SMTP id
 4fb4d7f45d1cf-64350e9eb3cmr12342945a12.27.1763391978684; Mon, 17 Nov 2025
 07:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
 <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com> <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
 <xmqqqzu3qi43.fsf@gitster.g> <CAOLTT8RSN-72gVXDS-zrr=7wW4HU=CL6acyDx_UXnvo4c5MaRA@mail.gmail.com>
 <xmqqfraeeqgw.fsf@gitster.g>
In-Reply-To: <xmqqfraeeqgw.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Mon, 17 Nov 2025 23:06:07 +0800
X-Gm-Features: AWmQ_bkRiN4UFeakujLn76jIJpCzxn3qayyOwuUs1DPk-Yl5SSmVVuPV_wSPpAU
Message-ID: <CAOLTT8SEwipDtthO2T0CkE5-rCJdq9oDjTKcBEH2YxzpjAM9jQ@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8816=E6=
=97=A5=E5=91=A8=E6=97=A5 09:06=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> Isn't it more like "You need to run with --author to correct the
> >> authorship by amending the commit *anyway*, but while doing so, the
> >> committer information will automatically be corrected"?  As I said
> >> earlier in a separate message, the author and the committer are not
> >> symmetric, so having "--author" does make sense in the above picture,
> >> while "--committer", as Phillip points out, much less.
> >>
> >
> > Well, I admit that perhaps the design philosophy of author/committer is
> > inconsistent (which has caused too much trouble), but for users, a cons=
istent
> > parameter interface is easier to understand and use.
>
> I do not think it is about design philosophy at all, though.
>
> The distinction comes from the difference between what "author" and
> "committer" fields record.  The committer records the identity of
> the person who was at the keyboard when the commit object was
> created.  The author records the identity of the person who wrote
> the change that the committer is turning into a commit.  There is no
> symmetry between them, hence there is no inconsistency here.
>

I understand the difference between committer and author,
but some regular Git users don't really pay much attention to the
distinction between the two. For these users, being able to quickly
and easily correct user information is sufficient =E2=80=94 it's just that =
some
previous solutions were a bit complicated.

> And it also comes from the actual human user behaviour.
>
> Many authors can pass their patches to a smaller number of
> committers who make them into part of the official project history,
> so when a commit is made, there is much stronger need to tweak who
> the author is for the commit than to tweak who the committer is.  On
> the other hand, it is rare (if ever done) for multiple committers to
> share a single shell terminal session and take turns to make commit,
> where you would need to be able to say "this invocations of 'git
> commit' command is done by person X, who is different from the one
> who made the previous commit in this same shell session".
>

Yes, I believe users in this case are very rare. As I mentioned before,
I just want to help those users who want to fix things after misconfigurati=
on,
making the fix a bit simpler.
