Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B517A2E8
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583329; cv=pass; b=o+gkma/4MdSFI4LBfGG2RiMtbXUafRpnMnd+X4sOtjowX25QQE+XpC73/WtjKjTrcc28X+Ekdv3ZIJ4yfg6YfS5nKQEUHA8T2rsOtSZhqpYwxQFL2wW/lcxgaeLsNFJtUcX1/4RgOZXZ98FC0M7jJfEVUGpR/3ZnvevM9OgURDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583329; c=relaxed/simple;
	bh=6MUMmRtXwAy6opJUox4CjvqaM9mhrwoaJ2VVEmwqOP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPX8Ba4PZQDd2sY7MeUgXyHNcnMsAsIZftc+XTTYCUPs8/lMcbtbkW7Hz0c3HFy/9P9zQL978o0RRkl3x7fVTpbCF5XyjiJHB9FZR8aahrMtsxCHmTwhZ2QJovp8wmtfN5faW5AUzN5XqRBgTKcbRaeknCx/z1ktge91+RpQSIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7b10gGJ; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7b10gGJ"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6966e1a0b91so807939eaf.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 14:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777583327; cv=none;
        d=google.com; s=arc-20240605;
        b=VA1Q0inosjQ2C7Y3QEjZnSHZ3XiZ+eQJmWtkqJAqhe8eLabP9HkHet2sN+AHd+c3AL
         sn0p6P57zMOIrBnp9mQtwNy/YZiKCz6d34iAgJPUSsNbPP+yLZpXnQP/Au3ug0A3YBeB
         sQjtUmmFD18Xiy09EXjXIQMjWnbsvUop+G3KG9oCVMMXmCq8cAoiwY+ttT7r0sl+fkqx
         LA6Mleg3rqP9ir6ICRaRyi55yrHG9/HIar2/heqw6oAtZI8RET/PIYGG5cVF3T1dGVQu
         lCcI5NBRyTA9Wqwrb+qNLq9sY0rSEZ0WZg7dycwQEWAWlXxjQ7u6iOKHZaH535+YBM6w
         bxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8spn4F5JYDTBGUy5LpvWY9uPTaKt4vivSf+aD5b6Xk=;
        fh=AK9Zkmf4rpcZivghApxpKJFP+FZl/5kVhCHgwTtxgRA=;
        b=QLKMffCiKUxTPlAGWD3DQyao9G09OemLUeUaDnm1cHlsw5tlFjWJaLI86rACgb71+4
         GjIDNViSeO9Pd8qihBC3rWrWZSoEFtaLfCMPODz2smOe+ozVJXcOH9xTxYYgCGZDXXyL
         8Gp5KHQ/x4tMuIyX7lcRxwHuhpl2n0oRkpuEgU1am+0BYk6aHzzd/nyvrgYJ0FyNDJPR
         jAwwRjwVZp3lj1n4ypN0mkA6f2vvGDIP+389a9RtAO76/KAtxxHj36cHzJAefC7WQi2i
         6TsUueMBmuoodElF+b4N3YIlLc908SGXBq/mo9I7kIsz/OcQVAOUhaA1j0nQmzS131jd
         jJLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777583327; x=1778188127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8spn4F5JYDTBGUy5LpvWY9uPTaKt4vivSf+aD5b6Xk=;
        b=E7b10gGJ07i81+wlgELg3k++mhrvBGeR3KV7XgiBSJ2SaSfEv8t1t8Y/8LzKk8nRH4
         rp3i+eS121mk6u+4yddnuh4Ba0RhRSacZ6prjaap1CWZbTsFlEEVqOLfX0CnSNkiLgpX
         wCRdGoi2eakVbBgrxtUk7/rMrOZdmrcdNqgWVlxJYllLGtLWQY8TgELQEClZDwtCwyCB
         isqG92CtKiz0tqDGOK+eH9E6OwjUIgTWQZMGU3rbxJvoIp7+eqmivoKRPJjePsXI9Eyy
         f0WzUWemCxX7JeAceLXJv0GgB4kdDa0RpHUJHyhmWduSgdDhks8zULP9KJN0YAPl8ZNZ
         V1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583327; x=1778188127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8spn4F5JYDTBGUy5LpvWY9uPTaKt4vivSf+aD5b6Xk=;
        b=iHOIblx3uMEGzel0t7QrRDF1nPbHuGemFZ5IGCo4MYcigTDjRiBhCPWrPuOcVmso2G
         7rB2JRkpdClvqWJIkoTe75N0/OMeeJ7Q1wRjOZA14NlqYIs0IwHB4MjhxZHZ5T2uIpln
         01z2MA3Fb2h+aUb0qK55or/uHN4Djyu2bs2bKGMfqsjXape+Mge6hW9J6E5aj89m55mh
         N8F0hAWI3N11VWbtUHr3pTlmEAKiLMeCh4RZeTbyAaQFQreQn/tOvLG+N7dOr/bjLPaJ
         fdM+FRScnATfZGJ0Vfh6kGOlOSjoL1lGUv+dKXhPTLI6GO4mAtYQ3mq+/n6VZEiJecDW
         gtqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gZJYG0/v/FBh+iX0Ks+vj/yoeLBFy0ZjKOu7EUmXrh4ZrWGutWbqBszi5vkVwktkTzb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iwbRlIkiFlKj+BXcM5xUD0k9Up4LsMW2PPZVV4iYEzGA76kL
	zzud5wrQRuETJ7GVrsVOislbTDuuMI1OTFSrA0l+fUAOFkfoVUFVURYjZjh0edA4AH3CnEbxDnZ
	RPhh3lv4k23xB3gtjzG2PBXdKNS1nPUY=
