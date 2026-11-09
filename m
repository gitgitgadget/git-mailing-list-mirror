Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794228201;
	b=jAJnkwqQSZh2GjixMnjXx60WGV5Sf0VQ/vaOgPfvjMToGkOtuMbq3zl3hd3JoDcdgsp2
	 0fgI2h6g732sZTNDQq/KffWVJkrnfZ5b8IIFPyVoTK2MWezfr2mUEZEZwoRIERBsxFCF5
	 Wk9z9Z9+RneF2BoXlxtebnc3xtbCBj4gE0qoA2Rqx0d6sAOOfUm1tVFPVqhMQFp6SJTVk
	 y9BisOgfJniGK+0pxTdZVkRweh2KLxuSm5baatSMlrLcJF/+JmkD7CQT2tkbN1FVJl/Ai
	 ggqLeAesGXClb3sq4uqziLNVf6o4YzXgohstyOWIte6dtxygbWaGoGMqlLc0LFA1rKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sM9OQYKLBEDZLfvbXpR1BDWvW6/v/CyYSN/VjOJ2P6Q=;
	b=0hm14kdivJT7KBU6ZYIw8w9J8Fm7cFTtdx2/WGsn0LUY43QRh6iDl52sPxwh6b8LQtF2
	 WTHxQ61UDR65u+obNR6zOBg7oGFu7ba4VO8hSV6gro4PeT0NkrsKZ4AAXBVcfGkDyqsmr
	 O6pF5Efhqn0zQUA41cCGTXPPZ607Ja/xmOoiWGfjm8kFvhxaOLdrE8gfH9QgPVQA251tT
	 Y001JyttBUtQEHHnxaGJH4zDomZqYnwQXceswD5UYc8Q5w14M2fcuFVr96PRNTTM0HArF
	 bsc3kVaQsmIYuz8xyzCOkCwIM8NwlhRMPTqJdZJTKttfk3Tseqfo03zSFcIZztjdp5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gu3l+/8i";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63A606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 12:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF63A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gu3l+/8i
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d7791b00so6242815ad.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 04:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794228200; cv=none;
        d=google.com; s=arc-20260327;
        b=isQIoGFu8AYB6kzggWDBGZbXP9wXnPIw56T2ee3PHpHN7bA7BbHf4WL5GJlTk2fIfC
         h8JqPNbxHvlvbSUGIUVOEm6q0rHg4aNEuuyXV8XrtE+bbeOIZdD432MOuOe8kxMvBVgF
         9tLToIHfEb+xVzMMWh7HrHphT8yHYr8FXYNLiL2xkcrxEzbRvgdGlN0Y7zIFGZF07oVO
         d8n8F/OXFF/V3ckfo4f+hCsVr0NqsJA6qYvWEE5PIcZAGqlUg22YEs7dNNzZzAa00GTa
         b+CFYDT7dMNTmNJ/iONOoRJ8+COs4oJuoaMAiyDmqG0PfAtUp+CgVpUbsquNBWrqADzN
         8n7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sM9OQYKLBEDZLfvbXpR1BDWvW6/v/CyYSN/VjOJ2P6Q=;
        fh=6Osq9QKkmOWXRpZfuLDp1ZxpkFJhKiDUTlnEbnT/k6Y=;
        b=mPTgg5/9Xw3PYSsw9nio+dV6wBa8I7FVje8e8kJfvDyhNE9ZogXTH+/2mqqlBFu3Hz
         NZ5MGLJCVcLVWFuakULOn5GQwFI7yxtevfzTgPq4if6cqiz9P+tYopbV6HNnvsgUECdi
         nqZP6IQ6NQivaSc5K3FXsEZU7cHgDHQAQ5RTxqLE7a/HmZs68qW8pgm95Qy1DJZJbr4Q
         B4CWTMcH+n2CWr/DKVrE3vmxU8oE9HgumPK2x+5QjYKmd/1AxTCxRjtAPm5CX792Ivix
         A0T46HaK1EtNMk/4uYRQYwBG2CFwh40mnP92xIyStf2KJ8cdNpbSZlHBGWFES5YKjVyT
         ghNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794228200; x=1794833000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sM9OQYKLBEDZLfvbXpR1BDWvW6/v/CyYSN/VjOJ2P6Q=;
        b=Gu3l+/8ivG79MM4MWnKGK2NK27LRZ3v4xDrkonw1UFs2TeKqsSqz0zJxZcro/JydHB
         RXkPJj/6hwW/j0JrqBX4FFWsAWDyx+n2LMXOOjwO0hys7yH0lJk53StQZkIu5FS73bJi
         ggTWSldI3wY4DW0QeU/BRZ+CoTMbwQFrdHPMmja45lLZjWu2IYc9ff7hBecPv6XnvSsj
         d/0tUJ/v5qxsaUj3vNAP4WrncIIJqruBCU76V32PEY/qlvjcKUt/M45OSli9EkM0vNbh
         InNunA4QXn2DgRna7XIZX88Fd2ASQnwCHS+2s9M1IdSElz9S1EeYSVYgbk+a8J5ZRdVV
         hWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228200; x=1794833000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sM9OQYKLBEDZLfvbXpR1BDWvW6/v/CyYSN/VjOJ2P6Q=;
        b=GMIa8Zl2IkURWhqPVR3dutfmW7vwJ4AEZ/3PxiAZUrlXdIEFEnOwhF3FMcA3SJZrDB
         cOpwbPxPyDZjLSN7hMv0WxadsZomCwXQt64BbTGcha/nq+DESgpsDI3RYqE28SL0YZHz
         wYAVqv4pGxRtshe9hFqG0Q8SNYIFiMbGgqwwKXOCEJUG44u5R6BpJzRgG/emj98T/scY
         BNfjDpuyGCqlyPHx3y1m5figi+f7nKJ/fzqp/ZadLJ2guebLAv6sloN1d2WtCRWjUqRb
         DFTeS/YDTXxv6bp1pYn8NiudcRkp7JvPsaVsulTszV3g0FFMQVA9AosK12pfMwTt7qAI
         h1YA==
