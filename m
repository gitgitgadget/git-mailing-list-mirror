Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE23515987
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681935; cv=pass; b=D4t1YpN2wRlxw1/78MDqdORRSfI4vZ6icuFDoutH1pKc8VQkTGdYKHuwTQhQQV1wYqUAewjpSC4DRhiImot1FWrwSRhsDFxvL5PocUc0e2Gih6852s22ABPcLTqhJweyDHR7XcTZ1WnKYk6uGNgQnrlFQuG0UxRs3ib56BuNVtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681935; c=relaxed/simple;
	bh=bylyYDJr+HD6/PqCn7l0U2G+KKURReTsy9lRhEjLyYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y57GqmOoNvvMUEHBXuiMaoagrZwBuoZYBIdFIRwgHUKDVRFOwNEhujZPKHmrKOOFWVcUEzm9qM0gRYmzEMAuPWbdbXRF+PhTwQRIPaKNlnbl/6qGIsviVKHjzIn/TTQe365Z3xdsAlGiXsOBKWs3LXNOho57wsG2pWs6J3NKUb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPgB0+Fx; arc=pass smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPgB0+Fx"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a498cb99b3so396846a91.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 04:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790681933; cv=none;
        d=google.com; s=arc-20260327;
        b=WyFu3vBRpiL2zuRzXUyEEGrpOngZLNfPPph0CgXLzqJ0wlsOlIaZJM5QloA95eNho9
         QkiNeFBgbwZ0d6tT0cyvW18jgPQshmkjzWFfQ5FbFl3znP+dmQPyV+KK2PVvleXUjNxU
         h1PfO1SlGxbrim2GY590FmWpSFtHWGhooEQRLyrgTVLtFmHqNcPdno8ol0po7bIuT43R
         xSE2L8eL1/vDbW18KKJf26Qg6htwdjMfE138RfOxZWhdnSlBu/1fgrCJ+2gfob7Fbtdb
         TynfEXqJ9SStK8C5aFnrMhkYWYv26HFyLkP4tPZFEEHp1xJMP2E/BE3dZxnJE7yCp2dy
         LoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ry9onfbAIlMSnJoWhp+p36hj1rTuTYxsjK5zYEPs+gM=;
        fh=Yc5tcaQn2ra69+RkkQeLK6T+AKoRLmdoMcPAvgmZadw=;
        b=eDagoXR2dM86U+kvtjNn+G2OqzB/oecK+DGKr3yGFn+RzPkTdyk/JWqVBv5SKSfBZu
         SCiohI5qdUsVUXa32yCJbxb66J3gHaxCMu4Z0t/hjUZtOGBmgioa5neSy4+Vhd9GhSuL
         /VzdVPdxMjaXN8w0b6uAuF9RfVURl8SCrp311JulICVMLG6RC76nq1WYA+FrJ6mIJDJY
         J2N+GdvchbXrD6seaAZNmx10BJSdFMkyd+a7J1pcwNh31Ut5B9VK+9jbCNDWol1V6B+b
         eSm+vd0rOtrzTBU8aFf9U+cxYypTXeBbCe4eYEeQtVHeMiurvP9DlYWL/JIAzA0s7hhR
         MdJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790681933; x=1791286733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ry9onfbAIlMSnJoWhp+p36hj1rTuTYxsjK5zYEPs+gM=;
        b=bPgB0+FxoqZ7dVlYt5Vaui0PPcF0hmI043UuOp8Cio4EseRSntkRBPM18OXNHV/Bpk
         FFMfZMMWYKtcjIJaGCnsFFNw8bx9SVbvTcP80rHGItOnyG5RtdeHQaBpzLCtcu/YaosH
         f8EuBjWTToNvS0+crR+s4s0ZaYterrv6cNAaw9qLMedXVy/KeD0ew+q/Na/rWmnfueXy
         FM6qsZRfqxlxrS0Sj9hv4eJmRBaWCL0+XZy2fDpVxGrFKgApsiF6jcXPKWgoygMf7fDd
         wNqMoRYNQzblXfrb9beE95MZwa3e+FpfKRB9tis6hL0YkmVh1GXuG37isJRMLT7cgCmr
         NdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790681933; x=1791286733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ry9onfbAIlMSnJoWhp+p36hj1rTuTYxsjK5zYEPs+gM=;
        b=Ai2WCCrfrogbbrIbqIhJTfjGehkvsenaeS+qROkmq11jV9m+4r2TKghqebUs+xyrhY
         ph1/9M+LbhVH1ne+Pw/Z6UzAXW+Cnc0sUEDfLIh10/7HfP8CiKX8/O80wOz53HCeVGQi
         xc2h0G+lZKnuNGTgZflnZQRjWLxB9d5YSQ75fc7P9UGazpFIJYYDIJfaST0yrEehy0gh
         R7POiRs/sCRx6J6YvpwnYKqncBvVyS47EYtM7uVmI6v6311z+A8XsxZw4/sQv9BmHfeV
         THNVPcaCKzCCse9ItapqNehq6fEBrJ8GlCnF3HnPLeD7dF7QzFBOeFbRfrFT2kNIRA6J
         jAkg==
