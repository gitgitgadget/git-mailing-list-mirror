Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D942882C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020324; cv=pass; b=sSHl/08BvmHJmyOrRXwhEY2E8qWMVt2Wdy3CLJyClRVzm9IybAbQvUN1qilgXMKqFiA4YUxeO2q2jHM2ZlX+myqrk6tQ2coKu3mQjcSJeQZYl9qGpmuiKzygw2sRAobzZgnx+KDPMaotasWO0D1XqMGLyUWQEbXp2sy/WCOMjcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020324; c=relaxed/simple;
	bh=+oYp1+0iGE82ZFF9uXNBZ5xT4Y3wXuc2uLXagSdKncw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq9xRSnoFkgX+QbQDuN7sgPShKDxmTXH7/k+oNH7Z8vzTrnEh8s/bB7UC61JPmhzLvrrriQTItMkIOh3HUraTMxMKEJJWBFBIxTLdr37z1llsOeluPJ7aGq9Ue8NxU3LKI9DLAOJ54ZfyBDAmg7wQtkRjRzAsQn1eYs4bxjENWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVTu78vU; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVTu78vU"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ea16f090b4so72389417b3.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 08:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020322; cv=none;
        d=google.com; s=arc-20240605;
        b=ZtNFW+Y+cA7NRt8XqD4UBKhxPd318twOGyF0MXTtork30ck0IWrPjwioYWOZxXVtyB
         Hn6aV89r7jfe21ssgKTmOVqno2KwXwFXFfDaU9yTDdBD7dkiEzD2TizGRS4u2fPKwA7o
         dSm1LFnxGClS82bPiNPUQGSNDhGV1rRGVeXHoG0a+CJVeW2eS2Rq4p3PITGODOsztVMG
         nnoMhFe297+bV5gQIpLudKpHpv91w5a226E0MdcCQpSI1Q+Em/i+TFAiJq2ZSsnzcYqG
         i6UTQHLhy4xhwRhqgIbZUq3Db+E79fYDurKetKDO4bhci09qwkiywFWTs2cvg5OMfvlV
         3Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BG8zX6+gptRKDOGqSlVhZ4cl0qS9cuCptoOQtEw0q+Y=;
        fh=m8B/XNuaTqYsNUOoywnyMFBQHQdEKktYU2HE5XqewuY=;
        b=lSNGVIj1ApHk1vh9b9WcpPm9PgDjQg0P1Yrq89o8rpb09Cxa50RKPsodWE3oyD6SBk
         Pe6QE986ZcSDsCZbfVMQl1gc2WIqEygUA2B+rYq3b0BwhwhmlGcOK2oGd0iy8MSrh8Xu
         RceA41cERUbuJTQFMCKS0b3oZpnISooxSmRTNQwr5grJsZ9Qy0KWJRAwuBvXIDqqGtBe
         jnRYSGts3/7iXOSJLKgkPPRTgsqrEZVxi1pp8Api0MnLLEvpfRKXR+O4e4uaU2ua8VxR
         O34uXDSEiW7ZPFEDxPAgWDP9/sEeHCj/Ny6YMW6vnlTWKozgrfbdc2xxE2n1zalFbwIG
         AlyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781020322; x=1781625122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG8zX6+gptRKDOGqSlVhZ4cl0qS9cuCptoOQtEw0q+Y=;
        b=kVTu78vUOumUecma0tnPT0e8ByvWU4S0XWXe+MymBI2U+PoMqIGOO2OjVVx5TOq6Md
         yVQrXqJJINbu3RAkGCYxaDzzmFU4QemTm2DZ+Gtm45t59MKo/VvP72Ceq3JJQ2obsTr5
         QlhCdzviJ7krFkLKO0aLctmecb+ue2IFII1K3OUVd9zCgs6pLaSrcDWxrvvUxPypudWo
         BuMjseugAWr3sBCnIA8TdWe5uW3ykesbOHwiWln+X/6wwFgPCJtjuZ8k2ZwnzmqdfYfH
         di85ndJY2c/0EJPnyrWNoGPlOxAkGILkAR7z7DysRiDEHnww6Dv6+mLxObrl5srVjiVn
         L1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020322; x=1781625122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BG8zX6+gptRKDOGqSlVhZ4cl0qS9cuCptoOQtEw0q+Y=;
        b=XOJyZU6NRurEjvoFdN28XWcGdOYlSzAKz2Urb28MTaw8XL9ZdfapQgB9Mze6NEUZPF
         UCjqSo9eHTExXwTrBjQQigpzkvrSXZ1SDD2QYqRpI7HAiqIiGbYsP24FoBlfz1Kd92Dz
         dSmTS5FRS+BDt4jAmlE/ziO64xLoRQAyfhfX3UqGL2G/SsNGnYKEOllhofcCIBbphTdf
         DiVPHBuKcjimunCyBH2CQtAdR10JdlGKHXaJ0l4yPvjxmfh1aK+I+BDj2Q7NJzYh3C6n
         MmO3uwDNMkOeAzNvGab3qGOMyPTD1/5qDAqnE8Lwo2LSm0gT91M5Yn7newhJCstLhS19
         Wqgw==
