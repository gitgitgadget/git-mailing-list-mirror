Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EC3A759C
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704051; cv=pass; b=Nr1td1FNZrJJcc9Q2qEPblfjMquuG6ISk7MIwL3vF+UG72HQAXmg/vqvzgoVnIQ3bQH46drLFyNZ3i7UtWNH7SDUbfCORUhT4FeE4FGBcHodCpb0J4/X1s4AvNurwMrwU2b+L1W/HeVQY+IUfjGX9Mf8fyePvS/Das14/tgyhT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704051; c=relaxed/simple;
	bh=4vx0YjTOOJg6QipJ2nDZauxLYxOhvlw4X1rrFeE9sA4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eJpQoKK4nsR4PrZXz8JorX0ELWjmvcEVlx0bIwt0xj9w1Q7oQZyax8TyURpWh+yzNQMHUHGgKn7qpX2Ub4hzUOV6/oXnBWtLbrkM4EgJEjXPXhDKa7K+ZyCxZPMM/pg1p1yOX8gJ0fo73wrJnW/sR/dABbudy2sRgitWc016fHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMIHgst+; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMIHgst+"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ec3b429a3aso630107a34.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 03:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786704043; cv=none;
        d=google.com; s=arc-20260327;
        b=Gn8z9q127ThPcKZKKdfi+Pf0URlMOdUL7zeY/L8HvCd2n78Dr34jC1x9Z+5zjQlXpX
         tTxrpsgWDaAosWtNk9+YKtKDixfpsGyGtcmrdpLAp203tvmASw9dgwtas0ZDi13SDDVb
         AXSB7sTxRd9VAU3NQRMeoNEMvBWyPB7rPqlmV2++CRPnmY3qE7nVrurloqiVux8/0SxN
         khm9621+515HSm8FPkUnmHyo/LYITjzdnKGAzlwhXXPqMl8q3tq134xsBDzbjyjqtne0
         KSO8BduYlvXW5DaT3FS6lLq7zqSLxajYBoFuG9h0pa+Bcu/i387Q4s9jlPM928EChtVz
         Mrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4vx0YjTOOJg6QipJ2nDZauxLYxOhvlw4X1rrFeE9sA4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Sl7IQ6dGwxyB+7aue1XU/trDxhX05Lps8qVXU9dQKfvCEs7aXhImktH7p5DnG7up5l
         ZICPLcJnfh9ABpryR9XtV9b7L8eo0MMpkTXNSLa+XS2WACSO7y/LLAr08Hg0ReY8anbr
         TxkeEPV966cTPcMkDhJqDK28sw4arkI3M+9IYEmI0AT3PqcuKswJemHJIKcQNojpLX73
         lk5dG6JafNpmDfrk8DpSFhd06KWeic3JWEZn72zcPMqygRLFKGsvlvLxb4Pc6TP7SmUJ
         f+krcXyreEwJsqO4KguCUe9aZ8IMxyeaEKRHigktx+Kn3b8M/CUrE6eMCkv5w2MJTZp+
         rh9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786704043; x=1787308843; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4vx0YjTOOJg6QipJ2nDZauxLYxOhvlw4X1rrFeE9sA4=;
        b=tMIHgst+XW0qqUSERcayl7cC6Rng39qWXqGNLf6uy6cOFBRd5OBBm0vIaWCJ47+rtT
         Zd0jw2pKFoHmEOw6veGvPSvTl7p+6DXTIMnmJ1yc708yQW+O6SHAc4OzIxhXVX4ElTGl
         e3oVFG1Q72Vz0aZgKVwANlWFtK7DRoEszkwcG2UfmabLgPGr5ZZkaXeH6rVofqUGzkbd
         PoipetDJxGs117aXRXjlAUJG8cHdBs0/96lS/BEYl6w73Xb5c4DQqn09IOdTlmbFenz6
         8ffY4QHYV1ti064cmjGc7TBfnbr9imO60gCnmBKXu4CZAGxTpaVAGyDFXCJkum/ORa24
         lBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704043; x=1787308843;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vx0YjTOOJg6QipJ2nDZauxLYxOhvlw4X1rrFeE9sA4=;
        b=De/oxk2CZRxqt257W8QH9xIgu9BYPpaxoyOeS4FaUE/5Cw9afZQPDR7wBbNz6Z8N/9
         gY+cwhrEBcnlpLSoo+g53eWA8HLmXQWD1aCmgVt0yzp0TUlxPacpkG8bcLKBj8iV2LTr
         T1ItKWzlJNZQSURNKl0NNGRaI57tFvlnDaSBR7UendPLt0xdmyg8iG9R0KqwVS174ydB
         1+Ad0YNy1sQsJB1NIEaabS8hFp6Q+vZQ2NTfkbmXUVsRv1d1MCcvA+FwdV8AV6vZf3Bf
         0uO7VGf5u7Gt20ZqPYZu/94nDveTPwPFpHLYnv75hFCpVSc6G3yLCo2vzB0J9iFexxuY
         9t5A==
