Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FA22259F
	for <git@vger.kernel.org>; Sat, 30 May 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153676; cv=pass; b=hBUVRd/7TiG0tSDxBEjQo5O2Uq9rz9Tv6FV8qf71vpvHi0GljEwIQ0YEvXiByc7XucI+2xPW+3kSOjJVoyVRIqkUFixw7u3cN6GuqgGI8URyQxmcrSo1d7zoa0jaIJugwZ9y+azYWhtkzyByu3qQs8rcvZ2SvbDDPcGt9BYBDQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153676; c=relaxed/simple;
	bh=bVn/5ZKAfsZsibh2gSpRZ8ql+q8oDPPZo8Bd2oa/XLc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IdQaKM5MOJJ5RnaJ9KHKA3+KKFRVDBpLwm7X817FXV9+39PcH+CoKgRqwzaFbcfxDT91A42LQGkXiiqqXarR1HCu+G2kiARlTkH9CEsumKwAnrVfHRHa7e7CdUyGlBdU49GWGfkOkgr8uXEqyK5XZztzMjpVvgygOaMDOhb7WYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=diyguys.net; spf=pass smtp.mailfrom=diyguys.net; dkim=pass (2048-bit key) header.d=diyguys-net.20251104.gappssmtp.com header.i=@diyguys-net.20251104.gappssmtp.com header.b=NHofN9ZP; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=diyguys.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diyguys.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diyguys-net.20251104.gappssmtp.com header.i=@diyguys-net.20251104.gappssmtp.com header.b="NHofN9ZP"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84237c55ef9so74865b3a.0
        for <git@vger.kernel.org>; Sat, 30 May 2026 08:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780153674; cv=none;
        d=google.com; s=arc-20240605;
        b=BWGK6je56PGgOos2b9M5rSliy7lbG+AM4IW3pRZ1XQvhwAmLIhAM6jALr/z5MngLUG
         Epzl+X6RkYnX0LXCiRwNib3A7Y9TAlPot5GODi+iyh4qKxpGwvFzmICsrd6DAK0kI58A
         Q58jfVUvMt9lPu6BHnFftY1nMYx4TwFYgZZoRSHMVgOVbB0E0JzIHW+o/Oq+WkrUqQUz
         dTgnyzn2aAp4mVk3VPhpCCOcBALMYTGrC8OgQ7zl8tgFUsWwYyB55tE3BcPfW0MTX/SX
         QwkgpUazyBPjBlitsQD22YvBOyJ3Xy7CHfi3N6p5L3nlcAxq2nURiW1mExboIAZF0ZTR
         jt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=bVn/5ZKAfsZsibh2gSpRZ8ql+q8oDPPZo8Bd2oa/XLc=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=HiPBYpLicA3rmVY4VYrMd+zXdgMC7saAOlof2i00Ng4Z4y/Faf0zyiKnwEBx2HwVrz
         EjyfzaySB+hQasP3C8vZIY6JeUhb6r2YyGZknh8PS1SkFY1rOheSahffU4OkYGPcFnmS
         qWEXCXPRLpJpd9ZU4+1GayGuxZHF/40zMIKILly+mcBJS6c1hIPsY8bpw8YdaysX8DBd
         nFPgxIJlJOFIFOJmFxfhZtPUTTbSQjNvUXXfG73RGVZJyHOW8gwOdrI9zK3xLBTRLMbf
         9w70hRID8NgwmQkGy4TJ9CnLBlHrtvG2aR9WDMbpSxd9Cor3NKoVwepxMGMFMjIiWhjF
         tgpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diyguys-net.20251104.gappssmtp.com; s=20251104; t=1780153674; x=1780758474; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVn/5ZKAfsZsibh2gSpRZ8ql+q8oDPPZo8Bd2oa/XLc=;
        b=NHofN9ZPk8so6H4GvV24bOS06nVAgEdM/h2218vEt2ihOFVGq2CqNc1oLFA6PYc9E5
         0TGLGZRTdv1h+pQXkgRcypvdnhkEeJCGMroQ17/pWTpLyltloYGWeUkDz0TVJxJ7B2HT
         8viyHJhNX86KZXiJlmDXvgccUtonbKMNd5WAylR4oLxmefxa8hoPxy/4dlSR0yr+/5sc
         /yBlCj+tqq7CNdJrBp9rhJPoZjRR8GfXwmlDoFs+/pFdDXTthvwvqzYYkSLCTpPoCDRf
         6juQPNa5sw5g1VJUmF094V502P7NxGKyH/XR9jAYSpqk1b9Qu9QSEpTWMGCQpAF/c7y5
         YFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780153674; x=1780758474;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVn/5ZKAfsZsibh2gSpRZ8ql+q8oDPPZo8Bd2oa/XLc=;
        b=YIcbDlwo4y7DNOaQDGHH+4JjPzNrY0MemvEIUjZskSgEpi4IbQ+y7ucPFfCWv7MG3y
         zuq3L9pRvLOIqb3uWCM0A+cEnc6lOF8oD45mgimYk+/lkJLQmRVDR5IiTV/I8giQL/iJ
         aava55LlR0Md8U+IJFdSCp+11VLQdFhbAALilzu7KL3En5J+afqQyPp60zK4vPjpfrFa
         WQfM3JyLUrWl+P29IEx2pPzH7IYwE2ZpuY2ZCrVssvG/FJxoKCOFoP/qagEQr0Po5QgY
         VpimYwUsNRoxejABuMB5hxPmJirx1S5XTiIGmOzkl9iMx7EzA6OCeLr41BDt2jwN4dlf
         9S/g==
