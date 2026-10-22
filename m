Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792680121;
	b=opdDHK5/4U6Ve/eMdXdwdl5hdaWYiIFaUM97RwRVajkbUNfrp/cpPROYOeZs+g9TO8vx
	 nvKrT7b/dSaI81zve2ry/mAt70+kC43yPnCme6buXPzEq3Ri5vRQQTkqN2XH0HjC1DCBj
	 7Au82/k8AbOyaQUG19RONm+wuaLL3hPg9ej0RKYSDXk/oAsrHVzsuGRzy/SUc26d0R1VK
	 dNWo92OHjZXgvzK+p0rYquYrp+0jsK6mBDyda3oD+6H8t5Pw7LODX5n+E9iTxfqToZyVs
	 Xa1dUVtktGJFz4KiDE1R3ISTcYLvDd2MZqgOmPfrDVJrCfYG+ORz/2KSVo5HQfCr5MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QAI2gGytOZz3vWWnoD4Jx1JSiwxXMgOg5jom3fXqqMs=;
	b=m1nX3UoZ+xOMhBUzhRjkSMOa6nRlXBRHLoVk+P5e+49pelPsYAMJ+q+xQxSAtHJg5FAk
	 OMdgBJbZQROLkwzx1MPQ9bw+VKYz+AS5U9DHwvN57lMWQKhLf79rz4T2hduaJ1sqLoNqE
	 VNAqvIx9wUyZfsbuRPLV5FdfyYoJYpRUDMU0BCeawdEwwt/mmEfqJTPAnz8/u7UosD76s
	 ogjmG8UmA7w4WF+kRrl0Lcy9BCQh3UOFiFW1hJ1onxDcUoFuIbLn+vvusO7cqMzAGa97i
	 d4RH603uYRuO4PBwJ0K/W8sn5JsmpV3hnC9hbQloLlbP5NlfyvDVH+vk+CASKz/9RIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ScCVwBhU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327A606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F327A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ScCVwBhU
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso307046266b.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792680119; cv=none;
        d=google.com; s=arc-20260327;
        b=X1dA0YZqrvbCZ1JMgp9jheptwXjy9DgJ4i+iJAzythWkYUVQ566m4ZgqrV+P0Ojwxg
         /xcihZGVg12LqY1RPO8OgDh+gJ/AkSRIXm8yAt7m7oUSHycWfjNk0TFtZi/6nmZ9aTvB
         1NY1eXK+e1WXncN8VjhSTFwrk8pe+7Ydt1LNhrulQZCxzW/W5H7trQAp8kbePQGeAsxW
         D9W5ZDTnwnMTRk/nKZq5z5PoX4K9Sa5ymJLc2OOP3CVE3CQjUZ5t2sHuAdH6J0SPlYpm
         iztrDzi9o3WDa8bROrvMrqCSxvi+vVVCy7/I6Qd9ZLr4vnK31wHC2M9EtIDMBJ/IwRaq
         Mlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QAI2gGytOZz3vWWnoD4Jx1JSiwxXMgOg5jom3fXqqMs=;
        fh=b/hOx4+aIwgtff5aB1gOAjs9vFkEh7ha1Q9+xfNEfeg=;
        b=soOBPgUHg8a3C2fcViJcZpIgol0GxLSpiI5SUGIeTBcjAGM4oZgZw4ljJV7Fr+/KMV
         yfU3+kDhH4v3agRzdZ8X10yqWimm5ctAtv5bSQt6LERuRQL8CGeuoCd2d6EKyA52TCWk
         tw8KqmN+YaJG5hZ53SrpU0zzhHRPHzq3o9QJr/oek9+yFvpczJFU5oxke7tosgB3cBZL
         jlc+/Wpjt5HATQd/IZ7j2XbJJHBPfEtW6hDq6Z2coDZrgdmEVGtpxYQ5uR7j9GwVy4vz
         i/4gkjCy6cVCyxjaHTajM2P352yJw/gj0gxkQCD+L9BIi31Zt5KbTDJvYDkhtJLg64V7
         nFTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680119; x=1793284919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QAI2gGytOZz3vWWnoD4Jx1JSiwxXMgOg5jom3fXqqMs=;
        b=ScCVwBhUzTlCiNvydOXmS2E826IxWQ+80BYfzN40nw8hjKW8ofFCbrPF1ddiqz3XUX
         KBlt+jonzewpk5oqpuZCGsjCh6zGsIwp0PrcdMVbit0w5nWjRRllg+ZJ02+QFFFVGaZI
         xfI1cMPhqzlYeHL4dzchXYZas6NQBj1Ef0WCoQV+UfKIJYQ5idGjc0xPsKXBEpMIq4oN
         wh+xHnAcmu3xO6xw6m3CBQzBqeYMpcBzhauOO7T0FtJz6Y1whrEJDo2bzwG/h6XbaCOT
         KLZ1sBzLwPDbu5LuoIpBIuK4caGTIbXW4K1Ea1DNybqI/8WiTurscSCtFpnDaJkrC/yu
         X0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680119; x=1793284919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QAI2gGytOZz3vWWnoD4Jx1JSiwxXMgOg5jom3fXqqMs=;
        b=z6DX1epxSQasp1YMXTgJDmkqtX+0bOVapfHGV+SBM6QB4AEvaMx2fFCNwnsQ0aARTn
         DqzBiiZ+jcUsaSmDiRE1NUoFvzyVU8rjCPO+2s//GoddMYkeSTW5fHM2RUv8SUPvYAO1
         EbASWQM3ygla6edgwCs0MOC4Kdfn4t4gwjIN9qujCP45b9pJODl7SpmLLKp8dtu6lrzh
         P5n/i0s/0EewLJ35ZwXwU+N0U2B5Grrfp5XiYisOxS+qyky/HzduLDLZCMkYyAtEnjFb
         ZCf8tPY1CPw0qufs7+sQ2ZCVa4muB7Dyy0lq9Tfm0PYpWGCCQ8etyYGo1Q05ffpZjBM/
         nEhA==
