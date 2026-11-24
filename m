Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539776;
	b=vm7Pzryb7Id4QNLIPL+O3GU3C9gubNoATrqXHQif13WM6uJUqKGE8czr8j/vdiKC0xb5
	 QtNTCFM3xpqiiobVTlzD2wGFSvVdh9GlA/c8TYx1K/Fgv9DU+4+mldNymVSP6e8OxHJCf
	 uJKX104YxESOP8b/1zzFHV0j7gCcm8PcWq5kpRh6cIOixw+MWx5G+9y/qcFC0C+2REpzM
	 DntuRKn0WhQ2Ss40BcIJX/Wf6V5sHhtWMj3xzb6P7tEJxCAO27JWbsFzcQr1CBwPSFSn3
	 d8JJDyBroBQhTeS0G4KuYCnRiR/ItI3cfan9Rq9iXCs3FmAtKZp+OsLH9pdssxCBYjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TF7auDeQ29AW/Mq9zokPaF+HFqH/Pt8PSwTRwfNdgKA=;
	b=lhWIgOrwsELziMb1y6qz3beSrmqHedbwjtOS17VYr4xJ2ilt2yv1FUUIHrBcXHq5mfKB
	 Nyd+TUy2TLS08rYd51lrF9MAwL/37BDVanOXNfcfIcwVY50vMzeKB+SeuOWDjiFfUaojU
	 jmQDR4Fg2UvaCHoiaxsYf3sw7i+3nEImsXIs0tsVdObd54OH8S3BBPN32/6IRTZs2AWuH
	 AMPR6o/RKFqxyhYMy2rXgEhBwgxlQR5PvCpact9kJAR7dwm+2VJnk5w1F2qkR0O1AoDtg
	 oPN6mKWlXiBn3XfzeKTWMA4VrX07pu5lJIcuQJW4lbzg1ZikJP/dUiT6IOt8x493ZUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p1sg/QGU";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26B606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D26B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p1sg/QGU
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso2223924f8f.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795539775; x=1796144575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TF7auDeQ29AW/Mq9zokPaF+HFqH/Pt8PSwTRwfNdgKA=;
        b=p1sg/QGUwx+Xx81oYrceoYmRONK8z8585b9C/0FKFzrtCaD73a5164aQyGKFrc+ida
         u6Wb9CaIiu2MbwnjwheP82Ok822WVsxrQnSJK9OCyVNzbPRcLS0vEuTh741q2uF1h3QD
         nnfkveLB3tNI/fTfJ+s/XNJJyq5Cl14Zo3Q+XVZ9WtHixaBbPPMPNNLnhHs+KMGGTaTb
         XaakSLFA5Fko1D/cNozDJG5H4/M1wcOW5vl/v3gM69lJUBmfDEiubUx6IvjSOjeJX2a+
         0LRfrag8w9KuSvhTtUW4obyEaJkrHVD/G53b/ETy0LhL/PxYDynxuPWdCSofIkmRgNsK
         fVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795539775; x=1796144575;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TF7auDeQ29AW/Mq9zokPaF+HFqH/Pt8PSwTRwfNdgKA=;
        b=2m2xhIiXbRQCf5x5AVe3y4kprelYNLka76e+ahXNgG1G7VRrJnBcg+I1EeIdgn3wc3
         QDrnmW3DuweOyC3l8xFCYeMXIEmDZJyu9CB87b8cV69ubkhYxMEAnJKPl3YnBibY5MyH
         I7YRKBQwaXLBC1AZzTwaVNqFnyawGjZEOYEcd1BSJgKDTEX0iio9H58Q6I9vW+Mb5vjQ
         Eor1ChbVMLaASSswInKK4lMsMEXvaI5cPQopsDy4eqs1vOjMp7wALVUpzF95/i/7iwQa
         VURR16QME0/x4Jtug71JzwI2ay09g4w3YHf7KazMCL+l0qHdKmJBrimdVrreCyLN3+GV
         YB0g==
X-Forwarded-Encrypted: i=1; AL+hErF/ZXOsb6bE6v8ewWmYRPXWYwBLp+mhcn/bbwgCslN0AwHXVb1Lj3rmeUAzLBJl6eWxEDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z99g+VU0h4VAJ5VrOVXKEzqaSYMiCx3nPmuDkIvptS/X0oxL7Ns
	mkc1YMeGlYJ6kAew73Fs0qtA5vZiyR4eJhHfCtyEu0OKzWItjVlhXfe8
