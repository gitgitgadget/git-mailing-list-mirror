Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182622FDE6
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744393; cv=pass; b=EOfepZ9UpjxkBGZeCKGFVziBVdOSFqMNdeW9jFqFAmwL4T8hSeTHvb5TcKePxga7Mf47MbKUoV9hAXJ1nPWMH+Bk86xhSDOvjfw5l7R2vqBVoOwQwSSeRC9BfMO/OTRPbf8kXC2RQASGmhHZMVGsYplamQp0HnyE8uG7eoXHcQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744393; c=relaxed/simple;
	bh=DroxztANo/kRwug07qBmEwK9TuKaFjlhNIVpZ/VJMgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxjowgyzqiPtbiN56jSuFpqWG+tazOp7CQ9DluaZakXg/lnUu4xWi+oWzYm2qc/2CCSsfIZUkNDSGcPW+Kx+oLvZAdYxD8tKMJy+lqydw2W/ir842V3MXz4N9/G33+25pM0/TBD+8gZYuITRuyZ9ZqxdItNjrkxmdMp6FJlpxTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5Ki3gXK; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5Ki3gXK"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7831116a5c0so172305137.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 04:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787744390; cv=none;
        d=google.com; s=arc-20260327;
        b=d6Ddt0qQU0mz6oKqgvmRjoykubUdDMmBponDYE4nCDCXEk9JAC0/yK1jMoXqvxCMP5
         LSJZXOmtJecZmfj/JZbg/9OUh5ej1sSXjhkEdQlttXvpKRVHWeAZ5f7Z62s/qNdP1HWa
         tf+H0EjUtusDJzMPqrbP5QxzOZjOtZWezuTFrgA3qjLxYw/WOWxcfUhRqsG1LvldvEbF
         eaXfQqkS3ADNWh08aARnWSsCyLNEfhzDkwycQd70f0zFbGmwnkjXOd1M1kBRtPzjbVL/
         KaXPn1cceV1EvMztrh5/fnVtwr0xJDVb548+1avcwFpRfxHmTgKROXP1Im7agzapGLCI
         LXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DroxztANo/kRwug07qBmEwK9TuKaFjlhNIVpZ/VJMgU=;
        fh=pLaXRNpH4VzdV4p3RWNeD078jFmBOob0GXNvrMaoVec=;
        b=db9CObGf8kNDF1inkwABstALvrJhBMyXTOg/zSLcAAvK3f9pQPgDGMFQ6PsN2T4jfO
         C1NbjYeBx2rCBSr/kbCacNv+tB9rhAemKkXsI56HwYxHBm/d9jBfSFvDDrnA6I4Cf+AO
         FjyrjtS/KGbt+vV0z5ol9lD57hbWhne+KXKbZo6g0hSmAcGu4zFyhVWkwdbfJXcCM0cl
         SJISj9Roc/NH72Cv7CbnYmDBObLvaOH7mNfw9Y7ZoJPfU99oxd828XHG3xGclJ1u4iry
         TR2VI8txkesD6GMAbyeeHiyzWWkvTCHoTMt7/VaH8+jNGKCGrqR+PnVI3w7vR+WhCQBb
         S0zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787744390; x=1788349190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DroxztANo/kRwug07qBmEwK9TuKaFjlhNIVpZ/VJMgU=;
        b=T5Ki3gXKaSFAtnkhWDznN35b2SMQm+a9otJX+5UHRObj6P98eka73dfTuhIKbbDGhR
         AE7HqnyO/RNVGGtZnVY00JLyS+zw8XxC8/zqurmdjzd1utZNH/TvhvHRh4Tthek6A4LG
         hRS26fS9FN/fOd8nctqshcFwpSNbMrhRNWnC7h15rtLrI1rIw1vSDg2/xECArBud/zIq
         p2QiDuLnnsAhoDmrbpX5/Hd2GpbhMK1CrkIY9iXbZGPPodKrVcfvzLw/VSiZbduYZJNW
         W4/FA0hu2kpIoroZxiAWZpigOrNW0EMPJqowHQUk2Hqk0t5v1G5sTrXdLAPTlJyI4gY9
         hcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787744390; x=1788349190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DroxztANo/kRwug07qBmEwK9TuKaFjlhNIVpZ/VJMgU=;
        b=BxbIuDEBBfYl110COk5j2qz08NGBmvKZ147istg6VSyjcgo6cccErEeKABFJ4DBQrE
         neHXkrKSyMj+sARsgvM9MICuNqelyQmW2OzMCEU1osPwvdHgMc+kZ+VVzkbucmCs4tfo
         t10i2BpiQtEgHNzXZLRUSmugSDaurO95ezlW+2L0+b0P/MfUkxHZ9ll/pJ91oLvYS3R7
         /wRRIApBg22WpmNpDJL8cTfzEH3kGAX1F6NtcEGX+XR87QWY02rPCfWZoxlnLy1nJytl
         UX6TC4nVhX4tLEIoXPLajQjbT4BOEsfdJAaZAGedxQjQwCBsYzEK2ldJfAg/dVUvrInJ
         p5iQ==
