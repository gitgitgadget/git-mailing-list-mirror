Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602C7082D
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818186; cv=pass; b=aB3xu2QsIJ8j+J3E+NtnJmXiEbm22Rs5fhz0OpL4/lyLxBMGVvf19alVSGlndIKjTUwkq5rEkBUf/LtctWPr0/U1/Nhq40FPwLUEui9vG2LW768vjOuBgbOhYWThLNTvIX424tgOE+ErSh6jii30bN1HlKdN4HA8+rYt/waJ7ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818186; c=relaxed/simple;
	bh=ez/QrqjuPA2Vmu0lbbQN4HiXDUWBga9kQLRiPStUVP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTa40LzT4mqKJLDwE+o0FEanY6v/JCharfyTWjLX0CAAGvDtZSQdUvZkSTC6GPibd1UBEHAIW57l2upGhCHZWGnEIf27IDpw5fbVYWhElTpkNUrFOQzHO0BK1IYSUelh9KA8/4yi7AJx21dp1CxgRPSK5B0GJGPQfSF/B0vxWB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxAmJ7v6; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxAmJ7v6"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8453b56ab74so778556b3a.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 14:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781818184; cv=none;
        d=google.com; s=arc-20240605;
        b=jzzUvSupHymZxxriEv770BN6tG1RBO1qn2w77nCGnou/BeIXmb8J8+x16UkxbU0dkE
         gmrQ04tM31rt+QFzqjaM2NfXZdJm44TV3T5SLVP+4DnnaLpBDgNR2bnd/WGSTHYlixoe
         Grhn1cQ/aG32C4rAJwXwizhckkKt2V0SAElNUlTxcV6cbisp8mbTidXLihSBAnBiHa1v
         6eD66s0yclkMM7r9AQzvxg0tVoZxKBRLZZaTtueVrneOejJ0Tz9k5uCKF3Z0HhmI7Vfj
         tAgz2Y+qNBHSogJuZ2t9k2XYDhL9uWbCKet8jHo1koUXSAsD3rpwuERtI6sOpJ2x8XsP
         fDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TdG2BeF8weZx0fpE0PDHnbV1CoaZkof/NP2IU9VG+NM=;
        fh=mzqUJKA5IdQVsYBzh1muBtS2EzfAZMKuteHbNA2KTDA=;
        b=ZEkCwAWVdgyXR+VZTevg8WlmGLperaOQC+ToJPuuxGxmm8El0PMGbsuBVDxeqtRUiR
         n1Ac0Xf7E4SVPvVfbTVKRsoxqys2wS9ToMTTKQ9GhAoERSR/Y+IKU3pz5gRBWqIzSYQH
         qJzjTo/U1x3GsLz3a9Y06uFC5hO7ptDvmuqjGo1/z1UCuNgCWNP2/XzDr7FHr4NFeduT
         U25d0X2y0lQSdikWT+H2ZjEuaFXGKGgKj4fGCSbnwVA9Wb1zBoNDaCA1Do+NTHkLTGkL
         YGYXVq6sJGJ8EJ4gv9//3URWSP2U581mnmIM2mXMu8cYI3EcsDzrC59qxkQEWwz3AU4B
         cbNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781818184; x=1782422984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdG2BeF8weZx0fpE0PDHnbV1CoaZkof/NP2IU9VG+NM=;
        b=TxAmJ7v6anZQ8AXOPbc7I/RSFmjs38QuYJ099fNNI8+5R4wIQG9PAGxU97MHx9KMwg
         JpyxEL/DYzJbYL+9ZVGBIj0EmitQHiIgylsn9xbKeSGcS9wCHNGEgvBxfHCtSSfC+m1S
         VP9cf1kmUTtG5YwwESF7ywKLa9rNDfOcSzEXbBTWs5DQjy5NiLaDN32JVmz8UYAOiasP
         XfDN3SgHxolVPNQ0fWkPtKzrCiRi0/2Q21BrNWNybm6HnDNKFgPnEPZWKgVJJiriBWk0
         WuCw/MPHs4hdwDCthhbSFaa8evgY92dm8cUUAiPF+2Ei4UoYC2gs/cyqy7jN8LWx7ZEj
         AEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781818184; x=1782422984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdG2BeF8weZx0fpE0PDHnbV1CoaZkof/NP2IU9VG+NM=;
        b=oYpR2t6z4IFJR9uBtDcibpGs0hpu8hevZ5ynPZOh2OuJecm4OmRbAaHIKvjF/ZOLm9
         MRIc3kITPflN+v+Cv/cyrviMmMtc95Ya1oiqln+Np20ECh8WOI9wG+NI6DfWQ/oQY796
         hXhmYGkPhRkR767PzjgbTIOf7QtRrW8qkizxG+40kRogm+6Fh/DMoLTwOGq+pQsvfben
         mInA9TPZmtNEeaQ3/t1SAqlSPG4Je7ubWNYez07UdglbsiMtBM+T2x342LmO5yCjQqYo
         rhWABPYhOJH87XeuLzhl29Is84ir6tbQvLJaLVqQvbah7spREDpabEgUHz1zihh9GJCO
         WK+g==
