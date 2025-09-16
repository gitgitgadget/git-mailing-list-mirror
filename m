Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D773928137A
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009427; cv=none; b=JMXlEe3iNUSL1q6EhNfFNIaz8CJ3G5F+7fujQb6yp/JYbw1Idn5OfLMUlh6VbsjMGdtkSZlicKwXQY95HX9lrFL2/A4kM8sPQSdL06YLoqCyScyFsvbalyWT9S2B5nWVBIdffg2khcg8Qt6dPmmb1G5OCZJ5eK1p4uPD6+IPgDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009427; c=relaxed/simple;
	bh=NH6ynVHn5G5kKJSinLkfP4UDwo/Cd7ITtjOx/Bf7dRE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbIPxP7XhtCBL0djHpRoP2HGaie4dBLbbh9OGbGF65OeXcS+aeWga6hfuHbEZxSJ0kJlBTvabnHOLbPBJb4N5HBmp5tg4bqw7o9n0QBTr8KYptNtuGBQ9XkNOkXGSULlQKmW8gBtopYJ3ytjANt6pLOKEuJFmcELKs/e/mKvPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBYlr1KN; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBYlr1KN"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8d74e29eae5so1253755241.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009425; x=1758614225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3lfUnAM1UpUMZYXHyE3Z0ITLoUcA2V2eTJ2nLIVGHo=;
        b=jBYlr1KNnYl66pTy88Lia5GThpNJvEF5A9fN6pyCh2+yQjCen8q6bnsWCafkc6xRg6
         W4JdtB/EahkdKwutvkS0iEU+aaAk9J+cqmnRRLiTG1GwioUR041jk0D4RMuo2eD+xQ5d
         di/z090AJgyir7pfSktJDKuLhfXmwv7pk96jD/2DRCv6l5bzFvUA14yJ5Oi5eLDkvEev
         A/ipyP7dHPA6Ee7z+n8WNJFgYOtqY0wsZSUsZ6m6FuWANv0ZzxKIfM0tARw8tLiYggTj
         rghxwyi0mODZ94GtWvuapgJJPybc3hV/n4skOUL8q/EynUSBZfe3FsK8ddHethpOGkdT
         vZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009425; x=1758614225;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3lfUnAM1UpUMZYXHyE3Z0ITLoUcA2V2eTJ2nLIVGHo=;
        b=UpipBxYtx5DwmJZPsm0r/FRP6kTXk/BhfrRa+nirKcErk/8LZMQrdITsXLEUE60WNZ
         d632NCIYMipOK1SM1axcd/4JhRW6UWu1zse8YeEVCYZTPeImoauRAPwnJm+hf0wVqJSW
         jUm72K333yLfRBSEBw2TvRkGMxRWUqQHGAYcpDqcD07StnKYUk2PnLZ2v+PQkJ8ZVWvL
         cJ8mv9XL+sa5GZijSuODFis7mYCjAkwlDA+xwAX5mSeKQiQXtAXzURfA+Up6elMtHLNY
         A5kI0ZqCCgC0isJsMHLfVTpwSFK7E+jx4xlVr+s5RaIOcvGTeQFslotexMpKe0moOPOZ
         QNXA==
X-Forwarded-Encrypted: i=1; AJvYcCU4W0ux9V9UnTKvRLOHteymN+83oaT/BE0oOKY5FuV296Pb7V8VKtDs68RoZgZNez0mBxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3x0c5LUSgAjtaaCXFdFJpLlulqYxeHamsrNB10hvd/M0Te68
	8M1FNI7izC+6Yd/m8Y0oVKUhn9aHUjYjuKUgX/ceeZwPER/faR30N/KtHN1L0+zTwU4nNXhtpYN
	HihAugBUPPBcQCKQCv67Isub1mVoeBkDyVB/e
X-Gm-Gg: ASbGncvQ8dImxkJU8UdE2rWdwI0ZSQp2VYyYWBZqnvOkbTxaRuqOEOcszZc2I2XnfTo
	Sg3x97pq0fVNF5zjbE7GOY9JRcwcFp5PUgLUW4PIOEul/XcRKObSQiVsVYon/tD4QbnXHe/0c3s
	stHr5ePnQYKc1V51wc8xPlIzyY+N617+igpiMWZIbdXz3oz/3OtCqP8W09IYR2KLEgoSmLJKETz
	NwEqZTjUXfKBdBJitY4TALBIp4gWVvblNtli5VpUA==
X-Google-Smtp-Source: AGHT+IEv2hBMC178VrMMZOsnJAZc2JJI9Tx+tHMNekTWUWvUy46JnlkmHUqS+hIUfcGfY6HwQxSIgDWKlF9u8YVQ3AU=
X-Received: by 2002:a05:6102:510d:b0:528:ec33:3675 with SMTP id
 ada2fe7eead31-55610115045mr7166085137.17.1758009424483; Tue, 16 Sep 2025
 00:57:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 00:57:03 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 00:57:03 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250915202956.3784935-2-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com> <20250915202956.3784935-1-jltobler@gmail.com>
 <20250915202956.3784935-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Sep 2025 00:57:03 -0700
