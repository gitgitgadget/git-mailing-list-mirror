Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793147961;
	b=j8klxeddTfYwwkiFQVKbj01Q+FNm1wFrfMBo9v753rV/B4sGcWheg44ZjmwcJKyEf5e0
	 TZ0YzOgImmncobGUIT0Ly+CETDiEJFPdp0NTKvQbT8q8AoC7LlWLR+j/8MDn5aowZU4YK
	 eDGVqqghl1tiGeQc7XfhByxSAzwH9iAyeJqmaqlX4FsXLvxYz7aJZ0M7Jcn+tBNXs0cGG
	 QsZX0XjSIydQ/yFqaPKgLa+tNZ4YgniOZnb0ipA0e7+tdeZdtd8t6V+3cU6CmMPAuc/Hs
	 nCyuh6IToJgRUpzYwj4dZog/V9jZ24Hk+jMrgmZO+whoMCN3aYQFeGwBKp1I8C2UX8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=6Hj9wRw1m8xZDK2beu+jGNNuT/mQfuIYBYNuWsqjtyI=;
	b=VVrQTKf8L4mAbmbpFFA9MRNJL8SNPxRkLob0wFeBhgGfthQfV8a5cG+wXn7a0Y96d4jA
	 LMj0mAcLPeo5gF6nI8G801NovVA0+zSI+osFZHsQAoPXNrDcrfhxwIzzpuDVfHeoYIxyv
	 q6p0Bj0ZQVLo0tEGKz27ZGXaSLIGT8e+qIUM9O+4RAGdrQNch0PeIgNEKzp3gbNF8NlVr
	 /ijFAybeVzSHrN9Zl/XFNt77v8PvAI9Cng8qce2LIC3aQ0eKICyckysMWbUiywxmqPMvo
	 wP9LI5eOnMY/u0Vdoftv487IiFD4B/qCPPd+VmUk4w5QdoLPHT8yQriM/wtXwTIQ+2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=RLO7l0p3;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A8F606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 00:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A8F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=RLO7l0p3
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6dd4f3f696aso297823eaf.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793147960; x=1793752760; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Hj9wRw1m8xZDK2beu+jGNNuT/mQfuIYBYNuWsqjtyI=;
        b=RLO7l0p3CDDnyv4oLW7GvFI/F1kNlt0TWN1DrHeW6P4bahfxwatOY8XT7OzU1vyDCR
         n4fYFZNZ/ODpIOXYM4Zu9qfGc743+O/1Dz7xfWKwzDybRhzlU8Ch5NurTN0VtND4zDcw
         MFOh8qozpaiIPf/etoZ4zspzqPAQdM8rotHNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147960; x=1793752760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Hj9wRw1m8xZDK2beu+jGNNuT/mQfuIYBYNuWsqjtyI=;
        b=jSb7UCxVglHGu268nFWQqy3iTvR2hOzRpDszWgNAFS9kykj1OM1dYwsc8BL3jVGHGA
         UMcNki4yw6AZPk9O5I1ZE+zylDEEFTbLlXI7Ded/i1lkAup02YmZ+diYLoBWe5xdgvPt
         9WP8y6G1G7XNbDqSBNOu9+4dyV0kHjbHz58s2YtX83zQD/9lEaYECmDHfQQoA3AHTgty
         6vRgN3ZUaDzukowxshuPX4xDqrw3o9dQYIyZHv7lpEu9SQtuYkjz6xJHuf0HSPqVxD3t
         Xk5rKQa9ak3p9RW1nkc9/zHctjvm/siOplexLE63NTMOeQ7wPx2qj9LnNaGMkoFHvkfi
         kCxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFBoM6jEpKGE5n7AG2cUvkk0oVyV0OYI+c4CmoKoT7PrBHtXpbpyNLdjTgM3D7xLDyINU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTAL3wDEaCOzSc6/qii+8ZuqPqmDWH6v3EAsonq0tL5e6o8HaK
	osoZc1L7XiHp0F8hZMvVRAufGf/bBeqqCMWvm9VnAY6zxV1ZjqVp8oVR5fcnI7W83zE=
