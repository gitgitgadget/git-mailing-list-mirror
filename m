Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CBE1DF258
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024805; cv=none; b=pQsn00sz3uJ3u5L9PkdKAiGSMnZS2vcCcZea21lRkLgX58pgm7jfyII31U37MtvOdamdQT75XFDndcdgV3yF9rDc9AObVCKdfCPXEkKS3Cw/vCOVt/Q3ZeEqDFhmf5Q6TM3jqPWqmIiOHOLifYsaQl5JP1hDDzsPMzbla//Zp6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024805; c=relaxed/simple;
	bh=txy8DkacevYyxuZ4gJT9ipwGBs1q2iBWo/P8BzefNCE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DGj+6IDO05PJdeGciNU1rVzXPrqvX5kfMELjXVa5/1YsU8Ri24+NP4+RJgrq/eclgdP7lP92yH5ik0q85wxitxdJkrQ80l8UD25AdHZGjs/eCiEmXQFjtW+QOkd+Tq7jsjjY2JN7+PCjh8YZZX1wr1xFpMbukCD8Gd0w8SmR8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3Lmpms7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3Lmpms7"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso6913516a12.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762024801; x=1762629601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zozk7a98MfkE1wlsT86jOwfPp9cisxOWtauX8CjSTjs=;
        b=U3Lmpms7xS/iaUc5g9H0yCKDWdk8lKn6HkARvu8/PugW/GXulp9J3lMeQxPkZ8GdeI
         suoTU9YG/VI02zUy+aV6gVlL5e08HetgRWDOU8sam9cydU3TcqjJ4Na8/nsRxhbkYQsc
         vX/MQ6tcwMwptgBh8KlYGC7pGt9v0/MN+Kc7HAGeQiQUtHQa+mfx1WTnpOHE/u1DtQPf
         Pu1I1pKUzYzKFMxJVBjhVQGF5yIoPO3OM0V7CxkABck5ADE6lqCY2ppyKw4Q29KscP8+
         0fXqaMjYKbV0zND+pLKsbuAvGO0N3bavSwDnjLRaal64Lt7sy3vkLad3fctC8U+mCZIX
         tV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762024801; x=1762629601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zozk7a98MfkE1wlsT86jOwfPp9cisxOWtauX8CjSTjs=;
        b=s0RlNShOEY2rqItyWJvsO4HCUEuNHgCZGMZYxnt61j9GSyR97ZD0q2IPXO0g8Lwx83
         pRm0nWKYb7G82PKMNaNbBSZJJEfJiUWwreiNzPS19cOytFhTtgpV1ljaQjRvrJEoLGNo
         UUhXA9m00cXTJ5DI8gZ+4UJFsmT9SIYgEFdNq7bLoAvaWsgg8THkGQnOKcegCT50bnzE
         xZKt/TP6DSbNFD/WUrCIHgXZSV+iH8DhlC7Ac11mHyNmboJygXAVtrb4RYw+SytosbV3
         4GEm7XVHxp499DyBnWwjgxdUb6ibGo2Qj0n9t35VRJlh5hBV4s+xAXYqsIHdoC3YOH4n
         5NVQ==
X-Gm-Message-State: AOJu0Yzhrpz2tm/gAHw7mGjc8ehnDNTagyI0Cp6bY6Kyr4V5RBqvKF0c
	uHeOebLbHT95U2zQ8kLhAaw1XgqIkQyqFSLdIafAshNYqqEGF7LLK1wFEkzy0p7Pfv87OXeioft
	6wb3/DvtoJ7T5hTT4BVV0ZJlZ4sWn+MQHvCJV
X-Gm-Gg: ASbGncuFi6RtJEmFCy8KwjUWXq5i2gqdBW3dRTLH/OSYxDj0d/0hGvTMdxGUMTjcPI5
	dinp8gGE43t+8vMyFLuur74t0yE+GJeoRo/pNWhU7h76xY87aO91axNyd68ZmfszKzaFRGtOVI8
	wBqDZMdoteeRlAOM+v+F8RLa8aPkUJ/7sv48INeR4AN4MP8AfH3/CbqHAp/h2QFP9Fpf8QuFp8y
	q0FzstvQzmRDvHSCxgerabgegoSVSqjhhNOGbAB4mD8ZiVSTjXmXThmbT+EbefpcUKPzpthvDFR
	TjbK/A==
X-Google-Smtp-Source: AGHT+IF6XS2URumQMTEBP7xU96ocLO4E12QrcYuzqmli0bZplbSNXAWfHW4Hx+VXJzkcpflNPKXc338iNl2D1ukQ0mY=
X-Received: by 2002:a17:907:3d4f:b0:b70:6e0e:1a07 with SMTP id
 a640c23a62f3a-b70701c4295mr878276266b.27.1762024801015; Sat, 01 Nov 2025
 12:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 1 Nov 2025 20:19:49 +0100
X-Gm-Features: AWmQ_bmgICNN-12LU8wGGuHB4bLmGrmszrGKoW6-2pPs_VyrqaszouryzhRdUY4
Message-ID: <CAP8UFD2-abzed4qWKDmow987K0+--TWBNXcKZ6Ezi3G7RWx+kw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 128
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	Lee Reilly <leereilly@github.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Meet Soni <meetsoni3017@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, Jialuo She <shejialuo@gmail.com>, 
	Scott Chacon <schacon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 128th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/10/31/edition-128/

Thanks a lot to Kristoffer Haugsbakk, Lee Reilly and =C5=A0t=C4=9Bp=C3=A1n =
N=C4=9Bmec who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/807
