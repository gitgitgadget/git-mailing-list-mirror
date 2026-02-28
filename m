Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982986323
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772239946; cv=pass; b=OQ7aWUoOuYVSJF85AcEj2BQlvBlBYXTr6Rx9p6SB5b20y847iaUM2Yv9Gp/rlSGHMGNQ2B6KYwM56JkeDRes0bqDHEIMlAIAObKoDdfekwi7R8pO5Dpu3tIWd+c7skObVSbBIMMa+iOXwBZKKpblZjwj/dNO7P6vf7YZALAuIls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772239946; c=relaxed/simple;
	bh=vbG75CQsVHvEiolwxQNGoM3nZ/g/0P2LJm2FjdtXUdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epZcBYMhVfKHiCkc8UvDmn3h+jy7ID3jikuvWlVjd4GdZruavhWMcpjTy6cXx+UWqg/pD6G2u5kko0xpOvvufkIq7cF+EJTIJVRO8h+WPPF7XFf0Ew+T1alj/3eiabsH39mBeuOTxIrukxpy4LAwubZe2Acru7EvyeUc+El4shg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx1YIirs; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx1YIirs"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a5cb04f9so35220356d6.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772239944; cv=none;
        d=google.com; s=arc-20240605;
        b=FzB40eQDoVRPVzTGeF+L1AdsRyC71WKvihuU//h2GTskwV6fhvm3cRwxgbLfvL+Pzj
         CYzs5KBdayjaJ6A1qQ/ugbBpDaHaUruDld85h/1fN2l/R1ZsifSCjXJJULtDDsb3VRsv
         ke5NFIyCkeG/94eujGI5FmT8zwPsCUORiWj8KPliQg5Haylcn4IHjv9hCTUGir8/jvul
         o+m2agu1Z3hvqnCWXaGGWxTvo2LVlUSTfO+MKYHiLHr/Jzc1nM1D/ndh9EDnQCyVA4Hk
         BNZWJmAUmGWZGOcQosDnfpyibbrdRCU7StOWcu6TLElSdZV0WQagY27zIPPhQ3baz0Kp
         f8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7TNB+DEzU2gUzFglA/Hn1DyCtNMG9ObkeXH9GQDpuB4=;
        fh=fHmHonVNQX2pvlTjul+YOHl7cHKhoE3PuD8BJz+67wA=;
        b=DBlXgAUsOZFJJMRPUUms3cr31y0TBwHwCkQtwYw9J6H+nCREwtUrwTjV/QejVStYAh
         52yVGWWmt6kJSVbKUh1XnGxNqsxqFxTPoIdP96guH4wyFSnY83+cgQGXbA/xfkyeCP7z
         8xKVD+6P26J88lXFm8g/e3Gehvhli5gM8cOK2k+I5eDIKmZyxkiqw3oaDJhdO/VjBB60
         c5DL2KlKwbY8ZVsO7JVrVmBsTQ/UUFvJ2MqE/EfavPsgo5hzAwwzLUFRPGPnMeak//o1
         M/pykqJxXKUeMPOQftALMLRXOkDi+L99nbffWlj4YXvgpRF/6IyIe2dTCIdioTltEQ1h
         W2WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772239944; x=1772844744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7TNB+DEzU2gUzFglA/Hn1DyCtNMG9ObkeXH9GQDpuB4=;
        b=bx1YIirsNqen/B44Gs2S0qi5rNRzi+x65YXby1KG5hTQj01rxZpOlg4ac1x9DyPnUv
         WXk5DIDcPj25yL8CmcsZ/WspL17FdX6WbkRZPIDdTkrXbc8UKpfRd5cmmdv/l93m80sJ
         vZzG+jLfqztkIpn1m/h0WXbhHSs+lgaoCrV+ykHVlT7QlkGg9BDK+dPxCD9AmMVshkEj
         1nDNNvEY847IF0dclptAXD4ESoJEzZEleX/+0MqVoXO/9oL0V2rhKZMNNiwXFtNhbU2d
         NgO1k77qYa//kprW86LzIL/XCOixnAzckcsiizGNfItYVPRonyB20pCGXa8Sgb7y74ID
         ex6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772239944; x=1772844744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TNB+DEzU2gUzFglA/Hn1DyCtNMG9ObkeXH9GQDpuB4=;
        b=sVhtvuh5fSRnCr5nXB6I3bajSIvnfruU2d9hVrBbknc5/r1bQFRhEvmzxjand1KZqO
         eV+/xxbVHmpy+elJ/GTN7oPTKeVGUcgItimPg7OoQub1SydIf9UbzEwvviyjxb/0ZVEo
         kwcUuqij18GVgYfW4P2pJs161mc6Lo04A6cb2pKQMan3YXR7n3c7R0JnFYKf/fi7hh8u
         FsyR1bYSFKfx9T1K2DivqzgIEjwdiryuLIOZ5QpOaekG2Mc9CkpndOhLFFMmfgRcEupN
         3GzVhtMk7sKioBk+OVBYI7RFoZ/0vox+hH+mM7orWwM1Y8uxklQ1Lfm8rLNUp000tvyN
         /KCQ==
X-Gm-Message-State: AOJu0YzvD+dEPI28RVC7SA/na3KRPe2PFTy/nTh36YsA8LyM4trrHvkL
	a5Aqv7pr59Fh9cvBXFU+B70Ftn6RIRn2Lc9gwS7WfFXDnCoiVnPViQDSKqW4+xw7N0zWGE2W9M4
	AFeyRhlm1DzmQ2PFhQhovC5vVff1h6A==
X-Gm-Gg: ATEYQzwg5Zk3j4TNs4Echin5lsRzvAf+wh6bB4/OsANjAizg9mFfHP4V4Y5EEcqbo5P
	fQyURLOL7ZiO4RZC4+W30bKdfL4yyhvQgYnimCdKfZh13tmcfO9nT1OueY4gVUTbUJIGdWiycrp
	0hAJfnCcxzby3UZNPx8F3XYfkoNYlAzxAmMT5TF2ITPog04Usljdk+lh2oFylv9Q35mb3Oxcgbi
	Rya6ztGaY7oRdyhPVgFjvjMq6XsXFxQoK940dzH9+c7A1DpOf0xO469qda4oZQ/7bzzy5+ea176
	j0XHM36KE3FOWZJtQa0UIIRcoQtfpftXua0u5ppfTaErHrQP
X-Received: by 2002:a05:6214:258d:b0:896:ff3d:18d3 with SMTP id
 6a1803df08f44-899d1db67admr76341116d6.23.1772239943708; Fri, 27 Feb 2026
 16:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227184538.4718-1-francescopaparatto@gmail.com> <xmqqv7fioueg.fsf@gitster.g>
In-Reply-To: <xmqqv7fioueg.fsf@gitster.g>
From: Francesco Paparatto <francescopaparatto@gmail.com>
Date: Sat, 28 Feb 2026 01:52:12 +0100
X-Gm-Features: AaiRm50rrnuEViRSKqyNzov9U7Tyc1uBUvGHbu8hRNvnZjbiJ-R_N1s5tQotqPI
Message-ID: <CAEaT9_-Uc11uW=-APEhqLUWeD0-cXoyi95wYrdazdnL1CKVt4g@mail.gmail.com>
Subject: Re: [GSoC PATCH] t3310: replace test -f/-d with test_path_is_file/test_path_is_dir
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> An overly long line.  Keep the display columns for a line in a patch
> e-mail below ~70 columns, so that after getting quoted "> " for a
> few times, the result will still fit in 80-column terminals.

Thanks for the review. I'll resend with the commit message
line wrapped.

Francesco
