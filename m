Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BB101F7
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849597; cv=none; b=qpjwrWclpkF5Gxt8iprvxYIDIVF3otbz0NjxchJd5EBi/ZpjyeYJAftd/ZieSs1N66hB2IZEYnxcKLVoUBCJ9QFjZbJVmr3pERmCRZMFA+LjyvDRLEz30KA9FVZ7I/7jRE6eodsXrXQeFNObsMRwBLEZgDEyEBuOwX8UkbJp+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849597; c=relaxed/simple;
	bh=c9jWsEMq+geG81B0/miykqcAB0vjIj4cDdXZLiI9Ilw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqzbsXELMhNdmBJ0fBjFHochIX5rlv7E+PUAumtcIVQT8xvkXM5BVbgs84Th0BYnfanmwwjwSpqcmXlpQx5OPFcAc/YX90FV6gYwEGxvF8w3fFqkezBaSHLlxdmdkMeef8k6AsCgFY5oMukiTvvoM9Bup+m05X6HLYlw75OJf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHvHJrUX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHvHJrUX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411dd149c97so580395e9.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 10:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707849593; x=1708454393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrDYpbpDmSDfhsK0pIrAfPMRE5eJ8oZhsRJeTUYzYe8=;
        b=nHvHJrUXqXCON0qjm7GQsE7afXycnbAXkDswSi5y/sMLfq9wNwcLhxTbyg8fWUX34B
         rkwQH1mhE5i+J7PaaCApn8s78DbhYMX+Pl42ruT8BKerzB0gJjK84cbL0yUZ0m10WtnI
         Br5zzndWL8ncbgBKTa+eY6OpV1yOwbGu3bc9cyqMfRBYbxySfoKyZE5VWfP5edChDaPd
         IPzrSIQjxsIBgddHOjvp66bGkeCEXytAfUoNba/uzjKuoWmBhtQ9iIFEK1AntJSJZ9AQ
         6kvYBMaPGfOSspmXBaRLLn8hvIojks0PUNpgNS1+hx9cYOMW2KiKgkCW1LPj2hlxbtxQ
         TV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849593; x=1708454393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrDYpbpDmSDfhsK0pIrAfPMRE5eJ8oZhsRJeTUYzYe8=;
        b=WTBJ59Bs4r6IpE6QzMWc4XjRfyQl27LvxPsFpyAglD2W0B5ytgGAW25Lh3s9UM3pJW
         mCmMskWpLoVLR2vTch8GjQGFnO+apbCPiwryROXfbZz9B16G9HZGppb+2a7ATmCPnvGf
         eUugkasKgTT/UFjUYD0Jxa27lDaVIoQnzIHhMGvtqw419uy4bkQEacrovfiPBad13X4G
         M4O0bWwcmeeRfzcHwDBesnOm1G7H4LZoY/P0I7fQbJE3UUiPp4nJp8vnPfpNzoyB6J4s
         YVPoI+m/cC95V7XAQkciBTQb5A1HFxs5Y9yUWuBHPSRm+hNI5gfrt2lF4pk+ua3zVYLN
         AQ6A==
X-Gm-Message-State: AOJu0Yz9/F9EKx0qPCMJC2no7QC4PQKrQ4VtttSzzGWQL/P1hRlIJBUZ
	GSHS+T+4x280wTs8Lv77a/BdzywagVcQ2auN+9xBNW1n5krXSnSJKlfs8z/z
X-Google-Smtp-Source: AGHT+IEj3g/HghX/3RJnq/jQ4T5poa2npYwVQjwv8xPtvwYZgju/2kgMt1N4Z2kkFWNaWtcvWJ2MGg==
X-Received: by 2002:a05:600c:3b82:b0:40f:b45c:85a5 with SMTP id n2-20020a05600c3b8200b0040fb45c85a5mr384560wms.22.1707849593202;
        Tue, 13 Feb 2024 10:39:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbwRk2/wavgWLzsFZ9ESBQDB3NOx19GijyHAaQ6t8ixNVtDX1Z6759s8EwjwR3MDjHQRiv2TIObsBzmEjZjJzAQwJY4g==
Received: from gmail.com (15.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.15])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c248700b0040fddaf9ff4sm12363326wms.40.2024.02.13.10.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 10:39:52 -0800 (PST)
Message-ID: <69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
Date: Tue, 13 Feb 2024 19:39:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] column: guard against negative padding
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <cover.1707839454.git.code@khaugsbakk.name>
 <9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
 <xmqqcyt08fa1.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqcyt08fa1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13-feb-2024 09:06:46, Junio C Hamano wrote:
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
> 
> > Make sure that client code can’t pass in a negative padding by accident.
> >
> > Suggested-by: Rubén Justo <rjusto@gmail.com>
> > Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > ---
> >
> > Notes (series):
> >     Apparently these are the only publicly-visible functions that use this
> >     struct according to `column.h`.
> >
> >  column.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/column.c b/column.c
> > index ff2f0abf399..50bbccc92ee 100644
> > --- a/column.c
> > +++ b/column.c
> > @@ -182,6 +182,8 @@ void print_columns(const struct string_list *list, unsigned int colopts,
> >  {
> >  	struct column_options nopts;
> >  
> > +	if (opts && (0 > opts->padding))
> > +		BUG("padding must be non-negative");
> 
> The only two current callers may happen to be "git branch" that
> passes NULL as opts, and "git clean" that passes 2 in opts->padding,
> so this BUG() will not trigger.  Once we add new callers to this
> function, or update the current callers, this safety start to matter.
> 
> The actual breakage from a negative padding happens in layout(),
> so another option would be to have this guard there, which will
> protect us from having new callers of that function as well, or
> its caller display_table(), but these have only one caller each,
> so having the guard print_columns() here, that is the closest to
> the callers would be fine.
> 
> >  	if (!list->nr)
> >  		return;
> >  	assert((colopts & COL_ENABLE_MASK) != COL_AUTO);
> > @@ -361,6 +363,8 @@ int run_column_filter(int colopts, const struct column_options *opts)
> >  {
> >  	struct strvec *argv;
> >  
> > +	if (opts && (0 > opts->padding))
> > +		BUG("padding must be non-negative");
> 
> This one happens to be safe currently because "git tag" passes 2 in
> opts->padding, but I do not think this is needed.

At first glance, I also thought this was not necessary.

However, callers of run_column_filter() might forget to check the return
value, and the BUG() triggered by the underlying process could be buried
and ignored.  Having the BUG() here, in the same process, makes it more
noticeable.

Based on this, I'm not opposed to this change.
