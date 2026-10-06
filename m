Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53AA3644CB
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305619; cv=pass; b=RGEHcIADO5NQUhH2jVXxdipn4e8S+Dqkxg24KAkgtq+zAoDC3WVVuJ0pe8JjA5l+GfnDhgcclPrKlvnUIEXPrAZGuZgiXs/rw1jx/isNImEt8tNahC/S6wUl6TBSX9Gps77zn+o3J9OYfS0QM+0l4gV2k2cNO6MUG6esTiaAIHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305619; c=relaxed/simple;
	bh=jsUJRlZVh7VfRaVMAxVIvZ90eDXKX/FsX0aGdav2jUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY7DvXGhru9DcKGLP/P9G6NBRb0j2URAm1OpCBizgjK2xgb7MafZrOjvn81AfoVkm9nJaCKVdC3xO6h2KR3CZ9MMcqR1LNCT21sAQ4cfSquj1r8SiuO4nUlctoGnubmm10gL/c13nef6J5UrN4E7jjw+XNEO8B5j7l9BcC5/R6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5GDFusK; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5GDFusK"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso456677a12.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 09:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791305618; cv=none;
        d=google.com; s=arc-20260327;
        b=lneS6pQK5tdUYJmGRc7Huk1eK6iet7G7xprbADnYnD6X0NWmgG4DTe7txHilIBuKie
         i1f5EdkBb3JPrXY20fbhbKnh/OPLAbqHQOmpSEOm0XnsTHPKjNnT6e/+CfCEC7QW/3ls
         cswVP9WC4fAmsAKEmaGYDi5wnul3AJ7E8NH7ajUpBYl/UJCJP0VCsfz6dL7LaYhxYhRV
         56R4PZgGUujbI7o6/zrd+f9zHQigmlhdl3nie32rgUsw5Sk5o/EiHrMxXjUFvtDiGsf3
         Kcv/vyYQv69batBQKdaE7U/UGmGAWqluX7mB5wlAjRZvYsmJcG4u48YXLprU5Vylm6R3
         O72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fkEfRNCGCabgKkBGCTsDVFefSf76Fb21ZTL6m8L2JtI=;
        fh=JSBfD4qI+9SW0GPMgcsigpuTFyNpXQpodDb1vtJqEN4=;
        b=GkdcRCEE71glsmDm3eHAdXsfyR02JW7UqZBYCa73zOum03wFPwcsHmCwq4Bt8teBPH
         KjRdKgP3m/S/ROt6yRIgdhSV6O22WD6d4h64ROLklBfxe0cfO+5TvbIc7mA0AuXYVDbr
         8nTwuFohm8j77VZDImEPgXrKWLSWtSCuDGXQ+e3zaN10EyN/Bvqyq59uXS80k6RWQPAg
         ZPBHsTEHGFjkSQKCQr/mUXAa0ah4oIgjlSZn1LSRjrieJkHk/ZaCmqsa6UB8mY1IFd4s
         2YHYpAtHec2K3FeUiJVjoLbfFBHNK4ZxlVWneghFy9LYQt79RNm11CP47xjDtJ20S+ph
         xgCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791305618; x=1791910418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fkEfRNCGCabgKkBGCTsDVFefSf76Fb21ZTL6m8L2JtI=;
        b=h5GDFusKHd0DQDR4pi5HcrT76GCOGVR0nWw4zgLTJ2qiRokOoK+AKafyHunHGCNf6C
         fmoi3I6QPHwp1ig2f8GC44FO58IMx+AGLV98rz6TPSxdwpfu65VqPonxmnjOOxLxVYiA
         vkpffhqoELmhDTZrvnxygtiZ5p7Z4T+lE2LXBeaDCbZ3h9KHOg2cwV6e8jGP7Z5eVEyn
         pT7ZU7l81xG4XWPlDdSum40hAilrR4W5IheEDzGqr931tUB+7Q8nJHx/9uyXExveQTox
         aHVFdgIxnIAKXi2+zAIP0zl6L2xqz8HH37JuoEGYq9DoWaUaCJj+oAzXqTCGpMY3KFtt
         t35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791305618; x=1791910418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkEfRNCGCabgKkBGCTsDVFefSf76Fb21ZTL6m8L2JtI=;
        b=stUmTVYD8w3dKdRRDwCRjdrjBsUtdp7k/x717HTAyCSQLxHmXqm+yvnIljKqzvVpLq
         6/vY7OXpT3SzHywx5kMeAa67i6BI+dHuwpiFSH03ONgEzwPNs+gFiirWLK7wyCdIChvV
         J+aIVFrdZGXpU6oJDhrxm9TQf+1KQcdHapO0n+G74yJugs0eeb5YrV0UsJg/bAaYh0ar
         p2EHf4pNj/VYNsUTVEhukOHkSZymQUueInwinrw9d0PmGHxEURrcy8DMiV8k43SpB9qN
         g2V4vZaC97Uevwb4M5/twsULZiktq42rE2uy10GxGBtBYSVLqKilLEz6GbNQPUy0y0g9
         i9QQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQpYnN7wriz+SFP8xuxbRsAlMRSzA5hrpu8yY5S8rJSyavHC4FqglKG8zxNGS0dXHBzQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNcvkBeaiQ7rxnoTQwWcfK161GNTxu5HRaHRf/5Zkyv5E8bx2S
	8RTR7ptRmmI5kfMjmPTx+YF7oxtMxY6L3QK6VZFTgjXJ5r6DlPcGy6VBNtFtERdw2e0pyPBaZ7E
	/P4qh0ybZIwABEBjxQHHmfOjgPTEQ6UOGhWbY
