Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76DEAC6
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334152; cv=none; b=RN0/ZbR+DC7s5lJlgDfINMn1O46SRgUoE2j95SP5wJ6d8/DdkTZ8q/3G0BvQ/gYjoYJvesTr74XuUWIGTTeWny6Hb7yTxkUrXIKobUcdHqKPKfT+UfQ+OcS+pR4IN5bc+gC3WFvSWz9ugG7UCPaBqTkvea3DAiuHwADAv095E9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334152; c=relaxed/simple;
	bh=njdaKhjxi66guFArae0MqGpjVkKUG0iDnJb4QH2b96w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neElICKluN1euAVeMRzz1evjq8YvcMxjVlzM7yybMjLjIHisZcc2M23pySy/OY0l9U7vQuB4Ze0eIbQiH/IzWkbSzEahwImScgLcgZZt/1QftodRRKWDboXvFuWmc6zeVXhaK7KXB9w2somS11qvwW86TTYf/lmqjC98cgYUrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG+XU+Ct; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG+XU+Ct"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216401de828so38101925ad.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738334150; x=1738938950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxZ8zterNeqDX87awC1pQlgMZjqV415tnnbBJlEHnXY=;
        b=OG+XU+CtaJxufLkqcUaElugrXtBlRE/mORLhGqU8SJglscKmDWFrIbbxMwI9NxM3CH
         cUCaB/GoKMGz6DMnDVSbcjk9WA9AyGxDFqQriYVf8ZE+MX1tuz5jCIdi+ZRPX08VIXJQ
         tGtBEQplWh6KTNRGx7dj8LzUVpiQSDOGV54Ef+dYIvGvTm/3Bss2JP6ndTfc5JPCI3Es
         R77C0Oe8RZsgEel76Hv0X8b5EEOKOoK2Yk3O1KY6Dh39zKkK4vs8KKm1SwzmQqMhElCe
         QhpvwVQimPL5ryb52YKwAMbqUr2npngYQfHHPCsXXcmGa1fbUtEaAH7W1jWJjWBb1i/6
         bRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738334150; x=1738938950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxZ8zterNeqDX87awC1pQlgMZjqV415tnnbBJlEHnXY=;
        b=QDyKOCQc3ok3ZNx340c4xYqYUwyjw8WoFuxRPrE379V25oyqkT5Xc/UiuLSPa4ROAI
         YG/FSMSFckrpffERcZi1LXih4ThurRo5A505p45q4k5FnD83EdagKi0rcX7oC7JqFr1p
         3n4c78yDV4FVRzgkkBi8Y5YI79pAjnRCviOh53r0Z5DuWL5jU6Lx6e11ffUlppJrbA0W
         UWjsLCrJyosISgtC7I5tIr0rWMYk1AvT1kKfth6Zt6AUEOT7SDvgWikH1IwkmIwM8rrh
         kgUHP9obbQh8CFSbyG8RjBxvyvwjhQtP5d//RfpLzVT7RwlJR9yNp7opxI9sr4LR24Oz
         sXOA==
X-Gm-Message-State: AOJu0YzFBGs6er84noOIPrTJcbCcoskL472VFuYbgbLLDJdjGDKB/+IV
	bWrBevB3+jABNWSo1zaGHGHyV9Wboo1w9uq1DAwNa0W23tZYW7wS
X-Gm-Gg: ASbGncvKbJYKP6y7RU+g4J+YzNFxSa0bS3ssitk1OKglbw2Hw9VkVDAUAInVdMjGmTY
	5yFnbEMbvIs9Wmhijln7mQZKRU7N/hKdTPqXkBK6mApir0Zoo11zMFkXKya9eGGH/+UzJSrz/3b
	2PxpIeaSUuVJZ6VCYLzxV6/7yt5RlZ+qDz15ne2bpqOZ/6ceELa6p/irKj6AKvOHNpJgAsJPmW/
	EADe0U8YYyZTROcPl0uQXk/t72Fa5+MiQ0AiYzsn3KuPDhRVhXe3m6myPEy4tpSDIHX5Q==
X-Google-Smtp-Source: AGHT+IHePJzI5++Upy+IKqs9+hVq+k2hQRen/E28yKQ4cmjmyuSqR20+ddJiLyqYOuNj0imS14ViaQ==
X-Received: by 2002:a17:902:ef45:b0:215:ba2b:cd51 with SMTP id d9443c01a7336-21dd7d64d98mr183691005ad.15.1738334148854;
        Fri, 31 Jan 2025 06:35:48 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f83bcd0d9csm6549057a91.14.2025.01.31.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 06:35:48 -0800 (PST)
Date: Fri, 31 Jan 2025 22:37:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z5zgIp7k0Z9kscmt@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7NnzvirWEljwV@ArchLinux>
 <xmqqsep0ceec.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsep0ceec.fsf@gitster.g>

On Thu, Jan 30, 2025 at 11:03:55AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > +static void fsck_refs(struct repository *r)
> > +{
> > +	struct child_process refs_verify = CHILD_PROCESS_INIT;
> > +	struct progress *progress = NULL;
> > +	uint64_t progress_num = 1;
> > +
> > +	if (show_progress)
> > +		progress = start_progress(r, _("Checking ref database"),
> > +					  progress_num);
> 
> I do not see why we need an extra variable progress_num here.  Just
> passing a literal constant 1 should be sufficient.  The called
> function has function prototype to help the compiler promite it to
> the appropritate type.

You are correct, let me improve this in the next version.

Thanks,
Jialuo