X-Gm-Gg: AYBFou3Vea7dk14cdrsOUi7hJF9GGiS0yGVgJW75DUzLYOi0Mx1we5fSP7taA2FBML9
	HD1lvQaT6jgv4V32/XBQ5UEW+PrvOpWfk0j1zu/yB+19YfdNr3J/qxEvDLPikkbjPIZeCbwuUL4
	OHZC9jmc/IYspDHtZmk6eupR6e6T8sTUWPEhVtVLyVWQOWhRrRNZrW5AXUKIAAkyu0CSBj09//Z
	vU2hdfJ7e7JnHVzaan9ahvnbP4loQUUoWklWRGmTMedhcShifOy+ADXLEN4uK3uyccpQUl6Tveq
	IQG4oWSXaznLH/Z57YIUAtsSxBJg13byM4kwvJg7c93cbIVVIRKE6DQBtaUI5uvnJic1+MFwhFl
	5gYe3idwrnPsbKtBYzabv+mvj7zEqrNEDDVQk1HRYsibhQ6tfXY6dviSYKoFWA9PW7DgkulcpGT
	yA6Kz5nyp2mHs12fGo36aUYHyiSs+dbahAurr8A85M+wCjU5kUjWRFW30qEddDPeOdvt0uF4pAJ
	/IvcgZ5eB237u2/siZH3KqS19A2jh9fojI2+BeVlbbqiicgE8POobh1Vrlln3BH66IrjaqJs739
	hpIEndaXLfCATVFCOk9WfHs5bHlJTgH3A+rPNGMtKWKnLVmhZNTWkcpOW33eCKEYMnHvwjx6FGC
	LLXvqMOWeJUJHXIOT
X-Received: by 2002:a05:6820:1354:b0:6f7:4f6b:44fc with SMTP id 006d021491bc7-713eed49422mr453926eaf.33.1793147960005;
        Tue, 27 Oct 2026 17:39:20 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b2021857csm171552a34.23.2026.10.27.17.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:39:19 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:39:17 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Pia Park <pia@pierre.co>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] midx-write: skip writes with no object entries
Message-ID: <auFENQw2-wUmg_kS@com-79390>
References: <ap-KYtsDXXwbBzDM@com-79390>
 <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
 <aqAkfGZtLJ97nG1m@com-79390>
 <CAOWp8q6uCcVL-0cLxvf-ncydSiapheYTDnFhom3CnKiMWyfJ=w@mail.gmail.com>
 <CAOWp8q5UqPrJQosjypdcq=KX1TKcVenAOoZUYfTBDKbRUwazTw@mail.gmail.com>
 <xmqqld7ihka1.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqld7ihka1.fsf@gitster.g>

On Tue, Oct 27, 2026 at 03:05:10PM -0700, Junio C Hamano wrote:
> Pia Park <pia@pierre.co> writes:
>
> > Hi! Just following up on Stolee’s suggestion to return silent success
> > in the no-pack case. I’m happy to prepare v3 if there’s agreement on
> > that approach.
> >
> > I’ll also be at Git Merge in Lisbon this week and would be happy to
> > chat in person if there’s a chance :)
> > ...
> >> On Tue, Sep 8, 2026 at 4:06 PM Taylor Blau <ttaylorr@openai.com> wrote:
> >>>
> >>> But I want to make sure that others are on the same page. I would be
> >>> curious to hear Stolee's (CC'd) opinion on whether returning silent
> >>> success in both cases makes sense.
>
> Has anything happened to the topic since then?

Not to my knowledge. I don't think that v3 made its way properly to the
list, as the list archive does not seem to know about:

    <CAOWp8q6uCcVL-0cLxvf-ncydSiapheYTDnFhom3CnKiMWyfJ=w@mail.gmail.com>

Thanks,
Taylor
