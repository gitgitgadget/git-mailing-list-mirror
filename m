Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941113E0C61
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179618; cv=pass; b=n121MoMVZPhB9m/JNrqoozw6S/oBN9Bs76gcw+nyStjvIFn6YJxmFyHlX3WUo7Zxs+ElmGh0SBkb2ibGtaVU8JSYN96DhCESgfNJFGuev3x83Y6tobrMAhcFY047jo1g1UU0sHNzx2u1PEfJF8HTynczxBE9WI80lto2Ubinojw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179618; c=relaxed/simple;
	bh=UnQa3B913+4+MnEF1Cr7UXtmxzyDD4QJ2Mwoc4m+mkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1QbKhhm2GnO13hSeiz5ZxYT5mn59uCQgTnjU9rk5CetMu49QZVVZBrLXYEJVew5I5o/kpN116irBGexM3pYBIRJuECQdmli+PRjziArTlsuEozto6IkgDH0nDnWTP+PqNTXaxJixe3IIFQ3oxIcuO4xAKEK37jiR2rGsS2rdG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnS1RYnp; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnS1RYnp"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f9568e074so762599966b.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 01:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179615; cv=none;
        d=google.com; s=arc-20240605;
        b=ebMa3wsMVn6JPU9GKu+vTmytE30jNgfkAcfoyvDKfKDj5t5Z28o1HzlECXL0K2o1hA
         Umgn1wsO1z+SE7RjxQeIZ47I6i6DhZ8qDOlp8Giamyf84tRjfeVOjBENpae7bMhHcg9d
         chaFr+Npzs47DCZ3c+KeVBOFaZCtXdgrPZpNeCh0IxJIjpCTADnSBY+TMeOl8FRqsuFs
         3gYo50Qe0uNDn2rFvEAT53RbFXuJ1eYkgfYRQ8+fBQS3aSmiaAQYkx9BWcH3SVF2YbTQ
         oh0gVw+xVnHuJ+QKfoBa+AnXtQetUleTaxbRASSLd0rAKt1tIpuA1Dqp7IVJ0YPIOvXI
         ebHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XPzWArIY+GEij64aG685jGf9tDwYopi9avO9aDq6yhE=;
        fh=8OwT2XbjCDIX8TE0y/UX6QvISHm7GEyh8ml8LsrSfw8=;
        b=Hwm+uSys8fFtkkhOgNgoAIi2Qzwt04XwX7eHsJWfyr1pINEuHl7LHXRy3smeddLRff
         pmqXYitu4MzXRQ1CChPdHa5STkJmNrySop3LK7dextCHvhdEGSUhQp5/paQy96sQvRXm
         Mk2o4sS/k+uq/cYs88+dOkJNo5ZclY4q93qKpxMNg/YQp7jhGjmt3ecoTbh6pOdVVXn/
         Yi1lf8bssp2ClcY7HD9ieua58fxsXQSSmss9XR6LuUgjrxGRaoF4mhUbvaKJuBTbmyoc
         k8i2kGufxo05hZpdATxZGkra9ajn504B+1Ur5dAyWSLReTFRUm1HKaLYM6At6nsHe5yW
         Ji3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779179615; x=1779784415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XPzWArIY+GEij64aG685jGf9tDwYopi9avO9aDq6yhE=;
        b=HnS1RYnp8P2Iwf+mibwqE+dczQzxMoIbqPZvHQrfkxiOIFE8C6XwWNbrhw+8ZYjwTU
         0RbljvxZ0d5guIpk7PHyNuhHvh41dNlC1Ogwc8yXj1OZmdFucbOtG5vSBXtQzL51Glgj
         mAO2Gg1thwy2hRCjHxpxyP1wombVp1cHiwhk8pnSS6ultbKSj/C7QfJd9znPINizj5r1
         u27yoAjkMh9uuFQDecYgsRAEfpKbAKoWlilvowBC0q3F5XBJcq4abxefo05mYH1nbnJY
         aqM559iQO5hC8xJAp89bXtOeAvCtm4Y7zSa/VXFC7wzl574gbRRyp6LoODvspcODMHL/
         EHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179615; x=1779784415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPzWArIY+GEij64aG685jGf9tDwYopi9avO9aDq6yhE=;
        b=cNynbERfrZAgMtwXe1gjBCipn2AOxB5MaGXYmk9VW6ExtoSfkwYfwlomuSsIHqqxFp
         5xstJUClGwy7QdYFekZB5uFCtseU6dwpCVSMyIJZuzavlBAZY1EuF47P8GJNClzslCbC
         yYs4wp/GwoFWYriofh2h8X66rB5H1BCY0JBdMYh3gsMnsrz5hFzYJQ9hUMGXiXZubdIW
         OMA2GjhgOJZOS19aQxlduydTyvbGD3KjUY/10GJjY0ZQydAh0mCoIIIWVSLkQpTlAiaa
         tH0d9bInb56HgBRIPFI5YyDf5G5d5xmfFeWThY87VgI4j3aBKZkVcQrwloJA9TAXhVwP
         FyGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SvgQtrrot6hZqw7sR1XK2W5XTHfSR2wEJmA30hgIzl+/oPwCECUsqo/hcYKv9DEsw+4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdkGpKqBmiB83tKhe9IUjgbYlLunsYl+YlWxBv4pv+eUDhiAO2
	/VYBWIsOVavEwsWhfe12gmE8kqMhyRxUcXPy6wDRLdBCxO6XoJ50bevmWybU6jixx/V6PWC5dzB
	kGE2lVuI77YH2Gdfa5b4dGGq4SP8OHvo=
