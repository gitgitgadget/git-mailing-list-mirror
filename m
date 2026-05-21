Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F121B9F6
	for <git@vger.kernel.org>; Thu, 21 May 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367065; cv=pass; b=rHhkByuLUc40j24OMnIeRGhPbm2ysCBR1cOs1CQr6nmnV+tEMJYVc6y0xdvhdnP+bcBbGD/tKxtI/44CE4z7Qo1ZKHfpzhUCXMQgwP4kUFjYDEyiER033BVLJUZhxqTNW+1aLY6yL/AbEybKBkUSe3Mo4gpHCBVNKSKIqta8K/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367065; c=relaxed/simple;
	bh=aVwT2rqqmKsa95sen9iWPhz5RsxdaE4u8dtrHcBcD5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/L7DdLWlTqF1Xcg5VF97jBVHTjSFMI09vSK92F3s6Pjav5NK23QTonJ6mcbeAcEc9wof73MlIxd4UJE73hGAuP9f6E3sZpmA/yzzqb8u+Flz7eOv/GgZS8Qdel/bunc4IdBHChsQ+Vcpw81iWXTSp3FH1J4gSRzZsbQ9o6uBPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYn1eFxL; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYn1eFxL"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so10037793a12.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 05:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367062; cv=none;
        d=google.com; s=arc-20240605;
        b=k//vZ0aOb/Yuzm3MvaU0aDSIJ/iH1G0lK0Xi4D5yzqbgX8oAJkbvdpmxVC2HCfkayi
         yC+vsLpVsYa5K7dCH2pQlsexaYZPakEqCF8Pgqbx2GKmw3S3xehNgLd4fW5Swx6tiG6Z
         tau3EElpdri+DWy8JsEsOij07Vf+6gcT0VIA4zZrx1il8dR5Kq4YOiqNdQm0KPIzxbOu
         Oj8y9Iwq7JV+CBgmyd7Uu1SywLZt7OjNJpxxDRxEFvn3G+3VotDEmORA0PJt+q47Z1bE
         uwNLl0d/l01TcDLquXbTt5yaWsoGRh5YR0DHrvPxolLiY9aYrFV61KmMMyS6oRZLh0bI
         jsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NGFTrCtgn6uWCM6lhxeDCmeh2AaSaeHmBZVWsqetyl0=;
        fh=eMNB75jjBaQKedzggtQHUPgvuCDUWSPPSukSp/U7MO4=;
        b=FrBugSB8m2PZdFrqHKdgRQWpMEvabXoylPqMS/YVqvaXKBcfyHeWxxyUprmrOYfSH5
         TNWCB6xrTAmpspdNIy+EueJOXtvECI8kmiVHBlNUZJa0PxyOOciOiYO1Oo4CgkW2WqKX
         lO1nzYf5XlVretBv7YG337IZVSDljOjDPgEEBPpXIUxH1ZPmUOOrMmpBM6KItAkVt/UA
         GLIblrZ3+mqmU1sge+1ICuvnesNsepLYdG1ZxejQvIkKgn2Iu2w5HfsWwVgAbY+IVzfe
         j0Lc9ZNRYVSpzRYcjOgAXTfy3fGtTJs64lKD31NKahJqfsrqjb9oDzZV4QW/tOTygwqR
         zgkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367062; x=1779971862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NGFTrCtgn6uWCM6lhxeDCmeh2AaSaeHmBZVWsqetyl0=;
        b=hYn1eFxLGYYahmkM+8SMK5LbyShvOOh7Ev+mgcrj6MX3Fh48C1qKyeS4GvkDhHBBV2
         LHZP4S9gewTpz3NL4s/RC4COGTvvOMxBKPiPBvweQAAr5YuXp3NCogQe6LubU1Ft5Lwg
         16EkYbrll7V76ZqwbGMxBdd3NJeS+DM517OIt5I0jUgMAEvBTx1ciFqi1uvY8p96HGTk
         s9jV6pzEKFSOz+r9v/RmQQn8ekvKM94ApYaasa1uI4yO+pl2WBkeWZxIlczyeqRoCjWe
         Fzjy2KwQYV1Rvsd4Xc/7bT4SGCvymp6UM2XL2Xp4jZz2Z87NlJRmYAtoaVxhenFZLU7h
         2YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367062; x=1779971862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGFTrCtgn6uWCM6lhxeDCmeh2AaSaeHmBZVWsqetyl0=;
        b=RsR2j0PGaKDAya5nonvvwjZHxEtVBKxS9BVjoHrAzsOzFPubvk0a/XPiAXIbC4M0Bb
         UIM6yGN6qKczyUU8a/IZ2A5h5EvTjiPcu3OzxPUrHvcA8xwHXOAwQN7V4JB4wDs1fxse
         tU0VWpZXkoHvb8sLtEyGlALc3ZrvktROIHkIWJNFL1BI0Q0jkdApxrr4NNIxBJkqAVda
         bcc/tGRvJSAe8FhXS+nrH1rUCgWhLmC2aZYdacfdaSHUu4g4y7QMJa4ThqON9+4Ixg6x
         XEyRm0lEMFjYAFBSuGUrl/MWFUhqah8E8V0kihV1Cp+zA8tf8NTsx/9p9YrIe0ffZFVU
         jIoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Da0slQVCpZcv/bUMD7XEBx/yBL1WKVaTFqfHh2c4iKoykcjea+8Od3cOGfipjNyNGjJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3re6IT3OKy9vlDZujA8hXrVPVRu97U0dXbeqaeMTl7heHT87q
	SQeN4oTRzASP2tP/pSdSKCoj51GRTp66obauqctzuGMhgqmPmoFHAA/4DqDv8y3XqAMjHQDRIQX
	RJJG6a1lYjW8Lhhd9KF/lzsdEbPscirc=
