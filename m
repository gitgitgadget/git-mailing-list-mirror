Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37673C1FCC
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973305; cv=pass; b=ZikVNAqLlbCemfyyahVr9nGeAGLmYRGq7z5MxsZX5ahmWhkTKzdS7jKxyN5jC6K+dhQTF0JhWUtZ8JX4iCE/XyIiOmZQkj1T90w2HYWHtq019OvEtAQ2DmpjUFmXJp4tw+fZUK7QYT3Cth3LMefqPCRO+UPDi+0Z+yLfoP2WlSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973305; c=relaxed/simple;
	bh=sMIGkk3b9qm8fOrDvs26CwATH4lbJrp3kgx68NPaanc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVXZbXXbQqSJ38LKpnEgNGBVJQ+WYYnsjX+eVq0mGu4a3S0XDmYi8PYh57A523aL8q004jB9O2w4Dwb7YfOohVDxOWtgsYss4W4I5NB0cedFURbzlsVCjgRwZi2WdtreqaY7wSQhNwCXbJPJ/6Ohzp/hoT/uRuOTzyeyHO8Yv1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=GWeCaBJw; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="GWeCaBJw"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64669a2ecb5so767952d50.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:28:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768973303; cv=none;
        d=google.com; s=arc-20240605;
        b=TeUnR+GWVGqgCl1X+2XfQfcuNGKPRQo5gRji/TtD0VTj+CziixoFFdb4oW7DwoCUHa
         AqwkYOocRj90mq0E2llnKpLPf3WxhvwTeNw3gRCyH1SYvl7eHkP/oO7yq4nI0y8xIT9C
         kvie7gXoT3gOV6hhMMEvzHMwPzARuvmIWUOrRug2SnMR7MiQPQJcwuULzE58iYb6JL09
         Y2OT4Z2oSfGy2gRV7jaSgwVKjeH2P0q07EEbqeUcA58hUtgXDq+Gv07OOGDKSWW5OvD1
         3TLDvBiZycs8MWOHDdjYZ7QGUd9zQIw78Jx0XR8EZajIVXzxU5k6/PYJXLd0q2cgSM3v
         YDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sMIGkk3b9qm8fOrDvs26CwATH4lbJrp3kgx68NPaanc=;
        fh=nZ7AwcQB774YPW8HuUxIWUYZ0mAEzqVhEgrGoYVASPg=;
        b=Qft8DtfKKbuRhaYGy09oAqm/SGIjYq/sgocZqxs2alIcW9c7QslGl4HJ2935DTgdBs
         NfYOO23GqIv17VZC6cw7/RSSExEyzDqSoueP8cW7mm6z6CsBeXvBD4fzH4vDG0o91qN+
         dCq1PjrAfOfqcyNH2EFYuKdgmZStFvHROkYgrrWNOdiecwjvgHpOK2rZBarOEP+wzPWV
         lxEfMZ02YB/S7UbgrWJVYQRnChUv13iFw6EW9JLdwo6SNABMjfyWkUUg5/9NEB3zPusr
         8r2vxbcvHoYThcMiv/qMJcnmaaI9rdbPJF0qY4d7ZZzYmk1pvYLufKwYLfzp06Oupa/J
         3A5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1768973303; x=1769578103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMIGkk3b9qm8fOrDvs26CwATH4lbJrp3kgx68NPaanc=;
        b=GWeCaBJwjbOennEf6RiZqG+M6jtasOUHY6lF9o2CAr2SAjibarweykwQO2s7nvWjoj
         yOoinb4HhLJfjMVZvScqKI9f5ceFSpTYmhv2m59kF6R44ht8mom/9hcoQPi0NLRYcsV5
         eqwikxJ7fF7MX7PucScZA0aPwVOxj1Nr5GtMVS4XuHg73T2m5vkuO9Nil3tEDZ7dL9pz
         EKqO32w5NZX9ZThC+fy4rgWPjM/I8jbQtBlmwOd0OwwPe4Ed0I9Lhf/SJ6FrIb7XMWli
         M6RR8ossO6Mqc0aIgemxMNrF9BonvZOesRBrgRfldxiCVrBIWH3ZQpulXBD1irMNGsSU
         KwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768973303; x=1769578103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMIGkk3b9qm8fOrDvs26CwATH4lbJrp3kgx68NPaanc=;
        b=Y75ciy+MGYz1WpVWZ+YR7YQ6Ut8C0TDUoJAI0vctQ5w6G8CLowb7OJgjasmBoLHevc
         7EgLNejiA7siNUH/ja1ZSBEynKpO4Fr7cc8uEM/pZdo4NkXHqDSsZV41DehMuSKrcfkn
         N0HqLGIRWtTTxZH0twNQ/hnsnHY4ohcc5doxwOh3nDxu8nQ0PF2BM1hNIyiPWFgPrtbz
         7vuB4AxDuTy0MAwtMquWdAzSEuSRE7sDRdwBXbJuDm0pX8tWJTq9h1iaBvxGEir2tS8y
         EnKd9b94qqVo+RET+9/pTataOjcZP0onPXSM0dlAPbymJG+bPRdvWON5p79CAGcZ988r
         93Qw==