X-Gm-Gg: AeBDiesfiohcIYEahfRimw/LMHTK9ATn9y5eW57vqSML1lhJx2o1HwvmhXUDXakeQ9/
	noVQ75iz2hSyDcxtro+qBp7Dkr1dtGWxG5DWn0evdqy+v9gW0FH/YS1NdodqZtGgpcvIuc4CCei
	BJXQ6QIcR30JNrDdr5lMy43pPTFlFhH2xBBocFpaZkjwfBtXHG5YwWlFL3ovW4hJLGD2R5ovhBe
	DRqUZ5tOGrnFv3TfCVCrqYzc1YBG9IfqusSGMIi+GKpwIlXq4YBS3DyaqJs+g6w2cfwMPWBxmyM
	HWV0tqSJUP/XdNfOCYaWI4Q8Cs+dQNQ=
X-Received: by 2002:a05:6820:a288:20b0:696:7fa1:2675 with SMTP id
 006d021491bc7-6967fa12a99mr1299174eaf.57.1777583327464; Thu, 30 Apr 2026
 14:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
 <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com> <c8b48c6a-5a20-4981-9cd4-999b40c618fc@gmail.com>
In-Reply-To: <c8b48c6a-5a20-4981-9cd4-999b40c618fc@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 30 Apr 2026 15:08:35 -0600
X-Gm-Features: AVHnY4Ic1zYCqYBnQHXdHh99n6KwlI-xnaHTEEg8AQ-1_1V8Rq3anI03GX4da6w
Message-ID: <CAH=ZcbBqtE4AYhPbrVPoBEVk3-f+pdpzqxooYawrGJrcJuSarQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Xdiff cleanup part 3
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Yee Cheng Chin <ychin.git@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Jeff King <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 7:35=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ezekiel
>
> On 29/04/2026 23:08, Ezekiel Newren via GitGitGadget wrote:
> > Changes in v6:
> >
> >   * implement suggestions by Phillip Wood [1,2]
> >
> > Phillip's second "if" in [1] differs from his first one. In my changes =
I
> > made both of them structurally the same.
>
> I was in two minds about whether to do that or not, all the changes here
> look good to me.

Hopefully this is the last revision. These changes took way longer
than I expected to get through the review process. What do you think
Junio?
