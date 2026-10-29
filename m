Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793263170;
	b=2zma2tjJ4jRoyuWGVOCtLXobymCh9PTdIK4mzLwvwPsZSpFFubSwwXas0rLCFAWbaSRV
	 HsSxk5U8R+6J1LR413mzSMCnly4zGoyTAqcjFDv6hva4f6qdkxtnpHO88TmMXAIyCj7gL
	 VhNLS/eDkItyVPW3gIuEGLsEPXwW4UJYRXCqBJo1W3an7/4cyOuCgZq0/ZWKw8J9/1Mbi
	 ShZOWGgKuPOzp5/fbY0rpq6sVkV9uFEf3wobA+ShY4puM0Pggk1clu/iaVDyd9BbtwSC8
	 LY16k2+fEQn3ftN2vby4f9Cq2ywS08vfORK3gLds7wlNFYsFRseFzGwaLhb/g2zlP+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=UCn/ruo5eoC3TEHE6kZLQ8YsX57Oyxb4g2ia4i6FlLg=;
	b=rcSqebAQ2Q3dqGDAop8VeC2wbsYSs5uA/sbC9xqV9TlnvasqaLbAz+YQxW8dcTUj26Hj
	 JoO6qctaT32HPeD65sfoYjGVxNFmUhlxSrpxjCvQFBJiKoNj8QQnEfvIw//YPxq1F8pi7
	 8dw33Xa+binYygkgfmv2ewEBvCYv9l4lKklwco1CjWFrBuzUu6iiE193KNJSU1wb0pmIl
	 FtWwFv4YYtblprQ10S6fN/+Y5us+0F7bMOovsiaZR17Ke/2nxwVQGFVEs51FOhjIZr3nL
	 cTCL0DnuylE/8xeoBYUVpGaBX5gJgjkKRbczQE6LvWXl/mYquqsjB23exrMT8x90iVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsuLSg+w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E02606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E02606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsuLSg+w
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so2821393a12.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793263168; cv=none;
        d=google.com; s=arc-20260327;
        b=j1Iu3K7f6q/ts7XxMLEFA5nJHeL/lb54/E+XAz+BxQhdkJyszXWCnHuGJW1EJmKd8X
         UVrv+VwZkl8jYKwVvak0CpoRSq5dlXuYw79LUOYT2GgmdJBuUkDQ/NHg9k72XMWf+1xQ
         4ibQpfhHIIWhG+jY20nXUEb7bVmeuVh+YmmrKtHVqsA/tCgK7QUgRMFTc7+1dr/1O65t
         Ql9FT0y00rKgEVKxp3lHBfLiKF4Ou6EBg2Yq9UV+sfSdvw9pVrIKNjiVzps7vErg8+m9
         EIItSxguOAWAMh3+CLDqtrs2BiDYbZ5+LCJ6WeedA5lLzDp0gAMQko4JY4wrsUGsqu0b
         Wz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UCn/ruo5eoC3TEHE6kZLQ8YsX57Oyxb4g2ia4i6FlLg=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=fchHTuM0i5jMvt65WlsKgiV89z2gHDOZ86ki4FucuiHgtvZWzxZXLnEbTwrEDpJrwO
         r8xhPvskZFAcHkLDuxFY89lGRlR2uu2Wf9PqprmHQEy7zfm3UQQMoet3yhdfpAiY+p+Q
         +lR0yvJ+tMX2I4DxcPgQtJu0q2z/SEBBpDJU3BZ6IktukIx/sFYQvMaljJ7uoat4MN4u
         tvjtn+wv7yBjezc+7ejS0ZQuS5YWfB9T/IYt3UgjCdlqp6gYLwBmeJoru8ZM2AsJ6AZ6
         9gPTtJkMVavJhWQt7hauZlvoCm2MWEor7IMpolG8mH4mURKFA8ouUqGnnuQeQj/8qAMs
         6I9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263168; x=1793867968; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCn/ruo5eoC3TEHE6kZLQ8YsX57Oyxb4g2ia4i6FlLg=;
        b=rsuLSg+wsNtKCToaMy4nBMlPlqXzcWJzs9Syj23nWFArIs/z9hmSRDVVpKIQFSnaSs
         XxR48vmL32HxZvJHamGfUN6VgYKUZq4LiTaw6ppj70bmhVwkU/K+7RCvUDumn1o/9l/c
         FdeAHLuA7YvMbKJVnm6vMuWMjsJjL65oAh/x0SAyMayxMXTAjDKOSMEtL1C1/BHOaEUR
         SdDUrRBHsbhy0rB/ePzsCHCusakcuqpjhWMceOswdmF4w1QgKgASMV1qvvbAVKZ5U0eJ
         YF6utIyrT0I8PFE9R/6rS1joBXQQa3v6677xN2vTKB1Q33o1b4HT+jdc8cC6cKtck83+
         /z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263168; x=1793867968;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UCn/ruo5eoC3TEHE6kZLQ8YsX57Oyxb4g2ia4i6FlLg=;
        b=aZmolOpxTF7afdQWuq02/7/AMr7ZWKTSJXaD1uUFkEhQ7AXFIwjZnBA7nTme3THqzu
         IT8tD8Ik1y9GZVlWz6d+6RugetxKD8rJuquCBHJ4FEj1LyCXyOYDKHzcgD1mySvrY6Wt
         UE7MJNi0OycQgnxYovT1qVEphquV4oXJ/6wwP+QK9oN7gkVTlSoIzw8jTo78k/a6xlFY
         V/X18Bufq4lGKnupfJ5gaeDXBSbdErc/V6EIx8RQK9W6tkdnSAN14+PcKG+3uqe5XOYV
         e6xPSRP0S23HzZPJEoyS85vu/e65v3ccNMD+V+7Hr3Y7OT0fH9+/j/8ucxogCCfDYjXB
         nPRQ==
