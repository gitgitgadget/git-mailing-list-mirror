Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3C13A3E9
	for <git@vger.kernel.org>; Mon, 20 May 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244528; cv=none; b=hZV5SfCTEZtTpq1XsBvIiZLRETtj9AyFm8IS0Evb63J+fk0CJkI+ZEkZbVJ9lHXvEWhMawM1M5vf7bjXD0A5spQ+czmVCfhW4Gt0jU9zvGSvnyalB6thB7frEiARQFXKEVxKy9zEL+pzSC18oX/d6NTGW7y3iNrnrBF+Qq1BvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244528; c=relaxed/simple;
	bh=tBmBEEQ5M4FTO7lTWEAyPe98m84q+2LA0SDmArIELIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+NoailIozyNKGM99ovhHEYVPDa+IgAv/l7T67c1xGvQKfZwCtZSyZ1Sw/G1Cx/wflhzSpWDgv1sJZS6PjzxSdwTWqxjy1FR4sa9oVvW/z5KlopA32UpVziLFdqH7ppcjONpJ7kz4JKKxfx7oVo7dUFGLEFwil2gXod7mLp171A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPxe9EWM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPxe9EWM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41fd5dc0480so25397805e9.1
        for <git@vger.kernel.org>; Mon, 20 May 2024 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716244526; x=1716849326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVf4g28niQtP9/7bdG/Vpsp50WfeTMfg/+KakGTaaOY=;
        b=FPxe9EWMCpQvud2OcTKd82/FYi2nvZfkrvISKzbhNIjyri496TVo0RPRxdDJwfFJds
         ayeeI77sNC9ATLA6IQ2/GIamHpz4+NZNziH5+UtJE3z4rwNX8/VpUfJ/yy3aPQcQSJ8p
         wpVuaNjV4Y0V0NTHSym1mmDtGVGazdJbkpMqIF8DkKNC8HlgUbPLue62Eu58eJc7i0Od
         T9gkPAUJNp0oIADIWQW5/0u45SLPK4XcVJbrZuIbvIlUi/6+ST1uMR9Bq6LwVS7KRIPf
         0yF+qOlSNgOE0nTz8J7WuTe19xr8RYv/CnoZh0VwOGtrMCDr/FshGqhZAHM4VftdJSWe
         vnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716244526; x=1716849326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVf4g28niQtP9/7bdG/Vpsp50WfeTMfg/+KakGTaaOY=;
        b=ezcq8wV1K8m4tzOgVW2kWRE/B7o0u14hvSlJP2TPB0z9+YFIBp0+FsUWJfhgJiefUw
         qoDRdk+wIahl7y8WZExAiyvTY+nZ/PjwSTxuUoEBL5gKirfDXI1OdWPVPe7cFaXIIi77
         ngxbR7Ncb8mhqZKLR2jrj5KFlI3AJ2alAm+7DYfN6b8aZzWR2eNKdyErVtnUqqFNxLza
         HQ4V4kK7Ysoh5aDdqVMqRL6ZGKxZwqAPxMDbXPJdDhOIBf24WdTqBp50l66R3r+yCXUv
         A8MjlH3Y9Zj4bvRakO4SKStOdctsQKstZ+EVNcJgdFSl4mulaIuwWSy5WD03rt+Hq0lD
         arUg==
X-Gm-Message-State: AOJu0Yx7xU+MZNdnXWCvJQ5RraMhB6mpBhyv/N3YsjI10RrSRJxarrXb
	aqe5egwe9k/MW2upnHW5nOavlvsDwLsMCTA4z0jEgYXgcn4/piWb
X-Google-Smtp-Source: AGHT+IEAj9bYC5SeVRB/xO3b5ttkuhKabzIjjXn2cDZCa6cg7g5z/3D0QzA1RaOIcbCpLO8xSYH9aQ==
X-Received: by 2002:a05:600c:2042:b0:41c:8123:f8a5 with SMTP id 5b1f17b1804b1-41feab40c4bmr239222205e9.23.1716244525633;
        Mon, 20 May 2024 15:35:25 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm441044625e9.11.2024.05.20.15.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 15:35:25 -0700 (PDT)
Message-ID: <83071f70-e8a1-41d6-9fb1-108a31602baa@gmail.com>
Date: Tue, 21 May 2024 00:35:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com> <xmqqh6esffh1.fsf@gitster.g>
 <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, May 20, 2024 at 09:45:51PM +0200, Dragan Simic wrote:

> Thus, if someone wants to have a complete longer-than-one-screen hunk
> displayed and use the terminal emulator scrollback to inspect the
> hunk in its entirety, passing such (or all) hunks through the pager
> would make such inspection impossible.  I'd assume that at least some
> Git users already do that (I do, for example), and we surely don't want
> to make that no longer possible.

I'm not sure if I understand the problem... disabling the pager is
still an option, no?

    $ git -P add -p

    $ git -c pager.add=false add -p