X-Gm-Message-State: AFuF++lkOz2aUthDQVpW6pcw0Jg3Zsm5WPEE1Jq+rdV19pbcd6NGW9DE
	c1fae5mVG5EoY29/eGl/2leQTM9hMd38r9q/TcyWjwjbytKQGRDNAszIpdp5XC3S2pwJSHzek7u
	CTFxtLUlR3zDR2Ct+S5AvF+jgkSj4CA8=
X-Gm-Gg: AR+sD11zu04Y7+S36eXyJyK036qDWwoJWRxGMYswyBXy3E+SPxTB/jGAgdDBvQGNy01
	96eQQcWo7m9r9zrwj4n04U8klBv20suqfPlADC+YipHKdoHZ603+4Bx12Jk77ZsUqv2Z3qH6hwq
	UeK1IxclfNq2fQfJEJqdOXh9StdSoDT+RFRPSyzswHpq5awOE2rzgwLdiQpiTlDajCmbiN46pd8
	MhyczoLYC9+hAxdxHDx4TnWzjU2y4pTPPJcITo0aCD6L83S82Pj0BTupxtbVht1rIfyr9nqXana
	w3IMiWzKoMMpCCWfOIX22BMWoq81ERa/GRU1LjXbsI8Bz5elKt4v13w1pZgnI2+Ez9FXwtCPPpo
	tBg==
X-Received: by 2002:a05:6102:5087:b0:778:9b9f:f434 with SMTP id
 ada2fe7eead31-782c1a0490bmr1957802137.11.1787744390294; Wed, 26 Aug 2026
 04:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
In-Reply-To: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 26 Aug 2026 17:09:39 +0530
X-Gm-Features: AcwNN1UJdkQtaY10DVaA1sLvGdaI_NUjwKsuiJ7t-RsuJk9n3ws_383ZtMSFLQ0
Message-ID: <CAPSxiM8Jet5+4YvgSwCTK92fTmqLMj73nupY1eskWWO8i08fvw@mail.gmail.com>
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:29=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi everyone,
Hello
>
> Open Source communities have until September 11, 2026, at 4 pm UTC to
> sign up to participate as mentoring organizations in Outreachy's
> December 2026 cohort (see
> https://www.outreachy.org/blog/2026-02-06/may-2026-call-for-mentoring-org=
anizations/).
> And (co)mentors have until that same time to submit project
> descriptions.
I was already waiting for this.
>
> Last year the Git community mentored a single intern. For a long time
And to add to this, the intern later went on to co-mentor a GSOC
intern this year.
And also will be presenting his project in the coming Git conference.
I was also a previous
Outreachy intern myself. Because of this, I believe the program is
very much valuable to the community.
> GitHub or GitLab used to sponsor Outreachy interns working on Git, but
> last year both declined to do it, so the intern was sponsored by the
> Git project itself.
>
> Let us know if you want to help as a (co)mentor or an Org Admin, if
> you know a company that would sponsor an intern, if you have ideas for
> projects that we could propose, or if you have an opinion on Git
> participating again this year, or on how we should select interns,
> etc.
I will like to be a co-mentor again this year.
>
> I am likely to mentor and help as an Org Admin again this year unless
> we decide not to participate.
>
> Thanks.
Thanks.
>
