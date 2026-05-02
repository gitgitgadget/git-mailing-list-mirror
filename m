Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203B28C874
	for <git@vger.kernel.org>; Sat,  2 May 2026 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777746662; cv=pass; b=k48BI/eKdnyBwO5ZhJDh/U+LdCvud1Qk6UCi6N8QBq4fAjRAMl407fAJtXdI6rb+1AwB1wvoxPZ/CyLaknHDqMx/+voASW1SZwx6Li4BwXea3XEPOwbzv/2L+nD7cx8z3X3c0sPKxGC4TZt0msU4R6bAxJo5X4OXJW0ozKf42Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777746662; c=relaxed/simple;
	bh=czTwAV7h8yQOT+/DOHILReh4w0L3yuc06dxJC7Yajss=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=etAohd/hL3tFk4/mtWtm/uYvE80bAK+fPQ/AkkTRRjRmTKSRGLSggcqVVyXDRS1DdxeC1GW5R13SfPck+Yep+RaUxUZFaFa+u9Gb5a1FP1ff0dkWMs+wGTJYl5Zzg7VvFKLHM6GTw1d72a1LmInkuR0Ykcw+Xhee7zhnZFQXF3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQoAbUzq; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQoAbUzq"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12e332315a8so1150939c88.0
        for <git@vger.kernel.org>; Sat, 02 May 2026 11:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777746660; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7uUMEYg7GDc/rEZm3xiAlDUrYAC+giYs63nSoz5DqZVVYBj10X1usnlXuS1n7dUM4
         VJzXlfymMfUEbSON0pOxHAtuhZKO9iyPFL0JgVlTW08zgciAhtjxV5R0hzFdbm4X0oGo
         mt3g5Vit6PMgQ+Dz+FlqHn14Bsr44iAGmxdOxx/NDy5XqvA2QLj28PxasPydJvMrnutV
         zAg8Yn+VBsyDV9mEpAptli+2TYb6joVYcp0w/9q3dhz5ybvne1aKjhhx6D9gQdnxyXzO
         4jLYzDavTLYTbHDYruIh/OuRDAKKtmwDOHCtza/sL7tzi0gxzRrHRwR7K/ZDu3skyKow
         eREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yL3XFH9xWdVMOP0Jhf/CssAZIgyxdt+/3jDeEQu6S9c=;
        fh=CdpJAuIpvxo4T1xxiPs+CoLsBHq+Lo6LNSFOZiJdvSM=;
        b=Hc+f1vHqsjxBF3q8uF4PRH3A0Yur9/eCbdZR5IhzVkKY65JYGxDCNWGitAK37bUO5f
         MIItEi7DjfGPEh7o6RJWHOMi2bGk7sy1vu6cughJoZv2YAZM5WDLB+j9k4ufKxBgLcOA
         MdoDQXjl6WZ/URM2PFtr6ezgbRCpcFKfEC5xM47+fptcDqT9DM6GA9aItfBb151LRUwk
         0HLGMpYs2sI1TL/+/oRh2zaoWED/2Riu8+K4oNRhKW8G0IkHxDm7mWXx/FUoefWrH7+c
         LBLORpcDNKFDsw8R2+8nT9du241iocAwUjrwPhS3nbQF70q1SRZnggYS4cCVbapmxfV6
         91Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777746660; x=1778351460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yL3XFH9xWdVMOP0Jhf/CssAZIgyxdt+/3jDeEQu6S9c=;
        b=aQoAbUzqKqx74nkLShZuQr9NtMsLWU5DcslwFOK6TRy6+gdz6q1xfZT0nndRYtWj47
         X4DuHJNgXV/mA2mNzoeqTECqvm6nQO7VucIRiKufn/X2km4j9dJiYqWMuiMIoPRbSKuO
         2vSEKeBucQu2d/vjcvzveUTqcihjqdRUwUH2OPJRgv9hsC2RELFpSFn4lbWQxvtgm16s
         3c84OiinwXz+vuHQcgLU4P2gBw+K9B+EZE+Gq3aILCRsKnyPNR4e6mr5x12ekvuR7y9Q
         jqG/33yclgp5jMMCKanXG4j7cpdr+5+x+nq3K0YtsesWV4LZdUTYwn2hJ+fKTLPWFybB
         Qh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777746660; x=1778351460;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yL3XFH9xWdVMOP0Jhf/CssAZIgyxdt+/3jDeEQu6S9c=;
        b=fAmiRe/jYwvNuHDpGP7c0BsXoQTmg6XUaPjTJY1zAi8IH8FyKXpmYg2P+e8LkyyoKl
         tDkXrs4rB0BM09+VLH5y5nSn/gW3XGhSk2JFOqpht/gcJcAnWJPD7WuXAxNa5mHlLZ65
         nQoqMXNOpFOSDMtKU0WIQWJ7gOP7CQZjfLB1hSxd57XOIvSfqm9o78hGXlGNgRXl5vC9
         KgVS2G2XzY/Z4vmwdB8otVLT4RSfmyHBuPCbBpDvoutMFm0P/zmQQ2ESw2LGKTfALCVQ
         qZ1jEJPyav4ldzAB8N05dlipCx6lrcSniqVst9HY8F3aoxm049CRBuLkVm/MoHmojZ5Q
         Oz7g==
