Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC6305E3E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938289; cv=none; b=ZCYIxCBoBVoQrbmRHPQeRXvIMQS2gUdmOXkFYgH03b7eJLwwoA0HayyolulQ51sjfBXbiETX4qX0y2eG8Kkrq8qQoJ8zNiVmn06/3g8+uTBSNazt/eHf+QyVnJwWrej3HKSFVmsCI2GNcnB92lXOvf52H+t5PS5tZMa/xAd8FyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938289; c=relaxed/simple;
	bh=X2C4AN4ulXCHGa8n2rqxDU75qwmb2AOfFJvYr+jg224=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1IggR2AMAgus23MTpSnQvTo811DweeZrupcSi3Mt0FGE/MaZS3hvka7imgGjBBfxZ/5d6hxdBrxBNJKriMLqCfngj31UhEX6a4TictKF5sBjZlK90GVRjtXxSthw/gSGYNuZ8zMOqwLX3btQ2wog/GuGv8d+u0VXCrvKEqT4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCW3XUQx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCW3XUQx"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77716518125so886619b3a.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757938287; x=1758543087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTTB2WUGabuYp4ioElUgHRtjeIW1XNLSbIxM91htUPo=;
        b=fCW3XUQxHsFRFTT16aqcqixNRICgIk5n8l7em9cgeycuZbzVuvbrOOBCe/4nu7maPn
         bbBqH6fbrIC9hIoVACo9odPp8PrnmqXbxtteGSoh7PoopET0dco+S4mRVrQnFKPuO4IZ
         +epVMYJyHlM/kiUWJS2AyvN+FaC5wE3SEeTUC7KOfPXmCv78J2kZQFEeZ9DDgewwTneB
         LMt1VB38Q3ysTq5GrsmeD5rUWSqFFGSGzwbmYH++EjP22aEL6pNQO9Ho9TaYEqPdv7+W
         jk753HXTZuQt0KPwSkD9cdZxs20F83Dn3Cx1v7onK5VJzFkvFX1+B87QOeVaOY/J7hmE
         kCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938287; x=1758543087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTTB2WUGabuYp4ioElUgHRtjeIW1XNLSbIxM91htUPo=;
        b=RHp1CQWCL0a+41kpDs/KcOK5elZ2+sWyQlhmRAeYmv11kapLfVxYzzCGmxCdU+JWuZ
         GpXrZRxoxUBlqgMfzRRIPoMCAxXermq6UZihpo/+aGZdjurCszpPGhtOu4yKH3blEVgG
         LGGQFv7Dme8cDzs7s+rPs7vgQ5Yhd8INLUohnoimiVIXb31+diKNOnegQiwJoLX3pTzm
         iCzCXFzJAqbm+3JN/OHxxPw5QiEHmBUCAy23EPVx5sIPcfmZIyD07ozu1DsyvvsVuytt
         rENqkdt7mDZR6sjneH4a+o627l6rebFCLa6tx5LmL2CbNDMSbL51yDadDC1F6ylpCRX6
         0sVQ==
X-Gm-Message-State: AOJu0Yw22K0LY6Fr0qsSeQRxAQbGGLVkdaOoAbZOwOpFKlf49M3cfdTe
	tCK30bZm90csW2G8wgxuKa37SNRlsG9/VInmxkeR0uhNqvkwKbXo5hA5
X-Gm-Gg: ASbGnct4HCKZI5FxGOuOD2APMlFtJEhzvs3LtvgZ1Gotmq5TVS2yy1LCVoJdXLSQX59
	QoFxq89T9OQUeU3ZojToJ+32i1NjvfMso5xiLHlBKGmC0D1hkbYkQ0870ptFKFnySj7hXHV+lIi
	L6T5jlBwFPuJXmuPHCP8oXv2GkmCEMqhHSZqdKzHkXGRDls2FFykLI9XKpl3YHMW0m/h13UmAdT
	gsravEzij3CNzNUEmiKgjW2Nkxk2NLpSOcNF/4a7Y7KnXcIC+E4fa8eaQFZI9dKRfO34j9+BzUC
	c6iNENX3Kn7QG2Ru9Z6p8h7B2fF6yyNT2ogf+nJcvvncJpgOw17MjyD7rast6E01Od5kos0aQ5M
	jm1VHzdkz9e5h5ECj2w==
X-Google-Smtp-Source: AGHT+IEbsLf4xCFq1BM3v+8eRxdzGuVltNZxAouJW+FYMleJJQa0KFz/456O1wWmIVYRVU02q5t0Vg==
X-Received: by 2002:a05:6a00:1790:b0:772:7c7e:cc27 with SMTP id d2e1a72fcca58-7761209bd95mr12537433b3a.5.1757938286867;
        Mon, 15 Sep 2025 05:11:26 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607c45e34sm13366925b3a.91.2025.09.15.05.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:11:26 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:11:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aMgCdDLjOTlWi1GH@ArchLinux>
References: <aL21cEM0OcnrKtBW@ArchLinux>
 <aL219d7FYJQNKBEf@ArchLinux>
 <aL_HwMEJBLjrV8WP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL_HwMEJBLjrV8WP@pks.im>

On Tue, Sep 09, 2025 at 08:22:56AM +0200, Patrick Steinhardt wrote:
> > index 2b438c7733..03c7009472 100644
> > --- a/string-list.h
> > +++ b/string-list.h
> > @@ -174,7 +174,7 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
> >  /** Determine if the string_list has a given string or not. */
> >  int string_list_has_string(const struct string_list *list, const char *string);
> >  int string_list_find_insert_index(const struct string_list *list, const char *string,
> > -				  int negative_existing_index);
> > +				  int *exact_match);
> >  
> 
> Makes me wonder whether we want to use `bool *exact_match` now to hint
> that this is really only a true/false value? If so, we'd also have to
> adapt the signature in the preceding commit.
> 

That's right, I think `bool *` would be much better. I would improve
this in the next version.

Thanks,
Jialuo
