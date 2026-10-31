Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467123;
	b=4kQ3rHv534nEdLrf50kIe/c1MigAxVWmkH0AuAkn+sQNwKvkC2GAhbSmkx5bmyfyCb9e
	 ECn+eyZQXSCIMuDN5aiRIuNZConsizZSkDSO3OWGdj5lFK5P5Zcdp7cUHUCvUsSb0t72o
	 CcVzo6h73D1JASxrOpFfrPy74Ld7fRYa3u8qpw34lIHzMrkqxqVK1cyvA2FpFnW7TlIJw
	 qUEBme9t4HIKUMTuEpxd2Z0wMHzHEoxqgYeeSZdxhqeia1wdV3BsD3NXsmuniTM/cnS7M
	 CYo1rT9pg4GC+yKdqQxqif/TP/Dinj4RbGUboH+4XJIRq8FOboTjkzq8NGiy0lQYfTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0H6OfuzcuGYAWheteHC82SQyAshDq8ttW81k9/Ud2Kg=;
	b=nU4C6PJOyY6OBalvLrNPH9pbwgEz/CrtgOJ5xceYfb7v/ofEHm0zPuRPK0ukZbZ5l1fw
	 C4zOJjCtOYG9nsa+W9xD9rJ+nFvaxCz4vt3yEc9hGbYAG5OLznNH9L2p9VwH9fJ2arAr8
	 G4heew8bfOTxP5MD4RKzGLhP8gXT+NglNabci8pHv7OEh+XpH0lZkrsvrjKFfZa6ZfBqG
	 Nh7rd5vyrOKGQEv2XAQVApxEWkqFH6Q0BsnCt6PfSK3TS/xEV4Txq94fLQD3NCIYh8HNe
	 ora8C5aKbLl2ozyB3QqRsBuSZcDtA4Yu7/2qLC+uiYbb3NFHUZ6+8LkAIVSj66bUQmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PfC1zdcn;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD0606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 17:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08FD0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PfC1zdcn
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso1639026c88.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793467122; x=1794071922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0H6OfuzcuGYAWheteHC82SQyAshDq8ttW81k9/Ud2Kg=;
        b=PfC1zdcnsjCOKFQ0QcMkewauwhZL4DaBOdLdYGRih7l+HuCxhro5ZFEWqfL+LUTxp8
         WepkdobEc7vL0ygCqaWV0V3tXkjSSxzJayWCwCa3lbu0IpxyCtwozoifGVwtOU0+GHqt
         swVpxU6tNoFoqMFCZrQimCipb2mZuu0UlqOl6Sl7XbuL7aqDyl76fNApgmmrDTbkui0L
         wUJTHAzau4v88a7dmcWWv44TO/8fwPYx/lFNiaW/oWHZzszFzQ20oPwXlBkjDPE3lIMT
         dxxrFY6tslJ1+Zl2+9p7RJMtkoSdvLFyjYd/0kJoVQzaZf5F//lWEhlk7AYITk16YPjT
         Xqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793467122; x=1794071922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0H6OfuzcuGYAWheteHC82SQyAshDq8ttW81k9/Ud2Kg=;
        b=SLW3HGLwT4P+dk2IPijd1ajUGWSd2xXBKUqoDd8BSpEEzYFjntTUVSSUOo+YSdI3Bh
         19EN8oBtyuVYJNJrjMhd4I3HzDwsB3H15/zAhlxaFvKRBAmM2D2uWeq44Oz1a4M5FjuH
         ykSl49kzCwVwv5KKh6ZTq24NTkPR9G1ipsddYs6zzaen6CEra6GXniR7FkMi464BY8gf
         OYqC1F1lC1P9IQHVITalqJ4P5zsmpRJbV9Mvw7pWGyRZRoX2FFQYoph1r7tPFzUUC39z
         ovQu2g2D1a9zhCVXmUfHi2ibu7nlr+H6p7SldRSvofC/SBSMPQEn/i/gdgStOwflc+w3
         0ffA==
