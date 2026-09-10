Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB280356A37
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028724; cv=pass; b=AHLRY+K1LlCO7bIKZkemtRt/mysVzCKI3PTUozak8FU67orxasuLqPmwvEqa0uii75yTM/Qmjb8E1lAAwFRiAz8xm1gKHRaiCGBSzf3SQQuocxw1C6RVORZ51e15CHYVDU46X2vHxYHPAo9r8tIiIw3mYjwmBYyn8sUKRwiifBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028724; c=relaxed/simple;
	bh=Mu88Hbl0om4PPcQCwIbUJVuGiUVyQF7ttg5j+ZDmCGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNZBbCk6PNaMKjVe/y24NNTWNyGDguouq9gM+ZEpJUxPDYTrMxWv7/aoDX8/a/amuoovcTwDVcDv/MrAj5U6/16UK1gI7+EYysY7AcDF6lJPpHt220IbDT+KT8M163t0O4OIU29nEN/B9gvr0yYx+qvLs/tlJf12LflwAs0Nltc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=AeAUZRYh; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="AeAUZRYh"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-670f572e814so561726d50.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 01:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789028720; cv=none;
        d=google.com; s=arc-20260327;
        b=BhTWRKykjH2ZpBEahioy5v0PqlKpu2ifZN5CmYcEiLCLrtRQFdKSb+RoGpP5KNKPfO
         sd1xcNVGBrDufRkgJLJseaSeQO0bB0LTiYco7DfWIwrGik6LMCiqyNpWFamnCbFJ0cCO
         1UtogUwtqJy4D+D9P3aaJyQpbjEKzZ4YiwS1UYRzyKUFNHO8V0WH+lTGPpP4goivsXGS
         GytF2FdLsS3JTzFWoo39tTvH3ocoMNK36fmguHQTZNY04eA/bndT/aKg/y3NSaHLaBNI
         z5i6mh5mX1Lgm0TaW9uwoGln0XZhVizCkafi08x0thCl+3IxR9W8Des52/7WjXvYRMlx
         t5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mu88Hbl0om4PPcQCwIbUJVuGiUVyQF7ttg5j+ZDmCGM=;
        fh=97w/Jzaee3MCHj0c93nNjrQDMKoRa0NxIO5XU85SAY8=;
        b=cuadcOLQieg5g6uPn64UgnL/dBHuCX8rZ9lpoeHB3sxYvDLowUKSq7x8WbLPxvjtbp
         eXXaZbe4PMAtgK9gjVoctMoCZDXGnXyVlajfA23g0OdjTPMsMC5eswgIaGJJHpOzpAMF
         lVflw27Bb7sk9IpG+ZYVv9gvE1oCDIJbKBmBveTu3t0S8iwV0DAyu43K2EXhFtLE8w+e
         eNrueRCmRyQmY3UKd7rEeorKadPOX2FgPBmGNRBl3EERbSUVBVBwleNpVQUEg3uZ0UeV
         izkHegsdVB9cZfgWba66hM2uLeRgO/iTXxEgoGUoTXIF96fg1XPcF8XUGKqPo4wLz70D
         obvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1789028720; x=1789633520; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mu88Hbl0om4PPcQCwIbUJVuGiUVyQF7ttg5j+ZDmCGM=;
        b=AeAUZRYheSIFTofgDhpTkblAPft+FInAMGXw5/C0jBar2Ws2vqKGYwYQSO36urw/RW
         SbKGU6peALOFriY/aqaugtRadj79MON3mBCdiOPttM+eNpSbp3oB+iU/gPhsVyMw4e0p
         eBKXbUusyOpUfcwo7gIFBAex5WcKpfITOUiwuRTiE6SzJY9AxzfkbLEz6ni3sEY4u33G
         Pwz8Ccldh+rMeQ9X14hTdDPwERgkYRUcOFQ9gyv9y8uTA3EZzx0XYheg8d8ldT8DnDMD
         wO8S/F0tkxBOJ02/1ZMo6igSA6vx1ANjhd3fxLpp2EEYa3Gr7GuWgtu637P73665hV25
         3mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789028720; x=1789633520;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mu88Hbl0om4PPcQCwIbUJVuGiUVyQF7ttg5j+ZDmCGM=;
        b=Wgb6ti1O/wDI7/w8N6D8MFdzZ+lIuLgH5996U70/nxd9cApV39m8BocYeW1MNE6y46
         U4UMWtP1BW6osrxdjA/EQJhkFyriNDSYaLJQdc0b7b6zaLtu4yxvEUoIB2vsPw5Azdop
         ql0rr/S0rdvXRKhZeN6xH8/p6EdNJApOyVwtv/I5RPtdJCoI6lcDvaLehYJTTZmN6qdc
         6EXYTysitJytACu2QzwGo4f/VQJ4FyGbinvskJ/o2eChoiH2tqOJFyVT6DpZ6RnlPfVI
         /yai+7lhKbL1lKgrT6KtvRf4+t1XYKZvkw/NCfT+CzU9nb9E2SeK4NjsvAbDjGuDebSK
         uMHg==