X-Gm-Message-State: AOJu0Yywnv3Ubhny/cTLFGiHAkS23mJ5r+xYncTZ1d2PskB7+95q70MT
	OV9PrN9d47Ku2z8YEHhpRr9g7sd+tEVTt6lxKMVA7UHX3q+WiqwnFr8z2AHZh/KXJx1i/aJIP77
	fuQIpIuZBuENhhfzkxfh/nfhl3dzyXZUYbi6C
X-Gm-Gg: AeBDievOV4i6l1KrLG+PaZu3KsiJwCHag9DSV4KjzRY7O0LamJz9/MlVPNyJ1eHT1lF
	hMTon0owPaq/06iDQ7demMHYn0eyksdC6COUKwyRLOuumOCsJMLEb9CBu9sKwR9c28zp8YW1hE7
	asM29y0LtrauOH68ws+qM9FW9L9R7ZpVGotzqhPmHX2UZDIqUgf5J2aWH4Vgq9Cy9X93bfLWddV
	cip4qlqeBPVtpdsn171f15GDesJanNAcuJCAiH8jmzTkkThbIreLLsQljujvf+ESmN26phhNCNY
	2VOdrC2OxH8LdznaZDsdq9x9k5BSJlqvFxuHvPWh1xST1ui7C5og7zzNMDLPXqcV8khy02sl5qA
	ZhWU=
X-Received: by 2002:a05:7022:4c:b0:128:cedb:33c6 with SMTP id
 a92af1059eb24-12dfd7d1ac1mr1676802c88.16.1777746660027; Sat, 02 May 2026
 11:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 2 May 2026 20:30:47 +0200
X-Gm-Features: AVHnY4LHAfFpVPzusQcjIQRr_MLL_tnO-Uu-ldCFC0zJ4jBqesiQ1j7hPNIHyU8
Message-ID: <CAP8UFD0gxbok6C=sn8gtho5Ctf+7JvEWCqu+HW0WbVrSXEt=ng@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 134
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Michael Montalbo <mmontalbo@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Matthew Hughes <matthewhughes934@gmail.com>, Paulo Gomes <pjbgf@linux.com>, 
	Toon Claes <toon@iotcl.com>, Patrick Steinhardt <ps@pks.im>, lwn@lwn.net, 
	Meet Soni <meetsoni3017@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The 134th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/04/30/edition-134/

Thanks a lot to Meet Soni, Toon Claes and Paulo Gomes who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/844
