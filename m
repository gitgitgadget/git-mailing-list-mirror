Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A7145A03
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445250; cv=none; b=cuEc8WBETFCeh+2XeJpZqGOjiuZxBA8bw6FB7bxQQEqRSzi2q5RkibLynCPlteT0X2co0loeOhwXFzewXopbz09LZgkuy1L/lHOg3+bvrmOiF4zciqzph0vXYSanBwwqxPliCAUk4iOw95OX8DM3dEvsvhthoZR25vTtjwHz6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445250; c=relaxed/simple;
	bh=sTc8mOtcsB/gn1yNcRWcyqITtsfF3v+HaGoz2jylMmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcG8M1Y6e9QfefMHq6w01RU8wB6ybFDT/rwPIxqK3OIvTLBclgtiejKTX8Az3tUytv0PL8wxz7pzDtF/b68We947+MU9EuDQUS8oVyFi9PePaUBBnA7bRLsAjnV/RXJS4NwHHhlllpWH+bMqoJ6zP4jQrblMXeA4G2R0D/qI3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+3Q46wB; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+3Q46wB"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c09f8369cso963885a34.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743445248; x=1744050048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMDGWr0E6E9sI6j5i4fxRQuLFE/Jyq9DFeEBS6mvZnA=;
        b=I+3Q46wBLIHTzSAQGvyJcrcYDCTxgoy67PwcJ9dUCEQ9VCgL1Mrktvmp/Dwb7gCHv4
         05RJ3VRlHE/jJbtI59Ow2UForbXaJebcvHUl2nmDJGlMEiFpibjdH6pco90vLRPhXRew
         2VqXd7dv0dE+qUGMXHGldBF1SkaVZSqqNQdw0Q/llpJewmoKdRAs7yv4YcNNODgsSBXt
         7thPtaLbwIselZf+lxpCtS8Skq+AIUP8nn6Vt+sOI8Lfb1ApKjavZA/6Qq3pS4wuItaj
         gEUwxZ9zFYllqRe1oDZeIoYK+Yru6JFdV3UlJL0086vfgUBhAsipAF2PJqKp/l6F1JhJ
         0CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743445248; x=1744050048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMDGWr0E6E9sI6j5i4fxRQuLFE/Jyq9DFeEBS6mvZnA=;
        b=wyE15HxenGGIK/DJPyXEwcvu6DprOI1sfKQhd0rI2B3hZmqLendC5f1uZypd8BOgBt
         lQKpV94kKwz+3So9QMA0ciFwV4Juhm+zXWWNNjmdcAHUWGoNqpk6s82FwTU3xE1I8ogb
         e75MsiduFT5gC+NnC+2ePK6zGfyj4Cp9Pb5mi2eKMWhok9N1AfPJlE4YvaZtQSTYLN3i
         RCk7nZ6K/h38nuJtffAihqOHmGrUs/kMlZi+1oTFJrHgWdoL7vp0Ogiv8BzncI/LMPl6
         c/4fXEb97Dqz0Z4AM1/N3Dv/h8O0LtWFvTllVi/zkDJTk8kt6mhGAa1TZhbsOKgwcD0W
         tWhw==
X-Gm-Message-State: AOJu0YwtrsbGbiOueGoP651alOj2ws1qL+x7lNuvrSq/V5pt6Crr5I57
	ckf84uo/k87/yGTyuikvoF5soQjnJy+pnML1aPfyqUAQtOmJj+VdtC6iLQ==
X-Gm-Gg: ASbGncuZhRIMPr3xoNu/zRQyLO4y0tI3jO0Js9xg2c1wz89xlh+V6Dc+hOBAkIpvSO3
	VUeKhMr3EEhcpfzt4/q+W/zMYF/El1N2lVSn8UlXeGYqTDabqnNGnWnNJG50gZmIomdK27Cmz11
	CHXMOb3tydRSP81shhZXWmWPQ2mpuTbfERYdD6IlbMlg/+HdDhN2AXeM1PSr9cSRjPDDx28oo6f
	z1u4C8nxBxI9c5p8dEj9RDjjxosw0uhkSsFrDTnAfhVSCYhkqKhJj6IHh9EeXqgH1f2rBjApCaE
	PNjIbYz4R91CbLCTYB6CdBBBC3S3htGUXXjBkg==
X-Google-Smtp-Source: AGHT+IFsdYP1vGbP3F8+BsPqvMAxA3kfu+ElhMwDUlFb2eFX+ugWn+/Q6sKN0nTqs1ejSOCxRImxYg==
X-Received: by 2002:a05:6830:2813:b0:72b:9993:118e with SMTP id 46e09a7af769-72c638169cbmr6364941a34.22.1743445247860;
        Mon, 31 Mar 2025 11:20:47 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-602845f3c52sm1566220eaf.30.2025.03.31.11.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 11:20:47 -0700 (PDT)
Date: Mon, 31 Mar 2025 13:17:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] help: include SHA build options in version info
Message-ID: <4mivlvpsppq62qrotv7dnrib3izxmhf6zlqga33dm6olvge4tz@z725ju4cshv5>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <CAP8UFD1oYmr=2ZCOVVjk6NbSCtA1Zv+3jy26jSSwHuOfdS6BQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1oYmr=2ZCOVVjk6NbSCtA1Zv+3jy26jSSwHuOfdS6BQA@mail.gmail.com>

On 25/03/29 09:58AM, Christian Couder wrote:
> On Fri, Mar 28, 2025 at 6:05 PM Justin Tobler <jltobler@gmail.com> wrote:
> > Regarding "unsafe-SHA-1", I wonder if we should use a different name in
> > the printed build options that sounds a little less scary. I was
> > thinking maybe "fast-SHA-1" and document its meaning appropriately. I'm
> > interested to know if anyone has thoughts on this.
> 
> Maybe we could use just "SHA-1" if a single algorithm is used for
> everything, and both "SHA-1 for crypto" and "SHA-1 for non-crypto"
> otherwise.

Maybe we could leave "SHA-1:" alone and when unsafe is set use
"non-crypto-SHA-1" instead of "unsafe-SHA-1"? It's a little wordy, but
probably not too bad.

> Related to this I wonder if we should warn in some ways if a non
> collision detection algorithm is used for crypto. For example we could
> print "SHA-1: OpenSSL (No collision detection!!!)" instead of just
> "SHA-1: OpenSSL". And yeah that should be documented.

Elsewhere in this thread it was suggested that we use the internal
symbol names instead of coming up with new human readable names [1].
I'll append this warning to the appropriate options as well though and
document it.

Thanks,
-Justin

[1]: <xmqq8qoodq5u.fsf@gitster.g>
