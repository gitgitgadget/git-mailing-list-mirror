Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A94A3F1C
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211673; cv=pass; b=WKC2pCUekowpB3JrXc/i6tq1yhOJ5uJmXSeQ9DkWas5qsMmcn0fY1OrcJM1rRdCdfGIv+9EMWwZWYcPyoA/JwjyFZ4DDpO4rpN4uLQuon/3s0LQldy953MI0KsNDe2/DZeAedqQvDH6e8xhH4tUcKNYqE+5Ks+M6+zeg+gwyszE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211673; c=relaxed/simple;
	bh=EmPfQDst80UgQsr7IgZuIp5DzfOkNk1IUHeYP/+O6pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVQVfpsJf7x1oDMSTW/WIwukmKR2QeR2aHSPMgTJgz/R1VE/gKKg3/LsxIHPai/mqMhMpCWc0F7BNLJS4WChKkZgIIGl+UeFhzQZw5oEZJWGee0J9yf6Bv+oInhbiztEpEEiM4BfZ+UfLLDxwIMuJPm7NGT+j6+8kF7Q/Cg8CH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=J8WeiYNZ; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="J8WeiYNZ"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67567ff2e77so1592001d50.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 07:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791211666; cv=none;
        d=google.com; s=arc-20260327;
        b=WbOt+t3FXD84mRz+ER6ygMKFcNUVb8s7ESJkuKwru6U0Nva0sKaeH2CM9cK1irisxh
         XOXMMR1DbZLArBWCVMCBuybBaW7cVZTSDTnQizwx1zb4+JvZ0pGwUj/epgYm+TDCAIvw
         YkrETLEyG4oEnIeXn/QSdHlB00wFJjA3qL7QdEG7qPBYGlYWwVN4Btdwy/M+4DdFF0OJ
         UxoKteri0kTdSxdtEVyZgrqZqqCxj9PLuqMzZ9Wg6TX9EKvXrqkINrvNJd6wuDu4N7Ax
         Yp93KVU6ALY3FcM60c5e8URUxNuCoeDCQLRUWa4zXiy9gnrdvdm/DZ/Pk7nkmWjiG+0y
         ctfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EmPfQDst80UgQsr7IgZuIp5DzfOkNk1IUHeYP/+O6pc=;
        fh=pD2eKrkSyj75IM+6ZwNjyn9Ou/ico1bGwrU1OKNjOAA=;
        b=HTwjL431QB7DCzR0YuHcBdbcPNq17+6zkBuKs7etXjGQCze1lZyZ3ZwFJpy2/c7jIO
         CwM6nNbnJ/dnZDwPFbeMBKx+xNpwtCqWIqLjACYDXOa+MAVuYPJO39EY9nUnqTtdcAyG
         Y539+cD2xrYcZMAS39Aru5aYCZ7y7VzgiDgaGM/QVLS1JqVJXoYpfqErcRQruEY6+OjG
         KhB1jW0FktFSc7fvjd6jgnIK+rVQw/Wdc6rjZnak/bwR7RFA/t4+b2tNgtBNhXMj0Frd
         uKAZuD4cvs9I1Eez3BG7JwUbSGxpHfdCaFLr+gDFehOCBatt6eMGKJXWcRTjIWffYGiW
         ErJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791211666; x=1791816466; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EmPfQDst80UgQsr7IgZuIp5DzfOkNk1IUHeYP/+O6pc=;
        b=J8WeiYNZwuqNPCCoK34R8Ta2+tm6dth+02su4qhQyxkDdz30eoXsigZBmIo04XAtDQ
         8KIuGvkCz1MnIovzHC9VscsIN5Ey6DX0o34+834d41eKDnndRvtTFu+kO0SaClELW20C
         +KhRa+ZxajsqZ3nP4Snrj9+zBpYIn8aKimSgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211666; x=1791816466;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EmPfQDst80UgQsr7IgZuIp5DzfOkNk1IUHeYP/+O6pc=;
        b=irjN1JrkoZ16ItHQ3DpxiPd/Tw62c3/6oZ2wvVxRDdGZeMbi1uNnQYrxHNwRcs5mWz
         dx2zguKx9wzMu6RLs468quN1tV9nigfwuRa61agb5E4CB3LSU/Xk2CJNoh/NQjwcYqRL
         GaT8fm3xHgjKvb8288A0aykJNuC4+gk0NgjXeORymiec4kRRCDRNzPI15wtOmCrPER2e
         3Fkm18mgrrXLnLkNVPPYk2rjppb4MxRZhdY1FIM2lPoeVvHlVQdz+Lfvl0N33JxugOGQ
         DUih4RnztOjfpWk7ts6WQHjRGZNC5/W1StMGvKkquV1p/goGmL5UnyUCccjHeSqQngGV
         s2DQ==
