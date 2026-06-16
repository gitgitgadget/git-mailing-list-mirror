Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434743CEC7
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634525; cv=pass; b=p+4JyvTUENafymtQRaTgtavVTwzNBV4yZ8eauVKOUyrgFYfSSbJXaaSjaZhowhLIDn6JicV2qteG7roYXYl1SB6qR4DUiTbnLBlBCKg/cijjAcwuG1Wz0E+gO+qOoS6fjIAN8eA7KeQzPSusFvuNePLaMV8vQYFTCLnF8dTP1E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634525; c=relaxed/simple;
	bh=9IXjAdl9TXXOEdE20D8lWSis6wijqmr4+q63cX8Wj5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMOu8bIsWRWM+UylcJEfPQY1oq+v81h4089qe5sQcH/lPtwAqlGk0oTQlCK+EEUBhz0VvHLBNBPz7fXGcD3vSh5okm/14eMBHWuIJDoKjCcJwgs4DYt/rvdQWnvXmjXnofFTiPEyrXv6eiEVqROfy7aE3dsTcnFj6udDoYWq734=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imfh56X9; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imfh56X9"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so6892279a12.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 11:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781634523; cv=none;
        d=google.com; s=arc-20240605;
        b=R7lElBgZ7ejOLAXyouQGCQLvDPd6RFiF5+yX1AgCmJPYFQIPhxctd2bjSRIOwIRfS/
         u4Ylj6nw4q8ZshnFT0oEL0f1RIprleUnPceSfsYW2AJTebHLzFsck9CwhQy0eUFRkqEr
         0p/ePxGml8MXqA7EHStT0sbpjJ9Ylo/6e9J6CX13C6t+ZUzPOxkXzOEqD/naa3WwXiEb
         QxvLD+dN/aZFohyRJHsc5npH+0+1mSY7mYfpj9dCVSirFxoqcUS/SgxMaakmdZtMNXqi
         tKHQYrmM+wjeWPNjHxDDt/vuORntMyVp0k7ev2x66mjREPrB7s63Gju3M8udaeTA6UOF
         2xTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DN6lPv/TI/wORFo62eFJzvqQlqZqogIHr8Ujlgz3W+0=;
        fh=sQMz3fwunlK1zrBX2Z+XUjTkam9EY0CwXBvN+WWVPSY=;
        b=WxQbpC2esKW8MA8lws3Mq0oEvf+anrlVGVFcH9CAdIb80SQ4wmo2IZ8hC7PeCzHnCW
         2+VKgHkiQDfYtHrcRuyB82xOVqeotTnxniUYH9XOwuKj4o+v4xxKPN3L4Yq8+36WRM6L
         6kQVRz89KiVXGNarDrma1vUBpSORjMYej1L5gqnfGyuZKZXq0vsP+5F4A33M2e/147K6
         yogtClmXq62NLAsNJ1NXiTyxmr2oRO6uLbopfqu03++877KQlxfoF4bSd1jR6Y4TJZWn
         +VPGPGabUAKv76HSkURjYCB25ShFnM3Kc2oCj8kvALAL1B4VXocR+5S3a22cvrhZ3NH/
         SCXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634523; x=1782239323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DN6lPv/TI/wORFo62eFJzvqQlqZqogIHr8Ujlgz3W+0=;
        b=imfh56X96puT0rToN/v/IlD+/3lPRFDPArOs96Pf5FkTDCUL/NzP4Bwx7feINmAFgC
         DuaD/XzUSy1kZJ5tUCxDbb/QjFNUxWNxoJnmmiSSPXC0ZmmpJ5Ru9onTIBXcA3FIEnfg
         EWYT2JHVmDAsAO6LUzosREOJ4Am6Cm3pOltt2KbViBD5mumFd0u3tU4JC2eEajNRB7TR
         zdFQ3ezMSqSxFNd3r67yzRVOWtIi5D9X/pML82CVBPD7Q3T9+4QEmZn2VEj4hasCQ0Nb
         i+F/NdlK9XESDUswb9Y1fwvXaUMTdjibnezCbtL94cTeQhnDlGrfmkpZ/WWhyVO4VXrc
         mAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634523; x=1782239323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DN6lPv/TI/wORFo62eFJzvqQlqZqogIHr8Ujlgz3W+0=;
        b=k2RmSIe0a91N+wa8is0awkOdVovXdrpwkgVOd0RUq+dmpWeaJIdmnuMwJqWOcInJ5I
         9q/9TfvfTu4B148ubzD8gLybHHOTwda1AJ5WG+EBdTULu+sVFk8RzYcRQGTAj3UBDjPw
         dPStLB1rWOs+2IGGBqPx0GtJBnRdjgVTVVMx376fjfB/CpOzMPtf8DJlQZ+ankjKRHWl
         5+ZdVHVeEZ472f3/QrVVYQVE9nCd7/A/DJkNafNv3a79BDtnfi5ZbKZjlXi3UnCqRXgX
         FjKJnvv9du37HkpQUXF53l0mRwnjU8lRmO2zpDUGIqRI2T5P9eyYz2pdqpMKQ5zOgiv8
         j7fQ==
