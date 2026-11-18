Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795038838;
	b=v5rtBO0JVz5dtucCgqTjl5hp0oe3+3YRYFHK4utGcqu4tTuhr38PiQXi0HfDOFVL1biA
	 K6Xeyd84hT38BX+B6pF38xwXgfFhDiWtKJ3QpZpXRLVFDMARdI1aoLaEllyOI7sKMn3Xw
	 UXdJe/ObmxyJ1SL0Z6WvYl2I17cTmqxtUTMVWA75YTXK+kYtwIM2LY76CqvwoMWbuxxB1
	 RRAWVHSUNOdXPNzuNkAOPwPnjg5N33sdXB5JCcOYs2mD5P/YgcMluFnn4zieSDthCydWu
	 AzlBFVnk9FIHV8YQq+Rqno271lAim7uxZDRfu6KiJf2GyXrYgK5TALwUX5NmXeoqf5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3utI59esk9Do2UVXqwHIUnjIsN0TscHhN9CtcZmOPWE=;
	b=E82pdqlsXUaPGBWBvwSh/3mt/7GW25a16eEdJ+XbBPzYFpCZ2MoNeKHbRFWYnr+cuEmr
	 8E4Emb/4G1KFJxzKubsEHhi93dZvuc0+TzY3n8qKfWryUJMw4hej/NfNsh0etBMq7VXHI
	 RctqMYQbCYdg77sAF4iWMIqy7sBrEJ1JIA/ZkTl7Oigr1FfpBVH4gcjNi3weF8bpmzTgX
	 JvyI4E7RYg4gIaCYBmEtWKkVgBtmrolJwqWVKbsIhhXg2J4cItNu1gSOtfwixSPDR6IXP
	 kSogxAmazLnACNCx9AEjhW/k2T3xILP0MtJXa3L8EUSwK1foW0spNUWT2xA7Ik8mGlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Olp0yzcU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A13606A32F
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A13606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Olp0yzcU
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso4696a12.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:53:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795038836; cv=none;
        d=google.com; s=arc-20260327;
        b=Ktx9Uf3gIs9OgoAzmOU0ZIjnRyAMUe4ayNqhIMOkIggEk3pbZthJ3+cWb/JIVTfQey
         5dLZAJMD7TpQmUutkKOvjRy9oj2CzJu3PnI3WIF4v9nvzdsd6YAq3tU/OyD9l9EL2bjj
         Xxrt2NHsA6y7Y24aZkW4GRX+0rvm4E45r3eT3sm47m64D/a0djF1DcglInu1bOIQWq8B
         Z/SfIm44P5PNgpQJuqqepb8NFtOxLqYMjSILTfHWCggAc984QdICAXliO5jyRUiMf4Ri
         Ux9oJ0GwjGRtVhTt7o6cdsHrg9mftTHOCDPuiBROnvGSIs6oshXYig9na3zZtLOtdSLE
         zu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=3utI59esk9Do2UVXqwHIUnjIsN0TscHhN9CtcZmOPWE=;
        fh=48PGvb5NE2dTnmlWbSaAm5o7sRpISRm6A7sqNhF/57A=;
        b=eUnHaeAxlk9RewlO+C39lLQfbRB8A+2c8NrUPPLegqtifxa+igH/IWBq1N6hfGuuG/
         K25N1THFnF8Sb0C+TeiPucQaOlLpVxf+hJvOVQ3FWF7FEdeuusTFQ7IpzQQW9Tsh9zd0
         2N6D/flDIJP7tSIvSgjMYrPxWTNrg7LYA2uQ1Xs6Xorx1Hl5CgQd3+fqYm1czI844+Ig
         +VGhkB5POt9HrDIyzsp6JGzIXaoAg3LQFhktGGMT8xwfL0/I5sdWtpdQIRKU9g9ABVqe
         91cgwH+ksDO6iJtyvWQfwSZOgt5z46nGaX/mjMpah14UQG1lKaweQnfOPcx3YqkaiMiR
         FnEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795038836; x=1795643636; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3utI59esk9Do2UVXqwHIUnjIsN0TscHhN9CtcZmOPWE=;
        b=Olp0yzcUEWbkCELJs35GkyHvnsGa6H19s88MJLOx+JOJVYkeTBOdTNDvfcZimlbwOy
         HCDQ6ImM2RscoBkz6PyzCMN1Xa6YXclmt7RblTP8GvNSD/8kUde1Z5hXZbDNkcugSDLY
         qEpRa8qDx9BKu/P0Zf7/mB+/kpRXb9rqU/6eJUgo7Z+/cJ0XWa2fRcrfAfDKW4Eunos1
         oopZEziBCcWs1DFrytiCfeHOMxJRO29wEAr912CyAUFX0S6bKlYNBLeviGl0btv6xlN7
         VJbcgodGAWk9+OrKiClCPRKgqJixp7d4E0BUyRVsTpY3zMO5iGzq9mCUOSM9LDYhrLUb
         QIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038836; x=1795643636;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3utI59esk9Do2UVXqwHIUnjIsN0TscHhN9CtcZmOPWE=;
        b=sFm2jJYXcy9sHJ004P+ktGSRnJiIWXh+Zxyu5vBTgYWnKBGsyX67+DxzvpRKTeYArr
         gy1YrDYKQssEZ5QLYHjK+cGCVNrlquEZFPAXIL9pQlAqZLcvMMhbfpepJqU75/uBJLNH
         +a8L/foVallbhGE4URfjvvU7w45+tsJJkdaZtKtjcLq6YSQ0aCO+JbHVcmRD/xu/ALlc
         6NkCuKrGP6y6fvo8RdSwCdzufrB+3dVlTpJqTy/wD2q9HA1l/MvYtverWFg6az4u3Zkt
         PotNuMGmTQ7EE3pl3tVbiNMCu/zJ1CCXFuIha+I8WWZHzwbU+8Iq1sPCbI/QcXYhHoH3
         Fh4A==