X-Gm-Features: AS18NWBy2lA9qnnNb6-f0GgBv0iukYu7ba8EjFPi4HbIwVY9bNmSsUoPYS1Yj0E
Message-ID: <CAOLa=ZThwF0LTd17Wxa3AJnpQuEkcSyp5kHm=D-cZ=Ay0pWa0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] bulk-checkin: remove ODB transaction nesting
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000423dfe063ee67733"

--000000000000423dfe063ee67733
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> ODB transactions support being nested. Only the outermost
> {begin,end}_odb_transaction() start and finish a transaction. This is
> done so that certain object write codepaths that occur internally can be
> optimized via ODB transactions without having to worry if a transaction
> has already been started or not. This can make the interface a bit
> awkward to use, as calling {begin,end}_odb_transaction() does not
> guarantee that a transaction is actually started or ended. Thus, in
> situations where a transaction must be explicitly flushed,
> flush_odb_transaction() must be used.
>
> To better clarify ownership sematics around a transaction and further

s/smatics/semantics

> remove the need for flush_odb_transaction() as part of the transaction
> interface, instead be more explicit and require callers who use ODB

The first sentence doesn't flow into the second here. Perhaps s/instead//

> transactions internally to ensure there is not already a pending
> transaction before beginning or ending a transaction.

[snip]

> diff --git a/cache-tree.c b/cache-tree.c
> index d225554eed..f88555a773 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -474,7 +474,7 @@ static int update_one(struct cache_tree *it,
>
>  int cache_tree_update(struct index_state *istate, int flags)
>  {
> -	struct odb_transaction *transaction;
> +	struct odb_transaction *transaction = NULL;
>  	int skip, i;
>
>  	i = verify_cache(istate, flags);
> @@ -490,10 +490,15 @@ int cache_tree_update(struct index_state *istate, int flags)
>
>  	trace_performance_enter();
>  	trace2_region_enter("cache_tree", "update", the_repository);
> -	transaction = begin_odb_transaction(the_repository->objects);
> +
> +	if (!the_repository->objects->transaction)
> +		transaction = begin_odb_transaction(the_repository->objects);
> +
>  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
>  		       "", 0, &skip, flags);
> +
>  	end_odb_transaction(transaction);
> +
>  	trace2_region_leave("cache_tree", "update", the_repository);
>  	trace_performance_leave("cache_tree_update");
>  	if (i < 0)
>

If there is an ongoing transaction, we don't create a new one. If we
create a new transaction, we ensure we also close it. Makes sense.

I wish the parent transaction would be passed through to make it easier
to understand, instead of deriving from a global variable. Nevertheless,
this is a great improvement.

[snip]

--000000000000423dfe063ee67733
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 884972065e239304_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSkdFd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEF5Qy85OEJKNmUrZk5pdWNFZ2QzQ2oxRmQ0VGtsZQpuSXEzd3BqU0p1
d3pPQWhzb3J6K0xDbUxad2FSeDlwUkNpVTlxc2REWHJya3V3azFLVmJaeUloWW1tRXU5ZktRCmx2
djBFdU4vSXN1bUg0dlA5MTRyTS9GUTU3WmE4SXMyY2JXVFZ1K2h1bjloNUx1Q1pubTl0WHRWakk2
N0Q4N3oKUTZ5aU5QcERBRGlDODNqNkdmdHgyNTlST3NaVWN6ckpNYnYydm5vVW5jVXc0Q2tsb2ZR
WTRNaVZTRzYxQXZhTQptVXZpbitvOUNGUzlaZlFBc2lkWnc0NlU2TmZGOGs5WlJDVUpPZ0xRQjdu
Tjk2VDA4S1ZvR2ZpNEFrUlI4ckhYCko1N3ZlejhxKzR4b0Vmc0R3V00xTFhhWnc0NVRPOE1ZYWxL
KzA1S2dlczkrYlYwNmdob3hoODVudy9ETTRCd1oKZllsUHM2QVdwWTRnTG0xYVE2MUxPeFo3a2c2
U2luYzNiQTVrNGZuUVdOWURHV001NXY1MVVPTnVVU3RxdVc3ZgorTEgza2JlNENEbGtoVGlUaldH
K09CMmZuYURKU1pUWTkxeUsvbi9YYmJQcENGZEJKbDgzUS9zN3JFWWtXamJYCnlpc2FBeW1aVWN3
b2lzcE1panB0TXZ5NDNWYjlOMXFxbmluS3BERT0KPW5NSngKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000423dfe063ee67733--
