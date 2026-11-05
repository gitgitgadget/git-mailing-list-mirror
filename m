Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889435;
	b=xjs9Jth/OX334QoCkZmcdx2nwkFRzbtunHSVCd+09rjuUreSJOupiF9cgMYYX2lkjHe8
	 h6Ep0grIokHtReq82cv7g1Z3j2gcJqCjBvnBZW8llGJ2ZygTnPHwC/VJYfSPT6dUqwX1C
	 n6wUHZKMX/Azb3a5pevSMgpYSeZRZR/0d85IR8ECgYlNyYLeWwISuuFF1X7I1D1xZAtqc
	 fh2GAhX8HQNMlw/FSWHngeJdfUO8TRBGbGJ4Bjd3zvDyK9agDNGKgHeFGHfi5gT0u9mPF
	 LKC70abV3xHWwL3LI+b/yZuPqKx1F/SLNBeAuPJYyImaw0x1pombNX8zWtP6vFef0Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VQFLDGZOlC4bnxUGp5sBjj89c6XCNr2ljQBtMXC1/0M=;
	b=OqEYJ3ibsNH82wjo64E+GJTkw9WpjCPran94iT0VNgLansx6/JdoQuIw/CGkHK60BPbr
	 n/3VZm1zW5L0u2fGAz/6AqK5Zw+kNtAmnOw/W2epYALolxZGvEaNrZUOFFa+YZEslyuJH
	 8zJCFFP1ZwYXFjKZaJJc/9zV+/pLaiWAkjc0cVUI4qIr9eXucNsxOomloVNUV0y87fVmq
	 gJf2F2JnvfaEUY2vtJLi4gZUOViWzhqTNyExnVxXiXijz88P2s7HxpA7VMw+BJ/2yx3Ai
	 PGtmmq42pbX8mrhirToatYnd3SD/mwUpPJzW5oqWBx0iQw05ohj0lqSftYbeFzntv5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXcngXk6;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F50606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F50606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXcngXk6
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so21555475e9.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 06:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793889433; x=1794494233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VQFLDGZOlC4bnxUGp5sBjj89c6XCNr2ljQBtMXC1/0M=;
        b=NXcngXk6cPaVL+ZNLME3VqEKtG3dmCmpwk+IdIyVX4RUc6DHQArnEtR/tGaw4GUH2Y
         FBXWC2yPoS4WyZ8RZmMEmyPf6RRsE4EYo2++h0zEIZDvoTjBJ9RtCjOjbToI4iKEErR3
         xIIH56DEllAjCGgz5LNP6QsuCe3pUtbGRmOX1edEZH/EHmbkXTxeBGYFWbSxYEVIBw6Q
         Sm1cLG1ykmSe9hPk7FprJqywwZSReN10W8y5tOA4sh1zfgei8DsoXcYDu/FlN76FPAoQ
         xiwbev7S1hRbbEQC+/Suh4HdKfV/QO7bo1hly82qFxlFscRgD7mgS4pcMi5p1YOc9h9o
         se/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889433; x=1794494233;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VQFLDGZOlC4bnxUGp5sBjj89c6XCNr2ljQBtMXC1/0M=;
        b=A2zmekvMS6CkXMgp0R+0k1ee9hgC5x1Wl7oolY1upvSnn+l9ygyZ3b4MatvB28Uy/C
         uDg0ej45DCM+H49loR6a64isNRqm/76aZ2YCbK19TvIPc2vt8dencjMlsdJs8DJftROc
         cjZ526ztu8KETUFhKRqZ6OuWpk9WRk77yzbXU4wfUMd41NtYsE8JtarF4cAad1UukppG
         b+IJgz04CiVmAKgF0Q2H313l+LmoLmaT9R/MT17qmA1pPdjtgCZadsnXdZPic/fogO56
         I0KgFgPnFPaYsYC+1M4Iu0aR1zUFoz/G3JJBGEoyv8qQL+rs2Aw6ijkoCnp3a11uzG/b
         5U8g==
X-Forwarded-Encrypted: i=1; AKwUvBx27M6X/S56oDk19IQRsowOZfuS4PZrZVysrHPjSKFp7W+MOCKNzXpc3KXJi3EGUfWFnZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qiZ4uDOcbQncdswKhmZlV15c539tr3AmWzlAGIhX4Nan/uWun
	6cur5pP+YCNIOqNoDkZIpT9tpYnGZqRnsRzPEz2z5aJJqrJLFpAyHBw0
X-Gm-Gg: AYBFou0qds30L/7X4psYYeUu9Ah0eV1VXsptyoTKD4Yl6nq+x7oj7aaTXL4w/pSVPt5
	+E1GLYsBrdqTRvby/PHrYtqcrMYfdm1PIgrHsyd0tdE8CHye2x1/F1FMYSUbXFdsmhBLzSW3en0
	m/cq9FA94oiza+Z2D52Aec97rDzx6x4jxg/WDkec+DV1O2LEXAjd6vibgbVFotOMptbW67Bfqqa
	28ExM+Doki04qksYRXXhmGuKgwOE9DTTZl3172xa2L4oqGa03YVHkGDoi77BEVmgKaDNr7O+n7d
	cFcSGQHrz9mBdLQ+hc43jIDuxqAX13ijCEaLfcxQQCXqdobd+9DC1ATBopl6BjLdfeYO80EiBcu
	8SqDfouaO44Kh+mhCvh2nKW5UGIql7u9oualMKoalJEQq3O1u+inA2Z75Jc3DlspH7Bz64h+psY
	2kpV8fjFgcUY8N9HpMeYebNAQRfLhl+vnoKrxPvn4CMFnIponQ0bqPpiTlkbmUaTVFN4Gq4dRRo
	+dK0k46xWWDL340BmF8dyS2pRJUTqenxFZqcKZb/NifRg0P/l6fci+fYvLIB3kw+9Ag6cfK9Hqc
	bfJus0DZ+TKuUtbmlhzQlyifyajhmD4TSqBWq/3mHuI222uw7yJmpuniPyPsFtnR44QaK/gWpuC
	kE5pmMgc=
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4ac1793f8ddmr443150245e9.14.1793889433272;
        Thu, 05 Nov 2026 06:37:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e65c8sm68595055e9.12.2026.11.05.06.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 06:37:12 -0800 (PST)
