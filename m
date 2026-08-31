Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649E3D25A2
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174794; cv=pass; b=twWu4LVdT6MIexjDPaZ8krmL67raLfjFawWCbpzzkcl/iCq+vHqjHeeBRTlX4OobZBbw4X1w2nLLMtNaMMJb4M2ww744lSNRlu0TZC8YpQuScrG9Pnebz7v/3WZs6tNgRxB/DB3gPbERLyLzy2YRd1RRNWGo+OQiZIVL4H1lT4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174794; c=relaxed/simple;
	bh=72/kKhgIuCmjHwoW+k14sX+UN1Mqjr3NeAE0BRfZc6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCNqQ5wI/YfzPlmfEazvWdnvVlod1vVxMPwVBG1dvrybtHBjv95X6fGZJBI/YMi3+jaiVs1gBPQJnIfHn5JI29xpPTPbry7q55KZ+IpqyXP65wHtct2r/FDJLf5GSERYNxO9iA8kF3cbX0SwXYrAvkXPkYRHcifhMVuZqyVkaQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrdCuk6A; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrdCuk6A"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2533d83e3bso548774166b.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 04:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788174791; cv=none;
        d=google.com; s=arc-20260327;
        b=PqOr2hpIgbCznG9sbQF9VauYGTTlPiR9nsAn6I58V7o8cb+h0yPfD7Hk5VadPfR1+d
         ORbuos0MA2aO/LtTqPvgExDKOT+0F29J+UT6wOu2ypvlnK4kZR0Fsn3ROx7o3Ea3lCNF
         hPsKYz338qSoRwFmz6NU14EqEqLjvOPX5BafzL/utwilxW44PMUagA5axQs67UI3D3RR
         61rV8ZGFw2Yp3b/JabkEEkIqtKQiyQUJlSzLy2VeaaSmEJyKHwKe3EZTer8EqQkKgt64
         A3SM5OoMTJqX+960KWudmzrwHU16VeG5VDJaSDdsWHPniRoA4Rwtk4HRweVkbp5mJZc+
         I2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RFYpdfNX5HPbJ72UL5npeTg1uKFTPDM984G8FmO9AyU=;
        fh=BPKvNUfNuREciewnOgLRyjn8MgQ1yK11qD0EteZBlsE=;
        b=X8SjF+LKbNSHKkuicb/9qovm9UyQL/lwhAfrxywwSoNQmSARvPXD/eOrRYsYSwMB5Z
         KNAggM36mF0+/6Qx7bmd/Ir4oQobhv6Ay3Dt9nWkSsW+fjC3SF5HDRT7imiZAPpam6Xb
         3EVbc8EocIlOxwygqwY7SoAtxelkBqtHhNLHPjvowrQlItxFpWbzvfCLlCkOUpH//yI2
         nZOoVbMQLYgM+eUP3PPA773ozSCff7EBSaq4W/hs2LVzHuUKAyrZuwqfNKLNCj9GAVfI
         PtHhhKCdpgPzQ+U3Zpm3RDeB//Wh7jNocpo+LPyu48mOjeO2ADuNC1zkVtPXhTdEpivy
         aA/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788174791; x=1788779591; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFYpdfNX5HPbJ72UL5npeTg1uKFTPDM984G8FmO9AyU=;
        b=XrdCuk6A0T58iS3yTk1WpzSYpyq2rmacKmXzYD03nzNw/5tvHY+tcSM6U6DJVyzjTP
         gajteV3bz3a8jp+438G5hI+uQ8Es3KnpCtXFIuO4RLa/l8xWab4lMyM2zXl48Sj3otWf
         DGF+1OG2oBNQzE25Sjos8WWJ8NIHOd0YB8niwYZzSA8ym95DoEVQW/zekgtKX6h4QaAH
         PFSOQqXDApaEenUYfP5OXup9HvLtF4xdBq56lKS6Z5K0vAx0xnKFCT1PjGMx20WHT9TN
         nA3g8JTKLRh8fzAfy4Xt1l0Wr47kJRZ842dL16LreCkm4cThE1WpwTSsELSRFpbZG41j
         PPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174791; x=1788779591;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RFYpdfNX5HPbJ72UL5npeTg1uKFTPDM984G8FmO9AyU=;
        b=L0kGJk2AwBwhbW4zWY/tmOKSNqcxsayZD63xlb7FE2sljgV5VHTkjvFpGEadxm5vZX
         leAmp+V8Bs9HAY7aIRKuohl5A0RWmeR5uQIxU0cddJMF4JI5h+f65rgwi8CFQRix+OEf
         5BIJBs5/wkq34STtcutYwEQGmMC2xWzLgsKZywMrvdNmDazVAeb+Z3Ufx/Up1UJ12Zby
         ZTdYiX5VYDq23oRsQNdAiHhEhYwaIZWIM51Zt6Kpy+IgLzqD7C99XW4o90jX+biWhyIv
         SCoFO5OTDuaTEdGeo3aD9AEmOZ1HLvfmmalSw6wbLuugLnGyJWkyyqcnVJT0BAlUxM6A
         th4w==
