Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D023A1B4156
	for <git@vger.kernel.org>; Wed, 20 May 2026 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259953; cv=pass; b=rZ9ArGOOHKSRKFve+RrxyynxEnz8sJAFEsZE99ea4YtMPdB3LDBMv0KfZPjc7Lf+pZFyqq4PPe+deGtj6Wp7tJPFTMWHudQWR7+ls/NSNwh3cLnu6XKV5XD2k+3bXHd6oG+py5yIbWerSKwQP11iOj2v57JHR+pMXFvgmIyJask=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259953; c=relaxed/simple;
	bh=mfruqVZgWzK7YLRQA9KrZoRpeEo3LTOakYRqwa8Jp8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJ3OShffy/yRxymgscaco6QW7wyg4Cg+EXA0rmcx3IVg3ZuZ4h0oLz/3FKWvAtujtaNY0PpxlF5lEsmODG+yI12crdbikjT3erZYdaOKpmzV1Z7LPnoSAE5AOgaIPj2xt5v5pVbV5Dsr+4nUNqsqKcWFIVQpYOSajhNsLavYULU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQXtbzq2; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQXtbzq2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd01481e592so662303566b.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 23:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779259950; cv=none;
        d=google.com; s=arc-20240605;
        b=cFwFZH0ksCv2oghi5HR+DHLVBlShhR810TWJ/mksBROmFEbLPwEsVmPxaSPuJr8r0U
         fDQ/6I/qhb+3Ei6q76ZS0cfM9swxfVaHlUaAGWqr62R7GIJfTwTKjble+adySWXd/FYw
         YxCs+0+YFHI8eq5EzCvnB/TZluk+hFj11wYj3QnY640dY9AAv6Am1NmPLWEonsr8Jg01
         pl1KEEpvyxNo0KJcl+LurkG8KKccFvEDfu36dbksZKw7JzIKEpy6Sl4lazOHJcoJPD0+
         ljtPZE1/QxzSz/o31smHndrjWaA4F3YQDaHoUcbdcL9l4l4EdgCxfWAVU7e+j9MfbZZF
         zlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NVNwCq0UiOSwA4RGnRR2ycVGgbnsXCRaGpafjUalphI=;
        fh=ml4Cj7YhRmjw6jaOcUmL4N4rthcbW/XbnuT/8hNmE04=;
        b=ZiGIs2AheqT+n0HkmdPrAvX5RCSN60CaMaMbv26LzqyMQzBbxI81+dIjDpinVMXSJw
         2rq346Tupd2fLNqyrp0QhDtcGnrEBd03D/IbasD4u15+ZZs9x/X6t6szs/EEJm7HiaQj
         mugUTvLiwpkZhaWuJi0+Fywjf9gfvAOXqMhhNj71VtKzLpwlXZsmw//NwJXF1xT+XTuf
         5/qGHc8SmyCtuUpdZ6Y3FjEr9vMyGHA+eHnW8QnUHI+GDSNjAAGccLvGqsfPoBzYL6XT
         XC0GDOTF7U2/nGWNAx8u2IocqZyX/9wW30AoResibw9tMiI3Nsex6nD+0X60J4wsweKU
         Vzig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259950; x=1779864750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVNwCq0UiOSwA4RGnRR2ycVGgbnsXCRaGpafjUalphI=;
        b=CQXtbzq2IcMoNaOM/am4AdhwCHIjnlJVAeWORYiiMlRZMGnwif9aofxoSp4qIprRVf
         trxhSaNjwv+45MAJUGhBcphwjYkxANG5gbKg3yAo9wRaxDm8jVPcIwBGLyVvQFh7/OaQ
         j2PaxoDv+XCkOyRTpTso95HcjagxPhPFtsw3LyJoSl4WBfO+AzNzadqT+1F3X+7reHu2
         OTND2t6gWXZr2ASkjS58VNrKVLiTEgd7NE0o6xlbtiu3tMwO5O/0GUJvzvt1+HlMhrFM
         bgELfimAgTRQJyMMGMqeR6imTVOzWh7hMoS/OGkOCjROxIOdNC9yp8p9WGocKq8+uZyI
         wpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259950; x=1779864750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVNwCq0UiOSwA4RGnRR2ycVGgbnsXCRaGpafjUalphI=;
        b=qVA7iKUlBEuqR6J2OGeT6HWzA6ZyQoz1rfxZVKLVJSfiNOo9Ox+uFQI5At0xiO1Rfq
         5XshIvF2cGO+vxuLCHVPqnXBMD39qHHdlUjGzY87+MHJR+Fk4sphc1nsi8SIEUzwfRSw
         onXkou1uvOQUIWMSO9iZVqODehmMaESBty0w/Jnext1/Hi+ttfvVTl6Amh86K+/o7Wmy
         MX2pAYk8iVwcSHSpVg8N91aZnnTXOuxWF1MbMJQhQz4nlzSXkVHP3N13Bju8zQG8RD5O
         Gcsn3BczmxrjmXdbhVxzdHMzbpzSp4ASgFE8gtsGd6K2F3UyeD5FmqOirtWVujYabwbY
         65Xg==
