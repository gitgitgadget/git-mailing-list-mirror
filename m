Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774135CB6A
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908386; cv=none; b=P25YGokFHsHDnbSZs4+56XtLB+R+R3YSwRUWHvXrATunBOqC8Rg2L6soz6zguwxbD6VUawAVLGpQTbAFzLpsHfWQhVzRAevF/j/APcArX4k/dGjw4STybLQIHs7zNns8T6yKlaPsgMd2krNcvpyF69hW8Jl1y3+5cOdx3HL6nb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908386; c=relaxed/simple;
	bh=3NN0r8SXP/MopKd0feSbXJavtgHJWbZ+5FlZlS7jRWg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=uaLCedN9OyJ5qrhUgwRnOkcqkzV4xZoJICCGefeH3NtX30+PPXjdeZobQu69zfUu/vb4a4jem4fEsRkxRb7kuAciEujwQXAdypd11Msa+TxNwt0zCwfbU530GGj0kWm0edKZa8e9GpRd0LSXcto18PJ3VEZ1v01CV4n3KCAVEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DShx2Z+x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DShx2Z+x"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so32498995e9.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770908383; x=1771513183; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:reply-to:subject:to:from
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3NN0r8SXP/MopKd0feSbXJavtgHJWbZ+5FlZlS7jRWg=;
        b=DShx2Z+xM+31bVP4AlNeJg6JiPjTMSwwbKPMmtGgzuVB7aFCgqUN/7k+YukuerisDj
         qkPDB9tVnrKQabOpmL//qgTzM9d0NEgOP7DkPp9Er7D59KDrgm8Hbx/nMz0mdIaI/YmS
         r8/DWQdbwJNLW9km2phDLMuEf9v7m5D4AnraSmTKK7MvTuPG+Ey4nM+WLseYj5VptJCD
         W0Htbint/aGDzkWNwPRgbW7OKBeDqa0esu7UgkZ1mLDgVxQGV1R3BxSGATycNHTkVTYj
         U9CEU1aHa2jsJ8I1GPVh9UQ/DxppGoVFlLQ86vkTWCizRIl8JC4dQ4owNoUxW2mPqzgu
         FHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770908383; x=1771513183;
        h=mime-version:content-transfer-encoding:reply-to:subject:to:from
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NN0r8SXP/MopKd0feSbXJavtgHJWbZ+5FlZlS7jRWg=;
        b=k2RsdNwitDL8nw3pTsdYUmmW1ZOj24G5btHJM2srsGzJc8FgoqDYMOxrfuZqzh926T
         +cA/R+JszJQdPaLyVkCruOkGzCB8vwQyBz+UuUFa/003qFm7AdtzyQVszzVBdhi6+s3P
         vqKRV/Vy/VdT3BAUrbRiLSNgi41p9U210O0px3tHsKRjm814ZjqDe8wbrXSS8gsdhaOw
         IbN8PM3Tfvd2rs2PljbpQqRcBWpWtvtwDbIqhRJluGvlKdPEoXj5/qycN7gB8UJtGglw
         o/wPmwf5vudZYrCSCQADwbS9J2GTaEkALokYgRRaoMLFulEJlTtfGYkLT6iDtuik5f9s
         ngfg==
X-Gm-Message-State: AOJu0YzVQw28e1Y5WTa2Mvx6XUTY3fc0ZB5jio1cT8oCBnEL+8XEYIa4
	VTtvtRhupTU/dRENZCuGatrUft3UJNYNZ6pjNnWuaIFQ+AunpThnnWEvpCrYdJXK
X-Gm-Gg: AZuq6aJ8imLy328yjsioWUc+sSwjm8tPG4rfP3WUE5K9/lndo2JMte8hg7plcLmuW2/
	a1Lem7vSviVYNfOJfcaLNrMq/jdmYyd8XjTNXR+caToP3Fl1nI/BZudShZI5Ck76Qc4BGeMHv2M
	z/2vgGah4Nl2OayQNgl7e2G9U0Lqtuoa8aod7D3uCIKh0XDNGybUQ42kFml/ucrsjQAKe9BZ1yD
	MLLOL6MsVNxt92Bvt+Iw/gl01zVVZiHbbWR0n5psn1eDWuCq3rqfyWiXRMm5Abyn1k9v/xWE8a/
	/UkAnooakiwYsOa3y2HOw1g/RtC4pAHLaPbm0Qcn1A/8FacmyjHHxNHM4vsoVxFW/wwahCQNm8Y
	EuoEN2KpdJs70U+2dOVgT8+XDBIlZBrbs6So49J24AqzaA4kS9HpcLHtSEzfM7bbmlJjMC1JgPt
	0wnCOWH4onTOg4IkqVPqjegkSDPgrneajlMZWiGDaqSBeK2oWh
X-Received: by 2002:a05:600c:34d0:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-48367162f3cmr39919055e9.30.1770908382580;
        Thu, 12 Feb 2026 06:59:42 -0800 (PST)
Received: from mail.leaseweb.work ([178.162.236.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d325f7sm12917323f8f.8.2026.02.12.06.59.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:59:42 -0800 (PST)
Message-ID: <698deade.df0a0220.1b19e1.2146@mx.google.com>
Date: Thu, 12 Feb 2026 06:59:42 -0800 (PST)
From: Victoria <spike.chain.net@gmail.com>
To: git@vger.kernel.org
Subject: Python mentoring request (code review + project improvement)
Reply-To: spike.chain.net@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Greetings Alexander Nordin,

My name is Victoria, and I work as an assistant.

We are looking for personal, hands-on Python mentoring on a real codebase. I =
have 2 years of Python experience. The codebase is a trading bot on Binance (=
about 1,000 lines plus additional modules), written by a more experienced dev=
eloper.

The task is to understand how it works, find mistakes and issues, and bring i=
t to a high professional standard. The goal is to learn through practical wor=
k on this specific project.

We need a mentor who can explain clearly, perform code reviews, point out pro=
blems, and help create a structured plan to improve the code.

If you prefer no further messages, just reply "no" and I will not follow up.

Respectfully,
Victoria
spike.chain.net@gmail.com