X-Gm-Gg: Acq92OGhhxAZwE/mEC9YRbuWp5feNQU//rPpqljznaJcEI/rveLF8+X2oXFQN9UIeo+
	6dnZfAEUj3A5wLCXGesvp+azRNIP3wwwtF6xGZqR2LbzXGLQXIgPY5+geROcHkuPJCi1Nu5eXeQ
	aXKARrbkMuIX3nwFAM+s3BNtR/GyGKsVISFMvSUjOuqezoT1EHPQ2FGVMLuShsv8JAq51mTRxLU
	0w4LjiS+xzrroxHcPqeGZ4GF1PD9n5Zjgpa3tqIQJ7nx0lW4ep4E94Oa5UkEvHD/khxIhEiyuVa
	arAwOwahg3R9q/8y4A==
X-Received: by 2002:a17:907:3e8a:b0:bd0:20ae:a9a2 with SMTP id
 a640c23a62f3a-bd51780c63dmr951870566b.4.1779179614655; Tue, 19 May 2026
 01:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v9.git.git.1778583307774.gitgitgadget@gmail.com>
 <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
 <xmqq8q9f9b5w.fsf@gitster.g> <CAHwyqnUx=59MK5zKL0uuFXKrZ6PEc1j_2WT-_xtsGewVH3gBKQ@mail.gmail.com>
 <xmqqfr3n7r1a.fsf@gitster.g>
In-Reply-To: <xmqqfr3n7r1a.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 19 May 2026 10:32:57 +0200
X-Gm-Features: AVHnY4KZcyGvBBZzhrcB5gPGcnADDNlUg1qL8WaKT8jnJyx-seTzVfJZdGLvzFQ
Message-ID: <CAHwyqnVtZDsBiGSk5rvMJGGk_KRg7XY_rJO4Q37hOxgoO_SJaA@mail.gmail.com>
Subject: Re: [PATCH v10] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > Yeah, good point. I will try to address this and send a new patch.
>
> Please don't.
>
> Next time, think deeply yourself and do not rob my time to think
> these things for you.  I do not have infinite amount of time.  A
> good balance may be if I find one issue in your current code, it is
> likely that you'd better three more issues and fix them before
> sending the next round, or something like that.
>
> Thanks.

I already sent the patch. Sorry about that!


Harald
