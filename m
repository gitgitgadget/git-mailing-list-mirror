Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426088;
	b=s1IRdo6SU5dsgqsul/BGG4/it0iNCij3lmnl/DvoPe4Ecu2g+pfFOsHd+Ywd46DqF+Y7
	 ePe0L0jbNFlPz8/6QhaRU4DNkGb8uwURPRFw/vTtqNXHGNlTCANM+cYB8wLQzML65pC8c
	 A6ImTPpGsTMDyQq+KgZ2K+A268JmdQ2fLns9wMQ+unpbby1e35uK7eBkvMWC88l+SuPA5
	 3w7ZAN9aI+XIFUKO1ixLKWRGRsh2JEMmMvfruNL4kxS8FW5OLwdMVBzYClpeIvwehCeEt
	 eTVacA/AHTzMGEMWeK3esYJrerOJjs/8sD2vplQj8ckTztQBpguM7cDcM3zaiRoEQtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=UxUdOmfFXckGTEzuImnqibz4d0VTXhvvBgESWizjSgA=;
	b=hVBq1etUYky7R8UPGrBs8AYfoLyuc8XYn32H4W6GLzZGJVTB6cxeduho+OYoeI1vpYvI
	 FhLxckMDHEJXNL7V2fCc0w6qpxV3GwDN4CrbXdGIkAcvXkrvDQMFgBdXjFGT0yRlZFYCW
	 jxSqiu40AepE+MKSnkAjQ3oCbDj2s9HoOVqFjyjT30p/tHzxmuNYvozfBjl88faysUbgX
	 14YDeswoS0s9exwsre7pfh3ee9KOZe3l9BkKZ+8sb976TXIIkU5OiNlY3vTLK2HCS4Orm
	 sOM9YotEyS6cuPWpRBjqsJUdgfqH62wxj0zqqERCL2ING204UTVu5gh5eLTguZ/sM8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=at5HOHr5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666BE606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 09:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=at5HOHr5
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4eab91bcaso15531417b3.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 01:28:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795426087; cv=none;
        d=google.com; s=arc-20260327;
        b=STv+5KAk51zEElEat7ExgRPSBYMILBEWNj3emghkpfTO0rsbY1K8BzJin8rNTfV9KT
         HH85vqv/lllBAUbQqAkf2pCDGvudM4XifD/ujltgI5Tao0Lv4KIdMhwEqXRuc+WOX6ji
         qZXep66AvSOiI+0WgxdgXJytxBYul5igu9Kwk9u8w5zFaY1LVdEe43x49rpTJlbSpK8s
         ufXpN8UNj9qnIJuZdASUq8osO0i8hH7sNVdrFXz5aVCoYufKm+bo8Lqxcf8SdSYwHDMe
         xntRVGRA5U3q6dZzHI1rZMPy7n1cmu3+QoqDKOQVW7tZkMn6vcg56jnzaZpF6BRafTjG
         krow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UxUdOmfFXckGTEzuImnqibz4d0VTXhvvBgESWizjSgA=;
        fh=Jay/mZlYZTCCQGHwzGgA99sz/nck/N18IsyC3nEFIHw=;
        b=ORpZP8GhoTZNMM+1v1kY7PrxnGH29W1j1eBHK+//tZRBLTFwFh1SWbl31ENopZFAPU
         3mNG8EnRttrdc04X5xSR47TAO0JyrdW3/ru3IGD7vGLuW7VaduRO6fETlC41S1NMoWwf
         E43YG8FEXm5UR5QAtvtz2rnNoL139UhiDOu/yg5wBzP8rR+zpFG7wuDkuMF4MyUBz2xK
         i7gI/AgWJRszoRD6zmo1n2CtjU93qvV+uqBGvoUXREElM8zMkaiNlRy4lIBfBEZg45SU
         gixuhurGqBLjlr5voMvjOWUySn6Nr9ZbBmdZf+OaMWoGhyNUPMv69b59dgrHGJrPCrDp
         6QbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426087; x=1796030887; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxUdOmfFXckGTEzuImnqibz4d0VTXhvvBgESWizjSgA=;
        b=at5HOHr5Tg1HzRl94jNd5574Rj2ZoXkgoJuAS+RJAXH4sVqaokwfYtuiSszNxXZhRQ
         qImedkJ7rS6TH31psiNyWr2GMGlCqqmq3SxEiY6xhHmkhmmp04lVCiL321inIByYujLb
         EA6K6YsmtQ+zdVyMkWQXAI0safb64RoVuvOnFHwC5uEcQTEUA1Mzw70ufWZDI8AjAd67
         njetc788rKdTCZDvsstEN9m/A0/iyZWvzKeOhAEM5EUsDXfXluZ4E8XGHn3yILqeG1Ve
         Z0R0PuPLMK5o/3MBYYVGit5fTCRkkaZSedrJ3ZLNPsQ2TJ/3j+a1RHeOsdZZw2nhCV22
         RGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426087; x=1796030887;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UxUdOmfFXckGTEzuImnqibz4d0VTXhvvBgESWizjSgA=;
        b=NMHPyRcHeH5eyp3GQfOQ0g+n8poX8TnC/G9gFZ0gdg2qzvb3ecnqK7wkMwBfbIJ5Yo
         Ew1kbhBjPtPH4JqZeR30wklSypOEdNY4JAfFfW9nVcu8TK/ayrVNl+Y6EEYfPzz80P59
         qGxh2MSeS54qyBv3m/5ACbNSahQ5c+H2j0olPseCLab4tiz/0ETRDpzaeUJ+WFVn1jcI
         xk6YpoxIy0hN7YpaPeRYAo2OqiIsbzi6Sa+dK2Igv7mYkxpHq2P/tsujHNZqrVWmBD83
         sLkC/ahrxKfrisNz0VSz51wV9pgvQ/7VJ/HLFOF4o+RbN7An4MNBf9Feh62J0z/2hFdY
         amFQ==