X-Gm-Gg: Acq92OGZ9RN5y7XCPa4+2eVpndgIUqlm4Q/eGR+ZVR9WdjoIiByuLGhWY416/ve03yW
	7NB4vNybrvmGn7QqFbyOcW75bLNmc31h0/PHSG10SvzrG3APclobh4zC6/oHInsmkeS8zsIo8RW
	bl8UMsvKR/hPx0U0eQ/oUK77mANEZ47EK8fn3BTo//QkU//OeUKAUWsikoL7tD53lzPQLqEpkdV
	x4ObF2Btd0XN6yF6Xf8oshDAiSdDDnJxPRQvubhGguli/rm8zyD7xeVLDtHkxJrGLp/xCfEM3Uj
	ocOp7mQ=
X-Received: by 2002:a17:907:75d1:b0:bd4:b787:f1d6 with SMTP id
 a640c23a62f3a-bdc12aa60famr112249766b.6.1779367061531; Thu, 21 May 2026
 05:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
 <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com> <f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
 <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com>
In-Reply-To: <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 21 May 2026 14:37:04 +0200
X-Gm-Features: AVHnY4I6j1gJoXVYi8muDswS5qAztyhV1QwUCMA_uimbdZwUQlOT1W8LP86TYFU
Message-ID: <CAHwyqnVMpBA=fk8giP4E45FR_7UDpgr8GHYXV9Q2C3Skxxb5gA@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] branch: add --prune-merged <remote>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> I think being able to prune branches that have been merged into their
> upstream is a good idea. However, I find the focus on remotes rather
> than upstream branches in the UI a bit confusing. While the upstream of
> a branch is often a remote tracking branch it doesn't have to be. For my
> personal projects I often do
>
>         git checkout -b topic master
>
> and it would be nice to be able to run
>
>         git branch --prune-merged master
>
> to clean up those topics that have been merged. Similarly I think it is
> confusing that
>
>         git checkout -b topic origin
>
> starts a branch from the default branch on origin, but if I run
>
>         git branch --prune-merged origin
>
> to clean it up, it will clean up all the branches with an upstream on
> origin, not just those whose upstream matches origin/HEAD.
>
> So I like the idea, but would prefer the arguments to --prune-merged to
> be upstream branches, not remotes. We could support globs so that
>
>         git branch --prune-merges 'origin/*'
>
> would clean up all the branches whose upstream is on origin if that is
> useful.
>
> Thanks
>
> Phillip

Hi Phillip!

This seems like a big change. It almost becomes a different feature.
Would be interesting to hear what others have to say as well.


Harald
