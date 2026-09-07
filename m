Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC351D52F
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799043; cv=pass; b=Jd3fvHJLeyYqiE86p7Q5Cxp8zo1rwXmtaAfFa6QLOYStEQcCg1KTfWbcQjIyjm5MA3zJ+3mBOheBIg57NNOtODsad35z/nTYarLIKzzkoik7ILhnySxbi/Qo2c6Emyl4DWe9tvrCgMdxBBPX7rtLsECS66Z0dT383Qxbwecjn4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799043; c=relaxed/simple;
	bh=nZex6+n/sqw+h48z7Or8EJkw+lP2kA2eVi3kkmMJUUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h23JUCsbKCpAsJ50W/gZpzEJrkgsRdhVCVNXv14+MWPVsldqYjV1BVDV0aNuQR0N8xZvGtbDydTLwoQKxZH+scQpwamGbtq7Dwr4ndmdwYMA8epn+W6mHPJ0sFPKr4qZK1dYx4qZ7TBS9wUxc6/NapNohZ3joxIpEpqGR34C7/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=BZkMw+uq; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="BZkMw+uq"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836c8bde2dcso16201937b3.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 09:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788799041; cv=none;
        d=google.com; s=arc-20260327;
        b=qAC8KuMoDuQP41NDYz7zU16x2a32KDMwtV3RnwqEVGG76cR1699GYS0VjVjnPE7XXu
         ZUPBHU3cqMpU9cwxH1g5N/pyjvwxQ69UuF0AwYPar7Krcxa9jsWNsTDrQAILQJk0pqRh
         k0+6uX4wpCu8L+MwbwAGXKDATCwOrPZ+PlaNewqw50LDn96FVF5uWP5/NvKWZtLlEi+B
         FloQSHEqrkJw4+p0JQLm0ffIqVVQfAIsduUSrqR7ry+eAIhIbvT1fPg9rZMx+GZhNH5r
         M5GGdKQuD7TqyYNvEwMWiAUQzqjEzKK8NNKhSrwDUFA6ks6eqKYqilgNlxozd8+ZwG0M
         zcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2JLRhv6rUgkL2c4Zu6vxscqb9nCShT0WlBsxX6l928U=;
        fh=iLJxgP8DAFLrDQjsB0Cddp9OF9hbFU6T6ON0ac1dnV4=;
        b=gCfuBPvbMRMLJej5nw67nai7qYpY/qDmMf3JE3E1MwJGMYwvD0imYSSr/Rw/fYa54g
         xpDCDobruEIxpL/CPkG30LvGGxLVlf3urE7k1zfZybR/dgGW0uv0JfKSHS88fqENPkhY
         cZSDvXwZh4ahnf9JTnQACogq08CASc839Bp80o29kTUSkCjWocQGDjogEvKWW0UMbcTP
         aJujkawkggcJ9boI14qAaWHLENsW43JrWNhs56cXGIiznJDZilQ48njwG1B9yrdJ2iNi
         2K3I5I/r/3Uht/naq+bKDVoqlpzUDu25vZ2WqnQ2mQPHpVGPUOzyzAZ3wgQ0gfedUzZe
         CNYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788799041; x=1789403841; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JLRhv6rUgkL2c4Zu6vxscqb9nCShT0WlBsxX6l928U=;
        b=BZkMw+uqPzVrqU2q+kTRd4wyCYogQAuE1EJfRfinwBLkStGDSUQBcXJOo2EOKd6y21
         68kWLPuUMhnKl735wXV+/37vHn5pSxixThFC+Gpkh4zYAZ0zHTDntE3M19VQ4nGR2pyI
         mUtEFNO3/iwbquX6TGHYfqN0ygD/okhAZLTYmCTO2OMCPpc2AhEMr7LDad5Zsjl5ScBA
         S6RyChpWcuJEYknhx5RJz8qqdpTQJkc6O6RizK+MNSrBSE1s/dpEzrU80nCWQYX6VPt5
         L98qUzHFrdvGdxAZKU7zWuJUVO+4gyhLdYatX1w6i9F5Rxl79OG6qgaG3B35a2V/BOfu
         8WlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799041; x=1789403841;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2JLRhv6rUgkL2c4Zu6vxscqb9nCShT0WlBsxX6l928U=;
        b=oEHqA7Fbd7TuGeFdNR/ItDvdKr98/VwT3UUh7wVYypXi/NOMHyNE8vcVCSctqCs4mE
         umnvAsKId+hHMW2Ry78EVY8tO6AKqqoPODIDIUJh0xuR/kOXr1aauEt43Olz7Y4pugNF
         KBLDSqj3DP97nF/fXaryrsmiVBr2o0rrr5TqaPbwCRaOuwpjvhEAN+A/8KoJX8fssh0G
         NUDspF1VEDvXzs2aCh//ncJayFV4lkdY30FHGN8QjFNYxFZReTELuyFCWMWS9KIg+Q7E
         0X1R7cc2hPiHKikxM39Enc8aWU3ipN25v+H8ucTtlnAGgGKEDLI4W6jvUe1SpUcp+BF9
         0oGA==
