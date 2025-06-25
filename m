Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38149261390
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855995; cv=none; b=YK8Pd5EbZm4OHuUPf1f/JQOKcswPOFbBfyX6KNt934co4XcyOhgAjTnbYJXxwWFHoycYLO4EfAM1AVcrkVa1vgWyvo0dewdUzneu+aEj5Hoj8PYri39FiCNmcp2WnU1HNz5maWL94PbpbdEwyy2z0LNdYAgaPxjwdPuYsiEMjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855995; c=relaxed/simple;
	bh=n5KKc61hmEU++sdYXL+T97eUYx7AYtX9amoeArzaXwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJR4ToIdqiHKWEhlaYtHZQDJlSuTN3ZnwF+V1DXW6B8tAgWHSYG70Ld2CfEjgTGAbpQVi72mPnk51BpHyf2/HcnL2v/K9rCZ9kT7eFO3pcukfJAxBKq2HEKWDNqmBRX5b2RR6q0cYqdKGvrdE+IWI5j+fGcO+QVGC8EPgYHgrVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAnbhyUc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAnbhyUc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so3221647a12.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855992; x=1751460792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5KKc61hmEU++sdYXL+T97eUYx7AYtX9amoeArzaXwM=;
        b=dAnbhyUc1QNmFBPSEZXVqg0CWI3gv8EBYS+OMjoUTbasCXCCoqZ2v567RX554agA6V
         58ICsm4vsfvF2fvAB51MWL96quzkJq5QOawLpqU8hw33zrIgho6QK3CLcMJIwEegXoNq
         eyA8iHQzHp0HT75Kr81vCl1UafuaMmcydetT9cObylh5o3P3k9+QhpHaxZCPI9jP0/iK
         UNF2phuzDfkqE50bBMKjtD8V7Mgi68oUMEjLQERe8UH0lJDOW/bbZ0cMOyIajZR6Z1ZI
         qbCJJeRSwr9deL9Jl5MGylJEWJKWjsgFhtyILl6RHYjCMBC1ql4Gjhuj/zLHN9Zlb0rG
         g7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855992; x=1751460792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5KKc61hmEU++sdYXL+T97eUYx7AYtX9amoeArzaXwM=;
        b=qydXw5sw1jEHDcYLJ8WW5YMJxLViOGal8bGWUSZwi3g/uUG/3jpqhiMVwBt5pvp/eC
         Iu6m28JEKAo5HIjblEDCLFNjuJrPtFA8vLuzrh1QeiRnm1vLEyLTzebpANvna/Fu6OWb
         Am6naqBldEEpr8873QFJQ8uDLyNmpyXU49DNrvzPRD8vl3IGYEQTukHd/xAwttnwpxy8
         DquuIZD0ABzFKDNtcDDRnod7yHmREaIM1FAcMnylWkhy1bWgpQ7aTnidjISnjvguJw4w
         IaP+E8oRxNmexvNktUbZUT8KAsedXNfac0XlTxnPkkGjltDl58Xr4oSb5Ers8mcGE4wi
         plbg==
X-Gm-Message-State: AOJu0YwjPjx0XItoBeggRe28L9564jIQ6s01S6up2mW1y6inPevz4ygx
	MG1N6klsvkseaLYrc5w9AWUhPGefZLTNg4x1NcpD+Lh1gDJu3v0Guy+z/vjJLG3f2rV2+IUkF3E
	6qnmXMY/AnxlE7rSxkcRZaJumjjHBRynIqg==
X-Gm-Gg: ASbGnctF/V1VfjxLG6yz9QctVVtTXew+y65OkHu6hZHKr42C44M7LrWWs6neIuy5cyG
	jO/oPhBZUsCExHc7rXo7ZsmqkOkuHMg3Ek2T4VzU+5AA3wjuehyzyNOqGMI34W1F8USLNm96PL6
	UdXNwrM3JbtHl8FDErg8D2rVIYT+En9JALBoDBM3Hc4da8oIUCFteybCWr
X-Google-Smtp-Source: AGHT+IEYEtvi1zPl6Ji8Q8XqCpGrCvuLoekTd8wq6WDG2Z2iRhPKX0FTGrbAbMuKv3cp03s2bt0pVERJOFwyvSWaQfY=
X-Received: by 2002:a17:906:7953:b0:add:f189:1214 with SMTP id
 a640c23a62f3a-ae0be88ea32mr273541366b.24.1750855992248; Wed, 25 Jun 2025
 05:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com> <20250611134506.2975856-2-christian.couder@gmail.com>
 <CAOLa=ZQm+Hm_rMNJY7B4dGAuV=nFecsiPZ9N8uChhEwzb8n+Hw@mail.gmail.com>
In-Reply-To: <CAOLa=ZQm+Hm_rMNJY7B4dGAuV=nFecsiPZ9N8uChhEwzb8n+Hw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 25 Jun 2025 14:53:00 +0200
X-Gm-Features: Ac12FXzJtJKjJINomFCVHxKNtPxrrhKwS4ieWHFIjxj2Zu7rwf9fq_HSd1d2MzE
Message-ID: <CAP8UFD07pK0iAY4cqu4gCAASeaJRtu1+FhPtgcbJBP0Th72sKg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] promisor-remote: refactor to get rid of 'struct strvec'
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 1:53=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > In a following commit, we will use the new 'promisor-remote' protocol
> > capability introduced by d460267613 (Add 'promisor-remote' capability
> > to protocol v2, 2025-02-18) to pass and process more information
> > about promisor remotes than just their name and url.
> >
> > For that purpose, we will need to store information about other
> > fields, especially information that might or might not be available
> > for different promisor remotes. Unfortunately using 'struct strvec',
> > as we currently do, to store information about the promisor remotes
> > with one 'struct strvec' for each field like "name" or "url" does not
> > scale easily in that case.
> >
>
> Nit: It would be nice to mention _why_ it doesn't scale easily here.

In v5, I have added the following to better explain it:

"We would need one 'struct strvec' for each new field, and then we
would have to pass all these 'struct strvec' around."

[...]

> The rest of the patch looks good to me.

Thanks!
