Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E203B38B4
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886304; cv=none; b=S7hrXGNb6Muq+2TkBhmgkS01hEmdYeJdCRgFQJxUAKh6rJLW2gBDTHKy9ZgqxAQIomU4PLI04fsYJU/1oKv5C6JXLsnMIPs2CVRaCuTArHoltrYXBPin3sZSyqRSQXb8Epw3AnAoN2ClbHC9mQDayv0Xerxys1a/bX8aQx6iCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886304; c=relaxed/simple;
	bh=36EOAqJokr106QqCqPr12vT/tyNEtvwdVJ0wQ1qcTbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upixsnuI3tH4s6b1zUIUYcamb9LrSyG9Q1hkTqTxPi0sIY8OsPLk1N3/gKZ8vp/lySpoGSs8OcunZGnq5UgpfvV3Aa82JSVTOlAPO3EhwIJDcTNk3TYhxGkbNViJ6X68OnZtIqVPp5C1iGzBBHKAjIKUcEOehysL8/NkoBNGGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr/uyt9l; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr/uyt9l"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e701435806so1871305a34.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781886302; x=1782491102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bbrAXRFbnCjKdpMHQ68saZ/xbLeMnL7YowGtIKUpGQ=;
        b=Qr/uyt9l99OwCno0jVGUn0nDApT5DTp7zdXJtVSlhMcJAwXM8OTrYW2TXK6OZJFydT
         ElvgyJhSxQjSVG9AGO+bFxAkHaaw/9KzYREcHOqQCPOAdZAo5jaUuSccK8DD1wDRc/s4
         h7WPatiUDarcHqgTOLh2b75gyKRQyZpxDprM5jW+g6GJciz++HYmh72+VCakspUwHhNn
         qi813wgbOzsvDTZ1ssp8aiySvuoczH0DOY/Y7PRL0AvdZ/4m89CaoNuU+P9PRpNsRgtt
         lF9KV0QkuSfpngrxAGrJJVFy8FjWZgjzGi3F71w3SWG8ygRRD/1R5+PxbGQyjXOWm7jT
         rauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886302; x=1782491102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bbrAXRFbnCjKdpMHQ68saZ/xbLeMnL7YowGtIKUpGQ=;
        b=iz5EQ/dp9XpIU6OvNm8byaxzBPK6hGYU8wz+rlQ0I/Zi7Kd5f45eXG+GDqZa7o9gyZ
         RxKzPZMjsDIzwNhJSMlxCNOPuc40v7Ufr/pzy5gCir9u3AfehYHAudWaDH/ETxCAqZ7Z
         E6onX0lEmNVUjY4JX7ixMgCEXpG9++D1uPUE33HZe/K9PtwFtwb4RuXX4PnKQLsKXMcX
         2Pt8Z38Z3gEaAKc3JMxAcoY0nGbUGhAQAcHV0f+bekcGnE7E63JlL+Q9+mzpbwnNW25N
         bKWYXWlcc9gzTkdG2xG4UC33r6lBZcU7cV/TPIdRrNktjiHTw9h5Eyj6VmltMxMSq12g
         8HIw==
X-Gm-Message-State: AOJu0Yxb5DlBC7kGNA61uI+jskuEpfdQY7uj+igvOaXZupY/5mdxnufV
	NIOa8Qathk57LMpQTxUH3QW1D6H/CZjpM1gpevTJjp2mRAnBmuH1wUHvoj7/bg==
X-Gm-Gg: AfdE7cldjpi+UnQVSD3Eiybq7t8qJ8s4ioGkBDaNEzP6ZEDoEmE+3vvGqYlhOaJDdbd
	SnuptfzIezD+s18qW+tSz7hU7sMtlJa3IF4bWDUXXP5gXpbZErWQ3oo5WgYCDU2qVEZzPsCTaLb
	SD8sTJjwybWZhKoxPQP7Rt7z5BXVm3GR5/5PprAQryAdc+DhctGHHemc5zEAdRnls6dYqUK76zY
	q5U8z4bdwASzjVRFrIDOsd1FcWwyYO/BVivR5w4N0XRar68UP8kE5SABJ8kffRzSvYzYFHfFjtc
	U0jWF1Skdux22QrmvNLacFJTlPFyJUJiarEV3k+sco6QC+rrIiq2rmezNdoacyuT/5J3/37CLFh
	9D8BeO7p9FbOZHAWZK34Afexbvwmpme9Eu6pCCU7QpMYk6mDoJDFlfIufwXeKjuYCMclftdMZaJ
	c5ti0/Wg==
X-Received: by 2002:a05:6830:6489:b0:7e7:6:5da3 with SMTP id 46e09a7af769-7e92d9b61b3mr3027607a34.18.1781886302439;
        Fri, 19 Jun 2026 09:25:02 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e92ecfc0e5sm2156636a34.20.2026.06.19.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 09:25:01 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:24:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jishnu C K <jishnuck26@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] help: prompt user to run corrected command on typo
Message-ID: <ajVatJzQ0L5WAOUh@denethor>
References: <20260618142033.15216-1-jishnuck26@gmail.com>
 <ajQuqTB580gqNP8D@denethor>
 <6a34dc40.2c570c9e.381c97.203f@mx.google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a34dc40.2c570c9e.381c97.203f@mx.google.com>

On 26/06/18 11:05PM, Jishnu C K wrote:
> If the consensus is that the default should remain non-interactive,
> we are happy to rework this as an improvement to the existing
> `autocorrect=prompt` mode (showing args in the prompt) with
> documentation updates to make the option more discoverable.

I'm not sure what the current consensus is here, but as it would be a
change to the existing behavior it would need its merits discussed
accordingly. Personally, I think requiring users to opt-in to
autocorrect isn't a significant barrier itself. It does require that
users know that the option is available in the first place though. So if
discoverablility of this feature is lacking and can be improved in
documentation, that certainly seems like a reasonable change. 

Regarding changing the prompt to display command arguments, I'm
relatively indifferent towards it. I'm not sure it adds a ton of value,
but maybe other folks will have a different opinion.

-Justin
