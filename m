Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BF3E277B
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083113; cv=pass; b=Y+n+Gi2rhz1aP8+8OkK0AFob63CREuHJyc9+EO4daJ3EyMcKQUbxuVuFeqBYjCCfWF26340FctUTAGHv8Eu2bSaErQmTiTmhSGTPrHnRiV/Z39FsSY8fQPb+qq+F/v6Gp2Jh5oYtoXbQ0ALROaKSAL882Lu6oup9fp2DHQbtX+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083113; c=relaxed/simple;
	bh=Nb4oc4SNXANKbW/QTzi0Mmeb212P7CLjUDCcrYP+scQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fOOJQIs8EmXWOqY2s2SUNXGa5YKQF0EGEVOxlZsjfQ3fGseNh6y3bxwqjH442ZiSRLQW14UVj8pwiUHZ8Fk6WTR93tHx7tRr2HLsj002qe5idGguemu4hq8s9u3JeUXUfhZCFITUNy8bcqo+eeMOJD1U7DWUOEsemJiwGun9Axg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj12jJYB; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj12jJYB"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128b9b7e3edso860792c88.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 15:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083110; cv=none;
        d=google.com; s=arc-20240605;
        b=LbndUVbkrCxbEo/qsG5mBNg6uXBnZVlx2naXxsMZIEnCeemgTxZUXDI56dQksVCP+Z
         Mt4EybJd9gmchhTXEsjt9spLS7jhkCCjT159XAJAUEbrf6mOz0GBgiQ9PFOZkXl9DCms
         FSXpCx+QOMXo5O75OrpT4PcpxmDimRQxnXj5tAyGzBfanu9VcMRa5w3lWxVDbDLCLyE3
         /bFyCjAcGJCZGASB2sqK2+RxFSI/tFlzOr5R+92xbhzCU1zp5OFl0/GlRhd/I2bKeEGy
         nTApGwDgT5P9KlIwMQoNDnkf+uWveJWsyq/ltiuJ4wc1hesoDI92ibqOw3Q9/AeuZWjT
         GRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=xlVLtE34l8IVfHnaHxlBu/QlHVFfFu5Ypbd2Danj2t4=;
        fh=50s+FpNVa4DuHumfRvJDdqS29UHu87xe9DKaDE540F0=;
        b=ExmCN17jyASwHIqhHEmn6E+21GILEqmSyWjsFhCQ1zwWT0nDjKa8MbN+1Pyt1osoBW
         xnw7/TGAbokZ9CNQq2kvh5D49oJnOj7M9aXwFdXKHmMlL6qo527ZTZKg/2XG0duEgG7i
         3qU+yUFr3khU8NkVv/mWQ8omuy2jSZD0XesF35qeFsh6rhD1D+EJlLyHe6R6H0T3LCTE
         DTgluqBeO4GBwZCIk7F1vTg8NymUojpreyBCl9hYW9EY+mncf4UaSwbPLzN0kUMrlaNp
         ncr/xZb/r3hLaH24Xj80z5wi1sSOHGhx9BL+rWgyxeAt/C3KZQH/nwBHEjskXw2xOyvP
         v4Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775083110; x=1775687910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xlVLtE34l8IVfHnaHxlBu/QlHVFfFu5Ypbd2Danj2t4=;
        b=Aj12jJYBTZj5f1e9jN1I4itkmcYfrT8EsfLuivL/0ZWWwZAJQBDA32d5q8tfHA6PEy
         7Dd/4n72g4p/19JFic+ZhDB/frdWIaj6u/JovqthujZhsm6WYWaHf3N13uw6+QEVb42x
         ezFekt3Rg0uzfRa9FJcmbRXEo8js8wZalTXhc/4QDtHOMHvtJeaWYq3O83Fv1OCBSIAK
         YM4kV7ID4PN5rpMtoraSIQa5SAZ74dgcatrCRtZ3PbUkXkohLLlnSheusfzBmFNlxPBN
         ZI+TRpIkrMi2nnWw3WvZykaPqQmdUONW8/oeT6+op+FfV1GqACG42Hte6s9ziMwfbB2m
         qCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083110; x=1775687910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlVLtE34l8IVfHnaHxlBu/QlHVFfFu5Ypbd2Danj2t4=;
        b=soKi1FrL51NBEQbBL6INrw+fxrSdBa2sIn9hRraWswm0uJss6r/VRftvZRmMnZRZfy
         IySIJV0DI1GMRMe6wqYdf3gA11/5qH6JaUAdqLF5ofTWvBVtLhUrERQe/xZ8qyWpD5nw
         caQsjd/gXrqMgg/XS3oH+hfXZIUZMft46au6xKnlRWTfm4vh+aJJldqfu/2CHzjyPIXo
         1N5TNLtDVrXplq8xEyLwqi5AKbAsvAHetmSVpLmhJVoy/q1mhaim0HcHAMPv/y941S5p
         fBF6M1xtK7rs0tcZYVOgIBLnhyFH/fU/SF1uEi5DKFkFULG3oQSbzWi+QVCxiQlRQy69
         FQNg==
X-Gm-Message-State: AOJu0Yw8edb2n5fPvX1WM+dDqgWerLrXuf0ccUPWMMhpPU8B/QFPcJfI
	xK8gOZAKW2/m6yyKqDccVJkCXvQRzYN4fMKd+V7AFQaAzOmDx9Xr6M5AXqK3IZuOZ5MNDHiWQfY
	koA/NjVL5FmUXv4f8d5ocZhWyGPeuBML7LFLL
X-Gm-Gg: ATEYQzwU9WBjni5u5wJx/RhKidY3peZxWEbpnnADCysC/cuvkuLAZ7cUdWvkuLFmpT7
	EmrVEKh8Ud7k03Tj3C0h4kJhTfMmnzMy/etXaNgILn+ssGd7cxo/7TOJBnaos6ZIATlqnmtGNn6
	h5tgVuKCnlBto9dSuk0l8A7GlAhi9OZssA4ujN06iXAAta6+lsO8RtlA6Gpd1fq4hv+Y3T8gcEB
	u9OXBQhWL7rnnLs80mHboe5I83YtrtUfl0hkUwg7RPVnEt/aoQBykGb9N+sJPs/6+W3h61IzNHy
	8WrR9FcQeOpxh66au8HHhFo54HcgR2gtsyrThM8ycBoqcmovp9noDhzJcijPsyv3vm0v
X-Received: by 2002:a05:701b:2915:b0:128:ca6f:adf2 with SMTP id
 a92af1059eb24-12be653cf1cmr1921397c88.32.1775083110021; Wed, 01 Apr 2026
 15:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Apr 2026 00:38:18 +0200
X-Gm-Features: AQROBzA3g7M7NvWtZQeXQpoz_W1tcgmR57IFqCs_rpo8wy5ycBw8OfL_W9khkwk
Message-ID: <CAP8UFD0Zk_uzHviV1QSOVv4VoH15NwZxqqNLgTKBs2VcEvgmKQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 133
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Bello Olamide <belkid98@gmail.com>, Matthias Beyer <mail@beyermatthias.de>, 
	Jacob Keller <jacob.keller@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
	Jakob Haufe <sur5r@sur5r.net>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Christoph Anton Mitterer <calestyo@scientia.org>, Phillip Wood <phillip.wood123@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Bruno Brito <bruno@git-tower.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 133rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/03/31/edition-133/

Thanks a lot to Olamide Caleb Bello, Bruno Brito, =C5=A0t=C4=9Bp=C3=A1n N=
=C4=9Bmec and
Kristoffer Haugsbakk who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/842
