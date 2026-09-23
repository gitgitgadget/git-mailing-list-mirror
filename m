Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506B551995
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182521; cv=pass; b=jt5hjtQeBV1PTALtRywGSsLm41wnku8/DdHUdWmnijGqDChM0/XE/zGrzcKxzaX+KaimXwpLRXnW3JD04mTZG8hUMZ5Euo40fZr00iEUXRPj0WhZNeQL+/sGkY7fu8VQd3nYZiwwf9CzY0oK2elVkkAqBTAs5UDyTOVA3G+wwqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182521; c=relaxed/simple;
	bh=20gaWGmLmAHCBtf93cYYe6WAPBfFuY1CX0MFSuBtoqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdCf2QIWP73lWMCE3qs61fkyAek9cJ7qorWIS9s70Wa6Zo83pWIaEV8PkaEO9mm8auyqi5jgDaIVgruLMR0Vnbfm7zN+G4eMVKA4O4rMJ5ucvQSSsppBC7GTe2APjXArv88Z7OBii6FPcIwPxLU1FMbDd1+PpNZXXykm816CMuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWmH48lc; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWmH48lc"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f9bso6401095ad.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 09:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790182519; cv=none;
        d=google.com; s=arc-20260327;
        b=YNkd21ucaXZtIL0oiNncSrcjLuZD3IMYeZfx30D3OlTAVqU3yP0jgzP5G5fR8oycPa
         qNedKuqYSScvXYKEsxrwIfCh4nfiT9waOnQBRF+dV9ynANNv3IuJcgLejzuKQS7dwd3L
         OeQL80639eVoH+Ab4znA8pHgtg2vVVj4rZZtV6fnP8TQjxR7GwmtvrJq7AmhmhvWMXXm
         +RgvQxwkE1KHZ8dNED6NjLPXPXqT8FE1Q6KX6VcwPJUIIeFX3mhTSHdelqyqUCc5VaXu
         RH9Bq2+5/+PrUeeMBGSZNb0QDl1RFWdF1D8ed+HOKDGVxbeniywk5M0yvnB2fckhJKnF
         7aCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnxkKVjgbpee6CbjnXR4XR7EeyNJkjDu8tuFhFrJMyw=;
        fh=EtnMJ8nh1Hz7/LoaFhH1peums04cMnj9QsFeWJ8CeNw=;
        b=f75NmsPTiDbYwlIHKvmBqRW0vcfeii5nKWeHnSB6wwVfgmSEZKt76M9014HL/JDIgE
         ZljMPEZYdEFW634qDV7O42ffH8m8fSZbO/cRd4A/XdtWfe/+xDNqlDfMWLzn1F0sierm
         fKlPHIhOX7VNzctUn5TxqGztHzfs2CYqRet/pxjZ2UpUTqirjGYFRTeR6Mnn5nsdCIxS
         GzST3A/MoNhSzW0u5TRhMpU7naHJ5qBBfNugx+g+lh6JeXL6IvCcg7XU+wbAPd00+yFO
         c7sMpKKUFmGzN5iFxoT2bj4lES8Ae31qPRFI92DEErPD1e4JZQ993BMXEN4PV4Dxnhi7
         1IMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790182519; x=1790787319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UnxkKVjgbpee6CbjnXR4XR7EeyNJkjDu8tuFhFrJMyw=;
        b=NWmH48lcXUreZEMDAow7mg+iVTSCXKscZo9wT1cVzhEM92JHDWeLSJoeLiBZB58dE3
         uinqmJbHZxM7XIUV76wVJaw6D1xJ8+/sNrUN0tfPhn5xQy4wZuTDZZ3BJoJ5lKlWVhaF
         Ai7vHLaJ8+sxkZ9cTSEjXJjXxA84VvJnwg61GFA/yPCv9VEojvKsatwFhmwU4xFRteeN
         gvOoyN9M4K28Td0/YHkH1qyrJx/c5UFC6Sau3gsfU8tnSkfQPYFDEle/X69le8KPbbU9
         oDgAPqvlubctOUFbgswRtRDiIsiVNK9IfDv4+/w9lqUskxQ/TZhCOU6Hq3LvzPEaQ/Xl
         xWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182519; x=1790787319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnxkKVjgbpee6CbjnXR4XR7EeyNJkjDu8tuFhFrJMyw=;
        b=Cwc4mdeQaPrFCYvPwt0ym6+f0JyAJpMh1ZmWhyrhenQIgBF5OFkNwnkMZXT407mjN4
         HtjGPiyuG2cPCXgJIx4rbNxnA3dGW85MDhei2XBgtfnItlRCVQlRRztlE73NCGb2XYpA
         dveOfh+7nAVv2jss+R4cSNgcgFnfU+A4v5wlD/GyMBBTs8L0qLs/phndQSZ3WDtNC98R
         u81d8Q8HaiF61rZW8p7rY4ATBNydGFa+jpKDl83YJrl2DTOT3N9Glt0EgmZhq9YZgw5s
         2IJ48VXBcHZxF44DQ8u4BXk9a2onerT4fffxABtbQYMQZzoATptXgvkfFoXI3Gmr/SGq
         667g==
