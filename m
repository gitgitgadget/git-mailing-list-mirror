Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDC59168
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423299; cv=none; b=QJXGnnb7ZgJOQ4IjG6qJScjkcTaefyC/K86jSEVTT1dO0Qhkcyb1BuxwCGTOLplcU8e3VysXUFoZBMQkANAS0V2j7mohzWuBoOUhRnTW353shFKMIB4AVA6QFGE4l8Iy/7aucUWYntb+J0plolLAjPhwgaIXZph+eW7z6g1c4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423299; c=relaxed/simple;
	bh=J3FfNOlJ2vjDyJpuD8dyvbIjV0mxxKsZWd2wk8d0D1s=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=je9nNFRyZ+lQya9I4NhsGSe2BM1whncAtdGg/UDCP5yaih65GAB1O+XrkiWN7i3L5MQbroflYp9qgwQQT0+FqR2AzitkW+7qH3Wi8TWB086fQ+tQxW3uNkyDYYW32rv96g8/M+fsOTSmzyC3vsYID/D1VV8N4B9dtIoMSeHslNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/3eCJQO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/3eCJQO"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6eb891db9so435447b3a.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 06:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710423297; x=1711028097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3FfNOlJ2vjDyJpuD8dyvbIjV0mxxKsZWd2wk8d0D1s=;
        b=V/3eCJQO8Hos7J/QZI5RxWpW/NgAPHqxdOgKAyt0zXZM13VBNt+n/LHuSM63Qku1jj
         AocdcuVumiydc6QfcyTttfC/8wdSO+CP91QDusT/3oQboH2cVxgQbSvCVSxAbt/Thpn0
         DDP0tuvbyKSK/ofhHICp2PA/ocICstl7GgrjVHFbbSeGxux+RCwMObpHLwwXCYghr9EP
         KDWyLn+sOBCsUSroiqQ2d70c+XfxTWwtomFK/lahKUiLrM/cXi9LtjLKIWJLEYhT+eVg
         i+TPf4dk1nrF901RU0MFRF2ieXo2yyQLGXNLABB84etQawCVB+OQkxF8F/O0Jh6AMTQb
         /rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710423297; x=1711028097;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3FfNOlJ2vjDyJpuD8dyvbIjV0mxxKsZWd2wk8d0D1s=;
        b=WsOQD9whrhdaKdDomxFcFFGfveWo0xqwwuuUgJ7Bwbt0l6BHLcyeufBscA9+d57id/
         /hsg/uKA1ohfBP6mtiChMlzzEBSk9MTabpT5/l2eGv33vAcFz5rkqwUQMNk4/8k0Q43Q
         JoLzLCBLrF12ZQy7rXLL5GsctBmkka9FduHqdt+5shjkz8iKUorajIRXs5AYYABwDkG+
         JRr/ahaK9daolu/aP5BoKqE3X4hQGF2TEm9BiFxToy7x1LJcWR35ivMSsCor2IQKjvaJ
         D61rSpfdEAtNWmuViqUMptzWIOeXqlzW1HotwKi6DKcYKSLCSu4CkkGnhD+Hs6eBuud/
         fsig==
X-Forwarded-Encrypted: i=1; AJvYcCXtqGmRQWN/nlkDAXpmS2RGWbw/PD0m62s+HxEh2tgTDmX4dy6cD2YmpCT6mdjtSCNqHhBVPdaCu6OlRwKkx/QhrLDl
X-Gm-Message-State: AOJu0YxtkH0g9s3qIKa+/U1RPJQP/S0vdboECjE0xBoBJUMA5GzmReVX
	eN6aAso/K5h8gKuhbjnk3ftMwj80xiGUck69OwbJuuaF1oAM3rF66QPpMWf5
X-Google-Smtp-Source: AGHT+IGghgaQZMZkpF/Q4t/k3c87ygb2q8yaEzD1NjUbeZg592F32XhTbgsSvpU2FEvZ/0hhDOMI/w==
X-Received: by 2002:a05:6a00:2d26:b0:6e6:b71f:e80b with SMTP id fa38-20020a056a002d2600b006e6b71fe80bmr2095222pfb.7.1710423297281;
        Thu, 14 Mar 2024 06:34:57 -0700 (PDT)
Received: from ?IPv6:::1? ([2401:4900:4a95:fb91:c877:921e:530e:a6fa])
        by smtp.gmail.com with ESMTPSA id ln13-20020a056a003ccd00b006e69ef5c79bsm1504157pfb.93.2024.03.14.06.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:34:56 -0700 (PDT)
Date: Thu, 14 Mar 2024 09:39:06 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Tyler John Baxter <tybaxter@calpoly.edu>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 "christian.couder@gmail.com" <christian.couder@gmail.com>
Subject: Re: GSoC with Git - Tyler Baxter
User-Agent: K-9 Mail for Android
In-Reply-To: <SN7PR08MB8441D40CF11CE1F143447287D12B2@SN7PR08MB8441.namprd08.prod.outlook.com>
References: <SN7PR08MB8441D40CF11CE1F143447287D12B2@SN7PR08MB8441.namprd08.prod.outlook.com>
Message-ID: <ADE61890-8237-4D5C-897D-B407726414D6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tyler,

Thank you for your interest in contributing to Git=2E


On 12 March 2024 8:30:47 am IST, Tyler John Baxter <tybaxter@calpoly=2Eedu=
> wrote:
>
>I had a look at the proposal idea list for this year=E2=80=99s Google Sum=
mer of Code with Git and found a lot of interest in the =E2=80=9CMove exist=
ing tests to a unit testing framework=E2=80=9D=2E I would really like to wo=
rk on this project as part of GSoC 2024=2E Throughout my years as a program=
ming student, I have time and time again set up unit testing for my program=
ming projects and have become extremely familiar with the formatting and ex=
pectations of unit tests=2E After reading the specifics git laid out online=
, it is my understanding that I am to complete a microproject, review other=
=E2=80=99s contributions, and finally submit a proposal/application=2E
>

Indeed=2E You've got that part right=2E

>I was wondering if there was anything else you could suggest that would b=
e helpful to me in this process=2E
>

I suppose what you've already noted is a good way to start contributing to=
 Git=2E So, feel free to get startedwith it right away=2E Looking frward to=
wards your contributions=2E

Feel free to reach out if you need any clarifications=2E :-)

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
