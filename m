Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8F28643E
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262677; cv=none; b=WjZWljSOO2m9NC/ux4xqR0O3yaQeOkswUm7GLScv4MddfEQ+RDcju3TXnXHtngFWFbRrBDv4PYXrHnYJRqN1nY1ydqCW4ZOTCI/39tTDBR8R9VF2NYT04Nfyl8i+z0VAJvGFqIu3Pn0u6khEXMbImqXoan3k94kCbQSeembH3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262677; c=relaxed/simple;
	bh=UsmnjUpEd31t0E5wKD7uon64t6066BQ7lF8se+tybSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxYQe/aWeFcnwxiVELi12a6NBF5mlK7VgMF9UBqXbvgFKVPZfsdGrywmtsIApf8VHV34HnxHPsOi/vg+jFboKmTi8rq76EI0UdcP4bbcyrUPfpQURU0zvyPYjOc1UUKUrNMxZBvzb4nMv/YMfo7MFj79DHEdiFEJGbHaOKpbdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QyKgUUO0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QyKgUUO0"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7501c24a731so56371457b3.3
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759262674; x=1759867474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsmnjUpEd31t0E5wKD7uon64t6066BQ7lF8se+tybSM=;
        b=QyKgUUO0Wnd2YbOLU3IvaO4Di6MrK86hU0gTokjoz+9ENehB5IVpoCxyTMKnVA25Yx
         /Hxgyt5xPSL6TZTg4B3mZcsv0IAsR9j6WJ4Sgf6Gwa+So+tqaWIP4U2YGXdwr4zU47wA
         LDpeUGqfiNMKgOcHRMnw51oLW/I7clPxvqClcGfVy0EFRWhFVTyt4T2FgKkQy5hVv8QQ
         2mWGFQSrp56rigWXKf3IqjL3uCZz4riXWytBSuVf/C6vbrNRDJZ5SZEbGOnaa6Gwm64R
         ql1FYejxD8GbWII0CC5fnkmT+xcKwEW5t7KsPfaYwLYSmJHgS5H2D5epLgTbOEpRl1Lg
         sClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262674; x=1759867474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsmnjUpEd31t0E5wKD7uon64t6066BQ7lF8se+tybSM=;
        b=rVKHXjBGql5UQFbrVjytVXETMBKEQAmvIO1/Xggy2BJQnh7I5i1FRrW7rGY4rx0Tur
         TLF0jHVYPriPLLDTH8kg5QMCiU1hJFks386CwpF8sX5iwPcKK/psZE1C7u9wKLk3TUOW
         2nNJpGwX5TkNDwmsQsz4dI4HRrmcDFmqaT3P1LZaikv7b6wy/4/BMcUfFCzq3MOtypWs
         eh4CtGVkOtSuCPgj3AMj6vpW6dXp8a0H7r+5LKXl5vpazYgEX97B4wUvJDfY67LwuUwy
         OSEyQgt4bla7M8VhwsGdoYRCwQwv6CXRMY1GUSaUlp2n1Myq62b/Q95Kpa8eoCqlQhAQ
         AZIA==
X-Forwarded-Encrypted: i=1; AJvYcCXXcZHtuiS85WhTvb1dxmPziPZhaM6jskfDNV7bZv/V02Ut3eZiyuySsjHzr6wYHIdhgaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbju5pEp97EqISWJkK33bOpY04lVHNRKIkWCuLg7juerC/K3zx
	of1+N3+pXEG/Z/J5VHWsxhl9FnEmftKp8S2fkCMnl4/Dd2lxR0gla1L+pdCyLpBaTCSetLvMC/N
	oLM34xrRycA==
X-Gm-Gg: ASbGnctJv9TnI9iyi+sUJXbEHAqh+6500Fyk0qyp01ZaytqkvssWNBHTCCadccrrd6x
	47mVIf6mB3nsgXg4WHxq/AtzKLCNDFRNIFVXcsCk59sfFd7Oc8CK5inW/a7g57LUVxfYx8UzQ6a
	JnIulLzcxdQ9bO8yiMqLl3Z2P2X1cIJLLdMTC+jriBcur1XEradwafozZXYutJFXERWk8c92poI
	8kwd3kwEsLDPfIBOIZnEI/TPF1mW82WkpK0g5+AmJxIN7Wtlw0fW5IoYaQmHTABvJpFjNFUqMyc
	tpJI/crQTnz55H867T5xvhZLRvuSGytwDSKr5O6yGeC2+zamBHPl5aXTKy1kQgjm6Nuwum5KXtC
	EkAWxcL16OW2oGczLkye5xTY3sMy6aOwMNRGbxD/2pRUfhCyoyHrSYtEZPf1JXtLZQ8LFgnhW7X
	uW/FjHPOMI5GixFV8nHysG7sO7S/5+SETguP6IN60rPxqGyQiTBrAS1RSkJ3RL
X-Google-Smtp-Source: AGHT+IF+e7rmrWl+U0LuKqCK4khYEavMiTWBCM+LcK8T39qRvga0OtPsJfdA9sc7pSIOqiAudsaKEg==
X-Received: by 2002:a53:4206:0:b0:628:9b45:5e29 with SMTP id 956f58d0204a3-63b6ff0a3c6mr1359509d50.15.1759262674381;
        Tue, 30 Sep 2025 13:04:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6361e8c28dbsm4498262d50.3.2025.09.30.13.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:04:34 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:04:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Message-ID: <aNw3z0E/xvJ/OChO@nand.local>
References: <xmqqldm0am4b.fsf@gitster.g>
 <aNhX9AJ/zq4IYhmW@nand.local>
 <aNsG8JGvpzui7XJA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsG8JGvpzui7XJA@pks.im>

On Tue, Sep 30, 2025 at 12:23:44AM +0200, Patrick Steinhardt wrote:
> On Sat, Sep 27, 2025 at 05:32:36PM -0400, Taylor Blau wrote:
> > That would leave topics which do not have active reviewers in a lurch,
> > but I think that is sort of the point. Contributors should expect to do
> > some of the work of making sure their topics get reviewed themselves,
> > and that shouldn't fall entirely on the maintainer.
>
> I guess this is a realistic expectation for oldtimers on the mailing
> list. And it especially is a possibility for developers that work in a
> team, as they can basically tell others to do a review. But newcomers
> already have a hard time to contribute to Git, so we should make sure
> that we don't put more of the burden on them.

I think the roles would change slightly. I agree that newcomers should
not be entirely responsible for finding reviewers, and I don't think
that asking them to do that is entirely practical either.

But it's also impractical IMHO to expect that the maintainer doesn't
happen to lose track of a topic from time to time. Perhaps other
seasoned contributors could step in to say, "hey, this topic hasn't
gotten reviewed. Perhaps X, Y, or Z might want to chime in?".

I dunno.

Thanks,
Taylor
