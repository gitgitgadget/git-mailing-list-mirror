Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642A4D6C25
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223811; cv=pass; b=fkvaXYY9I3Dxrk1bYQU7v8X2VHg1fRtGA+7TaOdTOb1N0sYI8i8r4rsjTCl0EkQ8xE6DVoLV+Uh5Wl7HoLuHDnGAsI2xFWiour5zL+dnOt7SokBSdFaudDyRwiHr+OAaVAK/X6mtorljNtIUsEZ/5dwyDeItJdA2B22PsDUCiQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223811; c=relaxed/simple;
	bh=Qg7ZuBSdL2E+nlwDLu7XQOo6jeJ5yO0FSxM6jVLcVJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvSLRBtQ8nwUzUzdzzON58uVkKQnT5MQcujdEYs7xc2r+Zu8JMDmSqTB4jcfKIEtRIWEHtBS+ILGmoxDm8gSv4hpF5pA767Nj3VoAX6qlD/QMxhKwvaVbfb9ddT+g7wPaGCys+qLjSrNt498NFY7QmrobDJqTF7iuTxpVV2MXxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l693b7eI; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l693b7eI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so2715589a12.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 11:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791223808; cv=none;
        d=google.com; s=arc-20260327;
        b=P04hudwfPIyukZ0uxApNjvBEfiz4dnHGUJtXx6c58QN5dE7WGO05vatlsOQm2Xvxc6
         QB6xgKpYscwpahOF7BI+MM3UpkYmTHJsppg5Ie4FOLBpGMznMbsTSicfbtTKxk5soQ/V
         3jZBFBsk2QIvxcJseBN4+XDDC/Dlbq0b4er1RPsn2fIdR5VmoR/L33x74HjVwHFENG1T
         hfdtY5TRj/wFw/cvHNPXUN33idNjjC4AII8u6NZPe142dgaU85jRb+nOv/ianS6n+2JH
         rwSc3KiyVzyrIarcxypUNTjfb6S8sAGoKaVRbHbkt+EkXTEA63D/saX7k0OPothBzZvA
         4Uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FZb1kb9fMNJCC2nEfvOfWwZRGR9sH5s8vhmfvVQdO5g=;
        fh=KA0K2ATrLL7Vg2RTnuUJ3yetBb2eIIYMVYKZ8aJVcuk=;
        b=GeFrB1shQw9MBOTPpK/xazI0U64ihcgOozBwOEsnS6jPdaH9dbVsZ7KBlaJi0XoPnU
         DS3ho4YtHAGqKCLe2wq3BeKLDPRYWWcQD/dY0hd7Nhl54lhY9FN/CeWVsrUKUmDAaBv2
         jpGhJsaS/HhL2cEGHUZwv3xQbQFdIt8yUcd1KCEF9yUXR/Xkl6cbwgR5sJbpD/pDPxxT
         gOjMulEMFiz3iB5Ur/LWbC3s4RhxvkKZpHBVgOtBLVb2/uJPE0JQwOIjtY8E6qWHuPTZ
         PtpWkZp2unlZrrC48MpE+azoxiDf9dK7pYwBneL5Vf4SEXcs3PWknVwAp05c5zH6WDXr
         1iIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791223808; x=1791828608; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FZb1kb9fMNJCC2nEfvOfWwZRGR9sH5s8vhmfvVQdO5g=;
        b=l693b7eIRPjUxjWmwl3ButrD2RAtRurqHCXFM944o308pldde07KV64WEUtciLVm35
         bK73tQxF3QshRWuh3dq0c6q1EV5U528e4LFiMn9hdVKx5JJuNMDhsL1O22hSydXycXYI
         9Z/zGg/NAwbfzdlclji862vMUkWjhY46TsKqamZxhsmr4/lPT/ySnFs61gL2L19X1PNT
         41mGKTX4QTiLbCKf5+FYRW2MM92axhDQoTbmOGPxZ8a3sTieENWtjWLjXuKiEocmGxAP
         t8kg6Ma8ROyCJ3INljKmFzHebDrrtoA5ZjibFxG5dXFmcZtldbhqF3K0W2yzRw7S4FPZ
         669A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791223808; x=1791828608;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FZb1kb9fMNJCC2nEfvOfWwZRGR9sH5s8vhmfvVQdO5g=;
        b=0Qndvhgea27fNUUtWogykvgztbo4I1F8eMXZgZcp8+UHElqnIIzBLofCWmbD7AEKfB
         J2f2uVpGY5K/b80PkYUvdlFj20/5Fpc7zc2HnNIokxrmMut9kYD+W2bIvvJsdoYN/3Co
         /JuBuezd/C+2WoyN1Q8jZT2Y/dO/vnH4Z7AUAANRfW1UI/nssFRMinoYMYPDgi57dG1z
         FSSK0VcvmoPWfm4sQsp3aiKqhzTXy4mXQ4ofBlC1Fnm7pwy1+dmWU1k/V88/8pm7sPft
         bKVcxJ7wQZSouI72EUALDaIt1vNOQTjuQbttE1IxwoOv80kdYwNa1D/rInWnTEEEmADu
         WQUA==
