Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689E374F1
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748205266; cv=none; b=u5R3tQbvZR7vcAY3vJAZCdLLoiX/6Bw3lbP8i2dMvZanXS8AypJWdTdEBm7+gQTyW1vKPBVQ+9kHuHns7GeOpxXnx+V6JeAW2KvOIklVLQthj8+Dy/oH+lAa8jx8sFf1EaloBkS6zV4Xj0FuQ/4aEGJ6WJ3Q+rwyXoxZ9nJrXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748205266; c=relaxed/simple;
	bh=L/uJgqRWuyX7BsDo3MfXwimDaUxdDXbKQN4wuLkup9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WY1xOqS11Ki39jVspIFdskLFG+hXBlY8XYlpNpujm7PbiHHHkJSTTuS9iO7Eb1JXBc3fnFmbdA1OVAVSTJU/UZqJzgoYtXtsF2z8ajmQJAfWwgJF7J77o4y9ZTo3rL0CXgWlsEp4SitnTF9W7kuQgeboeCiZoWIRqkfWt3e7ubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c548db0aa0so29773785a.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748205263; x=1748810063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LesvsY9M8I/cGsnpBtcr/RQ8BcxD/j4wadbXuYUY7/k=;
        b=YoMLsplRXKJvt/XXdmmVCDOL67kbXTCaCbAgtX6SmKhdJcpKi0GeNaNG69MlJbEVCm
         HrST9KghTKLuGe89OVYYvBrXOjSune2tWYdy9hur8qfy42Bk1mvvBHm0P9JmC560nlzZ
         uEnhBc95Q78j2BQfDo5g7/RQchEiUwgP9ylI3Hs/8H0tzlmixgQCb2NZ9o0dwDNhC5ev
         5woAfAD93ZBuS2spcGKG8c85jmvrgXEqCOWqjbtgdzIjbBHuQOZ3x8NFWtZOt7zrrIKG
         oZqANXIdaTvHtqOnyUhC2JM+vrIZDdQ9TUi+CcVCoLoGe88weUcq5nGkPKSxe5LCe0ZA
         A+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVhgoXqB9shK6bXzdMU4XsNzPouSJujH+KCliagcFY/vpXR9KL+woEUWfsoPL/JlLbntE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTopHxvBFx0Yo6chH7HYCka9xwNpnZz9hBruR0z+2AvI0Z9sI
	d5FdJG6WgsdnORkmxnaJJShGQ9C+ByQOKIjlZUmiwemK8jd/ZGT76mdhp3JM7Sz3MqWfZ/L9aPr
	SJ2SqwDqcYDxLX5K0nou5/zQ5C6uJAiU=
X-Gm-Gg: ASbGnctEO89ihO/iqcme4HnVQfFZ4Y/hzhi52d+W2sG0MAh8+rX41op55bhpdf42rQ5
	cGpfJ+j5mOKzDZV4ONfxNYfy5TDchQ5Cs3xtwhdJq4z2ZWNzzuxQZxc0emr6CjiWOfW1mUurgQR
	pJ0WbZX/RK3m76oK8JFu14DUD/kfHpBgnIpBqhHgqFeg==
X-Google-Smtp-Source: AGHT+IE14zSY6fIfrwm1cJIJy2qMALucjqsMko+xnzz4xsI3TDDvHNA2RwjWKZuIHrAldOmn2JaFSeIR7yDnaVDPov8=
X-Received: by 2002:a05:6214:19c2:b0:6fa:a0ac:8d44 with SMTP id
 6a1803df08f44-6faa0ac8de6mr35647846d6.0.1748205263068; Sun, 25 May 2025
 13:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250525185447.29982-1-gargaditya08@live.com>
In-Reply-To: <20250525185447.29982-1-gargaditya08@live.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 25 May 2025 16:34:12 -0400
X-Gm-Features: AX0GCFunei1whCiXiKO-2MPTVALFliJ0LdxUn29mPGq1hauq_XySLgfT17sWSIQ
Message-ID: <CAPig+cTdaGsJpaE2wHv9miPyRk2GusETOykmLT2O-MGiavfY6g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] imap-send: make it usable again and add OAuth2.0 support
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>, 
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>, 
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 2:55=E2=80=AFPM Aditya Garg <gargaditya08@live.com>=
 wrote:
> v2: - Added support for OAuth2.0 with curl.
>     - Fixed the memory leak in case auth_cram_md5 fails.
> v3: - Improve wording in first patch
>     - Change misleading message if OAuth2.0 is used without OpenSSL
> v4: - Add PLAIN authentication mechanism for OpenSSL
>     - Improved wording in the first patch a bit more
> v5: - Add ability to specify destination folder using the command line
>     - Add ability to set a default between curl and openssl using the con=
fig

Thanks for describing the changes between versions. Reviewers
appreciate the thoughtfulness.

In addition to describing the changes in prose, you can further assist
reviewers by including a range-diff (see the --range-diff option of
git-format-patch).