X-Gm-Message-State: AOJu0YyA028sg8MfvxscK8QoES5oCLtqFJMrt7ne0VAXovTKqm4ZGhY2
	uGpbRwJyhoPmyGdPrlRa0l+5KANGTlU2p1YDUo1H4feN/heo4W3X3bwPiKeAWKOkmhQImOEy1OF
	rWOyMHt5VXzFMNIUvj7hvQZU9XeM+tA5dgs4m/2A=
X-Gm-Gg: AR+sD11fcP2un4aPYsP4uAVMxDA5t4TJEoQRfI77oLUpvm1Rkaieju17zljmHFrefWX
	sTrfBJGUhinJQPqoRiVjw0s1RmFGglA5xzybnAET2p5z7ScYd4dna10I8hQtqbIy+FqTTUsj0M9
	rzCVJZN7KurEGvMX+NJvcrm0pswiceld1P3GytR0TOg0UJbydCQA5ii4sclBnssUH3mgL7ukOGY
	rP1wESAn4u4iN7rc5SfnvvoVc9OS7Ce3qgqGk4dJIvUGDJPVkMIryNiwNYcfxHed+gDf9EDzVNZ
	toVoIdCLJW1JPE40/tNd6IvEkpczhJwE7RHtwfEdPhTlv/TfhBphgjTE2AD0wB8cXC3jgeqv+va
	S2mE=
X-Received: by 2002:a05:6820:4b8b:b0:6a3:1e40:6329 with SMTP id
 006d021491bc7-6b0d61ba765mr4340079eaf.13.1786704043007; Fri, 14 Aug 2026
 03:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Peter Morris <mrpmorris@gmail.com>
Date: Fri, 14 Aug 2026 11:40:30 +0100
X-Gm-Features: AUfX_mwKG0aWqdYWVcSTLxwY3w-NAxLIRl59FVJL8qG7aqJcjGaf01uouC_-z04
Message-ID: <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
Subject: [RFC] git worktree: use filesystem cloning where supported
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'd like to suggest a change to how git worktree creates files.

# Problem
git worktree add creates a new working tree containing copies of the
files from the existing working tree. This is normally fine, but it
can result in a lot of unnecessary data being written to disk.

This seems increasingly relevant with AI coding harnesses. These often
use Git worktrees to let multiple agents work on the same repository
concurrently. If several agents are working on a large repository,
each worktree can result in another copy of a large number of files
being written to the SSD.

SSD storage is expensive, and SSDs also have a limited write lifetime.
It seems wasteful to physically write the same data to disk several
times when the filesystem may be able to avoid doing so.

# Proposed solution
Where the filesystem supports copy-on-write or block cloning, could
git worktree use it when creating the working tree?

For example, Windows Dev Drives (which I use) support ReFS block
cloning. A file can be cloned without physically copying all of its
data, with the filesystem sharing the underlying blocks until one of
the files is modified.

If Git knows that the destination file will initially contain exactly
the same contents as the source file currently in the folder, it seems
like a good opportunity to use this facility.

The normal behaviour could remain unchanged on filesystems that don't
support this or when the existing file is modified or a different
version from the one that will be checked out.

# Why
This would potentially:

* reduce SSD writes when creating worktrees, extending my SSD lifespan
* reduce physical disk space used by multiple worktrees
* make creating worktrees faster for large repositories
* be particularly useful when AI agents are creating multiple
worktrees concurrently

I'm not suggesting that Git should become dependent on ReFS or any
particular filesystem. I'm wondering whether there is a suitable
abstraction for filesystem-level cloning, with
platform/filesystem-specific implementations where available.

I'd be interested to know whether this is something that would fit
with the future plans for Git, and whether there are technical reasons
why this couldn't work for worktrees?

Pete