X-Forwarded-Encrypted: i=1; AKwUvBz+l2rB2NoQR2f4svr8uAzWgYF41Ay6L989n1rvxQPe9Gm+ya3Ijb3/rL+W1j0Y0WuRZtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm65xaTh6OuXS94Uunmn/aMdnzxlKPu5kQU93UoACVf3V80v0C
	uI/yMXueR6gt4e0fZbkM0GaT1PpsAAsBM/YwXiSLAPKVr1ol053EEw/Rj+kPjYnLJSue+I88iJG
	koqreH7xbmptacxs3UA1p34c2Ode9zqzeEK/t
X-Gm-Gg: AYBFou3Naddsw9j6XnFDSinC9bj25zXIZjAFYGI06avIIHvzzNCRPgCaFcPEzFohEXM
	ucPZttqwfosBRQT3zZXjVsiz2YKXuvwaEnPlePCVnk5Urhvl8hwHOc6u2NaU8y2hysbtwVYHe5L
	3TC9JMWGJaBOwnq2RzxCaZiCiGygijHjdRk0wVNgUjxqS4ewnhIbDlPeL03njI5OnnB5Iw0fzqY
	mX9zFopIpP/5OqgRMMyUlP5+HkU16SeudLoV7H3D1xN1dKvFtBgj8tLSNF82hV30MekGz5/pLDB
	gFApv+R24KfPfWZdURAsKSYn+eQY7BbDSNk4enx2KBkqilhS+K5zc3UNggemBtJL+hVTSQ7yICP
	kBnZBRGVxFBHxWLPIKDRG04vvIzdWjQRM6e1K
X-Received: by 2002:a17:907:2d12:b0:c29:f5d8:9c78 with SMTP id
 a640c23a62f3a-c46799b6376mr560568066b.39.1792680119152; Thu, 22 Oct 2026
 07:41:59 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
 <20261021173503.70887-1-me@jaspermayone.com> <CAHwyqnWnp0W17TXbXgLQPaGuwasqndgoPHV1CL3mBpfGFYadtw@mail.gmail.com>
 <CALnO6CC0+t3PTVXC=TohzpqzgeOK4t9bKzGP-43uD1bbA4dPOg@mail.gmail.com>
In-Reply-To: <CALnO6CC0+t3PTVXC=TohzpqzgeOK4t9bKzGP-43uD1bbA4dPOg@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 16:41:20 +0200
X-Gm-Features: AclHuK8I3ge_ECsmRnrRf5u8OyR26o8qQd560XFDJmKp2BAXrP_1_A_YUWMVy1I
Message-ID: <CAHwyqnXYopD8=KFGdYkaqwCdm8q548QOKnyjm7SSRUqGXkOxEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Jasper Mayone <me@jaspermayone.com>, gitster@pobox.com, git@vger.kernel.org, 
	kristofferhaugsbakk@fastmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 2:56=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Wed, Oct 21, 2026 at 2:52=E2=80=AFPM Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
> > My branch being pruned because someone else did the same thing would
> > indeed feel weird. And it could be stopped by doing an author check.
> >
> > But I question if it=E2=80=99s realistic at all. The code has to be exa=
ctly
> > the same, and I don=E2=80=99t think I have ever seen that happen, I wou=
ld call
> > this an extremely rare edge case.
>
> I have seen this happen when 2 PRs contain the same "npm update"
> commits and are rebased onto main: whoever gets there first wins. If
> the commits contained additional changes, then the later-rebased
> commit loses some changes because they were handled prior, but (when
> doing so via GitHub) the commit message is unchanged. I find this a
> bit confusing, tbh!
>
> But, I will say it is rare. Perhaps not "extremely" :)
>
> --
> D. Ben Knoble

Good counter example!

But it would have to be something like that then: an automated
deterministic script.


Harald
