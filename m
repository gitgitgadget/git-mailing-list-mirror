Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF9363083
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924041; cv=pass; b=NNlkfe2GcY31S4tsCIkV2Sbv7Akfj/a/tE2cMVdKP2O0VZPB/Ab583ri1gDYUURafDjW+6r83r7VR0uern8ubZT8dFxSfzW1w6tyi0qry5eghBqgjWOilW3fR1nWxrnEq/sI9vNyoV9mtQIb8GGUAOpUiqbhNMIeXk8YfmCtn/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924041; c=relaxed/simple;
	bh=1C36AatOMYfTG5okzUb/FdBtMLauh312vGkH23vzkTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbH9zjesLu5VG3JY+/+Or+W2/wE68fYFySYFgofx6OZ38ztAgj+ImK0PmuYvtXUWFNSMg2aIoPq1KAJnfdBF8ca8oB03nPExJE6C/mG8gmMf9IFLoJ01MqXyvQuWj5e/2ncH8u3ALH81C6g8K/4Z4l7OLU9qR9NcCqw65mvVJ40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKNZaV6V; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKNZaV6V"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb9b427da2so2556613a34.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 23:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783924039; cv=none;
        d=google.com; s=arc-20260327;
        b=OpMzk6JjP0ltaVsSPf/vbQFzdRFlN82UJexgI2GSwm6zjTyvEMTm6Q+HLCu5/SQdA7
         BYlwNyR0IYNyd/D8pjJUYMtiy5aFY4I+Mzaoaoc4LZqyXrc1yc0fmtupzPNFpxri7gkP
         +hDu0ffxrT/CK9X46I1K/UNSYSrz3rDM8gU8Vw+qpP8Qs6Ctime3DJR7E7wSaNygxViF
         +Oh8hbHSKFogEy4byNT0j2Ef6JdsVeJtutlQBDax1LilKeukrUt8OVTfavg6rmPtVfd1
         xwXnzmncTPb2mfpYQkiA+Rv7rTpQbR6m/3PsakFWe46gWzErdzWycro9vqgQUZScp5hh
         j9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dQUflXgPwOrGYCF6MeNk03ooL2JVrZVmQ7ZBrXJRujA=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=RYR19oHfpxfjpi46BxCJOsDwXUl988y6ez/FKA24h36dQvzT8YR1xzOHBnsoRX1P8X
         eapStmxGyZS+KXu1CewVpfNV/CUxhSa3Mc18C10IxpT5XvaV0p0JBF2Bi/y920TSGcww
         h8Cupit46moCItuQLh2RPHVXUMgxTGyK6048/DocW4ykzlDvSHg7LGe7fvTxM0HiEFT5
         JC2IanYKjQkwFmvwyX9lG0WS09GoC6K7adfkezuKiG+Y4TMFEIZufxl+OzVxsuDcsGs+
         IEkNyI8B51xl2iJw2ayYKQ0J1KtY7n/6G8K6QJXnUOROvyLr0C4dqsvqQCJfNcVE7aDG
         kviw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783924039; x=1784528839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dQUflXgPwOrGYCF6MeNk03ooL2JVrZVmQ7ZBrXJRujA=;
        b=TKNZaV6V8I0zt9zsvkRhxpHihQ5+o/H3iIUKmfUHeOrnlNi6D0EEnWM9On2AzY1L7L
         dKNhykh11ew30lPBUNJKkhvB0ebR6lPn0s79mycUHeTsxreymnK4ndtHlo0JSrThJHh6
         wg9aacFLaFZ+G91Y94drGbqZtNXwJBhKWTgrGGlYqS6ZZXarEiCMt2iZdoNS4ufTRsQ+
         miNQzYR7xl+iRSW0FMAh5PgfgdE/WazRLHeO0ss1PSU/1uk6JJaExOt9mA4BgvI2LuMY
         AnbZiswoiNXZ3teS7oPjsXjYEdxCQ3mxtyF/nD+eg93JypqqnEh/ACLxOKBOuI4hN6BO
         1pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783924039; x=1784528839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQUflXgPwOrGYCF6MeNk03ooL2JVrZVmQ7ZBrXJRujA=;
        b=CACanxzSpj7GHfjN5X1gf4twRnf2PsFg2AAqAA/IAhZdU/i5ItltZcdlLrbtpVoJZy
         jzEGnEjmn8oA6lUskt8g50JtKXY0bUyFhgckYW++zLUNQLXIsjUSX4gOdyufF4O9aE/1
         MwtoYNs+x0LyLO3XYrg5y6Yo8OpC8Jz0zo6trsPKRjQOBxDqU/uh9hbx7GJsdwAj/c/a
         cPJB3oZWf7EL2SpvOk0rLaMXWk+gjqiCbpzjV0LRBBAWNsupcCRqy+0WqMb1afa3gS0e
         +CkDiZWKXpDzYITlxBA1Cp8e7LPYgi/IwGyOC0cMPkAeV1l7/Zx4IGXy6ZpDCbaGwRtn
         bmRw==
