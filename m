Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA51C861A
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975445; cv=none; b=sjDKqQ4Iz7MNdAu75edhHtHh+1oIrJB39LBq0SP0WsiQlSYH3aepU1DPdd29WkNMSVlB+X82kOJYh/qzdyySXiktDq3OoPyYWC0po8u39EoxSklaWm4t7TrEJ7GR+iqUS/ihzNHfRtaTubzC/rkSZZuD20lU+OnGZl+UViM1IJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975445; c=relaxed/simple;
	bh=1pg46XxcX5LXjCq5egwWVMYg3OJxntR5/m9hAuE8k9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGKjg6ZKC4xI32fgW1cej800aqyVRvbk8DCoSDhwyc68wMoTOtY3+15BaDugVXUeQW4TWOHXgXqhatugFNswxh/3btf1RY8FEx6QRP1dLeQln4vlp2Hh6M1q2i/l1N5g6hW1rEZyEGbiZ4rHBNW7qIZGTgaYstXl2WuHaouNDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiMKpEaT; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiMKpEaT"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d751ef36ccso3217271a34.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774975443; x=1775580243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDERe+XPXB/Qd0LQea+JaqIkVI4+aZdvHwXIpjrXHKE=;
        b=kiMKpEaTbHEtGtksF7VLDl41kPg1jlA1q7lQJ6PhSzbN6BaxtebXgcjin+tfk65aST
         kyn08gLqEeVgLNiHGhEHu3g/miNjPda2O9eE1zLLw+BTXP6GcQAAyKJPaUIhC/hDHdCU
         MuF+Fm8QsTZNzhBHm8xxvSCUY+to8ZdeZPvTQkn8ziMqOdsstfUQhmlsf/GOYo0lDrjI
         t7yiTXVL8xisEz9Nd9dbLMVpSDNzFCu+KGPdxPPjiRkfSU1ocjBhtGsVrfG2gcYWjS2V
         rdb3Ho24zwkFByP74zDXGL8wnR75qlcNBsfIjZv9i9ZWkQZXQR1nVQtTBoqpybKk6gRU
         Bqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975443; x=1775580243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDERe+XPXB/Qd0LQea+JaqIkVI4+aZdvHwXIpjrXHKE=;
        b=kBluqzh8zJKof6aVOsUwih18E6/ANsOrZWB1zAx9unSGsmtqvUuSGx1xOhPhy7yNQ5
         0uM6sV557Zx83GiSxzHzTVSRFlkdpeUhpSHaf0DsMa6JCKwZeA+KFxAP8aCY/dqyhIef
         8TVL9kB/tgX+Jx0NoKqJ4cyr9m+/JgM6A0Obt8+egPHtVZXd6JJc0fboTKzyv6K1AMpj
         5YEkndFph+Po9CPLoj21gQTi7b0Ka6EjvaPziJHL7oedzjeIFYlDz5EjWjXqK+1svbxO
         7eq3Ek/G8PCSpCEZ6b339JGCfgPqO9JxmaJx73pJEOIXrL8mG+J2S7k2K3TIjkYY2JFL
         PWzA==
X-Forwarded-Encrypted: i=1; AJvYcCWdRpXJNW1yQSYK3lnKtDaIt4SdWoTFFdtu+Q44GXiBR4MicHop51qRI6mjQfudrIBcZPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQG2ObAelkQSS11zSvgR/7TxXEvsnfq/Zw1SJMtle02peTOaGp
	eaxx5pY8hze3kmgmorapr/EVeLAJhLyoy9Z6cdpopf+QiMW3n4BH3j2Z
X-Gm-Gg: ATEYQzwkisb1OVt5qdq3Chyw5tSjfxj0efCejBvBM0VSL7Bg8xyR3YW5qkrk2rdIpnW
	IACaD2r8O99GUZy5oqEAmYl95omnUILkFmHN2K0FY6YanbokECS8iygMQXCbSAQ4Mf9Xehs3aTI
	5lvNl2H9MCL9ppeYO9QPTDwECaUBzLitkET/ruQnvUCvXIHOWVrqX+gOTpKsMFBu3jVLdiKE/Bp
	GtxSkm5HnrJdNRDMSaOMEMiHvmZMOjs2onN2HAfkZ7Z5cdvRpc5xmiqxvliI8NVMyd22pc4rMHC
	8GKcsIug+40tvSmrI5CdSlvVe+DO6tJ3erICeTmvZ8TGyQhAlLLS1DjsI+m+oeTus7Ie4Y6gzSw
	JWWtduTIqm4vQIVEOph81Fbg4K3a/mvT1Cq4pXI3f/fuwDkY4IBR4jifmFZvHUZ4PBgoSzWZk5Q
	O6Kr3G+h3X+UQfUBnz
X-Received: by 2002:a05:6830:6d48:b0:7d7:fd7d:b035 with SMTP id 46e09a7af769-7db9946f8b8mr202934a34.32.1774975442746;
        Tue, 31 Mar 2026 09:44:02 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a335421sm8369400a34.3.2026.03.31.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:44:02 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:44:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/6] odb: split `struct odb_transaction` into separate
 header
Message-ID: <acv5lsgfw2eKDCkO@denethor>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-2-jltobler@gmail.com>
 <act8SB3hqHvleT_Z@pks.im>
 <acvSQ_qeA79LV-8y@denethor>
 <xmqqmrzo2dpk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrzo2dpk.fsf@gitster.g>

On 26/03/31 08:58AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> >> On Mon, Mar 30, 2026 at 10:38:30PM -0500, Justin Tobler wrote:
> >> > The current ODB transaction interface is collocated with other ODB
> >> 
> >> s/collocated/colocated/
> >
> > I wonder if this a regional spelling difference. My spell check doesn't
> > seem to like this variant.
> 
> Collocate is a verb that is defined as words or items being set side
> by side. This word has been around since the early 1500s.  Colocate
> is a verb that means to place two or more items closely together,
> sometimes in order to use a shared resource.
> 
> https://grammarist.com/spelling/collocate-vs-colocate/

Ahh, good to know. Will fix this in my next version. :)

Thanks,
-Justin
