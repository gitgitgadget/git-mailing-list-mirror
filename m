Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793628696;
	b=XjXtsv2h6+69UfUHGR1b5D3Rj6KkuB7SJJOdLHCti+Ok0wyBC4Webeq1qHWBJ+l2RjkQ
	 0KTmvvSMSe8KShrDQhnDhGM5W00Pdjs0RK4q6WixERiVWodx48anI8H5xFdiG0bEEVKt/
	 NQEmLDR8pQjdpFJF9QvigNnaP336CyPWkrhOv1YBnqeJvr4+7GiAdOSOnWoTVRSmRadDR
	 CeeHdqzf5uifAX43PpYVLYH//IojvxwyIXQA59rYxqO4sDCSOmNyU1n3EENp3h74Ah6FB
	 KLk0/o9fJGfDfqVlaljv8XB6juzyuyR59YLPOiXIdRO9dlOCkmI7XaBB8k5DuhcxRVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RBOeAxdh7aZB9EUM6G45uKssMPplKUfhkjNTDxLvVvY=;
	b=hRGTi9hq7rq/VXEfF30/zuYIlm5firM4pWez/5K329Yzt59LycDi8Aty+z39WCRHe84K
	 w4H0Z8iaKGv+BvFHIdpVPkeC4dRn0BSHO+CezKNDtXsTdtY0aXwfNjzOjcil1vC9fgsgc
	 n4Y+x8EuyBeFFhPJRdnktOveHM3wvBoUwvqwOUsO43okyQzj49ATvHL1TqKjZqfulzk92
	 3wXfCLDhiJ+IJ0BiexqKF8UcGKHYD1es6R+uzm2lQXIdZA3tnkQnZL9faFcU0KJbWZHl0
	 L5Fks+/UHWqfcSfcz+C9mSMTD42GzTRZY6/MEBu3R2mSz/PMSqjTG3yb2yE/CvzucSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn56P7Rl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927C606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5927C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn56P7Rl
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso4428234a12.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:11:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793628695; cv=none;
        d=google.com; s=arc-20260327;
        b=Dl/fdAo+S3xrpb3T+u/fhRmsI1Zrp02bKzBMHVdSg2dWWiJzBgKc5sq6m3Vu0z7Trt
         h/grH/7T79ahC7Hf2pwuuF6wCmeh2LxJZuZUmyeexWmhzXOU8hUSB2FGDtD2dgIb0+f+
         FFrM5AlXq8XgFlnaTYuGAlHsbwKUFr74N+4vtK/DM0glqZHXm8fNOjM1enz56sS/QS+0
         ffJYndRHp3qtG/ejcxxpxM9qFW4jOOCrummoB5C158RsoqP4HmnV8ioj2x2VuS+W0snU
         5AZ0yzlA6ILaiNa6YCJA4TVMKx8Y8QFinWn4vlsozNLuG7pa/gLWjTsiBNr7sFaMiXio
         4w2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RBOeAxdh7aZB9EUM6G45uKssMPplKUfhkjNTDxLvVvY=;
        fh=I2CGhO1/5wJl1eL3+xyAAPpLAZoeYxlVfznXWHahQxs=;
        b=sPCRgIOyKw/iDnEKeY6fpPKxOV/o00H5yMw/2FWKYH3Yy8e/TmP1a5qVczBBUuE6yT
         Bx387QTPXETjfVD3Y2DjtJZcv/5htzSuEziGw9ZEpuWELGAkpktcQiWXV3BkVpEmca5v
         VUFOwc9v1gIDNTP7Q/xzA4ZjtGspVYhsf6AzWFeEn8SrZ8tBq4ssQ6HNo4TM0yVotLTL
         GpT1mh6kM6qVCC+7+X1W9QApxhcqLs5ZKN+h2NIaWeEcFxFPKzIOU/yReBv4qgLfEfQk
         oOJ0N6OIb8w7ymPg14Y3J8x5GTJ5ashuD58Dw/xNxqsoirDO5szrVJidXoVKF8KJmqKR
         qKEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628695; x=1794233495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RBOeAxdh7aZB9EUM6G45uKssMPplKUfhkjNTDxLvVvY=;
        b=Fn56P7RlIL92wJSqIa7Z0CeFbdujnOKxBeJmN7KUYbJ4aKsNAqaIL7vQYc/geoY2ID
         0sJUaHO6dw/EUsdbnmpa3fL+8z32DZnnbKAW9R8BIdHyVqTZH2MgfpAXOzU/J80WLcH8
         P03O92FxzpOF8XxnB9KGHzaWpZqwq5Y4TzD47sWjHLSEuhGFfzQ2MU5aD1ACNmrjoP3o
         ZLr/ZMnuzdbDkTcdx3QYas1ZpD1IIXInw2IXtEADTQ0AJLo0bFxdtDqGnhn+Y8P0iBIk
         21+8vY/Qd/zNLB7+Ci1owabvCDsaJZWp2lYyz2NFMmIf20a9354AvH3QN1ZbdGALBVhO
         Dp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628695; x=1794233495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBOeAxdh7aZB9EUM6G45uKssMPplKUfhkjNTDxLvVvY=;
        b=G1IZ7RwqKsmUJ8MiKhqkPQG0FiTmbuR8oiXTK4xLVYjoUienAqTJr/nYambD/6UPbn
         IApZytEw7+U4ctEsw1gYiHt0aszAsf77Jw/qqgjXvlqNpqesWYLfvqh17PPe9k9Ody1e
         U3h7MF94Ws/cNmG6G7vNtw5Rcc7+znQF9ML+nWCFRv4/+JAb08xN5G9fToKnqHmYXBv2
         EJSCof33ZKH275AM+qFoJZzYcZUHw5mUxMI/63MD1JcqOVIvqkq/JstsC9ni/4/8B9jm
         RVJU1gd/MOCE6EequML+511GhH2M/8kq0xrA6EsFAnGTqBeOO6IRkuwhRMH6Y7zxcBkW
         nMBg==
