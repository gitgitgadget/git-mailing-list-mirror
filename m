Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B237B011
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336082; cv=none; b=VOL0Y6fM/bcfNbY+HxtqMMNZa3kEArfU/fYsJgw6eAfi7zrGlJU2qWE1/wkGd6BEs3j9aT4A7ddo0ieAUypeloumA2L7xGGPqz9oCV8ZFFRJE7vosDsGcstTq7wtSaUvcg0MdYU7dv0uI5ZXU34TPM7Lekwo5IwkPZ98LVAP7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336082; c=relaxed/simple;
	bh=a8jks/U99AojQ/NPOIWoQrZKJJI4X7O8YztZ4njt3uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVn9UY6+yrW6UenhA9qu0bra5s2pZjasnNRjEBPA1GB4KAluX+1neXWmnfgELSWYt9nl7tjyBgzWaIGorjcnH8AtI9RUD5XotkPRJLrR6enhyfF/xFrwUJPCzPUtuB8Ea8e23lW7pKF6eSm0dxLUpHKYvy03cFY9HgBzH2zMNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT/152WQ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT/152WQ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d1872504cbso1467842a34.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773336080; x=1773940880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSOFklbtQGugwUO9HVPnJccMJgByv1WLrg27sy0qi/g=;
        b=TT/152WQ+utTfj328S7o9e731OMRPsPxmT9AxLzevar4EX+qGbK5IcSBructK/I1p4
         6rL7MEcCj0+XDiuKUCS8tfl7l8WaWGRQJinsIrB+O2ukUaHL7uOBVQRjmgXhp+hNvWgb
         1nQemP+UD2Rjbp4wAcnf0T9DNufcSfi/Yox171icdAAe5lJOStgtBidoE+CRSAW+Xl3S
         OJWIEO02a5eFCxTMg/3TubIJhoHJcd+RdLX+0vlQSOWoU/JwhkwmTaM13HB+aDLh9HMv
         noyPwl3A3ZgV2D8r54mgWhiK3tU6APdZEf6MNilx6iUkbdXVS9ruzXL+HP6PS8LxOtYR
         tEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336080; x=1773940880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSOFklbtQGugwUO9HVPnJccMJgByv1WLrg27sy0qi/g=;
        b=eqlJSm+XSZY6JpRLhlfoxa0GVt12vA806WbgULNimeOn2MUAVwyRyHoEHyYTRW0Yfo
         JPjeui9X8SfVhnDytkb/1cahw+7Lu/rbvV3vbGRj4mDzQKglJyJWqddkhmw7Dj6JDKe1
         VvIvNOynpc01gYJTld9UE/hv+gRGLHgivZVWBYe99CiiwcagagcQX6AQQZrxD9UYbXUr
         3xpiOXFGk1OMvijptKtM9e93vhEZ8ssrgo7lGM0KF7zhuKV6zEV2K+okzhSRAsJ+vJd+
         5/YUwje/0f4x5wzhTPlBo7ooS6CHK/EezMDdMCyOcWBH+G2aXdFNatqkSIvvVyDWJ6du
         aXTw==
X-Gm-Message-State: AOJu0YzAeviXSXBKLE4VXCrr230AH9HMjSt7a8PO7XLOR8P+WzX9xSz3
	eL0sSVkzgzzOii+QS9Wwu7/YG0HDNYhf3e4KCXOx9wLIxCdZaXfu5b3j
X-Gm-Gg: ATEYQzxbc9HBGSulCouJgHK8b6AwBbQi0hmAVIfgbA13FSOnCSY+on7xpkKqcULGjKx
	fJ++XTXMCmGrDlxbtfV/AiDxqbAmLUhHf+hGPS3LY42I1eFgKskA5Sj6E4rYndhWO5DlPVrLI56
	txpJy4qnIes2PuTM+mMGd6Nd61n2sd0iZRjraPlrePB4XJQHoQLkNTmpK1iWIKjO6+sgWJbHpWN
	1VsuqstRGAru4qW5H4X74g5Y1c+ProuI7RMwsvbIcxoHZxk2/oYeeehEKP3pnKJJM4iQ0C1T2YY
	4z2a67/CM8lrTPTsX+rCtfAF+d51Z8qqc6r2OUMO0PW9DS3yyd3KvPSiCELRpfE9ouapJSlYygS
	HDetzDCgbLCdfbKYXMDDZyFmpIONj7wTtbynckm0RXY36xZyYR9AwOPIc65RPELfBhLlX4+WBUh
	7qhmAND8tfoA2D9cP/
X-Received: by 2002:a9d:67cd:0:b0:7d7:4c90:ddce with SMTP id 46e09a7af769-7d776b8b295mr1855669a34.7.1773336079986;
        Thu, 12 Mar 2026 10:21:19 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aa5dcc7sm4644206a34.0.2026.03.12.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:21:19 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:21:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 3/3] fast-import: add mode to sign commits with
 invalid signatures
Message-ID: <abL1Nkb_9aNUcUnY@denethor>
References: <20260310201116.1130160-1-jltobler@gmail.com>
 <20260311173147.2336432-1-jltobler@gmail.com>
 <20260311173147.2336432-4-jltobler@gmail.com>
 <abKUBRRgRmbJ1hRA@pks.im>
 <abLGgq-PXzdWs6kD@denethor>
 <abLMCxWWNiCnqmp_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLMCxWWNiCnqmp_@pks.im>

On 26/03/12 03:22PM, Patrick Steinhardt wrote:
> On Thu, Mar 12, 2026 at 09:08:46AM -0500, Justin Tobler wrote:
> > On 26/03/12 11:23AM, Patrick Steinhardt wrote:
> > > I'm still not convinced that it makes sense to warn about this case.
> > > After all the user has asked us to re-sign such commits, so they
> > > probably expect such cases. These warnings would thus result in a ton of
> > > noise in a repository where most commits are signed, drowning out the
> > > potentially-useful warnings.
> > > 
> > > Anyway, I won't insist on a change here.
> > 
> > I'm not really against removing these warning as I also agree it creates
> > a bunch of noise. If we get rid of them for "sign-if-invalid" though,
> > shouldn't we also get rid of them for "strip-if-invalid"? If the user
> > asks to strip commits, I figure they would expect such cases as well. If
> > we think removing the warning altogether is sensible, I can add another
> > prepatory commit that simply removes the warning for the
> > "strip-if-invalid" case.
> 
> Yeah, it kind of falls into the same space, agreed. As said, I won't
> insist on changing this. Maybe the right way to approach this is to keep
> it as-is for now and create a follow-up patch where you propose to strip
> it from both sites?

That's fair. I'll leave it as-is for now and submit a separate follow up
patch after this gets merged that proposes removing the warnings
altogether. We can see what folks think about it there.

Thanks,
-Justin
