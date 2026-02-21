Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B573EBF21
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771690518; cv=pass; b=eICBufPlaJDTrn2+bqqTpX8nXmnyEkNUegozQlXNq2nC2HB85Vs2uf5U/Z7tFMGfut4Nu6OEiy2aUAHp8y+B8eHWoBT9wTo1nQIpuMUtxUVcfQMrIOljzPR96cG17oHVECSxxVd6O06HMnKAiLoM7/wEJNT1CmaIxVjItuI8O/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771690518; c=relaxed/simple;
	bh=WUzoH3juJ7Zd+fyW1elU6FK/VA8ooFAQNjMhvfwCMo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8VUT4+wl8I0RI8yQ9wCnxyPk+n18DJbEkD1vR7J7nYwuRstgJfBNqlwk7fwk3y3luEjb7ju1cyJd8Vij/HnYE77QWrJZ8mQvE3OkA1z0JVpsgfGCzZmtkJthT6lZJSI+JRjeN+h9scpv6ELgXeRd6K+PMDHuv4qS9hGkrwTcqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=paultarjan-com.20230601.gappssmtp.com header.i=@paultarjan-com.20230601.gappssmtp.com header.b=FI5DPpvC; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paultarjan-com.20230601.gappssmtp.com header.i=@paultarjan-com.20230601.gappssmtp.com header.b="FI5DPpvC"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7964f1405a0so30592487b3.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 08:15:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771690516; cv=none;
        d=google.com; s=arc-20240605;
        b=X0KpHp/ZBzY6umh859FxPA4Gr5kKA7qs7fB7nFLhNoDosDN2QFb6oosnLZJ/Y8Qhha
         5gXBbdM2qj+6fo1V4zphEvpWmlAc9sNCS3pUY5K3VbxyShpuHzj5IC5CjPJZAZpC1sfg
         U18Ss4Iu8BkcVWCZGEgbA5zmjJklR6k1KKNBECknQXbQdOH2eYHdW3BB7NjpQa7MUuWj
         Jq816TbKbOJ1lsmvuwJiZzrlFpl62GPaPgQ1acHLl1gjnskopHZQH+XiYAedLKzGd7sG
         J8CAJyQniMhZTtWniFA2YueWfT79zPdVrvHtyJJKk1z9A1ag2+aPf2jN9HIegdrhn639
         o70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Uyyg5E9aoMuJeo+b5WscQgXxsM7iubb200hgB737zZM=;
        fh=19Hcq49z7P2dLcHEaJexFrkrWvfSCOSroUX8WEj4uGQ=;
        b=CG/3nDoMTPe/IOpbsBti2meXkJnG+UKkLxI+qQj7fsX4uAWgkirC5ul2MaDuYS5HbL
         2GDyUB2tcS5qQ5J/RsseatYjcLkhMtu9xFshI0xTVKlOuDf2ZHORzxZplqLYDGSoEXWH
         OALObGtDpwpPxPG1qMKxWlBkoMPIotDgGByFxXotHXt9sKtiYgezzXDfyZeb7xawTBF8
         aLhJ5sgtGGWs7A7kLdv3u7itxhW6mdFH/kmXgihKkosb/F0lzqVbJiqKPmg+XT7xcV6Q
         3GwTXqOT+nunpxuT5cOGUboWZGIjX+7O67rCbSxCUDwWDDd0HHHvvL6Lp6j1BHzNFMBe
         YEjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paultarjan-com.20230601.gappssmtp.com; s=20230601; t=1771690516; x=1772295316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyyg5E9aoMuJeo+b5WscQgXxsM7iubb200hgB737zZM=;
        b=FI5DPpvCSW37qUuriF387F64RFHHA535T+En7G0L+1FAnRq8QfcNSYHSaotrq1kLjp
         X2jao1PavA1pXSmwheQUJNgsvBYZpyBtOulr1wEQ44OdXgZHazSgnJWT51h08hDJAs4B
         pe5a/KgzkZfkNddqTmA1FPSoa0UDl59jm6TwfcMeOTy5xWi4veccDxwoDI79nNOVmPyT
         MQQWBqb+AjY/EwOK+wXf+zxvsM0dJr+v8CArFeGSUGXp27+Z8cfdjhXQu2Jga9Occiv1
         XUVzO66FolgYwqIDHrNUd/jjx2YgJ5Ihia7tJfMTLASRfQN0s6u1ymtQqmfpM6gT9Udu
         y/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771690516; x=1772295316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyyg5E9aoMuJeo+b5WscQgXxsM7iubb200hgB737zZM=;
        b=OIRH09dRK8keBYhW/GXhFIdjU53x1Yj3pqdE5VAC1JgjbVb8xegwNOFRdmbh1SmVzH
         e3zGGDNUNyZm5dmSMgLu0ArS/p8HVTtvfcPjewXO5TnTL1FZW43ZTS9OZlKprg1TRspC
         CYNHBLa/kgmx1t+9dQGYpnxZi6M27TeYuDbuhZgHa0JOEQPGrY5p+60T5xXV7U1rR0gT
         1a1JfZZvOSH1BQCIoz9pYfEFrnAzMXtuJU/cbT3ME1oQUoMu6b2ZRA1iChk1x47qzGZP
         igfoREqg1wMIwchDSvzr1eemGBn6oWh0R0Nya+B6fFvVMcMKJl5MDRLEGWUq/7SZTThU
         k3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVTmKYuKO7Yuoe6a/JP1BR57mhRAk2LdHwDFzRwiH1Wp9PkeRk75HkbJLTJ50bPoW1mSrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/ebxZcUQz6PHbvuyip3LT5odV3aqq3AQCeVAAgw9d1Y+05q3
	qLn4O4G1S2pcw875EfngVTHofKRgQgN+JwcKUxk17fKRHJjXnWwvyHHfH4oV6gbhL9xLjXFfVvB
	khS6kUPuUe4cCFX+/XxGQnBVs1baD3SI=