X-Forwarded-Encrypted: i=1; AKwUvBwNTDuVU8yxGF7uL24B/2v2Mh0S+9ACy8ihux45kQboePAm2l/i9lykiw4YQsyZP2FmS3c=@vger.kernel.org
X-Gm-Message-State: AFuF++nItOwGgb56n8O2Cnd03pCQqKXIGinl05i1RiJjIjbqlMynXrDt
	kutGCw6mPQMH3ZUxg7XetmDgGLADGLbOq+gn+XdRA3+tFQ0Hb2clPs9fkF/aP8unlZlqMgkuWfR
	/JKh0iTosfkVsn3LR0kxcRSduqUf7ZZg=
X-Gm-Gg: AYBFou0scTvTzernIGQ2wu+QRb3BvH9TeYpjBBBukYb7LId5z7ReD5ZVTZyvoVAAapk
	7S7WJyCstBsc43eMEAtnqlH3BuC3DA0Ub2gZ9IvQpCnt4SKqvBm6AmAA5oTd7Vs/1TRYX69JZSc
	re+PRPLJiCsslt7isP8Hayw+6TkDt1wLqE1yiREWpYqkRXUtCGhKACJ1ZmCVY9ysLQEdoiOphRz
	AuQR7jkHgZXv03BaCIli9U4rSdVRN24aSNaPZ8wLI7yHr4IoxRNLE3gpMsaN0gYQFr3wexxyj8c
	ijiAmVzS701o8sGsCsBtlM1Clu5T8tayShcm4y+haq0EVovpg2EGy+Lqbxus062t/8xRet306/X
	MjFMOqk+UOqNVM0VqQKQ//WuFeQE9PFPfkUYIE8r5k/SyhH+l+G0fOvmoDg61xRguRiNKhz2chC
	+G+kyijipIInvKmO7cDMRO++v1bakj
X-Received: by 2002:a17:903:2284:b0:2dd:ad73:5b74 with SMTP id
 d9443c01a7336-2df69dc873fmr26778955ad.36.1790182518823; Wed, 23 Sep 2026
 09:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com> <xmqqh5jhfbyw.fsf@gitster.g>
 <05d0e6e0-e156-4a2a-95a0-4986ab18ef49@gmail.com> <xmqq5wzwc76w.fsf@gitster.g>
In-Reply-To: <xmqq5wzwc76w.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 23 Sep 2026 12:55:07 -0400
X-Gm-Features: AcwNN1W3ttFrHaHLY6OQNJEaeQBH57F5Q8F8OYURs-cnvkdU2btt8_3rGlMSoBw
Message-ID: <CALnO6CA2DXvyOO+fu04sozg2=E0JoymAqyhs_heHzExgRSEzVw@mail.gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> when 'remote.*.fetch' is configured to signal that special mode,
> >> 'git fetch' would:
> >>
> >>   - Find each local branch that has its '@{upstream}' set to a branch
> >>     at the remote we are fetching from.
> >>
> >>   - Fetch these branches at the remote that our local branches care
> >>     about.
> >
> > I can see that being useful fetch mode for a remote that we've already
> > fetched from, but for a newly added remote there will be no local
> > branches with their upstream set to it because "git branch
> > --set-upstream-to" fails if the upstream does not already exist. So I
> > like the idea for fetching from existing remotes, but it leaves us with
> > a chicken-and-egg problem when adding new remotes, so I'm not sure how
> > it would work in practice.
>
> Just like with "git push there :", you prime the pump by explicitly
> doing something (for "push", you do "git push there mine" to express
> your preference to work with branch 'mine' and share it with the
> remote).
>
> So if we are to allow customizing the refspec used for fetch with
> "git remote add", you might do:
>
>     $ git remote add --fetch=3D: second https://ho.st/git/second
>
> which creates:
>
>         [remote "second"]
>                 url =3D https://ho.st/git/second
>                 fetch =3D :
>
> (Note: I am not sure if ":" is a good special token to express this
> mode of fetching, as I said earlier).
>
> Your initial "git fetch second" without any other arguments will be
> a no-op.  You may decide to work on top of their 'main' branch by
> running:
>
>     $ git fetch second main:refs/remotes/second/main

I've wanted something similar for notes, so allow me to interject from
the sidelines: it would be even nicer to still have the ability to map
fetches (so that "git fetch second main" did the right thing, creating
a useful remote tracking branch with the usual hierarchy;
configurable, of course) on top of this. So, the first "git fetch
second" does nothing, but "git fetch second main" + creating the
branch does as you describe.

>     $ git checkout -b topic -t second/main
>
> At that point, the local branch 'topic' is built on top of their
> 'main' branch by having its @{upstream} set to that remote-tracking
> branch.  After that, running "git fetch" will update 'second/main' and
> no other remote-tracking branch.


--=20
D. Ben Knoble