X-Gm-Message-State: AFq9FYIyvCNhyq+6cNCdoupCBjt+g5+GS4sNFuUwSDMaaBn7vOi2Hn1e
	BGDWuFgonFNtuWFH3h7dHjadrGQo+mrhstJmcck46It+xqd5SdroSXPC5NnFmeKaBIetBbLN27I
	iWewu0mJr3o2wULLNC0kkOBMpJ7JEky0aeTEt
X-Gm-Gg: AYBFou1Kdj8caasmSkaudsDIFBcytgEDN7sv/aYqCbKCMy24872AT+0hZagQS/eByKz
	aujulgY7qi1oIVt+Kljl282GjM9USF90RpYaztUoNOEJ+gvGi2DMaghAwJWyS2dQaGwOaFs4m1V
	iWqfQ0aaWG1l5hpJ4H8W7iIs2Tb+5k8PT5c3MiZywJl5o1jj6NHckb+asp8xM8Wy2SQ+S9UMKYj
	MMMYD6o/uuZiyilJKBEZQfxo0/5g2IBtRUPljU72p/TOzgi7itejrFea+lFcdYtmCGcglXKGeGH
	iJG9nVo9sXIgm/zNsnAMsYdTf9jfRWv7tEwAr5az20U5tpMydr3QAgCDu1YvfYDb7CagmG4cgRd
	YEy2oYDySICyfL6QWuzL1DCP7TmvuwA12qdBmPsd3zCGKx4P7YkGjLUryiHfCz5BoPJI=
X-Received: by 2002:a05:6402:280e:b0:6b4:602d:f1f7 with SMTP id
 4fb4d7f45d1cf-6b49cb66b05mr3298908a12.20.1793263168131; Thu, 29 Oct 2026
 01:39:28 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqqo6cd5hnt.fsf@gitster.g>
In-Reply-To: <xmqqo6cd5hnt.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 29 Oct 2026 10:38:51 +0200
X-Gm-Features: AclHuK8VG5Le0vKxEQxNao0uyGgqE5Z2iZJ7ur3HCdg5w_P50s2YEVTfhl5Tim4
Message-ID: <CAHwyqnWZh03MH5i4da+8h90kGnth7o3=Ea5mwQc4bx3Vk_yzRg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2026, #10)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> * hn/imap-send-header-fix (2026-10-27) 4 commits
>  - imap-send: match header names case insensitively
>  - imap-send: check git send-email copies like other messages
>  - imap-send: accept messages with Subject before Date
>  - imap-send: wait for the tunnel command to finish
>
>  The 'git imap-send' command has been updated to accept message
>  headers in any order and to match header names case-insensitively,
>  allowing it to properly process messages saved by 'git send-email'.
>  A memory leak in the IMAP tunnel initialization has also been
>  plugged.
>
>  Needs review.
>  cf. <auCEKSc60ZnLKjBE@pks.im>
>  source: <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>

This was already reviewed by Patrick, maybe that's enough?


Harald
