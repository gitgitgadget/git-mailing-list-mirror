Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120241D5178
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415792; cv=none; b=Hq8NuWh1FW8675pJOIA87u7GXEFHFS1w/M+RZI4zbgzc1TVAlRkea/Jr/e9WsijVMDYP9s1DlRJWbA/zJZXix1bM/8npXDI3tiiPfbwhrTTm8v5gyfcVppOFFvSa9b/XUctcv0xBHfchJ6c/WhKQAtuOuvT7VM08pwAXuVT6E/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415792; c=relaxed/simple;
	bh=MnAYELFor4YAnb/fW4q+1Z8X7v8I6XHo7WQvOM83WG0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyC5yxsw8NpInA14uGnubGl189mX7ROB5cOo9FAYxADiBgKsy2t9r3ecHYR9FDbTdQlukZ3hF3oGkGFaOJGcVgCd88aRU0P9/8V/nFVqlMH3XDzmXJcnRPFmGZHmMpyephl6P2lU0XkIyC5lDiKNLMycggTab5AeNIdnHNlO6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=S+FSb+md; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="S+FSb+md"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ea8b3a64a7so7537025ab.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756415790; x=1757020590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQlwRJEegioXzOroPSTzQskABOdYLAaOsUAQhWUQX1g=;
        b=S+FSb+md9E5JQjGmd6ZiuWA5POG7JmOE3WIWaMBd+Zo3jzEYmD2y8N4noMO06z+9Iw
         lrAVUjRzLWVjjNt0mLS9hD93YS6AwFCeT76f5HKHYU4RFndxcQkJwjuxhqQ3hMb3/0ct
         fhkYgW4NqEeAal8sTmJ2UZVPLUjPbnPSC4eTZltx7nurOb/hcurRqx9Ke6brjSl/TsFA
         p3M5rNxqdL8VzssJVut34mADQTYt58PS92G0i67FdQPGznx3bvQyx3G6t95kbe6JZA9R
         HrxsuSkxeWM14fkPJ+i5/83hasAt/guRQz1FPj+wqXBQfzQrJyK076/KyyhU/6GmszGP
         wmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415790; x=1757020590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQlwRJEegioXzOroPSTzQskABOdYLAaOsUAQhWUQX1g=;
        b=f+aP1yCXmrjo5/DagOqMPf+hfO3FfPVt3eO4Tgq9x4DbN/TTJ9SVcsnfj4PKW4fKVq
         O0R64nL44OZVOqUBrffVFM1hMypaoAKQAOfOQCA19f7HJBrgU+BES3TAqGAOmgSgYMIu
         qPmeX2UG2KqtiLpiLYBW+W/ejhckTrwkaA6uPCiZJYjTtUW6TYFwgTfSs0VUBVLV9vDQ
         K4bun+jqLIKs9iCSNj+i39fJpTdzBS6WtC3GGfRfyYJHIioz5ocT1gP2vIO49W/KPVDP
         at5CYybNeQuzuoZxi30FDQeipjJ6pvUUtx9QJq6zguCrletZjKggtXlbWTjzpFb+deIZ
         f+ug==
X-Gm-Message-State: AOJu0YxYk6BU5hjuFQfKu3HAgEFERB1aSuKPqIrkvNxgkSOMidZqfDrp
	wXuEfPWKMO8nq64DGkABY7Qdkjfah9v1t0rK1A0qrXqTyZjOTWr5M0eJsQLf86s4e2s181oP++/
	lQk1L
X-Gm-Gg: ASbGncsrCe5Z7CnVvZjk2f0IXcwcvX9AJswKISY0ivJ9KUxmdx2k9HO/I2BHpKBuXsc
	av165iHioZCaj0cFGe3ARywpj/US4EMXglVCdqv6CLk7gMA8q9k7ywA1UcCqruJ9NV5LEzTuan8
	nUtxj31N14DtKpDSrzGtQAy4hJ8SJD8u6DV1lQ1sKzKywUromkEuqTe47MNXf5HeoH4mZfZTHUd
	ffI2CGg5E5W5uVefbBSzJhONex41a/B4I1DviB5Sn+QVPqRKJJ59DwY+8VkjoNh7eiC+hHCVycv
	Ibq2UDrAFUIE590vtj8KYAUJvaGJDd4AvLxr//spiRfM+4/3lJI3jl6V2ZUjoop/2Y/1tS4PymA
	c+IkqWODXgG/r2FZyq9frJny6kC9+0uAvQl9f0FSgHkfh5Y4mNtaUA/G0BLK+Gtgpt+RSYnga2w
	GKzchg7EiyTY4brTKVbRLwGfHnQtoyEHvhAKLP
X-Google-Smtp-Source: AGHT+IEnOR8iVFWakLqbzqmS44wALYdoOmn4en04195qKflsf4GH5viQYYsd+hOK6lKOCUrJj/gDKg==
X-Received: by 2002:a05:6e02:219d:b0:3f0:b75a:ca29 with SMTP id e9e14a558f8ab-3f0b75acd43mr84742965ab.28.1756415789733;
        Thu, 28 Aug 2025 14:16:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50d7bfbe81bsm34869173.54.2025.08.28.14.16.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:16:29 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:16:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Contributor's Summit updates
Message-ID: <aLDHLMVmdskbqIic@nand.local>
References: <aLDEPRnXqazmxwzq@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLDEPRnXqazmxwzq@nand.local>

On Thu, Aug 28, 2025 at 05:03:57PM -0400, Taylor Blau wrote:
> If you haven't yet registered for the Contributor's Summit (whether or
> not you are planning on attending in person), you can do so using the
> following link:
>
>     https://git-merge-2025.eventbrite.com/
>
> In order to grab tickets for the Contributor's Summit, **you'll have to
> enter in the special code "git-20-25" to expose that as an add-on**.

Oops, small correction.

In keeping with what we've done in the past to make the main conference
free for those attending the Contributor's Summit, we're going to do
things slightly differently

 - If you are interested in attending the Contributor's Summit, please
   e-mail me off-list to request a code which will get you access to
   the Contributor's Summit and the main conference for free.

 - If you have already registered for the Contributor's Summit but paid
   for a ticket to the main conference, please also e-mail me off-list
   and I can refund you for the value of the main conference ticket.

As a result, the "git-20-25" code will no longer do anything ;-).

Thanks,
Taylor
