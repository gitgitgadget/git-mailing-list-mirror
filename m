Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B71E9B36
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248259; cv=none; b=ZcNvUX4RoqRVoVGY3OTKsrh5Kt98ma/xDPqYGdrW4+x2oNZ9OKgUQzRBKrJggZQZs0iQmINLiGzJhSsJqDCzCK38trt4+mmWWJpuYtl2RRSxD74MTUtArVY+G43pZ7jFXKdgs4Uto8NQUt3xUkG/Cu2KkXjHyd3riFbvb2NTfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248259; c=relaxed/simple;
	bh=E2ILWDc8L2GuWu/XVEXF5fx8fdEbJJuDBzmPj/+AelI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGYw6uR4jWARZRxhVDEUEJQldZEOId9fZCsci3wN3wbVhCIwMqIcnCfONy5G9XvwZ2Tc3KRTuY3Q7bp0zQihPE2568Nq6qNaIK+NCR+2TyQTD3yvsP2KZuY8zMKxmHxbnfzFf1WwipwOd+l8KeFH0ysOUicikMs5vCEHFgkSh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8f9494312so670166d6.3
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 06:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738248255; x=1738853055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2ILWDc8L2GuWu/XVEXF5fx8fdEbJJuDBzmPj/+AelI=;
        b=lvs20Jvz7J6j8vCpFd6/lLZximccH0noWIxCJehl1M/EnQL2hTZHyYb8tIQ3LJmb9D
         ef6R3Qs72OFAS8GiYjxnXDPKLgySRwZpLNyygL8VFg8S55c+o3hwKAs0qpOzSX/T8Zrq
         OIQklkzl42Vw18bpoK8BD0AE23vKY7P7UhI3aGXk1C4oHk32Xbkp2t/4Hpa4wclIOR+M
         /IghXuX4oM97DxuCjFO2tur7SsbN5tcpRNftZM3oU4eoQIGmOO5WNjy54Ae7Tpck4oEn
         SRBeCXQoixBNN97BzOGXZ/+iKPsRpl1m/F/GUuWxlboBZWPvPB0PMnXJMSX+/IImwmdr
         0oCA==
X-Forwarded-Encrypted: i=1; AJvYcCX0HyvPQPipz0nc67pgzfz4dAtwjPoXRXEbx6jxTSPRr2Vb5AVU5kZvopfc6/BO+eo8+8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxix7u4KfO+abXmksXSfeZq/ZrwTZZMDKsKWHqrFNHQWG3IuSWv
	WmIh6raDolxHu4UyAS59YTKXdzZ/gK/PVMsG0HGDyUFvJb6GkpWiacWo1g83HMPbrJ/ebabwG9u
	QfdKmuKyQEDZxGJ4fOZNt8tZSn/s=
X-Gm-Gg: ASbGncvEWXxHjF8sIqeG49TxlEpnDLJqVBfsqSSymNAa8KPO3tp1D5YA2xWfC/eTZeG
	PFUokmEq4+aRSgE4t+wr3jrlgkFJLu+UMPLjMoo+9/44/dpzsx05KfAJrJXMhMFlJthA1S9FXGi
	DZ97NImLuNYdjZFWz6OWl4g8MOgMxw9Q==
X-Google-Smtp-Source: AGHT+IHa9ZZonCHQwILK2qSRFr/gGqb9O/eJ8zUMxWv7OeF+hms9SQT8gI6noOuWYmeMllM8r1ujgsvre+tqZP5ELm4=
X-Received: by 2002:a05:6214:d89:b0:6dd:42dc:5 with SMTP id
 6a1803df08f44-6e243c9bc83mr36973726d6.7.1738248255558; Thu, 30 Jan 2025
 06:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
 <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com> <CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
 <116C27A8-EF7B-42E1-9606-815FDA3CF94C@shopify.com> <CAPig+cSdbjzTmsBOmFnMxzYLGrUzY46=mkW9S+si2KxLhS623Q@mail.gmail.com>
 <F15C12AB-2238-4553-AFA5-18277B18CE5A@shopify.com> <CAPig+cTHfD1fK73+S3fqQ+Oz_VpBzap5=nFFE1bntSeaHLcu8g@mail.gmail.com>
In-Reply-To: <CAPig+cTHfD1fK73+S3fqQ+Oz_VpBzap5=nFFE1bntSeaHLcu8g@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 30 Jan 2025 09:44:04 -0500
X-Gm-Features: AWEUYZm0-b6ewxQofDZydb8p8n3WrQun0PVZxZ4NADsX0RVAdy4IaXmcetQa3LQ
Message-ID: <CAPig+cRv9Z2mQ964PNgbbgk+ByGvC1EMNc6=-itD_7v6_4Pg+A@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: detect from secondary worktree if main
 worktree is bare
To: Olga Pilipenco <olga.pilipenco@shopify.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 9:32=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> (By the way, when replying, please use the normal ">", "> >", "> > >"
> markers to signify quoted portions of earlier messages in the thread
> rather than using only indentation. The reason I make this request is
> that when I replied to your message, my mailer stripped away all
> indentation from your message, leaving all earlier quoted portions
> flush with the left margin, which made it very difficult to figure out
> which quotes came from which authors from which earlier messages, and
> I ended up having to reinsert the "> >" markers manually to restore
> structure to my reply.)

Examining more closely, I see that your message was in fact multipart
MIME with an HTML portion which was using <blockquote> and whatnot,
which my (plain text) mailer stripped out, hence lost all formatting.
If you can configure your mailer to send plain text and use the normal
">" markers, that would be generally helpful on this list.
