Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C022512D3
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746669; cv=none; b=pTmPbewpSQ6K4MQO2IKD6p+mQmNn5YT6uKzbjW/aZpqV+K5a61kNW6xvXBilBDvsQXl1Gpda2dsXp538E6WxnavheonT9S0yBXCX92DgSZnNuVucYP61K2r9JHnjtKD5wKie8qx9KKx3mp4QGsTVA8jk8hwzxPkyERegvkGr1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746669; c=relaxed/simple;
	bh=SJ7VHQYdH/K0ezHxhIgDFIncoTS/V23z+bIT1+U4Ihs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkkVZZHKHFmKhGb3BoXJO90riQLH2UZ+ltpmKX3RH5Dz6Glf7RA5PXmeTtGYqFQS+qjTECb74uGtDtU1PwEHTuHRyRlvjnwgilouDxRVu/omlmgAiRFZK1UJspOCkZDxMLJ+3wZebs7oP680i85Xk/yYsLzeXim5Rr8Cs/KzPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xeDym4Zc; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xeDym4Zc"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c55500cf80so464219985a.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744746664; x=1745351464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YVedS5hXlE0rFNVvYsikSbtJCQ9IYy6tK1ylSNZdsDI=;
        b=xeDym4ZcxirOud4doGbg4r4qkT7qgIM+731tvRWoUixw/NAFQmri+t4p6PX83izcf5
         m97JMX1EQqxFnqhaWE7p4R2WLmCuSa/Vwgs4bFLP7VykFIDKAHW2nXUpP/98EkhCMKgk
         m07J5Gqjxe+FYL02ZdTVm7yBbGWvjsMVPtBi8QH1nVUjcswbOfwWIRASq3l1VmnafwoY
         ux5T5nL5NvjYs2LVm/ZmMo9H/8zpMA7EZNOw5UnpNTTgwThhiUSIZs6iYD9fUb8FF3d/
         efXSezGE5brlQIQifeUwTEZQdxZI/UsyJFWHqOSxFdhl6qzVVQyZim8C5fNecOKF7gX+
         BMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744746664; x=1745351464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVedS5hXlE0rFNVvYsikSbtJCQ9IYy6tK1ylSNZdsDI=;
        b=vKwJKcb8foGrdw61N48lxM6XEUk4ZRhOo/4lFyadyeJ0Wu3vSlpRx1GgP2UuSW+hUY
         tgF93XmobNlNrMY/A3yLn1dcqRgPUoQ3/15LU6kRUnlsx2PpKbxcOkSzrMyxhWKqJk4X
         7+PP/gKGTQncPBX4q98PzwObKlhzyr8k9BIin3Fa9KJpAbsfjcxAdqXjBxp7dPbxtXIC
         Pt0+L2tNo1eXmj2kaerXtVvE15dGuONCLzeJ9M6YLBnTtK7Ihqjga6+j/kptFJ9M8GUa
         T/Hlsae1oGHY5zg6GxHGGHnzCwrvECBk/YOxg7/aY2U7MQDNQOJsOQXdCWgEZ5/T8JqR
         AxNQ==
X-Gm-Message-State: AOJu0Yy/SPNavd1ieVy5a4nTdt3qwR9qmYuiIfBWVDmjqmssiYy+bw7q
	FjVvZ+RkdgBMfeMzy5wefiY9XgpSrxF74ri6IA0A5gCPvzSuifXVnhFyNWR9RXDRlmH9a3AuGIg
	kK6Q=
X-Gm-Gg: ASbGncslyl0pEZQsRB28az0QEn2J/sqmCGc5U15r7DgjESHr6roVINZPjdbBo8XiYIU
	k2YUejpy+oG2kf5Y3iOWYp43z42ZDFzl0R55y9fQYpJzZ7psgnHWYvDt0HSlt2efTW8Wvlaw3Fd
	/jy+WgUDyLXlpfzyNbcyCKHJi/3DTsN4/Gpyuz6XajCYvokgld+AiOyj0YMisw15n/tPfTFGoNW
	o5zJdAGlVjGfZdigpRMNkMqZtTBFtae+iTi22EGvQzthnNKk0MZr5+9mmRl+d5f0rFpukAlM5V+
	hnbKy0GugBO9X2bNUC+iWolKYh3UM9fTvS5JP2s1YFiDbeFrMT2wCj1FfKZI8QYuVUmGuam6yel
	KzOZWmnYS6EVJ
X-Google-Smtp-Source: AGHT+IGl5JkizBDBd3XoZ2hirXqfLiMN1UvnqRkQZpVuAk+QZvZU0WaTAK1VoSO+4hgvEJa//KejZg==
X-Received: by 2002:a05:620a:294a:b0:7c7:f7ba:270a with SMTP id af79cd13be357-7c914274de4mr120604185a.47.1744746664317;
        Tue, 15 Apr 2025 12:51:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a895180esm946456885a.46.2025.04.15.12.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:51:04 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:51:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/8] object-store-ll.h: add note about designated
 initializers
Message-ID: <Z/64prrBW77QSznZ@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
 <920c91eb1e5a1b6d5faa54240dd9c85f72968edc.1744661167.git.me@ttaylorr.com>
 <xmqqsemapi40.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsemapi40.fsf@gitster.g>

On Mon, Apr 14, 2025 at 02:07:27PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -337,6 +337,14 @@ struct object_info {
> >  /*
> >   * Initializer for a "struct object_info" that wants no items. You may
> >   * also memset() the memory to all-zeroes.
> > + *
> > + * NOTE: callers expect the initial value of an object_info struct to
> > + * be zero'd out. Designated initializers like
> > + *
> > + *     struct object_info oi = { .sizep = &sz };
> > + *
> > + * depend on this behavior, so consider strongly before adding new
> > + * fields that have a non-zero default value.
> >   */
> >  #define OBJECT_INFO_INIT { 0 }
>
> Hmph, after thinking hard enough, if a developer cannot come up with
> a way to avoid non-zero default value, the callers could just work
> if they instead did
>
> 	struct object_info oi = OBJECT_INFO_INIT;
>         oi.sizep = &sz;
>
> and the member of non-zero default value can be delat with by
> updating the default initializer, perhaps like
>
> 	#define OBJECT_INFO_INIT { .enabled = 1 }

Yeah... that's what I was trying to get at with this patch. Basically,
"if you have an _INIT macro with non-zero defaults, don't use a custom
designated initializer and instead assign fields after using the _INIT
macro (which itself is a designated initializer)".

But like I wrote to Elijah in the same sub-thread, I think that there is
probably more to discuss here, so I ejected this patch from my copy of
the series and will re-submit it as its own series later on.

Thanks,
Taylor