X-Forwarded-Encrypted: i=1; AFNElJ/HpW8cpZHPRrS8UOOmiuDUpG3ECwfr6h/9+Rf+1qrp0nkaCtWPs6pAewQe/Zd0T/YIygg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmeJvShgvlEhkuX05gkvEtrHSX950RAPK91rWDQi81ktSUUV0
	+Z/ijmZ34I/c5Fyhk0ORINv66kMKqIOnXaXmf09ah6Z93sefJ7eILBdLJB4F9lOgU9iOzE3j+LS
	no9JxJY8PrcruU9T9mwA3eyzLEz0K0zQ=
X-Gm-Gg: AfdE7cmo1NfYXKUgqOf6E9SYxBy5EwBlGFdE6vMkQBynd7gtaYVEdrRxIUyoFfrEad6
	Tuwwz+PZkcf/fm6ayHUIE2v8A0WhjqdEOKcMBphb95SG3jw7WI77M91OXcFeOGqOXLBxQwTxmVP
	AE7nOB4yVMPDLTumMkcDlUOxBpRqUqdlOUJUOb6c/6755py/K/vGJnYvk+rhxWK7Jgk9wVMZN10
	NDCfzHh/gTHRVGb2U2ZoCeFqzm9wasdLGJauV3cZl80xfdgTrNs9dsZ+ayDAUA6dMQbMmV5Rklw
	62L+HNp4owX3xqniKWrzf4Ap3Nf/Tv/8t3HI+/ghtKjLy4txAt/l1JEWT8WUprR+W+VSZJhx/ZJ
	m+g9f
X-Received: by 2002:a05:6a00:1d89:b0:842:5ea5:5fdd with SMTP id
 d2e1a72fcca58-84550b1c4b4mr772945b3a.40.1781818184214; Thu, 18 Jun 2026
 14:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
 <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com> <66b2f49fb427c7328136b2d440dc7461b97fb4e0.1781810227.git.gitgitgadget@gmail.com>
 <xmqq7bnvr3qb.fsf@gitster.g> <xmqqzf0rpmn0.fsf@gitster.g>
In-Reply-To: <xmqqzf0rpmn0.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 18 Jun 2026 17:29:33 -0400
X-Gm-Features: AVVi8CfYzKQfOQOq2LJGKPRJJVFvk0J_ZTDvyPTi7WiF_O2NYB9XVZMl3JVcVNA
Message-ID: <CALnO6CDK50QhiwfO3=gyrn0HNFC6=2FfjByAcLxtg0op1cpF+g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] history: add squash subcommand to fold a range
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > As t3454 is taken by another topic already in flight, I've queued a
> > trivial "rename it to t3455" patch on top before queuing the topic.
>
> Another tweak I had to make was to replace "grep" with "test_grep"
> to avoid triggering test lint added by another topic in flight.
>
> For the one in the second hunk, it may be much better to rewrite it
> to process "out" directly with the awk script without preprocessing
> it with "grep", as awk is a programming language capable enough to
> recognize a line that matches a pattern and process only those
> matching lines by itself.
>
> --- >8 ---
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Thu Jun 18 13:44:36 2026 -0700
>
>     SQUASH??? avoid test_grep lint triggering on uses of raw grep
>
> diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
> index 1edd148295..20370c0136 100755
> --- a/t/t3455-history-squash.sh
> +++ b/t/t3455-history-squash.sh
[snip]
> @@ -177,7 +177,7 @@ test_expect_success '--dry-run predicts the rewrite w=
ithout performing it' '
>         head_before=3D$(git rev-parse HEAD) &&
>
>         git history squash --dry-run start.. >out &&
> -       grep "^update refs/heads/" out >update &&
> +       test_grep "^update refs/heads/" out >update &&
>         predicted=3D$(awk "{print \$3}" update) &&
>         test_cmp_rev "$head_before" HEAD &&

Odd: I thought the other topic acknowledged that bare grep as a filter
(here, with stdout redirected) was fine. My memory must not be right
:)

--=20
D. Ben Knoble
