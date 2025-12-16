Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67023EA81
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846673; cv=none; b=nlSYa0WIczpwy6RdwgIz6rzlxFdVASwex2Vj91xVWxCh/jy4Owc/kWABsDAj250GAukZ6itCg/eTlcNfUYV/gJ/mEBtyUzf94Z72CMmCuNcaz+UlMbWRCUvTYpBtWsUvWdMvs6HLDIJw6ONwWO55FL9qkbdZoLMeuEf4Jy7iwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846673; c=relaxed/simple;
	bh=ypU6ujlOykUcfV8kybdBHJfhxH2J1iANedcr6UdViw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHEjvuM97pbkMGyUmETESzPxnESt/S7ePoFeHjolaI35mnjP6EHsW54yrkgTFwq4dWIY2EXVKoqP1ddh0yg0llmNPIcHNfpFDX2wzhXWLa93oGZ+ChYoi6AszgvaCjVC4C4t+H+l00IpDi1FqvMZAdMqTTY6+5PyYOU1QZzEXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4zvXwDN; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4zvXwDN"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-657490df6f3so2334756eaf.2
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765846669; x=1766451469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPP1sW+knwwjLsecwRNbFNPYMluKCxNZGwpf3CiIHW8=;
        b=B4zvXwDN6ovu1olb8OjTJViLQ2BVK1NHLxbCmJpNbGFrFrTbQJ6WWV6rz8awfLjFJg
         uzzPJxSU1E8X6R0uJYIYa9o8ICr6aK8zQ/v19sltckR0B6sZrsl4TwMrNCVL8G7RqC2Y
         FEeHjBe8TVCWzTxFqGcTKrilp7lnMkic5V7DrIgxZw1QfjCwA4DggQXtW6BROZ14+d7r
         cu3F8+l0/EiMe47s4JHmLmaAnoGgzTD+SyslHdPdUbU8SSIkshdrsSkp4xPcG+lV/qqM
         NhagSVbL5wsphiFxU0Rrnof4HECi8Aw063hbwguXXm4BtxstiXDHt6ySPuHSBBT89k5O
         qcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765846669; x=1766451469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPP1sW+knwwjLsecwRNbFNPYMluKCxNZGwpf3CiIHW8=;
        b=UrvCyoZlM8XkIbyt0p/KSPLGRZ+iDrJm+GFttms6yELl/N6yLJYEHURrrcu7SmK5j8
         1jWxsGBIbS7jOZdWpITvqiPkeEDTJzthyXWiF5c0o2oK7EXcHXCHhzRyYUCoWQxEyZ2J
         DlFUnWBdCylash0jXnNDGHY6We9/Iqq0pFVBf/upKFV1VPyk4I7TiIl0kN9L657Bra0u
         f906zqjbBJ95QrypNff5aND1FBdQ9IAPuozCCNp/nRQrEENVlerGQFCLYY4bEu76lXkr
         qOCkIgTUA1NDGxwLMv/aAd2DWk5TOEiXGB2wiD7pKgNZfcfsvCQuJ1pQk9PsqQ7kmOfI
         DZRg==
X-Gm-Message-State: AOJu0YxFCJKwydod18Asac1ATthEja/VUFlfftKdrH4rdqjyQZ91LBrv
	PtWx61WwVWmzX5Moo/kVNLVcRfvdPnmMjx2DDZmb2dyiI6Kj7gBEE2rjm9+OLUqIPCb3FGv5I6A
	T8ad27U97m/Jvpl1PKJXThhj8xq7xF+U=
X-Gm-Gg: AY/fxX5EgryBHE3ml1tRO5mHgapej82EEVzZREK5eGqaNh4SLPwVSvOhrUuQhcX8tqJ
	i/cdR7SB8rNUhYYQVMs7/A3OYAiWKOwP2NUDRALbJ6s+p6yV5VDGSpSuzgS44KcRHstCX0WJPUN
	JPB/WNWoD6f07poHlYSTvD78g0KsAJzFBbeZoYsyazvJWq56oZHZIQ5hPPa4Uk1BTOalWpd6bKs
	0pvkm1HJJRN69PqaoUmRHmPSQ3AqL3hnoVtkpsawV1/eJlkWnLx+Dz6RGLW/iU8vBtkMXItZJCE
	/7bUTG/iE/nc14Yq7zyZFM86hJfW