X-Forwarded-Encrypted: i=1; AHgh+RrxY7TmKFxrxr7o8sIfOIRRC1vd/LjgPQQ4Cqax46DsfLUkKN6+bk65uVaZDQVj066FLl0=@vger.kernel.org
X-Gm-Message-State: AFuF++ntr/7jCZ3OQ6NaJwTnEWfuDjlLD3zRi7qKkv2xQhykKL1BMqzg
	Tz3lEBY8UmG15IwUG/KWsXvfxXDUWcJHk/mlkgRgWvevdO2dvupUZt2DBm/iikPs2NpLa1kZn2w
	wk/cI2KAJsXzmsY2ou86Ic3nhML3k9W8=
X-Gm-Gg: AR+sD131nN9rdfbO3jLlY3l0XRk441eST6WRfs964Dh0fnweP0x/hdNd6IyxwZn8hsu
	YlLa0Jqjbo7bp5l1YCR0lVkK3ehB63pKM/tFzU7XdOY8FuP9I7pNY/FtpqLJs5FQBev31Vs312f
	SX88itmLULNZJGEOG19La/E7iRc70NL0ahnYyXoWvvjWtJsazfLDysHMt4JwmeH567ZBcxXE3iV
	0PkD47fa6QY0mKWskA3zU5dPV6iUzC0sp7mCv+H05PHk2AWUjqSiGNoCdCTR2iVmxrIwhe6qnvu
	ra9v0WDjzsYUKwBOSoMSorw8MmsZbVREtSz/Ifp7zzKx
X-Received: by 2002:a17:907:9307:b0:c25:2688:8212 with SMTP id
 a640c23a62f3a-c25aaf048eamr143206066b.0.1788174790799; Mon, 31 Aug 2026
 04:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
 <pull.2369.v2.git.git.1788087560290.gitgitgadget@gmail.com> <xmqqqzjfz0ba.fsf@gitster.g>
In-Reply-To: <xmqqqzjfz0ba.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 31 Aug 2026 13:12:32 +0200
X-Gm-Features: AcwNN1U6pjzReN778RgJsQ9xzmGsp9JxwawD9S6rjtUCY7nocAM5D_zTg-w_frQ
Message-ID: <CAHwyqnV5YTJsAnDDHQj0gwmoWXEgnPSJ8tJCcXrg12vBvtwFfA@mail.gmail.com>
Subject: Re: [PATCH v2] ci: cancel stale pull request workflow runs
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If a user has CI enabled on their own repository, pushes a commit
> there, and opens a pull request, wouldn't GitHub Actions trigger
> two events for the same commit at the tip of the pushed branch?
>
> Before this change, both events are assigned to the same concurrency
> group (the commit object name).  One waits while the other runs, and
> the skip-if-redundant logic stops the second one early without
> wasting cycles on the same commit.  With this change, the
> concurrency groups for these two events are separate.  Would we end
> up building and testing the same commit twice in parallel?
>
> I suspect this may not be a problem in practice given how our
> contributors use GitHub Actions in our official repositories (either
> those owned by gitgitgadget or git).  They push to their own
> repositories where CI may not be enabled, so 'push' does not
> trigger.  Still, I thought it better to bring this up before the
> change gets merged and wastes build cycles.

Concurrency groups don't span repos, so I don't see a solution to that.


Harald