X-Gm-Message-State: AOJu0Yzwd9nWRrWPThijrQUdCOF6n2GT/YJaOoimsT3D9XSIRnNdVFnQ
	Bbi8x41L53bUcYAtyciF+UbWtlTY2+7CrNn7sn7OpHrROQu+T9FC6Wd1WyF7wf7sWQjVCPGmLb4
	gxQxMigpgQS2WBH9Ou2Ki/5kxVXXQqR1UVw==
X-Gm-Gg: AfdE7cnG4tJ8cRIRkQDcCGsHgXioGY0oTV3UjnaVb2wtQGJPMY/0VKMdAH8X8h6VTqM
	ih+ozXWdg533jFCFCfguNIaaE6wqo8R68UuQ7i3BGOCL1F/V/eg7+au7aY0XoIaFBtKWJKhkaUg
	kyOZxeqRh4xLk9ALCfK82uljmNCuc20dHLda6vAbLdREOZA5CEO+2KU1zdTQl1AbkPRn1OHhtwk
	keOtnMKwtliyCRplgtFDz+oiQIrkqyZG+NTADd8ABg4KhvU4Je00A8S5bJBvtYcmOB269tX+fxv
	pySyuMCnxzaNqX0w+8g2rV97wOGakEPBhF3T/yPOOW5zsTjPSf4J/Q4CU24IMWroZwww6xd9ryP
	/HnTLEQhJJYOJetuuUpVttzbTpQ==
X-Received: by 2002:a05:6820:1a08:b0:6a2:84e2:fb3c with SMTP id
 006d021491bc7-6a38b8852cemr6119125eaf.4.1783924038858; Sun, 12 Jul 2026
 23:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqik6j1m7u.fsf@gitster.g>
In-Reply-To: <xmqqik6j1m7u.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 12 Jul 2026 23:27:07 -0700
X-Gm-Features: AUfX_myawi6Ut5bYxovL5WOcq1k_4nMDhYltqxON9Y12UEYwtWZPgXk8nPw4YEM
Message-ID: <CAC2Qwm+avzQ2JmM3YXMzsPV_3Cq5-85uBoMkdL0rTuOHrtGJSA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #05)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 10:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> * mm/diff-process-hunks (2026-06-14) 6 commits
>  - blame: consult diff process for no-hunk detection
>  - diff: bypass diff process with --no-ext-diff and in format-patch
>  - diff: add long-running diff process via diff.<driver>.process
>  - sub-process: separate process lifecycle from hashmap management
>  - userdiff: add diff.<driver>.process config
>  - xdiff: support external hunks via xpparam_t
>
>  A new 'diff.<driver>.process' configuration has been introduced to
>  allow a long-running external process to act as a hunk provider,
>  allowing external tools to control which lines Git considers changed
>  while leaving all output formatting (word diff, color, blame, etc.) to
>  Git's standard pipeline.
>
>  Expecting a reroll for too long, stalled.
>  cf. <CAC2Qwm+P=3DfZOtpfMPeMiSXf3Afk6OLYpTP8Br78_PRA8WNL1Wg@mail.gmail.co=
m>
>  source: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
>

Apologies for the delayed update. I will have a reroll ready for this topic=
 this
week.