X-Gm-Message-State: AOJu0YwdDS03+Hi9jNH+JSSiEt3NAPayZ2wPcp/3DDRCKc5i+QhXlxje
	S79W6VIgZsIUuSUUiJ/440v3DOvjXdrP+4t3VsV5OR+w6CeYLCL0sQArf9veZIMQheoIBJ4EbiB
	ukaKJzqceybQvE+kU1kMdPL8hxCt48eTXSYP8hcZIbqThFZ4A1Qe9
X-Gm-Gg: Acq92OGbCrFRAIw/ubu/yrMP/vd0t25A9d9GvD1QBqBmaLNtEaf5Cxy6LmijNlsYlu6
	YUO9HTxIa2IquGvq9St83kjXULaKqPqJKR8V7DsYBbKoyqh/T8MpNeLqAoUaZhESXEQyubDtJiY
	q0UDAwbfVsAabUI9dMQyeFkbxbdEdxjcuy2381P5qhc+0oKS1xeqggwfO5CN40snQHuMug6W6Hx
	aqITaOqb5MqMs2IKex0BQOQvdH3q2gXZaw2y6CksGz95id8z0rXgce2mS4hrCLb3g0fhr3wfy3j
	vPrx5UoRbUgQLGSdv7xY33tl90K1KVbifERJKw8PzENU0ZAS0KV0EJY1s71PkRT6lVOu7aKoOry
	IhaFYaZC+VhYdq7NCKVZIKDeSO7sKs0b6Tud3WsfpJ+yahKcagGaZ79usCE/Hgd8spLNVdOyxPg
	eO23rA7XvxlHqIYuo=
X-Received: by 2002:a05:6a00:4097:b0:82d:30f:b197 with SMTP id
 d2e1a72fcca58-8422545070bmr3832277b3a.22.1780153673888; Sat, 30 May 2026
 08:07:53 -0700 (PDT)
Received: from 843110291511 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 May 2026 08:07:53 -0700
Received: from 843110291511 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 May 2026 08:07:53 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bret Engle <bret.engle@diyguys.net>
Date: Sat, 30 May 2026 08:07:53 -0700
X-Gm-Features: AVHnY4J3pIJe1nQVTe-_CxjyDhTteQyqvEy4wEoaf5nc2YP_Zice_xgEV700QO8
Message-ID: <CAE5UgKWMqBF+JDTEfHYWomWG2zBe6d6UMnFnOUR5C0WWt2Hfyg@mail.gmail.com>
Subject: =?UTF-8?Q?Unique_article_idea_=E2=80=93_your_thoughts=3F?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

For many seniors, gardening and lawn care are not just tasks on the
honey-do list. They are enjoyable hobbies that also have amazing
physical and mental health benefits. Still, as we age, it becomes more
difficult to perform the activities that keep a yard beautiful and
functional.

We=E2=80=99d like to write an article for your readers about how to maintai=
n
their outdoor living spaces as they age.

The article is totally free. In it, we can talk about a variety of
topics, including low-maintenance, budget-friendly landscaping
options, senior-friendly gardening features like raised beds, and/or
tips for making your outdoor living spaces more accessible.

To give you a feel for our writing style, here are a couple of samples
from our blog:

Great Home Improvements You Can Do Yourself
https://diyguys.net/blog/great-home-improvements-you-can-do-yourself/

Ultimate Guide to DIY Shelving
https://diyguys.net/blog/ultimate-guide-to-diy-shelving/

If you=E2=80=99re open to featuring our proposed content on your site, plea=
se
let us know.

Thank you for your consideration!
Ray Flynn and Bret Engle
DIYguys.net


=E2=80=95Totally fine if this idea doesn=E2=80=99t click - we can reshape i=
t or pitch
something that aligns more naturally with your content style and
goals. Our goal is to deliver value both to readers and through online
visibility. However, if you=E2=80=99d like to opt out, just tell us!
