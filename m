Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314E38237B
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991590; cv=pass; b=BGFk4lYHtByH5jwhaeI1+7WuDPnVKlxe8IhcJmwiDQsBJx77Dm+vQwW1h/8b7y5A7Wm06nyyB+CNkEothL4vaQHi9Y82noruFGALhRRc2osX+0OAmmlHwD9D/OMr4sSeynwQuBAMO1FNuuK3E/+w5iKXJuRUQWxhFV3GwJ6Zwl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991590; c=relaxed/simple;
	bh=AAcVwhHUflCrKHPruBK114++lVnEyrMLeDITzvjS7zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rK3RbCzDLBUzXRQmohYgmnGo4fQa+Syf13f9tSJF3wWs7n+7Rj49LTBhrCO1aL7IqH/Q039PaUdTMThkLjk9VXENNt6bjrEPxLYxdRTCkDWgMrgyCOaQcVOUjjurbJSi8nn1znASQoySDE3ZiEYhpU1avxoEsKGLreh74y0KlAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avdZ4Z8C; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avdZ4Z8C"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68f36e1663cso9213338a12.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 00:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780991587; cv=none;
        d=google.com; s=arc-20240605;
        b=KeGnhF71VKoVxF/NWF3l/8/kzk+XmPXJzOYg/j9kFXA7oC0iR/iUdA5YstIUINV8iA
         PcD+ay8sp+4nIfSgVybNIZDYLx7yD7pmnMCk0UJXcMxoHbvRZCO2Raki14EUpDJmjRUv
         pBoyH0EZOA7900IDgMpSdi05qXCx4JixvirDVp4nc+BBtDdlhpoLcp4cbPK9PwVeCYKV
         EfaK58Lzv0CCIJjZBzM8vyjJYwVKNVOCRm+Hl/fSeGiQJBXxY7dOIC1T0ZEI8yK6fX5D
         WtuQFIIwoM8AZybLk98H0PDwBxELuHL/WunrcoUt6CQuiFJbfKl9VEaETqwD1XQL6RZC
         2yHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SOFfagY97XJ6l1chUZjcuG4G2mOmRfvKS6jAdVO0kcU=;
        fh=GxCi/N/wk4cw9ZCzo8l68wHwAPFcZpqdoAF0g1K9y4E=;
        b=CDj3gLGJ78dMTTJTYGxxenlVdKQ3Qr36GJ0YvGIDJDvxjGii2gJrsDZ0DAFLfUGjW7
         5ZGO/4D5UOrmiuEcdQQkahaH+6/E73JDMZbC27yk3dI42lNbbDsGs4WrndR2SP8F1tNw
         4HUcnTy/nyiW+agZwwzbnv4Y15AJsQJ9TuIZ6kJHymF8fkjDrpQI9guY7moFHXr2zIl1
         /RJoJB/ef2oJE06Dtb4oaM21wVvwTj6UwD236Y85kUcJgtZRI2FLLIUGn1M3K8tzHYDT
         EQGKYrBRaASGuSFnKhKXCZ9cK0fleVnOtE5YTv9nUXuRp1ppx7s8moBQ8EnfbMEbGbBd
         MHWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780991587; x=1781596387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SOFfagY97XJ6l1chUZjcuG4G2mOmRfvKS6jAdVO0kcU=;
        b=avdZ4Z8CgU+J9qEYcmuSMu5nx8NyA8X89BV1/B/jIxwIEHH7nytD1CU8CMBx59uXGo
         xKa1DfsOsZvA18cLl+1UF5g3DM7I9k6ZVVYGiHS0pws6TTQJyWsKgmjTpT0IHIOwTF/4
         Gad6lxrbHAgsNarSgKOEx4T3zLz0ZrSya41UmT6yVOuFV8Z4SHtxIds7/DkQE9ov89dd
         WkGE5jKgtdyiMScwAH9CWsYo7fKh78Xl0EhCIUTCp92nDUAhHOu92E4uFm7E/GlJOrXk
         eRsVit9HEzJTJDVISzJhoDzBKJrnGp4DH0yz7oPvX28Zvi1iBL6lEum3KuHN8WWlz3CI
         dncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991587; x=1781596387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOFfagY97XJ6l1chUZjcuG4G2mOmRfvKS6jAdVO0kcU=;
        b=jys9rfH86gZi/EqAPB0oRHZ9kSfX1biTajlOUrc8rYSdJ0kpqBT55c2TEddhHEVWT1
         1VeAngq72E1vOl3b1zWWsxT9uWpsYu7j34LOY2td+eXB6p0fp86ihqegLXZw0mzI7bov
         uXlkQ2G49Dbyopu1uMnVQRZRNVLnI2AKSkoFbHVaChydJNhxRdSg46f+bLddxW8h0srQ
         q5G7X/2g2etPuJseU+KHSrU4zO2wRujZpQ7KVjUptxGzeba/rNwGjoHrkrb40jBgEtU4
         RiAyEFBm/LFE2PaOsadXUUoMuzG1HSHRbkfXa7BX3b40tgm59CN+Na+ojVCD5E73wS0y
         xdlg==