X-Forwarded-Encrypted: i=1; AL+hErEI6IIBRcaWHgCdYcX8Zk6ejBp3viBbF2qy0Dw5TAZcywi+Ho6X3H0bH1dnZizShNSO4WA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CAzrIRRtAtAuP4nPWtH+ZU9ramTQsz42lJhESz87/uUqftH3g
	WyQ1Jeo0Wal8tmatpeWZoYASfE8rJZXIcYB0ucc45qkcU457TUSOUkXhRVkck7e2F3z1oYk2Mmv
	Mx23TGoylwC90awqzXG3sD/gJxDBZiK4=
X-Gm-Gg: AYBFou2Z8ixxdFqTdG/TOdOSC2ivnwwftzS6DEvd7oiO6Tvixm+ckH1VZT9OWrNU0gm
	1qADUj1LVLgPuhY1L1vNftv398NrKmkMrmdADwoZ95gHfqIM3NAjmRMxpdx3hVt1/nIG82+0KQT
	w3M33f+bmKFC0ZC0QNPRWIsvc0agsA5NkBnmuNcvmYba1TAqpvncvb095PJTKjAG4RUAzutQoLJ
	DG7WNPlXsoFsLkCAoc6SZb6LAfv8+IE4Tel2HovOCaW+etlOCqHckmlNPaRdljP85OKYlULy146
	JYpMR8mWemU+vDYiokarGW1BDfUqSwxvm+lZ3BdcIUkdZve0vsXhxEGphaI2QKTlYgfQvck4wDs
	gAAVpv7Y/CiH1EIGQJUYFZv+RPFObGhQePw74OSvZEwYe77WgP9OgsyGfXmhT5aFDHkp3uuxioq
	wFfSjZMo2Mz12x89+Qn+D6dvW0tiQe1fYLq+fF/n28PQBvYGZusrhzV8YmafJPQvKSvsQ1mti3I
	Smg0w/NCmV1z9Y=
X-Received: by 2002:a17:903:26d0:b0:2e9:ca71:45f4 with SMTP id
 d9443c01a7336-2ed8375c41bmr36921075ad.33.1794228199989; Mon, 09 Nov 2026
 04:43:19 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107193020.583215-1-jelle@vdwaa.nl> <CALnO6CBarutmydfmHDM=y5yfUCQY5SxKKcoCrd0NXCuNVkDuJQ@mail.gmail.com>
 <bf54db39-d10e-428f-8c6d-b444f37cce81@gmail.com> <CAOLa=ZT_U+gDjdLYkbtqRjUxwHA6q6+Uk4ssznyHgn09xcFqpw@mail.gmail.com>
In-Reply-To: <CAOLa=ZT_U+gDjdLYkbtqRjUxwHA6q6+Uk4ssznyHgn09xcFqpw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 9 Nov 2026 07:43:08 -0500
X-Gm-Features: AclHuK_c1_4rFzs5dFWe_6Csxfv2GaHZrVZ-ivpMplheRPLCw-CfKvjZievbs14
Message-ID: <CALnO6CCfKsd=w1kVvbJ83WtJPbsH8hGcfZUUTE9eGqWOZeA=AA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Jelle van der Waa <jelle@vdwaa.nl>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Harald Nordgren <haraldnordgren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 7:06=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 07/11/2026 19:49, D. Ben Knoble wrote:
> >> On Sat, Nov 7, 2026 at 2:36=E2=80=AFPM Jelle van der Waa <jelle@vdwaa.=
nl> wrote:
> >>>
> >>
> >> Anyway, my point is, there's a lot of possible meanings for "verbose",
> >
> > That's a good point
> >
> >> so maybe we could use "--commit-verbose" (blech), "--diff-in-editor",
> >> or some other thing that smarter folks than I will come up with which
> >> clearly signals what we're about?
> >
> > Off the top of my head --show-diff, though I'm not sure that's any
> > better than your suggestions
> >
>
> My preference would be to make this (current patch) default behavior and
> not even have an option. I don't see a disadvantage of having the diff
> always being shown and it definitely is a better default to have.

When the diff is extremely long, or if the user has other means of
obtaining it and wants the editor to open quickly, it may not be
desired. So I'd prefer to still have it optional, personally.

--=20
D. Ben Knoble