X-Forwarded-Encrypted: i=1; AFNElJ/i3ptzxxEAHfpVhO33rvusAV8kA6uOahNXCiDT66xSBJQOj/bWzg82mZb3YSdOjc/f75I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6HfHFjDMg6+5NWq2Qs/oO0ERifVR5dRiTxFIsdIavL8KcBXkt
	zhAa27TgHpwJa55La2sCoR3UKOg+WoipQu2Tnzq4df0TqrPIPGYM4uqR3iZZs5q/fSGD1hGXeIN
	SkKilE/DaFxiwWKJnE6fi2Aox3IM87Sc=
X-Gm-Gg: Acq92OHpNczB+F7+Av1YH3nObg/1th7831qxRkrGCsjR+MKaxw+detcGfOwmLFhA95z
	9tDeOP9h7MJS+s2bcebzYpncCwuXWFJvjiFDSd3hOsi4ke3aZc+VcBSW0IBgNxg8CW7sxiqaS/1
	jP7FrDGOblnGf7zY3ZUXiLkBspTHlQWq0QhrdRsKPYChtlWWIx7xIFzEhWkRXGPtDVmI4Y5TqVW
	WgZkeOeJzFcgQnCp9INYpw0OQMy3g0liRJWqHHlmoH7UCBMX94dqf+chD6ckf2B8pMVkdHQOFgE
	w5yUpPQ=
X-Received: by 2002:a05:6402:280a:b0:68b:f026:f381 with SMTP id
 4fb4d7f45d1cf-69547580b15mr217072a12.8.1781634522487; Tue, 16 Jun 2026
 11:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com> <ede8c6172963fb8d15f0ae28f4e11501cf42be6c.1780999917.git.gitgitgadget@gmail.com>
 <7b43a0f1-32a0-40f0-8c82-d2ee78809cc2@gmail.com>
In-Reply-To: <7b43a0f1-32a0-40f0-8c82-d2ee78809cc2@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 16 Jun 2026 20:28:05 +0200
X-Gm-Features: AVVi8Cd_YITXOHyY_hwJrZtTcMHHBg2AbqM2CZDh7HHxdahpAbKKRPysec9FRcI
Message-ID: <CAHwyqnXjt962HBzcMwRfghiWtv7Wkx6CUxapMv9O9igg27A_fw@mail.gmail.com>
Subject: Re: [PATCH v14 6/6] branch: add --dry-run for --prune-merged
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> > With --dry-run, --prune-merged prints the local branches it would
> > delete, one "Would delete branch <name>" line each, and exits
> > without touching any ref. The same filtering applies, so the output
> > is exactly the set that the real run would delete.
>
> I can see this being very useful.

Great to hear and thanks for taking the time to review this! Much appreciated!

> >   static int prune_merged_branches(int argc, const char **argv,
> > -                              int quiet)
> > +                              int quiet, int dry_run)
>
> Let's not start adding multiple boolean augments - use a flags argument
> like we do for delete_branches() - if you get feedback on one patch you
> should think about whether it applies later in the series as well. The
> rest of the implementation looks good.

I'm trying to generalize all feedback, but sometimes I miss things.
Thanks for pointing it out!


Harald