X-Forwarded-Encrypted: i=1; AFNElJ9kdzYn0I1VLvzHvK8WGz5SfWmcdiTtkd+YY+uie1WwJnQZx2BRSi6a/LO0mkYySAgtbjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwa7xHP693pENHkGJ+c/VpgIg2J9Yt3o7su9pHM6JXJJwhCSn8
	mZnb55d2K2SxF1rsaC3kujOvrpW5DZ2qOBzkoGBPoKktCr3UvGBbxXacp3ebHQyOAhCLa+CUAIc
	++JlCIs6tKxWcyMgVplhcUYKkm8P9xmAyz8bdlAc=
X-Gm-Gg: Acq92OFAZJFEgqTbDfU41Y8FDuvfcfev9HA0ZrIDwsdvqrCa3E2Ll4df/BKQcO+9b7Z
	a6IQHvXpXQHt3gCGPDMc6U8CDDOVtRIwDV+Y7Opr30Y0ilyNmHel2CLjbTMOLmgeaAIhdQWBdMo
	TgbXJ7niMJRsOO7/RwfbwVQazlpa00hlOWpwsXvbcAfdGcz9/K/sP0f1WxOnUykR8X05FcnoaDr
	vVZ6y3hbl4/aMmHhwEgc4zCUIO6ImS7MMYnaZ3zaziNrbhQfGWV6GPoQhAfvliAwaZNQjRc0+C9
	0Wyzs/sBpd8Tzx/V4Q==
X-Received: by 2002:a05:6402:3905:b0:68a:c316:34fc with SMTP id
 4fb4d7f45d1cf-68fa4e27b23mr7904280a12.9.1780991586571; Tue, 09 Jun 2026
 00:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
 <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com> <a7672713f67d6a44992c0f0cf989770c7e9ca38b.1780684553.git.gitgitgadget@gmail.com>
 <xmqq4ijcvb64.fsf@gitster.g>
In-Reply-To: <xmqq4ijcvb64.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 9 Jun 2026 09:52:30 +0200
X-Gm-Features: AVVi8CdEakulpZ9xsQHJXh0iXo_2FmQXDQeU8fA_a7PIDADwgDp6ykVn3c06vw0
Message-ID: <CAHwyqnWpkF-8czt8+G4GJpMTb1qXG6FtN1HKrT5H+OcfAjQL=Q@mail.gmail.com>
Subject: Re: [PATCH v13 2/6] branch: let delete_branches warn instead of error
 on bulk refusal
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> This breaks t5404, t5514, and t5505, which contradicts with
> "Existing callers are unaffected".
>
> What's going on?  It is troubling that the breakage happens without
> even getting merged with other topics in-flight, which means that
> the environment you are developing in and testing on and the
> environment that I apply patches on, integrate and test (something
> based on Debian testing) are somehow behaving differently.
>
> "cd t && sh t5404-*.sh -i -v" ends like so:
>
> expecting success of 5404.7 'already deleted tracking branches ignored':
>         git branch -d -r origin/b3 &&
>         git push origin :b3 >output 2>&1 &&
>         ! grep "^error: " output
>
> error: the branch 'origin/b3' is not fully merged
> hint: If you are sure you want to delete it, run 'git branch -D origin/b3'
> hint: Disable this message with "git config set advice.forceDeleteBranch false"
> not ok 7 - already deleted tracking branches ignored
> #
> #               git branch -d -r origin/b3 &&
> #               git push origin :b3 >output 2>&1 &&
> #               ! grep "^error: " output
> #
> 1..7
>
> but it may be possible that earlier steps are behaving differently
> with the patches applied.  I didn't dig further but I think the CI
> in the recent past have been affected by the same breakage.

Thanks for directing my attention to this.

The GitHub CI has been broken for some time, maybe I should have told
you about this earlier, but it coincided with a period where other
open source projects I worked on also had mass CI failures, so I
chalked it up to upstream issues (GitHub, Linux, etc). But it seems to
have not gone away.

All of my GitHub pull requests have broken tests (see e.g. which a
quite minimal change: https://github.com/git/git/pull/2313). This
makes it harder to detect actual issues. But of course it's not an
excuse.


Harald
