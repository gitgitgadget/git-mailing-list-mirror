Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46B2F50
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145357; cv=none; b=UtOG0oiy9KC17vtWXrQUIUt8+4ZiUUCyl3zCZq4kEx3SeiPQQtIwCnE/gGRzNX0El6bCbXH7uFUSn7ZOcARi2DLuP23eKyR8E+GgyRfa0m1A6ObTE2rMQNxBYVLcmJGm3auS5L/FauJKbZg3Mh1ctH8SsIsOBWRSQgd90D+tdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145357; c=relaxed/simple;
	bh=Th1nBYAEHKGXiv16iTjPISYXsGJOxe65ONxBMlTodvA=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=SEqblcbKOYdwKTfHpYq4nWaXI1wsh5rD4v/+ulxcQZyhwbKUv8s6LwNQoyx8i5YnkOlr3/jU/WKge9J+iwH9RRiudMw14lQl7PRxCOlJ1WOh8WeevL1LKRry7TqvjIldl0AkxoMDCGlrbwLklSG0YG8f7PDR7vm3v8C43c7J3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTZuxV5R; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTZuxV5R"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-87f74a28a86so6597550241.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 17:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753145355; x=1753750155; darn=vger.kernel.org;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Th1nBYAEHKGXiv16iTjPISYXsGJOxe65ONxBMlTodvA=;
        b=QTZuxV5RuXCbQ2882NgrldRY2j/edXZQ4mtH4TEDVsGNXquIV8UZnaibOU+ekQ8vu9
         hAuxBbMAKowt09qnwfn7CxcgegJ5za4CiKDL3WjwOKaKLRVnMyGdNsBAjBjTAgIzJZff
         1Y0a2j64agtRxm40LbfYvdSsn/to8lbclnOn9kvh4W7stsqzCYcpQOTT1DCtZG+o3tD5
         Y+LLiNvfokAC+9TJoLnsQfqjNig+w+PrZqicwYKsEMh6vDYkbyY1HYjKw2A0lEaUnJIi
         9ki+6ykWwos3rJizWkQO0hNobrYVbG0g0mb0NZ089WB/qjXZQIYD8S8u/uYOvKr6r1iy
         8d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753145355; x=1753750155;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th1nBYAEHKGXiv16iTjPISYXsGJOxe65ONxBMlTodvA=;
        b=VuaCToMoAxoAVk2KOiPROvdE7kmM6fZwtklKTjBsVunzUU6T1raFI6JAau2xsPMeN2
         SFmPlCF9RynipIXQmWwJyJTgNO9bF10Gs+LNJXhQWNMf3mn5oX3t9fwZJcYR9Me4CvGd
         NfJW2WZALusvFyqZDpCH36pVDufH3E5lKQ0oDa+2RA1ECCZ1DjigOCLiliemEZxLp4oG
         7fr6oUwnL19OGqofL7HYrUMFlBEmKxwXnLgBWhJwjxIBtlCNE4yeiGsrELv8B2Lg1Hig
         gFfz7liOftWe+X5mA/SQ5pAZJXO3JqrrnwUnwQLNKu1sIQyKn/KVl4exDhVzaAk+6MkR
         cw+A==
X-Gm-Message-State: AOJu0Yzx7J0i3vnuxCiwB7/ei3qV1ORpuAB9cmrpZGgIdlwzfQyQq36m
	yFfi8jDQa4A3mK5hERyZrHko5/Dh8gBY4KHven1SrxsIoyXGvsCpVSfJFMFMFA==
X-Gm-Gg: ASbGnct1/ErQw1BSFVb6o+787Q2avwlcvYiHxeauBm/qRDk6D+BjUnFI1flWlmWY0kG
	7X+SE50bPAE2qw0JM7wRHWVPttXV+QPT6Y9BgEmfhDFboGRWh8iJ+EXxaLTtGluTEyduh1zBdil
	fhENt4J5MtQ8d53Sri4vlxQDr1XQkW4DbkI+ftt7mAGWkTFvC2wQUVP33o618VegMC03gM8Fl/q
	uz5IanSJSnlpW6l0cYd/MPVke28wZJz7fRV2V3iJr7QQsahnSR5Dzb1IgqVIAgE/jsRfIxj7WOH
	ltl5ppB4L68sxHsbDh8prrVOKJetL6UM37ymGHrJa1vX7lb+hTgMfskITzcvzaDOgxmNGvPwVtw
	TUCTCQjdodPwVK4SqeJrvC4Ur5uCmyI8MwwNTwtHUHukU7bff
X-Google-Smtp-Source: AGHT+IGvxNLM8utbH3mybliqkC5UNNa3stgfzVZpvvAXaUGgCIrVxJN6iH9p7XwezqS6wKNusTarpg==
X-Received: by 2002:a05:6102:5492:b0:4f3:1d:6b49 with SMTP id ada2fe7eead31-4f899994c2amr12642202137.20.1753145355033;
        Mon, 21 Jul 2025 17:49:15 -0700 (PDT)
Received: from smtpclient.apple ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f9ad094a73sm2378626137.17.2025.07.21.17.49.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jul 2025 17:49:14 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
 (week 7)
Date: Mon, 21 Jul 2025 21:49:01 -0300
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Message-Id: <7345A7D3-1989-4ACF-B714-A3B1CC11D711@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

Here's the 7th update on my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/#week-7-jul-14th--jul-20th


