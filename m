Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809743403E1
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480022; cv=pass; b=Fk3lT96hoHt/MpuMtvZ3vz0U7DJ89NYBxSLhSllI0ZNEByoV1USHpXT9FjjBVspkgpKjuEnnM+5jIJIP1Q8RlorPvR6ONqZVdClKns+DFAnSEn8jQ8gz7BfTACoclh4Y1Ipti751ByW3v/DifVpAYIjcVeKOAlrywWuw3YFY04I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480022; c=relaxed/simple;
	bh=bQQ0QOhw4RspgKEFhCtrSFEQ75oU/14ucIQumzPofpU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SowT990Dh1K74CyDnxFgxfP9uQPExqobNwMwxstLnf4gl069qH2PfraLgEBPjgwVS0ye8ymrOn5w/4zW+PHMFTz+OEfzXp/DNgpb1rN4TZTXp9FsfCMDq3KBb5zJyUEkZ8gbfGxh9Sl9/Zb2K/pGFcOpM+9WVEJTz80cqDKOpsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KowpL3VU; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KowpL3VU"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66b32bb75beso165382d50.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 13:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786480020; cv=none;
        d=google.com; s=arc-20260327;
        b=YWA9mgVRuyOEyqn4EE/gV37BOYt8dTh3I54aswxIvNFV2wM1OARmQ7cEhbSbjXrryH
         O2PaRnqwHqveA14vxCwtsLLged49rUbuCt6m0nLknZS5nsP1xolpNcpM47pDnR6EsHOf
         wWJhzxIxpz9r+ACyfpRZXtql9+mut6eK3JQuphOiKP0E1erqxhIy+Kvct751iDZefQ3E
         d3HNGCIkAA+vWsDIg1InQE8ZMn+cqIKPoT5wrzJlQEXOVQ4sLRCy08hb5hnRv7qbtb+v
         kr3edBQXFbs8rTubuBj1oLNEPNP7ZJCv1VvwGC2kBZE8dY344ABWR3GjSTr59ht4ww4g
         mlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bQQ0QOhw4RspgKEFhCtrSFEQ75oU/14ucIQumzPofpU=;
        fh=n7rwVXjC4KAPWZpCO5dMuw0DyczDQ6ZOyrWkVuRiKrs=;
        b=Sqh0enB0/bc3Nf1p1fX2QcZCScHMs9Lo4wb9AEYrxTsQ+6kcay8nDpqgW2i+SKFRzm
         swhNt4JlTG+oCISXiFdNgwCafjZh7vVNfGZfa300J2Je3u2XcgNKmzZO+da3m3shqN3d
         cRD57Fm4hHzNgVPC6Q9GmBdIYGr9pIfeXB62Af1Wai0Oqx23+JN/akz6CD77h23ECoUN
         0QMjOtOMDxioZDfzlosgsTyJB212PRF2OAU4qej1ufEq77/PxYJQZJfSobVYCXQjhnfb
         VA6SrA9xG6MVBdm9hInFz/UmITWxhbRfwsyyqptXdB2b86JiaEAUGpagqP4NlJfTSWTs
         MQ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786480020; x=1787084820; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQQ0QOhw4RspgKEFhCtrSFEQ75oU/14ucIQumzPofpU=;
        b=KowpL3VU7yG/vgILmHuMyqfotHrKEDgvQIaX6/oGYZRoDyeyCgaMJiacBLOmFnX2ej
         DA6qzI6cOXxIlv+ZpvZrkJBiGlfaOozTKacktJo/YdiNibwR0nm4/GiTNdW31HUR3390
         f1k2GqbBILqvvvZEjyxc8ro2P5ht+KywDezwj/KxavMtYN4RrCVn0uHKQkXV36q8wbaa
         TpXEmtmVMg6Ny5EeOgq47qvO1Ya7qpYSMaJTLESfWQLxUHGyD96ToNoKVgWMgMHfMSnv
         FurclrKw9sdbDXqxV6gH3Fl40RbuoqogqUXov5Svio7hFKzQWE8P86OvSZ3HgX0tVAMO
         Nxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786480020; x=1787084820;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bQQ0QOhw4RspgKEFhCtrSFEQ75oU/14ucIQumzPofpU=;
        b=YhjZyTo1iacBwyaHvwpGcy1+Zv+CcZkSx09cWVWTYG/w/w2wEUrOtiTZcDGaNdalKp
         bMojvyCuXlDasXLlvgqTvNhaZUhexrbASvWRyhACxhZU6e3LrnSNg6xaxlMFGRUGCnBD
         MWvmdFjxl2VshrodA3rv/bRzF0gJax8/w1F+weINdg5pqylcxqSPVavUhrwiJM9HBDU9
         iqNIeYYComwY85X5jCrwadNNqMG9FYitpaskozecdLYxwQpVAUDqLGKBtVWq8zcjI3TA
         3M4F79PQctp77oetBNBMvuGLnvGtPCvTf+uGvEo+O1GT4kNj0kAjNyDXZMg4O8Tp2dgh
         PatQ==
