Received: from mail-lr2-f30.google.com (mail-lr2-f30.google.com [74.125.230.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A543C1D78
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082520; cv=pass; b=iaLXbEdqTW/XOhAZT/WhickgUy/WitYOlJP8DqvuYF3M1W7G3+/lCAwJoqbQ4ty0YwqDfHvv7iB5uVmslj29R8qMv8F6MdrLQtD+7d2/5+FDf8wqLw2ezPX9Q3Y+CFfA5ozruVNN0SS06yZ15n40lB1mGj0PT0pcbS0rDuO/1GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082520; c=relaxed/simple;
	bh=s/gcsPnq9Ttq2a50+nyC/2tnz4tCJzuqeJ5KMmgT1qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HShb+gb6hOHeghEzCak//O3lwPVekXGSYqUGpY8z/hNVbRAtrU+xHcWf6IXPJmJsjEOqoj3McTkRoLogIHUaYM0wvoL0mz3m/Wt5XzsxtuHmWfwfNDfATXsFx/OOvrqrEvHsJ1cAvWzFH9bIHLSFCxnI2Bq2htv55y++UYDQJVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2mpdZVM; arc=pass smtp.client-ip=74.125.230.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2mpdZVM"
Received: by mail-lr2-f30.google.com with SMTP id 38308e7fff4ca-3a318299b38so37382661fa.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 06:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790082516; cv=none;
        d=google.com; s=arc-20260327;
        b=jIlKloB3zxrzsOqPsFoGLEYj3NN6sjLM7xuKbCs8xkD/4NOl6ewffVR0/AC800utv2
         G+JfCrFQ9Esf+LKARnAqdJ0AJYWX12WZJJGdg18Sg3rEmtbE6AaJuI4DazCkbatFg+fl
         WGP6rgiX2NcvBxWqmZd3uDBc/jQL5g+TJew2HU7lgjysXsIouB0uRVmSvUyZTP0i4sY7
         t7cBozlcN/Nyxh3mZaxFbwHQ3VQ1IuIK03WlJcgW0vC/0OEFI6u+wgD/Y+PfWoWR2ldr
         UUDUFMkPe03w3i4KvV+zlQRJBdrCO515R9wk1pk7pYdurr9xM2DLFZX7exyttdsomwIU
         kpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zq2D1j0/lBie2BKumZyHGMLZTqqXc5IlcREHuY4kTb0=;
        fh=i0gclfDSo6JX6PYL21eZ1ctCVvmneroUVoAgPfbjayA=;
        b=cC3811M+DiLp80s/Xor3CfVlZNT9iN1lWrZx5dUPWAWuAq39tslEEzNYdrOgUD0VUo
         dCfUZD0G7vmxymTbq6bN+vSHd3NR/SoOmobWlBehLHKbbuA3/72DJNQj8iliHTg8ZPX2
         V9P45ePYhseUfGzLHyVjjhu2uH0RmW6AtDhlj4n/eBAAhRUT44lKGc6BnAPou36gdHs7
         sutjxt/8mwvICODVsvoGEmX7t7aIsE4oSsv7ZFzhweF+1x0tOkUsEBjcLEPOxst+YiuG
         JtPoBA5sxX82gmWw4j7te7v484hX8BqbwxMJxlS2O37/wG4NAOuq+nKHGYtgEoLkYjIQ
         N9Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790082516; x=1790687316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zq2D1j0/lBie2BKumZyHGMLZTqqXc5IlcREHuY4kTb0=;
        b=c2mpdZVMXC6rlfAdDUW9AuKY+w3k87xlWBoC+OMDYttWyzneSAZ47Sm3h+1f9qZODu
         e+Anlfa6YRQf+55Iq0hpd8qMog7nFxgstSX/r0O5l/Hm+MzgiyUwYaYW+hgQx+fzf8gx
         6hemu3WRSUrZFQka9gcW5uwV9MhfEtyakl3gHNYwafhUgDtZNepycOS2usa7p1Vu9sLN
         8sQhJceCAzYwZkWWFr2l+/v1NBZYoyyJ5iR/oRTnxxuTEv5mYfhj9mFRwqLQgyxspo7B
         yaCMh81Q53l1XRFqU9GH7sAXIAhFAAj9a64lAKGP149HjmuWxf6xI0TXe3nQwmLxAdGg
         6qJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082516; x=1790687316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zq2D1j0/lBie2BKumZyHGMLZTqqXc5IlcREHuY4kTb0=;
        b=a1nqP7PRplYbHg+0SJ9w5poCjykgQHWOmjmRMzhBrcum280rG0dR2AX3P09OaVDajX
         kmfonV70/L2JCrEad1UIEFHk+s3QtSC058AolZzIhCRS1a049nOVKKvZF976l3Tdnj4C
         r63UEO//Sg7Sxdnh197hSK0asH0VVFID4lLRwXH2tmaRsLkBbEK70MapSbY3eRrTeaIb
         8pmxBaG9xdNRTTXsK0kH7qsswisecA3tFavg3G334PGPQzejxetwSUS5ho5eRMNt5IYf
         8Rvr5RJFNWRna48uO8wc/fZt3TeBZGy1CTKGSwgzKVcPYIVcXeiWege5mPE231Vq/swn
         oKJQ==
X-Gm-Message-State: AFuF++lZK848ylScOrKWon3Je6gz0spCK4Dcp+QugpDXkyEty2BnYY+w
	rJLl5vXMefHxlDqycpYB8eXc0M3Hnd3UuiWeZaNz4IMQddHvJpecWXnz1gG06EtRth4wGIMfTPJ
	OGCYqxkrbrf3zI6TSX4hD6CvkJDSnNXc=
X-Gm-Gg: AYBFou3aJvCu5UuK4XjB1VFzPpJBKKKh40520dQQpoQQcx0q3AHeHUhezuexR9UBYLc
	BukacAl+i1B05DLdlLIhaEfotGpClSJ0hXW87Tzeq9X07r5fDaNYnEiatQmXibDFXWIzHIkbfXs
	KUcbnQfwE4oJm2sEipZ9HOE6RhMMSpWNA93TbSxXSeqB/GpQ6joXUBuFXPktUb8JR+lJvM4UkRl
	LltxM0owBWfxPuNnyb8QUJGJUkDS8ajMv8X3WMfEDDjM8KGBK1XTrPQk6aApENhoNEwEzQis7C5
	Q6h0+PPPN7ko8Yqbkt4B4/gh9gQA7qpJpNKeEm4IkoiDhbnPS+wVUSPR4TMNvDGsQPBNVLeMVKA
	fKp/p8aMaqYfvg4noi5gsImerqHeQ0X8wlzlJQ8ac2AGxCPY0ljhPll5Tcg2S4YrfCjp28ig=
X-Received: by 2002:a05:651c:1543:b0:3a3:7680:67f9 with SMTP id
 38308e7fff4ca-3a5fbfa0d6fmr30276111fa.24.1790082515603; Tue, 22 Sep 2026
 06:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLa=ZTN1TU2A1sgEhiw=ymMYr6Ge11cMEubSaeKqr4WNU=2EQ@mail.gmail.com>
 <20260920165037.88524-1-maciej.ciemborowicz@gmail.com> <xmqqjyoemqvu.fsf@gitster.g>
 <xmqqh5jijiar.fsf@gitster.g>
In-Reply-To: <xmqqh5jijiar.fsf@gitster.g>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Tue, 22 Sep 2026 15:08:24 +0200
X-Gm-Features: AcwNN1WOpOo0KIG4Fo7ZTT2i84-3cC3Rn1ZU9tJXF05hKWQCuc3pUahqOJonu9U
Message-ID: <CACQ=SRGicdcnyP6mFifdZgzCgoSgDPA=yrkr2gSPQ6_s7GJKsw@mail.gmail.com>
Subject: Re: [PATCH] refs: run copy and rename through transactions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:28=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> More importantly, this structure suggests to me that you can have a
> single rename (or copy) from one source to one destination in a
> single transaction.  Is that correct or am I misunderstanding the
> way this data structure is used?  How would one rename A, B and C
> to X, Y and Z in a single transaction?  Or perhaps rename A to B
> and copy C to D in a single transaction?

Good point. The current design indeed makes copy/rename a property of
the whole transacton, so it does not compose with multiple such
operations. I'll rework it so that  state belongs to individual
updates instead. Unfortunately, I'll have to put this aside for a few
days until I finish this first:
https://lore.kernel.org/git/CACQ=3DSRHthWOLVXmY6wgknOPgpQ+oB1vV-Q0AL=3DmK9m=
Xb2Xy9Nw@mail.gmail.com/T/#t

Thanks,
Maciej Ciemborowicz