X-Gm-Gg: AYBFou3zAJ2ZAAdT1nInp4anu4TLXRNznBWKVgLAhzGbrt8jOJLQC1cVjqoc1N7P6GI
	87NVhD0c87XnZTGCowBlOhsGWghG2+JWkyZG6BY0+gO2gYZklDLDqhvshkjSmnFLIoRsCqFvKL9
	TePiImolaHXIRHSP9zppSlvoAMfECgvhZhVyCxWBo5Wn78V1yarh+9oAypi1tR/uFLW5x3Vv/1J
	pNvyGFGzhaXXtzCkB49GgisVrYnebKBh8xCjob7fF07FDsADaoUfTUy9jutKNPV/9/Sis0zoZ0o
	z3f4cQLst4y6AKLvVO3KZBT8DzfBvfXkRp0ivMva/rOFdxe6KEL9UN1N4zhBQQ0NrzC8vDdDcyN
	8Sc0qoTrsyt7m3HZuxmCoXfd/70OF7AN9ZqbeGwFseCHXmd+qKBhPCEsBO54bZRg3UoizZ4ohK9
	ndfctsmzre2BODY2g23+BzSLele00gGQf2pq2ovhbY
X-Received: by 2002:a17:90b:2ecd:b0:3a8:9cc6:4bb with SMTP id
 98e67ed59e1d1-3a89cc605dcmr54149a91.60.1791305617782; Tue, 06 Oct 2026
 09:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <CALnO6CA_=OsznkQ4iT0vBMWf3L=bmVKMBdk1MTHQdaKEcKwn4g@mail.gmail.com>
 <91396552-f86b-47d7-9805-8f6056c2ed66@app.fastmail.com> <CALnO6CC+h1y=Fu438nm4cd0K-dfPVYq9MqX_+k8fxBU60ot8KA@mail.gmail.com>
 <623cdf71-8076-4967-aff1-3ebeb57d1e3a@app.fastmail.com>
In-Reply-To: <623cdf71-8076-4967-aff1-3ebeb57d1e3a@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 6 Oct 2026 12:53:26 -0400
X-Gm-Features: AclHuK_bHfcyt4j9QhkdMGSPAu_8BqotaL_LTJgm036UIbS9TyqqUuHLdJEQUQQ
Message-ID: <CALnO6CAG-z8B2zXj+QEvZNb-Ufiq=qgyPR5VvQShyH1H_+bgNA@mail.gmail.com>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 2:50=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
> >
> > For now I would say the subtleties in that conversation really make me
> > lean towards the following:
> >
> > - "git <thing> --continue" is, for most users in most cases, the right
> > thing to do. It's what "git status" recommends and will practically
> > never do anything surprising (?).
>
> I was actually surprised to discover that `git status` does not recommend
> `git merge --continue`: it recommends `git commit`.

Wow, yeah! I'm surprised, too. (See
wt-status.c:show_merge_in_progress(), and compare with other related
functions.)

> Maybe we should change that though?

I think so, at least.

> I agree it makes sense to be consistent with what `git status` recommends=
.

For sure.

> > - However, it may not always be exactly what you *want*---and you'll
> > usually know when you want to go "outside" the normal sequencer and
> > commit directly (because you'll have understood some nuanced details
> > about what can happen).
> >
> > For merge it may be the case that they're the same, I suppose (I'm
> > genuinely not sure), but I would prefer to simplify folks' paths by
> > recommending one of the few uniform interfaces we have :)
>
> The only other thing that gives me pause about recommending folks
> `git merge --continue` too strongly is that as we know Git users are slow=
 to
> change their habits, and we don't want to confuse anyone. If someone is
> currently using `git commit` I want to know that they can keep doing
> it the same way with no worries.
>
> Maybe if we change `git status` to recommend `git merge --continue`,
> and we think there are no real advantages to using `git commit` instead
> of `git merge --continue`, then we could say something like this:
>
>   NOTE: `git commit` is an older alternative to `git merge --continue`.
>   You can use either one after resolving a `git merge`.

That sounds like a reasonable plan. Another plan that occurs to me is
to go forward with the "commit" version (for merges; other commands
should use the sequencer versions that status recommends) and update
this doc later if we do change status to recommend "merge --continue".

I'd love to hear from others on either changing status output to
recommend "merge --continue" or admitting that, for merges, "commit"
is the same thing.

--=20
D. Ben Knoble