X-Gm-Message-State: AOJu0YwOpp22N2J1J/EO55V4K4ln72EtQqYJuPB+yMIX8ZrRW5VUOJD8
	k+XDA1JoQz3N565qVRPY9NUb/yAMjnRwrU1KVO5rEMDEDcs6NCYDMzhA4szQPYtN+8Gh4KJF6nE
	Oxe9nUsaCbwn03tGdPa7Tu3vl5iYrSqc=
X-Gm-Gg: AR+sD12V1Rz0ZUnYxQYoqQ+iyJSic1ctH4KM+3KaNWl2cXUKgJ6v5czNdJBt+VF0tsM
	JJW0lZdCUh/H+t/eG6oes/UCRjR4rx3pSUM41KjbvrffijdfIJxLWXNBCWq3gqOkz07sbU1vI+x
	z9PzQU03aWy+d7FoZ/popGQyHT8v4N87iFvXxI7nr+BGh0dNxmKg1QtIXXoESi4/E5KwKPKWoTd
	mu5j8or69aLBgczYGpxxBVCeV1F6D34qEIqVRBmAP7i7JBrvbUdNYPOSltvCpVShmHQMPvnrXdE
	+AcCr7IDL/mKZzgSaxxutRLuLoVRhJkiS7w0A21Z4JQ9dJEfEbY16vnIrFnnucs1inN4LEgknWA
	=
X-Received: by 2002:a05:690e:b89:b0:667:f217:bf8b with SMTP id
 956f58d0204a3-66b33d1118fmr4579d50.0.1786480020410; Tue, 11 Aug 2026 13:27:00
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "<Alexander G. Riccio>" <test35965@gmail.com>
Date: Tue, 11 Aug 2026 16:26:23 -0400
X-Gm-Features: AUfX_mysETW998J4ZgXhaBZEnhIvn2DHrdE3GdCiegumkgbty3nFBzWstiPgWBU
Message-ID: <CAN3N+zmzKBt75Gue--FbGWDxFY7HKfmRXX6O0FmtMRNyEfCjog@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] worktree: add lifecycle hooks
To: gitster@pobox.com
Cc: git@vger.kernel.org, domen@cachix.org, cdwhite3@pm.me, 
	phillip.wood123@gmail.com, ps@pks.im, sunshine@sunshineco.com, 
	avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"

(Apologies for replying out of thread -- I have never commented on the
git mailing list before, and I found this discussion in the archive
while looking into options for my own worktree hook needs)

I have a concrete example of a motivating workflow, indeed using
agentic development and proliferous worktrees. I figure it's worth
writing in to add support for this - I'm sure I'm not the only one out
there bumping into this problem in this current era, but git
developers can only know about it if we volunteer the information!

For me, I have disk space issues that relate from the interaction of
XCode derived data and worktrees. It apparently uses the absolute path
of the worktree for the per-project build state cache by default, and
of course it by default stores a lot of this data out-of-worktree. I
think I can change this configuration, but it's worth also noting that
about a half dozen other related tools do similar things, and none of
them have any way to know when the concomitant worktree is removed or
pruned. When I remove a worktree manually, I already have a dedicated
shell script to do cleanup like this, my script does a lot of very
useful things when it gets used!! The root problem remains, that we
cannot reliably count on agents to remember to do things we tell them
to do.

Currently, this means many gigabytes need to be cleaned up manually or
agentically every day, which is annoying, time consuming, and wastes
SSD writes.

Sadly, it seems like none of the third party tools will emit events
when someone or some-thing calls `git worktree remove` or `git
worktree prune`, so there's no solid way to implement this outside
native hooks expansions.

Sincerely,
Alexander Riccio
--
"Change the world or go home."

If left to my own devices, I will build more.