X-Gm-Message-State: AFuF++lQ8DfezMMDKgIxakHPQBGmm8Gr9FmUcUbiJg+utuVE/0i6Tro/
	RxxYlVbkG+hw6ZsqChNGobo++QBYaP5N0qGj/6WljwOoPk7oLqDwcxFYx0oI0FvOo2RWBNj6Nn4
	d/J85z2XaDh7YLpCn9ya0CzfqfYBSRTItcnujalqN/mqGoAsBtb/zpsCV8WQjWVw=
X-Gm-Gg: AYBFou0CT11EJemBZoaLJYyC2Z/zvQhAEmMGEYby6j+w7jxDA0xZojniEyhp99nO8gN
	jjXIz0V0/m9b/SnnCJpLFnvTkCosMlCEu3YHDQQ02Vxufn1HLi9A9qk8JblTQlRMdHlIpY+/+Rb
	L4F2DbRWrNz57CFgBwhmGl9gnGmPs3bQStflB9qdaGby2qj6nXXgoFU3MiD7O4000wW7YiJwnPN
	4AVtswdxhsMnUFcCcpErsz8Gbpudro1LD0l5NA4MXhvEUvbheIlyeCgNU2UPhaFDWmC55NMvQ8D
	I9BddIegXY9XQmg/JFGXDLgDwLnY80rdfS6wLDfF7zPl+uUrsRn6VTeqwRPbGhuS6GRwy40I/22
	LSXp0
X-Received: by 2002:a05:690c:6508:b0:873:5c0f:28d with SMTP id
 00721157ae682-8735c0f03eamr65394497b3.55.1788799040863; Mon, 07 Sep 2026
 09:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com> <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
 <7493f0b7-a6cb-4b7d-bfd4-f4a318ff7e32@gmail.com>
In-Reply-To: <7493f0b7-a6cb-4b7d-bfd4-f4a318ff7e32@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 7 Sep 2026 18:37:10 +0200
X-Gm-Features: AcwNN1WC37QY02jy_qwSvSvlxPV_h8y5aJbeI2zGKYCnDYg6gV7uOpB7xrSddKA
Message-ID: <CAA0xjtoUBHcEJA6_EGgiy2eXghb3duMpTi=KBkxt08fV0c5Arw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sequencer: keep auto maintenance out of the
 commands a sequence spawns
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

On 07/09/2026 15:24, Phillip Wood wrote:
> I don't think maintenance is actively working against other commands, it
> just creates lock contention. Maybe something like
>
>      When the sequencer runs "git commit" or "git merge", either directly
>      or via a user supplied exec command, those commands run "git
>      maintenance --auto --detach" which can cause lock contention with
>      the sequencer.

I'll use that. The repack case is a bit different, though. It can
delete a pack the sequencer still has open, which 65cda10d5b had to
work around, so I'll keep one sentence on it.

> This is pretty hard to understand. What does 'the commit of one "git
> rebase --continue"' mean? Also whether the next pick needs to take
> MERGE_RR.lock is conditional on there being conflicts which isn't at all
> clear.

I meant the "git commit" that "git rebase --continue" spawns for a
resolved conflict. Its maintenance run can still hold MERGE_RR.lock
when the next pick conflicts and rerere needs it. I'll write it like
that.

> What does that mean?

Once the spawned commands no longer run maintenance, a long sequence
can pile up loose objects, and nothing packs them before the run at
the end. I don't know whether a sequence can get long enough for that
to matter. I'll say it like this, or drop it.

> Talking about the shell here is unnecessarily confusing as the command
> is not necessarily run by the shell: if it is a single word that does
> not contain any shell metacharacters it is passed directly to exec()

Right, the environment reaches the command either way. I'll drop the
shell from the message.

> This comment isn't wrong but sounds like an LLM, rather than something a
> person would write.

I've rewritten it:

/*
* Don't let the commands we spawn run auto maintenance. It would
* race us for MERGE_RR.lock or delete packs we still have open,
* so it runs once at the end of the sequence instead.
*/

> Shouldn't this just extend the test added in the previous patch, rather
> than duplicating the coverage for auto maintenance being run at the end
> of a rebase?

Yes, I'll extend both tests from the previous patch instead.

Thanks,
Thomas