X-Gm-Message-State: AOJu0YyjDvRwu1Wt3IgarJlx7MKIcdj/tV5kodDtiHkUw9S3WNe8xxCT
	RHIL6S8MlIPMLyfWsA/TisWuAl81q3YYu+EGfzhY5l5jXTgC1uWKUJvxO9xRUxYYFWq4i24154z
	+k3YHeiHhre+KXtGuwzp8RIU4/XRU3YKiQWdRCmDS
X-Gm-Gg: AZuq6aI8CR1fzQ2lwmz2IZOjdWvCe1YAO7m5F76WlQ2ArbgyxaG/KALcOHf98eE014J
	szsPY5BvOTlKkxcpZX0elRc3odKW7WroEzAka2AW6T/k7oJ0ItxQhp7htNGuR1YxBMoA8qk4uRt
	YObDpWHnFiQf0ZJV+qxlJ+ptjmI3zxcU7SG6SGJylxbhNFYZ0FJiejVHC6KGEtok9SFhjcHvzvb
	R/Y8enoNETrKhCNoQ86W0FMRLPzBhxnO+tOIszYJjuVpd70zlXsN05fQDczt8TSwSaVnAWXiTCm
	tuqhYkFHCT7ON21YJlJ5Uas=
X-Received: by 2002:a05:690e:d09:b0:63f:97ec:a5fb with SMTP id
 956f58d0204a3-6491690787bmr12119279d50.5.1768973302762; Tue, 20 Jan 2026
 21:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM8dTE=RciNHyyyhtprjXL22deTrzj5DKcBsSiAt0jFz6Az8JQ@mail.gmail.com>
 <913c7904-1f31-4d76-bb4e-178ab94f0e71@app.fastmail.com>
In-Reply-To: <913c7904-1f31-4d76-bb4e-178ab94f0e71@app.fastmail.com>
From: Stepan Tsymbal <stsymbal@atlassian.com>
Date: Wed, 21 Jan 2026 16:28:12 +1100
X-Gm-Features: AZwV_Qg_A1oE-W2V1l61eZZbFz3jBXjDC5cFd-vBx5tJWAlv7kxyzB0g8F_7bRI
Message-ID: <CAM8dTE==DXQ5Qo_hJ1mZNX05-ZBdVzg7rqLS7fKaWnZs+OTMvQ@mail.gmail.com>
Subject: Re: How to get failed refs with new 'git fetch' behavior?
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perfect, thank you!

> I think this is fixed by the topic
> kn/ref-batch-output-error-reporting-fix

Yep, looks like display logic was significantly reworked to
accommodate former behavior.
I also can confirm that the build from 'seen' branch behaves as per
your example, so it should do the trick.
Not sure if I can help here in any way, will keep an eye on the release

Thanks again!
