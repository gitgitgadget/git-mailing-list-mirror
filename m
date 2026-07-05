Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC138BF63
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246479; cv=pass; b=oM1eZg4srfPT4OzWq+Wtvx4x6v+G/qWrWgJ+xQ8JR/acE0UCatV37Ha4w4Wstk2q3Oytbr3HEfvQN8BGW+3X2psylWmSAgDbxMsxj/RB6QdYGtTCrKVv9/VcqQr2mobmhbtBvt8OxYzJNx7oS+EnzUBzXWKika55nfxymUEp570=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246479; c=relaxed/simple;
	bh=21s0zSXosvIp9lz0UN1HMMzTObu4Ydv5VlNS1PnpvMM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FpgbgXUcAu+4TwgB4+Sy3yMeof1t2MA3CQvWb+V39DfBK01/uaXYjKUJwbyv7oddWsbjNu5v8TDU6LUn10CINTARkSJWai3LYBJkmeVkQz88i2GoWKPFfFjPgJMHcL4RVyHtc6tgRdrZg3oVPThBPL1UIxSdKfnYaVKlsybFWp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzlTBI6Z; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzlTBI6Z"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664d35b4777so2827206d50.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 03:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783246477; cv=none;
        d=google.com; s=arc-20260327;
        b=mGTr9e+vFXKe3ijtByA5Z3WVI1yLqL7j27zYOBIpwX06kOMohomr3Lv98835uRJBzJ
         tU+cn6nYOpd/KtuOXr2BVVoiNZR6giTIH3dn2+ru0fusL6tnSbum2f4t0HbnfmEqAgKo
         RFAs3yG1HvopffsMaVXgfCAK2wCBNAgqt+JfnrwfpwCPlSILu9f1QizHWanzpGB6F3l8
         ewJfwSWvqnteKXFHorgBQppaojJvmxzsO7A8IfR9hvYA7GLs/uy3JQzLqbeYR54bAxui
         Bjmf+L/hjv6oi2d2BCDkJeOqUnI3YCvTc8g1i8AMyRkZDbmnl1mI//Q1xre/xFdBgZvo
         dwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=21s0zSXosvIp9lz0UN1HMMzTObu4Ydv5VlNS1PnpvMM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=AXZq+pP/HQiJv0ampxkmYJoBa/zE5ELumrEWFXqGSBNLvDCPN89LAfCtDvlOl+g/R+
         cRC1p7ZQ5lW+wzXY3DXWuKwNyaGbXte2BtrE+Mb6RMsJ6zxG/S4JE9YN+rZwwROG+Iaa
         Q4qNcCcHnnQekgKKvyy9+NkM+orlsjM6s+g+hARMqPfm0rjoYT2pZgAvBlgRk7ReaA5C
         I0HnOsNdenEVQjd2szl7xTQXMGF25k/NYxnFndPxqcfVerCcoT8bprF/nCpzN3PwT7CD
         9jaVO8Dks02YORadyt42L92wzqrlqEaMIhMf1eD1NRHa+Ma//KEhfT3QdKiCW5K1Nvsb
         zmfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783246477; x=1783851277; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=21s0zSXosvIp9lz0UN1HMMzTObu4Ydv5VlNS1PnpvMM=;
        b=NzlTBI6Z7fraWe0SvWTbNVQvooqyLHB53iQkHvk3b4QkC8YstDhXu2dEvMvY2X3OvE
         Wy50Z0Bq58G7wyMKwcYWrfXie2gL2pmIMqTfjon529RYJvA2fc89A3iBuuzWBq24Ntnt
         X+s+cYHF+q8ytScculCEiErBcIp+6/9X/gZD0i/SKJs8ZYT6BwBy1ACAMq0d1Udvh7to
         qxH+hKkWnOt0NSeOAidiNudJj4OJljvgB+IbDkmpN4X17cF5UbSbf6kMCWSeOL9PCCqA
         n5JsgU7ggEE6Uclo9r1vtsJi+1s+Ht1cHiBzGESPfisINowY5IXFGXsh5iiVTJsD0+Kf
         7ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783246477; x=1783851277;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21s0zSXosvIp9lz0UN1HMMzTObu4Ydv5VlNS1PnpvMM=;
        b=tTmzPQPo9TA1Uld8kovYSxitV6qELsaleWPHAm2im9JSH28JDJ2P4KL/8usi+FvUM5
         5U7IC4ZznXLMlOEQJftBO4p/BQNVnRbwjcHJ4xtTfn3sc48vP+JYrrPknQKDKgUKlfR3
         fq1e0P6mbYlcx53IzUTAzVCQWa/NLhYw7D6UGAHWAqmtUcuU66Gld+R5EFVQRVbymgxU
         fe6r7r+2l9rtQkN5bnzKUedimXKf12cHgW9YzgR6TIMt6LR07aP8CeOitECK/RHq2ryN
         S1E89Ek4UjDtFiF/wwwr3RjukOixnLRB9I3JOVlQLa0E4/48tyypY2Q073JEt/EMsahc
         nM6Q==