X-Forwarded-Encrypted: i=1; AKwUvByWHLijjhqGREX3DeOX4kW7C5xU+JuelyDBOWoX2kBpfIv9DaYeRlUnwKP7YkkRvrpTezI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWGREzJ/hSj5Z7jUpGEbizvbrBPu0sKuIIVslu8a53GAFEdMZb
	6eU7bjnrsGCjzQ/FUrxfsc1b9+WFSA4SGgqSR8W4PR4VR/QdQdk16zDk5eQ2CFQ5THpJLjyzz4X
	NMEKqA9pNrRCDHWSMrcf7PJkeGT82ly9mOzhn43DHJA==
X-Gm-Gg: AYBFou0+TXKdKo4WSxG8GeaQT03TeTQI1K0lQtpZnXsmWwkUvMWb2y/X4uijG2Ij2Gw
	TBAyJuI1iI5qSMay0e9pY4UTPhOArzP2jD0G4690Hutom3Sd1vslVYUIVUeN3Neb2jDOL4DMpVm
	NeyppqDtf6wcq3A8BfDA0SiqzLvP+wTHN/q6nhXGC9xaCV1Xo5JlJknYsjQ0gwrhWB/lx0AlFys
	Vc5fULGTgInrZR2c/UtFKrZUlgPR54KCBnNejHVX0M/Jz2a6xeAaVw5NNoCNGjDdyeKQ12AXi3Y
	fh8c0L+g4z1eFdVqoJQsHYTfzen10UyuW1PSRFtLC/of7rhCvJVr3Ic=
X-Received: by 2002:a05:690e:4886:20b0:675:6168:8be3 with SMTP id
 956f58d0204a3-677abfbabb1mr3009285d50.24.1791211665698; Mon, 05 Oct 2026
 07:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
 <fee92f3c2009f8f282fe98e6b16d403704db9ad9.1790930019.git.gitgitgadget@gmail.com>
 <ar-T2y54X1uDQ4mX@pks.im> <CAL71e4OcAg1PYaZZ2474Q5ayQgTeJFR2-7J+0ddrCe+rwwj=3w@mail.gmail.com>
 <asNDP4_YlCHaWIVO@pks.im>
In-Reply-To: <asNDP4_YlCHaWIVO@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 5 Oct 2026 16:47:34 +0200
X-Gm-Features: AclHuK-_SmKKZW3idU1CUiG8bna4X6ioSbaejM8747ZzC3wP-OFrccRbN7BPvtA
Message-ID: <CAL71e4MNEF-c_ErSXVyfe6qPv_3r2ECyu-_J2p4T1oF3mqEdxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: write commit-graph using updated refs only
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Oct 2026 at 08:27, Patrick Steinhardt <ps@pks.im> wrote:
> > I will include these numbers in the cover letter of the reroll,
> > or do you think it makes more sense to also have them in the commit
> > message?
>
> I think it makes sense to have it as part of the commit message.

Will do!

> > However, I could change it to use status != REF_STATUS_NONE --
> > those are the only two statuses we can get so both would work,
> > but I guess which one is best depends on what kind of new statuses
> > could be added in the future.
>
> Okay, makes sense. I'd aim to be as defensive as possible, and defensive
> here probably means that we should err on the side of covering too many
> commits rather than covering not enough. And that's basically what
> you're already doing anyway.
>
> I think having a short comment that explains this would help though.

Agreed, will add a code comment + keep using REF_STATUS_REJECT_SHALLOW
As you say, it makes sense to skip as few refs as possible here.
I will also add a test case for shallow to prove that the check is important.

Thanks,
Kristofer