X-Forwarded-Encrypted: i=1; AFNElJ/AhswGQOarsXtQk//S574TBD9p+t25UeaA/s6fEctJ2KvvdZ31gqepBOoD08X1oWzjJuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHoabzbSJdRbyHaDFzoRkTb1MnElz03v6custbbjwebXAsbWG4
	NncfHBMqtNYAGKrwoPM1wAHrhliNZPLy0aLfwhhuoHkDLpQFcbwm9OUzIOO4q6HjEvnMTMSgLUG
	qrVJ++ey67dhO0TCZLbI5pUAL6DYax6k=
X-Gm-Gg: Acq92OGiZP0vKVaE1kl6j9c8CTugmCW6gPP3kF89EDnUL45nuJkKtqwEH1kO4CU2rEv
	EuPz5AYKLTDJvcEitfF3x65Zzc0aMCFYBmUU0sXUaLplF0pc9WJSitOCIiAhnEe3ji9fhbXX6yj
	5aJMoeaoFIBYMl8pfA63OgjLj+X7Nh/Wr3Sbjiw6howtjrNzChMnsJvmev+d8IY6fTiSZlkVit/
	XwOUJYAEN96kVUTZL60nVZSKpABF1kFXZD0Eta+XhMqcUbSeGBjxUCqWNN5q5HpvG15om9nzm+4
	IvdbJXM=
X-Received: by 2002:a17:906:b3a7:b0:bd4:e5bf:1ed1 with SMTP id
 a640c23a62f3a-bd51781119fmr866494766b.15.1779259949800; Tue, 19 May 2026
 23:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2301.git.git.1778623888178.gitgitgadget@gmail.com>
 <pull.2301.v2.git.git.1778665812261.gitgitgadget@gmail.com> <xmqqbjeb7qfv.fsf@gitster.g>
In-Reply-To: <xmqqbjeb7qfv.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 20 May 2026 08:51:53 +0200
X-Gm-Features: AVHnY4KF2FmCvh5YCMbCSB9hv9fFPoVNuxe63YlpNOb69fsNJXGGj_WlGw2mtYo
Message-ID: <CAHwyqnVd+eG14ZO0OE9vRFc03Wj2juMWaj0tfrTBseVgi_QdVw@mail.gmail.com>
Subject: Re: [PATCH v2] remote: qualify "git pull" advice for non-upstream branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hmph, shouldn't this be done conditionally, though?  Most new users
> follow the recommended pattern to set branch.<name>.merge so that
> "git pull" would do the right thing for them, I presume, even when
> they are using triangular workflow to push to a different remote
> than the remote they pull from, so the new and more verbose message
> would not help the users any more than the existing message, right?
>
> Can the code tell the situation where the extra part of the message
> would help and give it only then?

Yes, that's a good idea.


Harald
