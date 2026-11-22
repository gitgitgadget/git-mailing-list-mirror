Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795331217;
	b=J5n/LB2lfYCp9cpTIgKfqjKsdBhXEnSQSur+COkxMi6cbCeXTcfM+NoA11cYx5j3cafb
	 amv0ZEESSxwx/48nMgH3qaRjZSEIhWjB15Tnva8KM4jF5YQGvozLQm6Y0K5E7MkE41WOv
	 nPnUP3BWUhKPsHDwK+9IiJ8YTm6m6iFdrBTBi09PfZOtzwTb89B1gHksF3M6de8ChlJ6T
	 fsaBtgfrXZB/LZNlWHR5C4h7B9B9gODXt9nCv+5MK/tywWam9Sz/8R/3jjMpf1g0ppn22
	 yVpSwjfZwe/zMYaWiVyA8az3wHsVQ7/J+Th2ioViMmlDR9ekp6NXXJAy0Mxex/v4LyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795331217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ZNt6vCJRAocZhUCLlSH1FTZ0moN7UjOcOtyLSzDWcw0=;
	b=r3w5YqFrQcp2w17hZPkNiW+oOetopCe3UMNEC8s4eoJNHB4RkQ8cPFi4md8KZvLCOLza
	 kRbeIb7XpThrU9TpHtcy1DAifviHqURdoHr/FutbIdDz99MvzADdoff3yr0C9VoXrKF1W
	 nO6pjNVChystXTsoXfZpw/Z8KhvyT0qAElIX6XPrhpKk0vBUp8eXtwILfQz4SxY2ZDZkz
	 bBgN9oLBCBcdoGXmEmIiqlP044h/wm3d4EaClbPa2KcGnIgd2JB1aT93IlNlW49UV8b5Z
	 6q8cMhzzNtPdHnRW3UBRcd5wJ1IcN3cXbwI+kgnZMoxpaHl+s8ISdWNSEGulu2C766g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sA8KU0uS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F9606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 07:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B4F9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sA8KU0uS
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4ad60ec5eaaso2118513fac.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 23:06:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795331216; cv=none;
        d=google.com; s=arc-20260327;
        b=k3z34pMYcle+AhQEt4LxgoIgexZ4B+oOw33pwr5pzdeKV5y7At3qMvqsqN2pjadLDO
         oons5xHfqxNuOhxSMU835w3TiYLJ7iVXKq7gfVsnJNELR4Rn8UgHIIKPQQgsPhp05yN4
         5N3gAshyO3xeybWBFWHPagtTNbZSxotCSKtlCA+6yo6n0dUZkLubU9kA3/3DiFOrH3Ys
         9gjNEQJsK4EZH38Q32GuR8g0ClUYwf0c3ZuHYh6XPLiZlrPO56DOJuET1lpHI+wCC7re
         oobTWri6lb5Qqh0xzi3dxkJGWAM8bYpe5yLRwUAvUj2yrn/YZPg4QLV3B0IY+5ibTmbN
         8yAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZNt6vCJRAocZhUCLlSH1FTZ0moN7UjOcOtyLSzDWcw0=;
        fh=azt8TgWTl01NptQZMw9NPhZWceF2SXJbJqFTBR6uZLs=;
        b=suZq2gxwq56LC0di4W66vGNZjnweMvoy8XAh7z+iboZcgcNseWdZw8gQXeN53iAqmN
         q2GbvGJ1KU6MZnwmXXUU/BBlhl8M+lLNRrs+m2WS7AFR24wCr7b6R175hMUrqDlyf7Eh
         gASTnfenKQyMZBOvy0d/G1DpZ7Lw7VTFiuVD66zLLW0oPQbOJp3ExrRWMfrt/zfVfwUh
         fGnk3Ns2f6BA8LDcPgY7x3ZtGJa+xXt/jkNwNZmLVawyeg6Yz7xT4TffdI6OdqlhiZd5
         k+M79aihYapl4wPjva8vvR99Dzi4eo24uLR06yRv2E5lxGuYyBfelKA2uyz1kFUcxbWu
         YUJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795331216; x=1795936016; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZNt6vCJRAocZhUCLlSH1FTZ0moN7UjOcOtyLSzDWcw0=;
        b=sA8KU0uS2/yumAI3Qs7pA1rG/6D4vGulqMyjT43xpWQ/UW145XnRNloGBjEqZKADmG
         Mp+EqHrGBsf+K0l6dfqQHnuAaaqsX1dy3Kk8Tq5eSfwgY9BnFuLOynH6dC+HHWy9tsbk
         SyBv+vi9dYfj0/UkTF68XxWB6xQm0KJALTOqi1Zt8vnE7A4oqHlK9VkfHWu0BAuMMtt9
         YKmzyfJgul/om1nC+2sTxAuTMSXbUVZM0IRhA4n8ZNRrQ1CeaZrAVLWBaxL5S7nklIEd
         W/qX6YNLgm2y3nI0f+wG7qH/PxVxJeKJrOcSnqivTf3KD6tA3YH5XKV90fGxVNHDwJkz
         kA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795331216; x=1795936016;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZNt6vCJRAocZhUCLlSH1FTZ0moN7UjOcOtyLSzDWcw0=;
        b=p/yTNf7bjKUiYLl3M6fxs/D5US04a2Ns/deNSXgQqQX+MOilBKSzNtV07dACWvBuG4
         Q01Pf6nOe+DcqoJqsozrQyNDk6kNvqBeAasggS/MOJ+I5RK9cYxY5JCSBgmxpondJuHG
         qpTXI80riLoyUBzhBkVsHir7rCuyO2JNM7RSsPgvkx+P0FuhVPLDARdVINZxbDEavlxc
         aRy33Yk8wpyVvloHtSmxkTpn/LjKEzfzfhzBBEkE3vZbQFNAj4LBpsNcVLNiuX2AqZuc
         WqtsXeqerKWcCl0coFR+hrkb7IoHqWbp7qGL+r01+HmLIXPt+z/Zl+Pb9wYxhdSA9svJ
         O67Q==