X-Gm-Message-State: APuU4Z8Ts5HIZ8xOtc3uYuxgLTUu4wZXMiaPYKb5iNrnygy7wi4Gdv1u
	0ZX58ieHICWePLFzf4P6Gyv1tQnC7k6xN8ntwsCdnN0XKrV2DMYWSuWl0UHkxUaoRUjZbKA5KDn
	P913ZxqzoU9x6XhEtexYoAQyOeR0dQ/6qBiy1AVM=
X-Gm-Gg: AZFdTZd7EGchjcr8+/eWfJBnwzAEIAd3iLrffs4SC0smTxVijC6Tfwt2Ys2gehfFWEO
	Nz6kRKT1Bxc7iaa+0Ue3Kdm58UwYoXH1Fb95LsMUBP9tnVPL8zwRm8Pz8E+JjSVYbAtYcsboMh6
	2uFMJyF5ya1+L20Ey9WO2NIxjL1EvQZu7mbgK3um7Mguoxhb8wtzTymCODhlH9ud2/lp39s+CB4
	PqYaz/3hKI90EXVVdDePp+WWRGBaxi6Dd1nKJT3Pho+ZU/JQf20zBhGMMJ6bOgdGtamNqT13w2/
	7jDWvPEGLT1XO7xiPy0snmMCUXoX++6J4GL9DTZmtPaP+/7FZkEl0bHOESsig6lHe6A7inbfAl9
	PdQXybS+shb1VOPPIPk7brRuM5vl0dIJs9O/4i0J0oWkOZFJZeFwQXFWT2hLlOCJbRxPsFq4BL3
	FgvThmlQxEKIQ6rT2ZwPDTeH4jNYIYNsB64esiHADpczgF90M0yeu0SF0J5If5Vmt59VS2cNZ1l
	Zsn1qCGIZUOaClebLELDmdpvUqzZhQAyLyM2TCtQxZcvn33Dtree3B919tC4g==
X-Received: by 2002:a05:690c:9a82:b0:8ab:4a67:71b9 with SMTP id
 00721157ae682-8b520471e71mr44937937b3.29.1795426087245; Mon, 23 Nov 2026
 01:28:07 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023211533.73433-1-okhuomonajayi54@gmail.com> <20261104090534.21838-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261104090534.21838-1-okhuomonajayi54@gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 23 Nov 2026 10:27:56 +0100
X-Gm-Features: Aa3M54oD8kv-G1P-xbW9GzyIt7xWeisZF5BtBy1jA4UwvSc2pTr3R7LAiHHgz-Y
Message-ID: <CAFpMFfDjuOSXv38=Y8zMQ7KCNmpr9c_uW1AYt4cpgd8iMA0oVQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 0/2] checkout: make unique_tracking_name()
 use the given repository
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Junio, Christian,

Gentle ping on this series. It's in 'seen' marked "Needs review". Is
there anything you'd like me to change?

Thanks,
Okhuomon