X-Gm-Message-State: AFq9FYIfJSEVz5WDLDx3i4J1S2t++skdP9PWckqwpa5i5d2gDyQtTgIO
	afCk6mS6nnKfMEUSZCXufxR7gGWSz3qjKC2j+6i+oWHfJxsIfZp3J3ZT
X-Gm-Gg: AYBFou0+RHp0TRBpNgyijN2NWbhopjb3XKr+lLyJvsNYpqqZ0pkcUJcLmKIpCwr9myk
	VrXxWfN9ySChpLCRGwD49ALSjRyET/apfIE81T2oZXkxPRX3Ozr852cgE3VrsV2/BchjqkV2f07
	4vo4QBspGrl9w4x/N7X3MzDCq13qmyB5+EPwxPBHbOXWF6RM8B2ZfOphyqgPhQHt4YRHnwrJPgR
	M2Y0OW7Fi6gL2WQXCUrZmK/++f7ml/SH6r30dwkhxnurObFjtivdrzfl7Zg8B6StSkBlpcUe05X
	ei5FjJ1yXSSB5EwnZ/sjA+ojzhUx/e94S3c7cvosiSG0qR5EsXbwXHIHovDIN+PVq2DcSRQoqMN
	Lfo4ueyQ2zeKNS6eeb0W4DVf+gRJ6f4L3i6WV2E18ygrQXcG8VhGSqdP5yGFHgCQS6A0Gn3GQIj
	4UoNsb+5qYucNeaZnl0eRGz5pOVxNR46lq7eLDq2R4aBn8KNGd+VGwEfCjEd1eQO7VrYIpDGSCL
	t1kMqo2adeEToDekud7THIk3ZeypVdamuwnFULD1Zbj2wPDaerxD0OI9rSUBGYFieRumQA+Af60
	8jirOzBClDROldSwDhmfPy4hedMteXpYmmv7OkGns+xCU8fIb4VlRg==
X-Received: by 2002:a05:7022:5f0b:b0:1a4:3fa7:adef with SMTP id a92af1059eb24-1ac5d1ceb76mr7141228c88.47.1793467121938;
        Sat, 31 Oct 2026 10:18:41 -0700 (PDT)
Received: from localhost.localdomain ([117.206.63.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1932sm17007959c88.2.2026.10.31.10.18.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 10:18:41 -0700 (PDT)
From: Nakul V S <vsnakul@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood@dunelm.org.uk,
	gitgitgadget@gmail.com,
	vsnakul@gmail.com
Subject: Re: [PATCH] sequencer: refuse to revert shallow boundary commits by default
Date: Sat, 31 Oct 2026 22:48:34 +0530
Message-ID: <20261031171834.64081-1-vsnakul@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <7179f371-a709-476f-8e94-807d7b62ce6e@gmail.com>
References: <7179f371-a709-476f-8e94-807d7b62ce6e@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip,

Thanks for the review. I've sent a v2 that addresses it:
https://lore.kernel.org/git/pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com

> I wonder if it would be better to refuse to cherry-pick and rebase a
> shallow boundary commit as well.

Yes, I think so. v2 covers revert, cherry-pick and rebase, including
the "apply" backend of rebase.

> Do you know of a sensible use for reverting a shallow boundary or is
> the new option added out of caution in case someone wants it?

Honestly it was out of caution.I can't think of a real use for it. v2 keeps --allow-shallow-boundary for revert and cherry-pick only, and rebase always refuses. If you'd
rather not have an escape hatch at all, I'm happy to drop it.

> For such a rarely used option I don't think we need to add it to the
> synopsis

Fair enough, it's out of the synopsis now.

> It would be good to extract this into a helper function so that we
> don't have to copy the code to detect a shallow boundary each time we
> need to detect one.

Done. There is one helper now, so the error message lives in a single
place.

Thanks,
Nakul
