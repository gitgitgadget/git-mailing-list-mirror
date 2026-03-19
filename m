Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980B38B144
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948562; cv=none; b=Pfuh8OTP/v3iDHBCDK/QoS10HZkFgU/IcDnWe98/VVyIHSjGMudqDV/K5RtjBiOPmU/2Mlu3t1kad8QuHOGhTMs2kvijOKeVQJir0bCoI9BtP+6dk0S0QIBuLJhfpN8e3aUw9fMeRYRb7jQmze/Ge081dgJUN0i0Jln1bO7ZI6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948562; c=relaxed/simple;
	bh=ffCzQwEoTRW+3BluWdu5I/k7dfa/v6w6Ax4v6UpENi4=;
	h=Message-ID:Subject:From:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gc9+FJSl/xdCjld4QrnoNkDwT8EpzIj2ZQYmIoVSrIe/EXNpY19AYA4FLVzsDzuaW1BjraMZL1gWfJCNTWe0NP9QeGk2gTHh2RCW46WwvumWC8YKFC1WdOnDp1g3AfR/q5aMO1s/qpEiXCir8w9bLruIcmhi6opb2x20oMp8Euc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvU/y5eB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvU/y5eB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so10890765e9.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773948559; x=1774553359; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNYYUHVoba+xg3Rgh18T0beoCzPtJU1oq0BYZ8ISmTk=;
        b=NvU/y5eBr3iPqAnNcTylJVkVy/I9PgiwJWQOhUF3nMGHlNETwkibGShSmO3iYEw3wn
         5w+VCf/risqII16iH3jh/i3CQ+QB/6TunbyMV27vPZcSeistClw5xA8H03YQluVO4Uj/
         Lz6sdO9QgRoMWMGZ7Crfm/fAfHYLcrdP6kPioQ+wukngu2dhNM96CLpAFUQQsb9D5JRE
         u1V+QXTOu2xtdGcTjcPcUCr3pKj8SJn38RPVktGvAZooF4sU/C5zZ9VaOjJ7iEuVmr4h
         RQ6GaCz88P4Ajg6/jncW6jb0SGZazTfVp6WOKPTlRibML7zP5KPzNlGiQ1tm+5irkdFc
         RNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773948559; x=1774553359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNYYUHVoba+xg3Rgh18T0beoCzPtJU1oq0BYZ8ISmTk=;
        b=VeiJEc2adxzag+y1QwM/xPVLGkxaVyVLkzWn5h8f0Xjc7X7X0iXfABP6aBOmzaUmQg
         5MFBi+D7PbOnIl1oCmgPCcxH20/IYVv/rIItsPBNKT1bKDr1OBQZ+GziwgeUIkDpM7si
         6znuJBh+M8cjoRYOe9sZYRTNldOJZxtndyYN1vfwWgMekzJ0RKGFxXjUqzwoq7IumKy/
         zYPECTxQsQLFUwIsNJX8iss9czK7eBpMl2/HeB1WGBhTEPaL9NtiSggD0aJyy3CKjipq
         p/j7GIidkdT3egQzVs2Gw7ff3NEQSJcP/nGW8NP+6oLzUAhmjM2qQJAiePC8DCWr5xOs
         5C6Q==
X-Gm-Message-State: AOJu0YxoOfsPT8df+yCYQIXq0odGvVweZ9E4+eJk5/5CNgYH9q5qnkAE
	Ivv7mvfqucSdfyBJLFadeQkeq4ebh35TPiDYzKwiRtEyKh4wS5DzK0acccJB6wgjDUqs0Q==
X-Gm-Gg: ATEYQzyNc1srfjpZ37QUfYNbqb6XSu2ESbJx88k1CTlWGmYUkZiYRl4AzLLb5iKJFdY
	U4JECVXoGh0w169rY2ggT8wBhsEghQDDklk4k9xITm5sdjdArharZ2lNOUQGz41BxovS+2aD0WF
	Hh9mO0bBzp/uSCMYeYFHEhMU7YAJTtW3Zs+BJCS1fAGnt93VOx/KsKDMhk7sQ40D9LW00oSAA9A
	hOmu2/EyUvENm0Mc2uiw/45IUySNj+NznkszYpUHFR6bWzVefMKsZ1+/9VllCr5/POhNHqCklIE
	xpiuH9E3MlfmLmmOJmZ/ZNZrWD4VgfIbs18bujfDpkb0C4zZXHGIUb+2851qMF/1OSMp2zhE8ak
	gl7W/oyLKf7s1HnFTuDN+u/TASszemkOo5HPsqZEqS/8yXoVKQrzna1rSI7VJFRQtWjIYDe/eUY
	nh0EF/lCSvAnIqE1vX6v+hB/dWqyXFYO9pCXVreQ==
X-Received: by 2002:a05:600c:470d:b0:485:2fc5:3b0 with SMTP id 5b1f17b1804b1-486fee2023cmr4755345e9.27.1773948559106;
        Thu, 19 Mar 2026 12:29:19 -0700 (PDT)
Received: from pluton.example.com ([105.72.248.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe83e994sm8760105e9.15.2026.03.19.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:29:18 -0700 (PDT)
Message-ID: <8669d87c1b7f96dd0de37dabfb9011c8745a17c9.camel@gmail.com>
Subject: Re: [GSOC PATCH v2] t5315: use test_path_is_file for loose-object
 check
From: BILAL EL KHATABI <elkhatabibilal@gmail.com>
Cc: git@vger.kernel.org, pabloosabaterr@gmail.com, jltobler@gmail.com
Date: Thu, 19 Mar 2026 19:29:17 +0000
In-Reply-To: <xmqqv7erk5oh.fsf@gitster.g>
References: <20260319160301.98039-1-elkhatabibilal@gmail.com>
		<20260319180803.164335-1-elkhatabibilal@gmail.com>
	 <xmqqv7erk5oh.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks, Junio and Pablo.

  For the advice, will do.

  I=E2=80=99ll also spend some time reading recent newcomer and GSoC-relate=
d
  threads on lore before sending the next ones.

Best,
Bilal