X-Forwarded-Encrypted: i=1; AKwUvBzdkdvAuttTWWrhhQBMbph6Al+pHMOguBCqASB6k789qLFlG/OuPRw5PK0memE/pCkds8c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSFEJ1yyrzSE5cTaAvd/LpXg/P3zBiUp564lxMuW+fUV+yQ6ZW
	x7zulthU8yMP+zRCFz1EjAWGg/L3kgYP+WR74E3zcSNHWmCPRr75UJorSQag+FtG2DDSclgKbbE
	cpBx6X/KZB8uwzs3b7S4jE+XN6zFtL14=
X-Gm-Gg: AYBFou2ncZL8/0jyONViW16LJIVsaxBejSQ0JytFTPqdlumfUR7maNxCrry8qfQVbPv
	mJB5Yuxp5ws9uQFsZOpgPC8WdfVFctGwNMvq6ubGgW6eGck9sI/uywExUz2WTTAd8WLyFc8YXPM
	cdREBxRjyIRG8XXTgAyHRAyeJVOJNo3BIOPIYyJvzlRAvdZ4/cOdSkn6KFQ11dNGIVaKRlm93MO
	3GKClQ+77oO56CIbghEnkl/iS0KnhkBvMNoPEtQSSpTCwFvbUXUfbmfJoW4xCn8wdfNOGaLjZ4D
	9dMqYMHH2xvbdnTO2FDr+aprvMhP6cLBDmmiarlWBYT5+rTg8P08HDQ=
X-Received: by 2002:a05:6402:51c8:b0:6ac:73f8:2e40 with SMTP id
 4fb4d7f45d1cf-6afad901294mr7224610a12.27.1791223808040; Mon, 05 Oct 2026
 11:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com> <xmqqv77hs7ut.fsf@gitster.g>
 <CAHwyqnXz+acRBytu9tWL+RzsKnzTZyZCnzzQQhEFjvWT5cgoww@mail.gmail.com> <xmqqv77gnxyg.fsf@gitster.g>
In-Reply-To: <xmqqv77gnxyg.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 5 Oct 2026 20:09:30 +0200
X-Gm-Features: AclHuK_4MfCAyLNqSXCNNjXO7zLP-_6qBCPMNQbUr7ANSB6GySJEGbeToJMkQds
Message-ID: <CAHwyqnXSmQ_E4u6S_dTVHe82E6ErqQAHpOUDcUZBGyLRbne-Pg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] fetch: avoid fetching every branch of a new remote
 in a shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> I think this topic textually interacts with Collin's followRemoteHAD
> work.  I tried to be careful while resolving the conflicts when I
> merged both to 'seen', but please double check the result when I
> push it out.

I range-diffed against 'seen' and everything looks normal.

I have a new version ready to send out, do you want me to hold off?


Harald