X-Gm-Message-State: AOJu0YxEliQX3ybELjE+Fe4wHDWgigroZmb2Y64NHTGI/oU5TEGRB9Zk
	CuNvMYFRiRXREWgS7+9WolEG/Y+swK21gUwX5nsZSw9R73OEt03B7P00utsPZe981QBMdBuwq6S
	bhj4E/ozmtOuduBHSBic2jVgrABee/dg=
X-Gm-Gg: Acq92OGRmtA3YWyXzbNxMbzjhwpiEkAwtEpFm9/azXY5QRHD2BNz0EQaS6/Ykbp4eHd
	Cq8FAEfNgCGYlP/B8OxUO+lvYwANW9/6uHc1h4tY6eJ43ETe8AfUm2OpjYASiiozXIQ/p//b7kA
	UeIgcq51UmR6HbMa+Bvov446vtsusBiJ/18+hgsOk5XCt2CY7SOwoc0gvbXiLBZvW3uNFwgZ1C9
	bSM8Y7Tr07cmQmi8k//vnqcz8irzF2iJpZoVUKQsF08fNsHvHSmru4TyXRhSUgssTQ2dYMdfRcK
	RKEGrycgENSwwPHv89FgziGi9kjfrt1N1TBq8U8ZV0JP286N05/E4YWkur4PnybZICK1uW6U3il
	wHu6DqS5Rs0KzPxL4Bh4tk+1FNj+WZQsu7tRz9D1f10yJlrvFd98+8MHs3Rl3YsocJLt70PlcyU
	QjBuuKP8e6GHUt
X-Received: by 2002:a05:690e:4191:b0:660:4886:9230 with SMTP id
 956f58d0204a3-66106e42b96mr17728145d50.23.1781020322270; Tue, 09 Jun 2026
 08:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com> <xmqqmrx5z0po.fsf@gitster.g>
 <CAN5EUNRW3gyLKGC7x5BBMTNKtunoQks9AaXJse4PHvCziRF87A@mail.gmail.com> <xmqqtsrbsvcm.fsf@gitster.g>
In-Reply-To: <xmqqtsrbsvcm.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 17:51:51 +0200
X-Gm-Features: AVVi8CcihtaiP_ShLCNtvbG9v6BTmb6IkKiX1Ki4zqhyVWwajjfK2ZpMlD7Cv44
Message-ID: <CAN5EUNSuuz61pxEk1ZK8RAr0HOtt1f-_mCRpm7RBwoHAcgVAOA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 9 jun 2026 a las 15:21, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > True, after reading it, history being more costly or the in memory are
> > not good args.
>
> And no argument, including that history is new, is a good excuse to
> make these three things inconsistent, period.
>
> One of the patches in your updated iteration claims
>
>     When using `git history reword <commit>` if the new message is the sa=
me
>     as the original, it continues and rewrites the history when nothing
>     changed.
>
>     `git commit --amend` and `git rebase -i` with reword share this behav=
ior
>     and it is wrong as well, but changing them breaks what people are use=
d
>     to. Take the opportunity of `git history` being a new command and han=
dle
>     it correctly from the start.
>
> and I think this is a totally wrong attitude to go about this.
>
> I may have said that it may have been a better default to try hard
> to avoid making a change that is a no-op, other than that it changes
> committer timestamp, while making the current "always create a new
> commit object" behaviour optionally available, for these three
> commands, and cited that the behaviour of 'pick' in 'rebase -i' that
> avoids unnecessary rewrite as an example of a good practice.
>
> But I do not think the existing behaviour to always rewrite is
> *wrong* at all.  It may be wrong not to offer the other choice of
> pretending no content change means no commit object change, but that
> is a different story.
>
> I also do not think *aborting* only when the message happens to be
> the same is a valid mode of operation at all.
>
> The most sensible first step, I think, is to add a new command line
> option to "git history" (which will gain more history editing
> subcommands) that tells the command to leave the original history
> as-is when the only change rewriting commits would make would be to
> the committer ident or timestamp information.  If in a future a new
> replace-tree subcommand is added, e.g. if
>
>     $ git history replace-tree HEAD~20 HEAD~27^{tree}
>
> were a command to rewrite the history in such a way that 20th direct
> ancestor of the current HEAD had a tree object HEAD~27^{tree}, by
> derfault the command _should_ rewrite HEAD~10 and everything that
> has it as an ancestor.  With the "--avoid-unnecsssary-rewrite"
> optimization feature on, however, it may silently become a no-op
> when HEAD~27^{tree} happened to be the same tree as HEAD~20^{tree}
> so the only difference between rewritten and original HEAD~20 would
> be when that commit object was created and by whom.
>
> And give the same option to "rebase -i" or "commit --amend".  We can
> discuss, educate the users, and flip the default at a major version
> boundary, if the "avoid unnecessary rewrite" truly turns out to be a
> better default (right now it is merely our speculation, and we do
> not even know if the current behaviour is a worse default).

Hi Junio,

Sorry about how I expressed myself. I didn't mean by wrong to be bad
or anything similar, I just noticed this when testing `git history
reword` and thought that I would like it this other way.

Saying that git history is new or I would like this to be different
are not good arguments to have `git history` inconsistent with other
commands.

My idea was more of a defensive thing, where you would need a
"--force-rewrite" opt to explicitly change timestamps. But I see the
point of having it in an `--avoid-unnecessary-rewrite` so without
options it has the same behavior as other commands.

I'll try to express myself better in the next version and go with the
opt direction.

Sorry again,
Pablo