X-Forwarded-Encrypted: i=1; AKwUvBxhOVnAzoaGprXNRwjcYQ/XQr7qg02CesM03jMf8APyhMj9QD6yaQyz0dgBMckabiru8Jw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ia+gjkJ6315B2/sLUZNuw8r+gIiTzoD2lbGjMyCTfAAnGYF1h
	ah0SpbGLUteplKVwq9Vv2j+MtfKW8j9FJYPlhRTwQqRRDAjcn8ROrh5ZGnjrcZdHSMWAvfXigEY
	D6Su/i/Sp6scTwmhWKxNQ0DBB085vv7M=
X-Gm-Gg: AYBFou0pnEiLY2MA2U6SZcuWfY7fGxlergKkdSXppS/JDvmdHakGQouQT++aJnhnnS4
	EmLunV1v78kkhbN6+dWSne3bNJh+rAW7zrTxfP41MWHYHAcyS/j6yCgIWBMAbEHtQ4rREnR+5Ck
	rxk6ARTzoG484J+SZ5XlI0Gvn7Ei9nsZ5f+qprNa7P228h34x7vcRXIqMXbjdm+5vx4L85WmXZc
	qXbsJiMtrhsgrlYgRdMB4d3UKwmyDEY6lTWuSrqn356iOYXsi4sMfDZwuNUgna6RRISPnJQLWet
	aSKwsSWq2o97hfmGpSYuml8Vk8OYi5z4tiEdhpi1C4CzicU0Iq6EZdcDOyN37UhBtDSrvDmaTnK
	ruZ6ab+fKNOqlUTucPt6hbLvd0hXVm6aJsuTtf6D0QMrP/xQlj9IsFZ7P3g==
X-Received: by 2002:a05:6402:223a:b0:6b1:827c:af27 with SMTP id
 4fb4d7f45d1cf-6b4d42901d5mr4759279a12.14.1793628694728; Mon, 02 Nov 2026
 06:11:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g> <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com> <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
 <e1ed2066-5cb5-460c-9c1c-0177d338f7fc@app.fastmail.com>
In-Reply-To: <e1ed2066-5cb5-460c-9c1c-0177d338f7fc@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 15:10:56 +0100
X-Gm-Features: AclHuK8ZfDprIIOFDM7KR5eq7O_5gF45PQWusebcKcASCQu5y7Jpyjw4MNsl8dY
Message-ID: <CAHwyqnVMb1BtJ0Eb3HqQx9SNyB9oWkhC7OH2_j=xZSiuwreK1w@mail.gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I=E2=80=99m not much of a C programmer.

I'm quite taken aback by this.

Is the Git code so sacred that even the reviewers are not in a
position to review? :D


Harald