X-Google-Smtp-Source: AGHT+IG1wVEASBI9+ZNZ3VHUOBn0NLN0uQylkjNWyEtpHlC6WTJr9v3FFAu8G4XWxNVln0ZJ+kSmATI3zEKu+JvR/Q4=
X-Received: by 2002:a05:6820:1b09:b0:659:9a49:8ffc with SMTP id
 006d021491bc7-65b45257f44mr5402756eaf.41.1765846669013; Mon, 15 Dec 2025
 16:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3742e7de-7d88-4e77-b711-9fed867a8c23@gmail.com>
 <CABPp-BH80R4LJDRKQnPmh5Am_HAcCgxWiA8vRoN8LgLRUMz+JQ@mail.gmail.com> <d7135cd2-e577-4f96-8142-cd9c7cd6995d@gmail.com>
In-Reply-To: <d7135cd2-e577-4f96-8142-cd9c7cd6995d@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 15 Dec 2025 16:57:37 -0800
X-Gm-Features: AQt7F2pV489-bFUpdd2pSZ3X9c_STaYbetoIYU1iEG3skTDLSgdJwnwiFc5MCQs
Message-ID: <CABPp-BH1qgQNHJzJZ05Ckru2PdYxRnWfQ3xVPrqGG5F56bX1aw@mail.gmail.com>
Subject: Re: Different behaviour for --find-renames between git diff and git merge?
To: Luca Balsanelli <lucabalsanelli@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 6:02=E2=80=AFAM Luca Balsanelli
<lucabalsanelli@gmail.com> wrote:
>
> On 13/12/25 02:57, Elijah Newren wrote:
> > On Fri, Dec 12, 2025 at 10:06=E2=80=AFAM Luca Balsanelli
> > <lucabalsanelli@gmail.com> wrote:
[...]
> I would expect that `git merge branch` would detect a rename and the
> conflict resolved automatically. The 'ort' strategy (the default one),
> "can detect and handle merges involving renames." and the default
> similarity threshold is the same for `git diff` and `git merge`. I
> understand that the merge procedure involves finding a merge base, but
> still the rename should be detected between the two heads.

No, it should only detect renames between the merge-base and the
heads.  The merge machinery should not diff the two heads directly;
that goes against how 3-way diff works.

[...]
> Even though the `git diff master~1 master` doesn't detect the rename
> (the content changed too much compared to the empty file or one was
> empty (although it says it defaults to include empty files as rename
> source or destinarion)), the rename should be detected between the two
> heads, even when merging. I tried to read at 'git/diffcore-rename.c' but
> I'm not very good at C and it would require me a great effort to fully
> understand it.
>
> So, why `git merge branch` is not detecting the rename and not resolving
> the conflict automatically? Does it use a different diff machinery
> compared to `git diff`?

Merging never diffs the endpoints, and shouldn't either.  It basically
does two diffs, each from the merge-base to the end-point in question.

If you only diffed the endpoints, and one side renamed file A->B, how
do you differentiate between A->B and B->A?  In other words, you may
know there was a rename, but you can't tell what it was renamed from
and which filename should be the final one.  You can only tell if you
look at the merge-base and determine that the file started out named
as A, and thus that B should be the final name.

If you only diffed the endpoints, and one side renamed file A->B,
while the other side renamed A->C, you'd be misled into thinking this
was a normal rename (you'd only see e.g. B->C) and be unaware of the
conflict, which is problematic.

If you only diffed the endpoints, and one side renamed file A->B,
while the other side renamed C->B, by diffing the endpoints you can't
even tell there's a rename; you simply have a file named B that was
totally rewritten.  But it gets subtly worse in special cases that
might really confuse end users: if they modified A or C on the sides
of history that didn't rename those files, those changes would not be
propagated and combined with the ultimate B, and they'd be left to
pick up the pieces and try to combine things.

Further, it's just semantically wrong to diff the endpoints because of
the underlying concept of a 3-way merge: If you were merging D & E and
simply diffed D & E to do so, you won't know whether differing lines
were added or removed by recent commits.  For example, you might
notice an "import" or "include" statement that one side has that the
other doesn't.  But did one side add that import statement?  Or did
the other side remove it?  You can't tell by looking at the endpoints;
you have to compare the endpoints to the merge-base to find out which
things were added or removed.  So, fundamentally, a 3-way merge thinks
in terms of diffing the merge-base to the endpoints, not diffing the
endpoints.


So, in summary, no, merge does not use a different diff machinery.
You are just diffing the wrong commits to see what it sees.  Combine
that with the fact that you have a funny special case where both sides
drastically change the file in a way where the new versions happen to
be similar to each other while not similar to the original, causes the
behavior you are seeing.