X-Gm-Message-State: AFuF++lI1N4NTvp/7P6eljuGUObMhKnW9oo2Unax9/du+lsHcabd7UoN
	mF3QQ/o2Js9JyjPKC6Q/bJA3GAuRLRiEMnH2RRO9bKddl7y9KXwSCYtRmtUChyocBxoRKECJZTc
	9Ql3yJRo6Hv8e71eEgWHQdAA3S+18jrv+qySZbV1zFw==
X-Gm-Gg: AYBFou3MsuPJgz49gcIz6KKQrNLPAmDyR4AheKrUJGFwTjVQvC3vDODn4R2J6rllDBl
	ksQM7dplbttwBJmDUJWDtovInqhGQ1S75cd/DTwACqsp+MY/I++xsQErfOhr46q0WTNAJinCBr3
	TPRxdYOgwZNWkiK8dIZw5zj1njOhh72fZ0hIMm1mmV/j+OhADFkECHNYrfXXXXN9nIdlsg4NlCs
	u4BsXoYOvKWTCpUfPFuIUPAzc9Qc6lXCGBro9piIDt76Ar7Ed4sab927K7zo2obx51xQOWnrDD/
	RB7N12hbGwRfIRqwJWDdnrukSwsyCBxxnNTeGYwnELuXgJOdGWaUeDMvTc1mCT5rSWFSbBHycJX
	BaA7nVHuVAN4jtHxk1cyDEga+FTZah8O/XSvPVYC0ROM=
X-Received: by 2002:a05:690e:1188:b0:66f:c1bc:4056 with SMTP id
 956f58d0204a3-671138a07efmr986094d50.30.1789028719631; Thu, 10 Sep 2026
 01:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v3.git.1788863286.gitgitgadget@gmail.com> <xmqqse3jyc2m.fsf@gitster.g>
In-Reply-To: <xmqqse3jyc2m.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Thu, 10 Sep 2026 10:25:06 +0200
X-Gm-Features: AcwNN1V1bC_ZiRHEn2sNSvLgzTH5_3coJCxmrbAbGhgyERffnCQZ9El1c815jUI
Message-ID: <CAA0xjtrmi980617q0GPge3YpWmmpoaQOs8gTCfnJ2U0Hscw4Tg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] sequencer: leave auto maintenance to the end of a sequence
To: gitster@pobox.com
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, phillip.wood123@gmail.com, 
	ps@pks.im, johannes.schindelin@gmx.de, kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On 08/09/2026 17:53, Junio C Hamano wrote:
> For example, I got the following from [3/3] with N==3 and I think
> that is far easier to understand than the original.

It is. I took your text for 3/3 with one correction: it says the
setting goes to all spawned commands, but I only pass it to commit,
merge and exec. The sequencer also spawns stash, reset and notes, and
those never run auto maintenance.

I shortened 1/3 and 2/3 to match and sent v4. The code is unchanged.

Thanks,
Thomas