X-Gm-Gg: AZuq6aKTr6xeToKvEWuULZVdrk4jKYn0jRDwAONWozM0eJ0Bm/FQAPvZUAmW6KceKE0
	gBIUAgMgwkGxWCok1xTLYzkggrwPhFtrd30RHfjP84ReosVJH+woAAvmN6+LKhGK0lMwySYpC7I
	SYszY4v73YmVadk3vQTNj386W02hDoc58kAZtXAFdkIY5rijI52zehuWH0h2E/slT3wgNBCczBF
	r9iHH6Uf9Op1zI+zdVeyuXc23GFhS6MaGA1eQH+9+VSHD1i2xrdVoJijijTBR0r9rU6cIRo5NMv
	bu5hzLs=
X-Received: by 2002:a05:690c:368d:b0:794:f400:1406 with SMTP id
 00721157ae682-79829155909mr27881197b3.56.1771690515997; Sat, 21 Feb 2026
 08:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
 <pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
 <aVuplzNaoCHlZG3S@pks.im> <xmqqikbrvz2l.fsf@gitster.g>
In-Reply-To: <xmqqikbrvz2l.fsf@gitster.g>
From: Paul Tarjan <paul@paultarjan.com>
Date: Sat, 21 Feb 2026 09:15:02 -0700
X-Gm-Features: AaiRm50LuHwwr30ID2xUoGNYUpYBcQ9wTewRMTZUTnJ0JM2o7JuAnnLP8rQey9U
Message-ID: <CALvWuB70kwPAnQ+v4ch1TKMDxbUQgi5NP8NX7tbCZRqivJ=vig@mail.gmail.com>
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for Linux
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Paul Tarjan <github@paulisageek.com>, 
	Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I just noticed that the discussion thread went silent after this
> message.  Has the patch been reviewed and tested well to proceed,
> except for that meson-build support?

I'd love to see it integrated upstream. Is there anything else you
need from me? I've been using the patch for 2 months at my work over a
very large fleet and it has been working great.

> > This would also need the below patch to support Meson. Would be great if
> > you include it, otherwise I can send it as a separate patch once this
> > topic lands. Thanks!

I'd prefer to take you up on the offer to send the meson support as a
separate patch. I'm unfamiliar with that system and the suggested
patch failed in CI on some dependency installation steps which felt
unrelated but I didn't want to debug.
https://github.com/git/git/actions/runs/20720903513

Thanks
Paul
