Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF122387364
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484969; cv=pass; b=ofSFlIhFbTIGi/UDLlKBlUqTra5TnH+XDmTkf4ZZUJ4zsRxVda/3RJ9MB8H1qCLz1qO5TkJcC8zNYm+uFMD9ihdYDFgC3xYrx3ho6DgjWH5L+tqsupuje0+vANPJuXAYi1XmAJ9yWLPcUJDFegKuYCf4qtVK5vH9tqk6T+Rk66E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484969; c=relaxed/simple;
	bh=k3pYDqSB881h+apRiQCO1T3noZupqBZGPnxlNgoOHBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2C1b0KgmA5ugrYiWpt7HP/s6glcI4Ric2ru964O3Q8Fd40+2bjT2MHH56nFrWTUfyLd0D2B//lcteUN/Vh7HzarMgc//EIsWOjn2fu5XEI+Up6sOWGnsfawpo3DhwS/B0nkjLVDbivsNM1U+my0bxExMttPWqbt8rbO4NIyKpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9V15izU; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9V15izU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso1777216a12.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 11:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791484966; cv=none;
        d=google.com; s=arc-20260327;
        b=qJIJAW+fagnB171d9pEMsajrsxBKCsIEod9fl5MCgAU1BVOGIChtOo7NhFA8PV7C2k
         LT6uSY/M9Xaf7TGK0rhllmDO27VN6HxiIDmojl2LUvU2TFGYBq7Ov+SIC6lx2DluWgQV
         U0OG0oqwuJYuLqOtMImRv28/UQSRiEFuANDBZ4rlt61hMWwtfNmyUVbKPRURWdUCi1Ng
         cDWryx2fzXppcGwM+1zkbdkkpDh0sksnz8wTAi+2FA8nnmi43jOiAOCvvmrVNNbVTDFO
         34UrJ2Edua0IG0Sfn6OmYYdIy6wazzfmnWtl2ZTBiwepIIr/Wpgwgn2ez1BksdUAoedq
         z7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k3pYDqSB881h+apRiQCO1T3noZupqBZGPnxlNgoOHBU=;
        fh=4a/dOG6QqepIPI2p1u5jfALhVq4ztAwIOgK59B3GhlE=;
        b=KBnKMN9aegM2SglIwy03SOh7DK9Js5MT1UG5yn5Un/9xL+jWggV7tNlC9v4rfLTfDV
         GicQiBGGRMivtFEuo6+G/hrk1lVG9KnQ7ZQr9ekNSnpNd+8BkzN+hlKYA+1lnoUHAjSY
         CrJIab3Ox+0bGQrCBz8XfyyBqWG+ZImUFH38uAMV11NA3qhzFCHdGY49Edwo6YsnarOz
         +5Tfyfae7H4VIDc2aGWpklAq6NtvRJspl2Qrzyf85dHaBV0Vqxg31mh6Y1xPFpVCYqgA
         jn22zcHnkoq72EsEVUDD38ihR2gRvAbkaFcu4KilzxHZ5cKJ2QMwbRPa5Ns7TopvmDwj
         FzDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791484966; x=1792089766; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3pYDqSB881h+apRiQCO1T3noZupqBZGPnxlNgoOHBU=;
        b=k9V15izUJQPySRJQ3M3DF6qvieqnA/4mS6zjfb/SrtMtr0Otf2jqtPXW+/bC4PFUHU
         /Cd9fRXCE3xMNdhUf8tiZJrL3ExPree39L7PxbEV4bLddywZ5OwyqsIcdYAoGQXX1rJD
         w9NprNpxyofXIV5tCF3jSVAE5BB+V3fzxxwEH7RlSwrFmu+ejot2Eu1vBgswEBQ6HTX1
         CBPx8sDCVTh3usu3WeBhC7weROlTy5jVn6rAdNGL1wowVSHqNuAum+PKRxlox8k2jXRE
         naeEO4tNOxLpPKeQJ6pDePU6Amj5WMTBa4MZi74Q+3P4OkpvmOaXjs2weoAcBfxMTBDI
         bbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791484966; x=1792089766;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k3pYDqSB881h+apRiQCO1T3noZupqBZGPnxlNgoOHBU=;
        b=hduKb6YaxRH7qYz0I0WXJTO11QCrCVdNpNsfVoLOoGZDlTx8mSqTmZd7+wJfvS+nKj
         lWU74lzADpQrBqceUC0lf4qFxnIy19ki1Ce7Ee2YMIvhrcOKHKKbUNmXki4HvcyAq9ra
         NtT7FIkdShHebKAONN4F1wDJ2mqc3ktn5i0I+R7pixP+Awb07OiT30mNkdLrBmvwVIvz
         7Ynd+yQ4JjhhCWsyyDRGw1Zlim3txztVfmG2IelqWsjyL0TMMpaFQKimoYLz9A7kPrF5
         32kUwHkbUT/+IKjWmVZHusj/HElgudnDSrV8Ik9BtYvPmjodF0lkejBERIHbIKH3yDVq
         uFag==