X-Forwarded-Encrypted: i=1; AL+hErHiJCDg1f4I+Ley4iEEAmMIDQRKaKUW3DFhNwL18UGpwX5ubdLbZgsyaGhs7GtZnUpzo9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hDOJVqtHb7gJURLHDl6BEOmxE2ysPSdzswIP5K83fdRRy1hEu
	LdWtAuDDPEzjhe0zF8jpY2buqsAKbS5MQIF23DQ2LYDBa0ZeyEXGw4ux6WsdEWVnDLB4GvlmncA
	YTdfqiNPL/lHnehyfz6e1OqDh9dkIYZLnqqe1NY4e
X-Gm-Gg: AYBFou0cw5zvEnEKnlQT8ZzxAFXplz9l7GToYaA/xTg3CnkKB26oitkJIIg7rEAtPny
	ND95rDk78T82Z2pdlEy/7bytqclhSaXVqizi30NVVQ2i4H/RrKRigEK9L+Hyw8ueNfu71pvW37G
	xSe3zcRxggYeB/H3bYk949jcMF7wmh2nItHDFK5Cj9VFpYOZLXOf+W5KHHJJlaEyGorLVQ6b/ju
	BtcxEQH8YUeLWADGEi6CdOylgPEs2VWP/+VjUm15kMD/RPL4VSDHrcBWkyh3duFOmBWokeCfVbV
	1j6YEM5BPAyjbjYQI0MAEPTe2btyj4DDqiI7QtJcJmDBN3MGRPpZ09sJmcM/Q+0IeWMcVriKu2v
	8RBz8HQxuIxdB46exK0EhWULiknaReEkmn9ktwlb5WZJ9ib+7xGqKcebfpBq8db7hbX7Fe52ts+
	SyWbUY/XPY7jgqA52ICnLVUqRr+FneNHQ=
X-Received: by 2002:aa7:cd55:0:b0:6b6:ee14:5096 with SMTP id
 4fb4d7f45d1cf-6ba0fa6fd32mr5467a12.10.1795038835767; Wed, 18 Nov 2026
 13:53:55 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 13:53:54 -0800
In-Reply-To: <av2TY6Oqm-LzA5NW@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com> <fe1e847dede7579da911b5a9ba16c806b5332723.1794022836.git.gitgitgadget@gmail.com>
 <av2TY6Oqm-LzA5NW@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Wed, 18 Nov 2026 13:53:54 -0800
X-Gm-Features: AclHuK9VPcSIdtWSAv0yrNvYOsqDFpZqA7jausw0mffKwaNA9af75ztZ5nogHXU
Message-ID: <CAF+mdicuQMM_P2xEXOn+PsVSo6HxaDV+-6QAXTPJG4Bf0NvKJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] http: add exponential backoff without Retry-After
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> > -static long handle_rate_limit_retry(long slot_retry_after)
> > +static long handle_rate_limit_retry(long slot_retry_after, int attempt)
> >  {
> >  	/* Use the slot-specific retry_after value or configured default */
> >  	if (slot_retry_after >= 0) {
>
> Nit: a bit weird that the number of attempts is signed.

Good point. I will make attempt size_t in v4.

> > +		for (int a = 1; a < attempt && delay > 0; a++) {
> > +			if (delay >= http_max_retry_time - delay) {
> > +				delay = http_max_retry_time;
> > +				break;
> > +			}
> > +			delay *= 2;
>
> Isn't this the same as `MIN(http_max_retry_time, delay * (2 <<
> attempts - 1)`? Feels a bit convoluted to have a whole loop for this.

I used the loop to avoid undefined bit-shifts and multiplication
overflow before MIN() runs if someone configures a large
http.maxRetries (for example, 100).

Thanks!
