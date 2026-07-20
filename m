Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C301FD4
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784507757; cv=none; b=N7/vCyUrKxP1tL+J8Uj/AFkCfzWpgRLR0WY1KLhHl5ZZlrvyUUTCnCo818leOyXvoM9xxBNRsBQufArZe9Qed+P4zO2ygOMPpWJclyxuN00SOmHs15AkKmh4QtzSxd/wPdhiDrX5H0GgZBwgSYjqKdLfP4RYS6DLddR+5kqfj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784507757; c=relaxed/simple;
	bh=R0m1lrY9hke2mrprT49s9vDupBme4gfD7GFuxoXc0zw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o4mF7Bc3JrJPlN2sAJa1WFGv4UupqCG7PZt1HxL0rhJKhXTl7Lx3K1a5yL2XRKv8tOIF/6V1sVX0/zIEZRqTMM8AxW2c/p79hrLicjB5NhFrmcxyJPzs4tatT9r+xIKd8u5OSSfNFIeAWepJzDARs9bJQJlkJHrUG1GeyrGv7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti4Aw5OK; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti4Aw5OK"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bfa99f8ef8so1622533e0c.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 17:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784507755; x=1785112555; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R0m1lrY9hke2mrprT49s9vDupBme4gfD7GFuxoXc0zw=;
        b=Ti4Aw5OKiyQrOE6gtHSkLGrYLSAydqxGIUOlatMLoJBFlIn1tUb75hJvEOlypiB+Dl
         Lw0mEaKnsnH4x3L4YDGXX5hoPMdWdqbBAjJRP1LMazpPky5RqePAs0mQv/akdGqlRV5V
         WNAD8iSPO22vyTk/lErgEcudX05pUmkd0sv9zo96UNGIhB3qbcqP++MQ1wd93mk/4r6O
         p7/9VS/Pzr9aFCTwOAQq0VZymyhjH3Ds2JpFWjbjPILE/e0ILBMBJUsczhdVT+sxDFKH
         9j1fGTcOY1Utm5EBxiAV/LmnzVp6MQ9krCPC92PojHaUih4zMU+hYHBLI/3fa7dZuak1
         ZOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784507755; x=1785112555;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0m1lrY9hke2mrprT49s9vDupBme4gfD7GFuxoXc0zw=;
        b=ohS8b7j8dbPgNTnR8oCJRslRyVq91mzmD7J1zb9ZwsvlxmcOuboSLldWVtuKehn9wb
         4sbd4n8GQPcGTI4wOJm8ormeocj8e4pgJf5oZVRnHUQL7HpJFhJh5ZdUG6Oe0smxMb7m
         YabTFqoz5/zIZJEvKj/Rqy9jIuNgFKeneEoGrWhvLtA00sLqvutX3Pq5FuvSlex3m3fV
         PYyRzJ5FskHfXPRh5k0dhLd04jpDc3yPZj9/BKSfLDhsUjNiIMfVjJWYW+78ZfcomVuw
         oHwZ4YCAjHCZcLrvEhmQ/+T00dZZw18I+sosK2oUp6J11iWlcxRJK/dW5o6oa/du2zmH
         TEiw==
X-Gm-Message-State: AOJu0YwQ3GeBwxY0OgRzqWjMoc7v8EVpnMLIb6KPcKAFgfdjKcNl4VgD
	mU9ONtMLiqmq3Ezc2F2SXVnGD/5e32Z0QynfSU3fdG6NUky911kyqW02
X-Gm-Gg: AfdE7cmgSApJEblt04PU0SrrgOY23+uzyHwiiHK624ITM584g9/zn22UE67VfVOfFMi
	YBdSrZg6YC5f6mPxZwA70XslFbWXM9Mxei9PRgjwh/Px4PVRIfYITAhX1jShcq6rpBlknIcZWLQ
	P7ot1nJKlSPzQ5KtJ+7XmTktFgtWwO7Fvun95HoBetoCS5ZrC2ryfXYHggtpPB21x/bDnM+bdRa
	QiLpl2M6EawlkQ9JV5TlKAHFZMJqI4KeismOKwscXG/K+oznFIiPb2VfDsgIuRxt1OKEN0QkXpv
	J1pr8yZp8nhf0cHZVurnRU2eI0Dp+gnaZDGTL3wSbgbqGH21tkgLV0sPvRDV79+XbAOCWRmXY2r
	9F/Bc+YOxSzXS63XSdRWEn/RPJu6BgF7d8W0NhYYvQsnoXW052tX56aoz9n5U+h0Rsen6ZVNnPR
	jUs4XYd5vbRMzm58rGKIlBE8JmvQEY7/4=
X-Received: by 2002:ac5:c772:0:b0:5bb:e5dd:d93d with SMTP id 71dfb90a1353d-5c13bed465bmr3115283e0c.0.1784507754943;
        Sun, 19 Jul 2026 17:35:54 -0700 (PDT)
Received: from smtpclient.apple ([191.181.57.76])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-976fc60ca1asm5912959241.10.2026.07.19.17.35.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2026 17:35:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC Patch v2 5/7] repo: add path.index with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260717133015.32040-6-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 19 Jul 2026 21:35:40 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <845D6852-98F5-4168-82CD-90B3B476BCF5@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-6-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> Introduce `path.index.absolute` and `path.index.relative` keys to
> `git repo info`. This allows tooling utilities to discover the active
> index context cleanly while scaling transparently with localized
> `GIT_INDEX_FILE` environment overrides.

Note that bare repositories doesn't need to have an index file. Maybe
it would be better if you return an empty value in those cases.