X-Forwarded-Encrypted: i=1; AKwUvBznUQlH6O3eg4vvx+xdccOj1nYQdAtAg4M87vgpLUVTFGWtmd3TWMeJnGvyokK7yumyEp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoYx7K5kX9AGq1xyaCK9+VI4xGGUtyi/eRG3h8s1PRqA+CGux6
	RO0uvSy0GhmlH7YwJRKchIOPIVD2imqAoaxiM8QH+NDSlFb6dUXLDCQpUiooNVf6C8Mvnc3z2X4
	PCEl/kVrJDq6pikSeSwjZCM/4RLDNbcdWfQ==
X-Gm-Gg: AYBFou1/dvMF1v/YAotQMaO0E4Lc7Xc/vU/0aiYcoYTClSmMqIv4v2Am5suWphCbiJh
	6MEgAVplDPR59g9Wduma3PpBVIw8yiO5q/0n9aDdRsXYoetn55TF1OmbLGoYnIB+/K3fIBwYiLw
	Voy6Mimq3TgK3YfZJRrd4AkDyIeaFJkpTo7RAysbozSBIgylgEpM1qC4SF2TI6NYJknDUErIV2v
	0ZbBPDviINOBKA8KzphSmLfPHZWvoLE8DkJ4EJ5MUA59H2RDnF2Nvhv7u50sjV7wBhSc5wpKrJs
	8WgvxpENqsNM1GdP+v9ho/iFWBZ5KyFvh5y/W+67B0D8pHDUQBSTnPM=
X-Received: by 2002:a05:6402:a6cf:20b0:6af:ac49:6417 with SMTP id
 4fb4d7f45d1cf-6b011c93c80mr1990456a12.9.1791484965798; Thu, 08 Oct 2026
 11:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com> <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
 <61ae371a-225c-4400-b878-8547547d1269@gmail.com>
In-Reply-To: <61ae371a-225c-4400-b878-8547547d1269@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 8 Oct 2026 20:42:08 +0200
X-Gm-Features: AclHuK-OfGlbVQJDo9m_wm5KPYWBuq7FIrGxZ3x3tuHTsEaA6-4nainVEXmYvkA
Message-ID: <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Even an efficient implementation is going to be a lot slower when it is
> trying to find branches that have been squashed, so I think we probably
> do want a way to turn it off. That's especially true in partial clones
> where we'll have to download a bunch of blobs to do the squash
> detection. So long as it isn't diabolically slow enabling it by default
> is probably fine.

A bit slower (depends on how much!) could be worth it for improved
usability. This is not a command that users will run multiple times a
day.

I would hope we could have it on by default and add a flag to turn it
off instead.

For partial or shallow clones, we should probably warn the user that
detection won't be able to search the full history, and offer them to
unshallow, etc. It's very reasonable that some parts are turned off,
when the user doesn't want to hold the complete repo.



Harald
