Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E73A6B85
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932157; cv=pass; b=XiwMBTyoQh8rGXzTv/I4emm2FG55Fszesc4p8aq6wqJd/SnSw3P0P7+6ATrJe2Wsno0ZwCTGaZvBttvCNlM7KVe9hPNImLb3PYvBRMaZaaJExPP9lDRnvL91xpmYzjj5T8nNMryzDtIyEVbdD3njK1OwpCU2MOU5zQbxsOtc23Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932157; c=relaxed/simple;
	bh=p1b3gkQUK6Z2QBQkKNdvvPZkxI86dcF0NEq1nCuebvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlINKl7ztu0ZWgB/YIix1w4S1DD/5jjiDp8oV1y9/QE8QIPGIwm8gGTQPvHkEsfwmHRMqGRHSY0S8y01zCquNBfbhZfWTxNSjeGl74ZzIRnK4bUzvD5Pi1ibJtInwQj6F4WDrQEcNPitvJJhCwEKOH0My6VtV9Sgzz1ZnlAFCdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNzhCFpN; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNzhCFpN"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so4754350a12.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 01:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783932154; cv=none;
        d=google.com; s=arc-20260327;
        b=LKWkBDj3xyA6tz25SWtILRt5N93sH/lynMGxqirTHDKyQw7AC+XWGUcICblyiUCZWF
         BpKSwffoSm0nN3Bxb7nzJLvpY5ZnefG9TeSnP6Qsr58e6IN58G0UiRdjt73VBw09lIu+
         AD/jLI1bgiRvqrmwqz/dL5DKVnkB8qudY6dJqbvWP2IbFAFGWZ/H7K673NT1mtKTLn/5
         d5YZfWZVPZpX+j6WKS+hJr6dD5RxpmuCehfJvd88PTom2b4hNSsh3iTlFNwriwk4yXen
         eIXtJEkNUElMRcikx117VFsNWwkguwzc+DF/HRUzAPlg4j9DaaPx25P+UKDsa1VxEG/d
         1PDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gv9IZeUdhzFeIR/6g1KGSbd/XgceWl0uhQ/M5JQsv14=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=DYZ4B7wNbF6HWtaB3IW8Xu7fkI/RiSHIjh5Wq6qDkYbwOffYoDtJNin2d7Nvzur0IA
         ZS0YixTwXqhEQ3F6vVm3/RWVaRUZbsdSmG7DFIMpE3X7+4roz7aQR+u85HTU14gQffHI
         rsITjKtsVzzQsOSoQKABHHw+sXpp5fxzjeRrikxlR0vfnfGdB0VJ8CT7qnJ7Qm8r2+OM
         giCFvjFAXF1lCaPjS9rv4996kYvu360B+Qqbr0OxElc2MQzBb6ktX10/3BX1rgbIynmF
         FrxG1B+z7ncGgI5B66qe15s/SOsPKWFaq1yMS5/cjCEuoatgtCqg0zFGjYfOMBzdn0df
         jleQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783932154; x=1784536954; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gv9IZeUdhzFeIR/6g1KGSbd/XgceWl0uhQ/M5JQsv14=;
        b=KNzhCFpNmcQZtUZbk2wmwMxyDVbQgDBMKLgdopft59tst9IxppTfkChV3dUBgNdqRj
         3//DtSIR7HH+wCwBK3GbJjBazMwCxSpuDIX6SVfOfS0/+qbMsRIvIMCDtfb9ENBqqHWq
         cmYMSee77++9l8wXXcwH/YOX9+W3oViZXUiq9vqkuHv12oWhg6GP4S0tn32FzmvrSjDc
         NNX+WiHQ732uDtQQv72xP94ZhHINOKHXGBoZZKGJDf0GVzTPiCJDxym3wD3/fKPa0oy8
         7Jjd3HBC2TT++yVJIcdF5HPhBP6kR3b1Eu3kFP4ZcJx/bqxjD8Z6fhMsP5sh6wdOtS9E
         kYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783932154; x=1784536954;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gv9IZeUdhzFeIR/6g1KGSbd/XgceWl0uhQ/M5JQsv14=;
        b=ejPfN82dknTqbCWXR22VHAuCUJhEZ3qxu/AfSWCa7akUc7yA/nzkIiFGIKWaden4nQ
         3IbmR5ywnJ/aT4p50KBy5g2tUr530CNUu/ZcCslab100Cz2v5i84tNV9DyuwV4ZfHlBZ
         fGIcyXx/WDV3efDxCexyQ1ngtK2xfd7+x096x7hv8WXpS/cxAgVzhFDvtFuBJJeTcyy7
         2hBQHbukAuMBFFy1KKgXAcuTZgKqeCVGvppkOQ8iYbwDVEcaq7Ga3ntzIFsJcBtrr50p
         C4ZUV24jbtvPyHQT9kN2pZszLSj+ZIzGJ79BzyK6DFtvn1+muyZoBKQvT+jkg88+QNnR
         xfxA==
X-Gm-Message-State: AOJu0Yztl+Bo3DjrHmnTJ5RNzchonfNnf7+djih73rLYoGjP3GT0lDEz
	MBgOmSn7coIWnnGXQPqbHZLBOtAbnxGE+G365bXJrWTTAlw9NfYoROIGUkvBUduOxiG+8Agg0kn
	7YZaina2z7qteQI+4qSxZnC9XE490hN5h/qfU
X-Gm-Gg: AfdE7cnr3UdY4w/x+D4XV7zO6F+r+eGI11s+wM4Nt8ZLRzMTS4sF5+QnaCfm6+YmIiu
	YRYj4BhMThkKaai4z5xoUzJfI20+K+Z6wo5Qi/uRfo3wVZu2gNd60EA1n+/o857gAeZtjmSWsjy
	Inex5LIAx79RhRIK3BumwkAFBot27bXoW25q5NyKvoTdmzuE1OgDmlO8HmgZEVC0h7nyTNC9vbM
	C6OqzTgPzDLmjUOeAY0GhVwJ38NTZ6g/uNLdkfgbtzuxrrzp3FXrIqMgu7wCtd0RGkOSAcQ
X-Received: by 2002:a05:6402:2352:b0:698:9a31:364c with SMTP id
 4fb4d7f45d1cf-69c5f23dbb5mr4271201a12.36.1783932154262; Mon, 13 Jul 2026
 01:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxwvk6q1.fsf@gitster.g>
In-Reply-To: <xmqqcxwvk6q1.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 13 Jul 2026 10:41:53 +0200
X-Gm-Features: AUfX_mwn2HE_qAy-C4PKYjHpYwSR8i4obynTsadcCQiBxZJTuKxFXkGH_dUSbPo
Message-ID: <CAHwyqnXLkahh5WXs1wYSizDUAE62PgFSZJnGvfX3k4YiKd7RvQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #04)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> * hn/checkout-track-fetch (2026-06-24) 2 commits
>  - checkout: extend --track with a "fetch" mode to refresh start-point
>  - branch: expose helpers for finding the remote owning a tracking ref
>
>  The 'git checkout --track=...' command has been taught to optionally
>  fetch the branch from the remote the new branch will work with.
>
>  Waiting for response(s) to review comment(s).
>  cf. <xmqq5x37h6fj.fsf@gitster.g>
>  source: <pull.2281.v15.git.git.1782338098.gitgitgadget@gmail.com>

I don't know if this is accurate. I think I answered every review
comment, maybe better to say it's stalled.


Harald
