Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264132F479
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054554; cv=none; b=Qruh4rfEs/BT2s7eOlbtNH2RYCG0pAvjjD4L3/nrF+ChmPvRd45kHiJvLt4YsYse2VJoSJBLkHc4LACRzEh1wD0DlJbE0T5s4lLs1Ke0QbVnnZBEomRRcJ7vh2tC9hs0JkBulH1Z8sn0YFfP0Ebi7dgX9ktF5uJVu3LqfFnpYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054554; c=relaxed/simple;
	bh=vyKY1J8V3CkA9gB68dap2KsqaYFy4SQY6DdhhUiE8Wo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nB68JKAwQ2bq61tWGz/4xKeZCLoyptC24DQq4kdTbrzDOvK76pYBwHzbrFVlPAI9QLhzaMzxgOsy1ZaSzJNAAyi1t8No2/AHC0pvh52N/ChKFQ0BXg74hp/WDBrUwa+17993qHCil2qLATxuIuC/ILhCwRfP92jkvb1iOmpXmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [192.168.178.32] ([94.139.29.72]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1Mof1D-1ua37u3wzZ-00dnTI for <git@vger.kernel.org>; Tue, 16 Sep 2025 22:29:03
 +0200
Message-ID: <5036f7d8-8ac9-4f50-99af-5a3a2d1a07fc@anselmschueler.com>
Date: Tue, 16 Sep 2025 22:29:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Why does git-status suggest different commands to unstage files
 depending on whether there is a commit yet or not?
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J6gLjkcyLGOFP4SGD6lZdpSr4P9j+KoVPSYo0kvWH2GVQANoZEb
 EWvr8SlZPpBg0SasoVbaP8lbFPtGhzCdwKcw+m9xoCa7E3jyg4WkuLM7vqvTJplIJ8uGoiP
 RS+67TOWJdvRRRERGHnvfwveY/imaUHnV0FUuPJTR4ZgBp27KMpsbFBC0oxex/LPz2yFTLE
 2a3c+DBUYi4GeO004GX5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EMQNcRZEwBc=;59bRDdKwlEIN4qShqifJvE9y3hK
 ihaBW64vjxgYvzI0mVRVRGQFSUDOBVo9SexMR1E14Qfi53rQ508aRCvcJvkMdgdxOMcXByMLr
 I47RbAainL9qGepyYQBhuWRgTo3x5KA0xbpxvS9Focy1p3E1P5sEJoSv5WpUx/+omChS5FEsv
 2zhzXSA8qcRAqfNnrAka+Sy7krEALJI7dIKcNAWnFgQD9VE+pCohfyHNP/Ob9NVddlBxIzvxM
 OmgjYaXOU/X+NZdEWEknQxUm4RmhL8wgDm2GSS5n0GPEckrMU8FHKUdlP/FGkC806Jyb+e7qz
 UKUWv6MIxncd9eAqCQxKrF/C+ruS762/7srMLnEA3RNqVLVW+7/B/BuWjSyUJUA7kWmNUQFJA
 IL787rOTOcLCq62Y+BW6rXv58ERrnwqJBHaH0RFcx/STBqeswnGBuu3CYmptesY95LghR3+pG
 0pcCMMiVwfS6view0rVlbf/El1ynAeswFvXO34smFUNlMhABYcTRjLcmoYd8w4OLzZqxBOg6u
 yvF7yoJPdL3sFQ4pjDh2k2W3AUSFFNzYc+8DLo6HwTJsatKnFQtUCZTB0DPsAiEeo1YTWgeEo
 bXPczpTqwl8Xly8D7ItAypVailzualPskJolotrLwqjLI2lBeRvJfVo5LPEpDyMJ7jRyQOGVg
 nynhKhlTBsYfGY3CLXaSDqykhfG5PhBS3ZNOVzNZUkoPayOaywtwBoaDe1Juuh1vazrknkKe3
 2UqSmLwcElsueD1F4iWtQ5RHwYhrlZKsWiEtCHyyDDOYSS/dZhNAPpOgHrGxTLqrBO2/ZM+D2
 XZdBcd4LM0AD/w4nFBz+6LHrXLJeKzlC5eiOGVoZ2M/0kY47ukLoU8qFHGkkYRSu1A0AHCplT
 5DUXb20rLCMA2Ske3JxcqYaVoIflGKN6CB0GAwx4qNmpy3FIgUGu0CrHXaCjAkty1exOWL5ug
 nbRl+b4VZy9nPx2YS3tLUDqeXnaB1Tu/0s3M01xCvOmXBzqG1UvGDQrxCGwHZ6rFmSohUblAu
 umofLwvyr5vTv86UQ/uw+cGYE1wqKzDfCqEgQ8L/7VSyb/SpZbXnu8HMVjJruicWZn0ZVNYUr
 Xi0YIlVw+IuVcvoffQWHWSWLo4cXztERip79/ExkePpXvi7qXPOsIZF+4YOJKMielG44SBf78
 HrYe3AEXWyI2u0XTKs5IqYfMgHiaCO92uvTfBJbkZ3gFDIsAwsp2ij/sJc4DM+ZmrKFXX0TTR
 lGANKffnWsiFfbLXrIdUR8cKpW7AB5iAKYOZdPXES0oAA5uI+BgC1pFSnHZIcWNL4HR+OxMfD
 cBD0cSqE8gTHPvZn2aQMjazn1CcDHRxcG5NOlGKxj2i1OT2iRneHmgvRhaN/LrmixqakxNLfw
 xMM4CJGoA/7MURgcANZWOM2/yHBbA0gzcWA/md1S+0JSwgI2WCp1QpFdIVoUJ5Hc+i+xlUbxp
 O59+rmzVSJh34J5oxoiTprWsPw83dGq5C+T8SJStSCiMo45GSzipXhMUPcR2P8iSWQuJ02wFs
 0MsrPksbrbJ0/zp9Vv77GpDVyUphCouYwR4m4WNrJlnoBc1Cr+sCnIbwdukKzyUjdxJcwpXxC
 Qsx6PcQ9kO78+kxwGHrtKPeE+eeBHlt9pEto515WDprUNq2AvBSFGUzMpDeGD6NPzkbsIaabY
 Yv662KIN3364OlX/2yWdHiadJXKDZTxIsGL3WtuIf9pJdye4B4WQibQAa9zmdBxMIkzlLxgce
 wpAgDIEu1f6by

After a new repository has been created, before a commit has been made, 
when files are staged, git-status suggests using git-rm to unstage 
files: $ git status [...] No commits yet Changes to be committed:   (use 
"git rm --cached <file>..." to unstage) [...] After a commit has been 
made, git-status suggests using git-restore instead: $ git status [...] 
Changes to be committed: (use "git restore --staged <file>..." to 
unstage) [...] Why is this the case?