X-Gm-Gg: AZFdTZe953BC6RhLI0yvqzzyWDwYbudI7ctT2x55gIJKKEZcMWyK6J0YOgbSMZJFyxk
	s19+dyJzldURINZyvzIrWAxN8XRcfqte/A31Lj4YQw5NJ61nAFKf1rqmB1Jdx4vCC/1SOW0kLfm
	cjNt5c2P3fFRGjnBlolrxZXHSynMhNm4mGEcQv0C/nPP4CaAxMMwtXMagpDShPyszqyPWTNnsx5
	Mz2qdkKnIE09UtKBsw3yPw6FBcGcUGEie9qP6N8DX5n59YTEQiX3vaeFWjyCU67JXBHD/16Bab+
	HpKJKWZfEY4xiJgOgx6V1DHr3lXSoKwShBIPtDRyiP87OQqe9WqyhYXXGOpLQsdEXXPmKsz5NH6
	riZ54HyhihYAuF2sREjvqZSMXrGj5/vwvmynmMpKxTQdlFFUhX0ZB7AHk2FHwIhxzQwn8gpls9B
	xfK7V2YsRDKi+S+59KnsLtmTsAWfJCihHLeaj/8JvOmdqawP2CTrQKTz1lPQ31lkLAgtokRKEZf
	hMV17+YsAdEfUvkkK1GN/xNg8/cJhgllFK8NRzI0J0nEU/6KOYCcxUVfkTkKTsR//K2bSQDUCkR
	K1gsLiP9QyLOT+BlUGVbuAdLaku9s7vEer1KwzveH51lQvdLu9tFW3anROukhWSDDOnj8xj1RBJ
	fKC1SmNGCW/Tp
X-Received: by 2002:a05:6000:310a:b0:491:286f:8e63 with SMTP id ffacd0b85a97d-4abaf7401fdmr33806698f8f.14.1795539774414;
        Tue, 24 Nov 2026 09:02:54 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:5667:a2d8:e11c:6db1? ([2a0a:ef40:724:6601:5667:a2d8:e11c:6db1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2050f1sm28849615f8f.38.2026.11.24.09.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:02:53 -0800 (PST)
Message-ID: <9ff62027-f0a1-478f-b038-9ece951e6c17@gmail.com>
Date: Tue, 24 Nov 2026 17:02:57 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/4] diff: use size_t for the allocation size of
 word-diff buffers
Reply-To: phillip.wood@dunelm.org.uk
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>
References: <cover.1793352943.git.gitter.spiros@gmail.com>
 <cover.1793439137.git.gitter.spiros@gmail.com>
 <b27ef2a8882c2badb88d257ca28ed38b67c13c1b.1793439137.git.gitter.spiros@gmail.com>
Content-Language: en-US
In-Reply-To: <b27ef2a8882c2badb88d257ca28ed38b67c13c1b.1793439137.git.gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elia

On 31/10/2026 10:16, Elia Pinto wrote:
> 
> @@ -2192,7 +2192,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
>   		regex_t *word_regex)
>   {
>   	int i, j;

I've added more context below where you can see that i and j are used as
offsets into buffer->text, so if we are making alloc a size_t, don't we
need to do the same for those and also buffer->orig_{nr,alloc}? There is
a complication though, i and j end up being converted regoff_t which is
"a signed integer type capable of storing the largest value that can be
stored in either an ptrdiff_t type or a ssize_t type". I think that
means they're likely to be bounded to INT_MAX on 32bit platforms which
makes supporting buffers larger than 2GB on those platforms tricky.

Thanks

Phillip


> -	long alloc = 0;
> +	size_t alloc = 0;
>   
>   	out->size = 0;
>   	out->ptr = NULL;

	/* fake an empty "0th" word */
	ALLOC_GROW(buffer->orig, 1, buffer->orig_alloc);
	buffer->orig[0].begin = buffer->orig[0].end = buffer->text.ptr;
	buffer->orig_nr = 1;

	for (i = 0; i < buffer->text.size; i++) {
		if (find_word_boundaries(&buffer->text, word_regex, &i, &j))
			return;

		/* store original boundaries */
		ALLOC_GROW(buffer->orig, buffer->orig_nr + 1,
				buffer->orig_alloc);
		buffer->orig[buffer->orig_nr].begin = buffer->text.ptr + i;
		buffer->orig[buffer->orig_nr].end = buffer->text.ptr + j;
		buffer->orig_nr++;

		/* store one word */
		ALLOC_GROW(out->ptr, out->size + j - i + 1, alloc);
		memcpy(out->ptr + out->size, buffer->text.ptr + i, j - i);
		out->ptr[out->size + j - i] = '\n';
		out->size += j - i + 1;

		i = j - 1;
	}
}