X-Gm-Message-State: APuU4Z+zwNPFwdGy/1/UQHJbrgXpxqCVOYp3ga/7Pq8b2Ewa1lymHJT4
	2qSCFN1APHCLzjmqFGO6jtzCYGjQsY+W1tjoGReubh5FfsiPGMtx1xVALe0DAURfjZ3bITojgzf
	MqVDlmq/9+fku/fn3PParntCPAfr12Vc=
X-Gm-Gg: AZFdTZec0phNC8lsipzaVdoFrl4XQKna9KCVgzAv426aY+zZHU6zmpizRDkzzwTfJh6
	phUKBHCHsQsg2w1yPBm0GBYFu4SnLgJ+NCsIaU2tUdrHYvUmlI89yfEmbmP83onDhrBUrVgZeCQ
	zavl71xeTQcxKdL69rsuD3PjQLxQ/oba5sCyPq55VkM7Cpaw4+1x36AeGhCKieO2FFXZMnxSZPd
	p6tW/7xCMjc2F6wZfOFBn5gcuTrvFyTX/B5NjeJvh3saSNbkIkfqk0C/Oa0eZymGS04dMvtGk9i
	/kQ9r7J1kEnaZBjF3gGgxqVukgb/zBAk27E/KycO0Bse0GW2asWbxBfcCasF0TOzUG+DF/uBKPk
	OPM26A9dHDxdVaCo9Yq6hYQ4p9nq4h6BcnYc=
X-Received: by 2002:a05:6870:2395:b0:4b6:dd3c:4569 with SMTP id
 586e51a60fabf-4bc85bebf83mr4719072fac.32.1795331216213; Sat, 21 Nov 2026
 23:06:56 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-master-v4-0-5ff523db7285@gouders.net> <20261120-master-v4-1-5ff523db7285@gouders.net>
In-Reply-To: <20261120-master-v4-1-5ff523db7285@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sun, 22 Nov 2026 07:06:44 +0000
X-Gm-Features: Aa3M54oNzvEJLiz0TxkNJNoMDKxUF0_FgmjlLrGFSy58zDAcCdBek51n-OPq-_s
Message-ID: <CAHWeT-aetC12pnVs=rEH0kYt-RAunfULxkk9JpvmoMi4puYFng@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] utf8: introduce bounds for display_mode_esc_sequence_len()
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Dirk Gouders wrote:
> + * Return the length of the ANSI display mode escape sequence (e.g.,
> + * "\033[1;31m") that appears at the beginning of the string starting at start,
> + * or 0 if the string does not begin with a complete such sequence.
> + * If end is NULL, assume a NUL terminated string, else never look at *end or
> + * beyond.
> + */
> +size_t display_mode_esc_sequence_len(const char *start, const char *end)
>  {
> -       const char *p = s;
> -       if (*p++ != '\033')
> +       const char *p = start;
> +
> +       if ((end && end <= p) || *p++ != '\033')
>                 return 0;
> -       if (*p++ != '[')
> +       if ((end && end <= p) || *p++ != '[')
>                 return 0;
> -       while (isdigit(*p) || *p == ';')
> +       while (((end && p < end) || (!end && *p)) && (isdigit(*p) || *p == ';'))
>                 p++;
> -       if (*p++ != 'm')
> +       if ((end && end <= p) || (!end && !*p) || *p++ != 'm')
>                 return 0;

Those checks can be simplified a bit:

          while (!(end && p >= end) && (isdigit(*p) || *p == ';'))
                  p++;
          if ((end && p >= end) || *p++ != 'm')
                  return 0;

In case you want to go back to a length parameter instead of the
optional end pointer: I looked it up and functions such as strncmp()
and POSIX strnlen() that take a length bound actually support passing
SIZE_MAX as the length.

The key is not to compute `s + len`, because that can create a pointer
more than one past the end of the object, which is undefined behaviour
even without dereferencing the pointer. Instead, the bounds need to be
checked with something like `p - s < len` before reading `*p`, which
avoids creating an undefined pointer.

Andy