X-Forwarded-Encrypted: i=1; AKwUvByxZ4v2XI7tpi1X+z2a7CroelgdoK0nzDTo43Oa3Px+MSD8RFOEDLT/XBHmAL6Ehm3cXeo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhH+eyUeuYGS5qjgJnK/cr3Soxt/V1d+fG4CG2hBqAIqy30ovC
	IYfWRyRfviLN1UL51AUOGZVfSR/dLfiPwYKdAd2Ppk+KtzfUcvMwiIIH1z2e9INVEOuz79pu4v7
	chDPSRS5ERMmAOfi0jFUvOhOqYPhL6Tg=
X-Gm-Gg: AYBFou3ReLKe+RuCAd3lVWp9e1T/do2HdDzhEaNetbswX9wfKD/L4ot1IWn5NqX0h6J
	5VHDKm4Aoz3LEypFPlWSnQaprrAMWTLiXbEjXFjHGQhwPDhJimdQ8qdVDW++vasK4OTY1PoXLOo
	fH9X6SNyVBe1LNo73xBHzNgujBhkvcHtvOYCXULKYU9sUwJTSjw1zjR8sbZBD1h2h4yNXfgKVrV
	v3ZR/2Te7/ts24U4SlTJGvW2GEwT9V8994+fmvANGcjj9owGjDl6XhON/UuPdgVbllV/XqZefcO
	v1McPKct5ip9QJDBTDJFl73twffrjJwt8MGnocZTMJyf3d9Fk6oDXzESbi9H3Ot3NQgHcr667xg
	W53j3FQFSFRdVB75mJJw3ynIeKpEQpDFBZj65U1GWG8PulaUKfdBKxk51xgs4H5yLRa7wYdezhn
	w+Yj4fewDs
X-Received: by 2002:a17:90b:524a:b0:3a4:71b7:eb63 with SMTP id
 98e67ed59e1d1-3a471b7f585mr3210226a91.10.1790681933226; Tue, 29 Sep 2026
 04:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
 <xmqqjyo6qz3z.fsf@gitster.g> <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
 <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com>
 <CALnO6CDOo35HAfqn_h2CUUdux9LeOkjM8OdFLkkS1nVexijUvw@mail.gmail.com>
 <CALnO6CAf491aNhqcb7K7YcNTSTNLAESmqeLwzEGk_S=ZsOjG9Q@mail.gmail.com>
 <a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com> <CAA0xjtpzaWH10pHOQ5j-5Hp1yHEKTDFbsicG6E4w=5nxb_irWw@mail.gmail.com>
 <CALnO6CC-eop86W3VREwGz0seG1pmtd0qS968TyP=mo_G+ZMrSA@mail.gmail.com>
In-Reply-To: <CALnO6CC-eop86W3VREwGz0seG1pmtd0qS968TyP=mo_G+ZMrSA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 07:38:40 -0400
X-Gm-Features: AclHuK8Fpua01pe5GjNQi3pAq7AIKI7TviwLF_pRdB29x2uDIp5B99RUpyfpnuo
Message-ID: <CALnO6CDnYmmVfcTrkuQ=hTUDKBAAspYrSxmwM+yVUSnJinN_Xw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: Thomas Bachem <mail@thomasbachem.com>
Cc: phillip.wood@dunelm.org.uk, gitster@pobox.com, git@vger.kernel.org, 
	eli@barzilay.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:36=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
>
> Let me see if I understand correctly=E2=80=A6
>
> On Mon, Sep 28, 2026 at 10:50=E2=80=AFAM Thomas Bachem <mail@thomasbachem=
.com> wrote:
> >
> > On Mon, Sep 28, 2026 at 3:45 PM Phillip Wood <phillip.wood123@gmail.com=
> wrote:
> > > Oh, when I was thinking about this over lunch I did wonder if that mi=
ght
> > > be the culprit. Previously we didn't run "git maintenance --auto" aft=
er
> > > a rebase with the 'merge' backend but with that topic we do, and beca=
use
> > > we set GIT_COMMITTER_DATE to sometime in 2005, if 'git reflog expire'
> > > gets triggered it will expire the reflog entries that 'git pull
> > > --rebase' relies on. As you suggested in another mail, I assume this
>
> > "git pull --rebase" computes the fork point before it fetches, from
> > the reflog of refs/remotes/me/copy,
>
> This is described by the manual for git-rebase under --fork-point,
> which is on unless we have an <upstream> or --keep-base (modulo
> config). Put a pin in this.


> But here's what I can't figure out, returning to that pin from
> earlier: I was a bit surprised to see mention of rebase reading
> reflogs! When I remembered --fork-point, I was even more curious (but
> at least it's obvious that rebase will read the reflogs in some
> scenarios).
>
> What confuses me is that builtin/pull.c:run_rebase() sure looks like
> it provides an <upstream> to the command invocation, so shouldn't
> --fork-point and reflog use be disabled????

Indeed, from GIT_TRACE2 output I can see we do run

    git rebase --no-autostash --onto ae98=E2=80=A6 f29a=E2=80=A6

but well before that we run

    git merge-base --fork-point refs/remotes/me/copy to-rebase

which is then presumably fed down to the rebase. Interesting.

--=20
D. Ben Knoble