X-Gm-Message-State: AOJu0YyUldS5Lq16zQxMRg/FJ1jcmvVj8JkkM98v3yLS4g8CEPkVleJo
	FaopNyGq037EIbxjc1daVXsbPnCA5ZquSqzzAT39lnrGh3nBji0A6gXyLB1tCB6ZwMyqD59wVyl
	7fxUhcLn4WHINxM1SGzhQvxcnpQ8lhkGEBLiMY3k=
X-Gm-Gg: AfdE7cn+0aul+acdSBzY4kQ04vvKXGB3/ibJQS4byKA/0pIYxZPUhCNeVL3SvugmeJD
	+kFTb0TBD7zXixCpm4DmBzob0GaTt3Zd3yKXo277OCHQZwe/N5KyPJ3yFJK69EozvW9Peepj9lU
	ykyVQr05E7RTjhjKK0EYxifFmyV2PmpSftMRD10zOnE8P9zyv4WPqqzDOcadoWRzM2SQcFLssLB
	XlQ4i37qhiwwTU/YX4UAUIZYkDyYtw8c4B0D7cB5pHaLdV8VfgJCPl6OHhyaqfhZm4kaxp4NVZD
	LhQLrv3msniGY4lFIjEmPhWP
X-Received: by 2002:a53:ac8a:0:b0:667:648a:d05d with SMTP id
 956f58d0204a3-667648adb48mr1723647d50.39.1783246477273; Sun, 05 Jul 2026
 03:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Frediano Ziglio <freddy77@gmail.com>
Date: Sun, 5 Jul 2026 11:14:26 +0100
X-Gm-Features: AVVi8Cf9wPFr_UIxNge1ZN5FIxpELgHTuroadhJval7MR3SYjEGopCOevf54CDU
Message-ID: <CAHt6W4f_ChtVxx0jyLrtwxVyWY6nUR14rKUg+WJO-XA8zYocyg@mail.gmail.com>
Subject: [ANNOUNCE] Guilt v0.37.1
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guilt v0.37.1 is now available for download.

Guilt (Git Quilt) is a collection of shell scripts that provide a Mercurial
Queues-like interface and workflow for Git.

It has been a long time since the last update. The project was unmaintained
for a period of time, and I have recently stepped in as maintainer with the
agreement of Jeff, the previous maintainer.

The project has been moved to GitHub [1], and the documentation is now
available on GitHub Pages [2]. Prebuilt binaries can also be found on
GitHub [3].

This is a minor release following the larger 0.37 release.

The goal of the project is to preserve the original design, in particular:
* code written in POSIX shell using standard system commands and awk;
* compatibility with Linux, FreeBSD, Darwin, and SunOS.

Summary of changes since 0.37-rc1:
* new "guilt rename" command
* new "guilt goto" command
* new "guilt series -n" (number) and "-m" (missing) options
* new "guilt push -C" (context) option
* multiple fixes and improvements to "guilt delete"
* improved reflog messages
* many optimizations and minor improvements
* better handling of guards and patch names

For more details, see the GitHub release page.

[1] https://github.com/git-guilt/guilt
[2] https://git-guilt.github.io/
[3] https://github.com/git-guilt/guilt/releases#release-v0.37.1