Message-ID: <c0a247f6-0dfa-4c10-8db5-203f2803ac8d@gmail.com>
Date: Thu, 5 Nov 2026 14:37:11 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] credential/libsecret: load secrets explicitly
To: =?UTF-8?Q?Daniel_Mart=C3=AD_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Daniel_Mart=C3=AD?=
 <mvdan@mvdan.cc>, Junio C Hamano <gitster@pobox.com>
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
 <pull.2372.v2.git.git.1790549181518.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2372.v2.git.git.1790549181518.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel

Here are some comments from someone who uses the libsecret credential 
helper and has just spent some time reading the api docs (i.e. I don't 
have any experience writing code that uses libsecret).

On 27/09/2026 23:46, Daniel Martí via GitGitGadget wrote:
> From: =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>
> 
> keyring_get() searches with SECRET_SEARCH_LOAD_SECRETS, then passes
> secret_item_get_secret() of the first match unchecked to
> secret_value_get_text() and secret_value_unref().

This sentence is incredibly dense - I had to go and read the code to 
understand what it was saying.

> As libsecret
> documents, that secret can be NULL: the search does not load secrets
> of locked items, such as when SECRET_SEARCH_UNLOCK fails to unlock
> them, and it ignores errors from loading secrets. The GNOME keyring> daemon also silently leaves out of its reply any item which is locked

Is that true? My reading of the documentation is that it includes the 
SecretItem in the list we get back from the search, but we cannot load 
the secret because it is locked.

> or which was deleted after the search matched it, e.g. by a concurrent
> "credential erase" from another git process. We then print
> 
>      secret_value_get_text: assertion 'value' failed
>      secret_value_unref: assertion 'value != NULL' failed
> 
> before git falls back to prompting for the password.
> 
> We could keep the flag and load the secret explicitly only when it is
> NULL, but SECRET_SEARCH_LOAD_SECRETS is not part of the search call:
> libsecret implements it as a separate GetSecrets D-Bus call after
> SearchItems.

I don't see how this implementation detail is relevant. Surely what 
matters is the lack of error information, not how 
SECRET_SEARCH_LOAD_SECRETS is implemented.

> Drop the flag and instead always load the one secret we
> use with secret_item_load_secret_sync(), which reports errors.

If SECRET_SEARCH_UNLOCK fails and so we cannot load a secret because it 
is still locked, calling secret_item_load_secret_sync() does not tell us 
why the unlock failed. If we want to provide a better error message in 
that case I think we need to unlock the secret ourselves.

> This takes as many D-Bus calls as before,

Are we really that worried about the number of D-Bus calls? If we are 
then we should remove SECRET_SEARCH_UNLOCK and call 
secret_item_get_locked() to see whether we need to unlock it or not.

> and leaves a single code path
> that runs every time, rather than a fallback that only runs in a rare
> race. libsecret's own secret-tool also loads each secret explicitly
> after searching.

secret-tool appears to use a completely different api to the code here

> An inaccessible item now produces a useful error message 

The error message is printed with g_critical() which is intended for 
logging failed assertions[1], not printing runtime error messages. We 
should use

     g_printerr("error: could not load secret: %s", error->message);

instead. If we cannot load a secret because it has been erased by 
another process should we consider that an error as this patch does, or 
should we treat it like a missing credential behave as if the initial 
lookup had failed?

> instead of
> the assertion failures, and git still falls back to prompting. The
> race needs a concurrent process or a locked keyring to trigger, so
> there is no test.

I don't understand why needing a locked keyring means we cannot have a 
test. "secret-tool lock" will lock the keyring. There maybe other 
reasons that make it hard to test but it would be helpful to give a bit 
more detail.

> +		if (!secret_item_load_secret_sync(item, NULL, &error)) {
> +			g_critical("could not load secret: %s", error->message);

While this matches the existing code, we should be using g_printerr().

> +			g_error_free(error);
> +			g_list_free_full(items, g_object_unref);

It is a bit of a pain to have to free this in two paths. We could avoid 
that by doing

	loaded = secret_item_load_secret_sync(item, NULL, &error);
	g_list_free_full(items, g_object_unref);
	if (!loaded) {
		/* report error and return */
	}

and removing the call to g_list_free_full() at the end of the function. 
That would match how we handle freeing the hash table of attributes 
after the call to secret_service_search_sync().

> +			return EXIT_FAILURE;
> +		}
>   		secret = secret_item_get_secret(item);

Are we sure this can never fail now, or should we check secret is 
non-NULL to avoid future problems?

Thanks

Phillip

[1] https://docs.gtk.org/glib/func.critical.html

>   		attributes = secret_item_get_attributes(item);
>   
> 
> base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3

