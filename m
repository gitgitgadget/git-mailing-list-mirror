Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269680;
	b=TfzqSiYRU3sP7WO7zn+aHrBI60aNVI+I19Mv32s5TivfzpdGkW/M0YrbSPij04u84n1b
	 DOd7w9LUD+20Qebm69LgcyfNIcUeXOZ2SrBccp5wuesa/Wq136RA+JDpZoUcWx82X28GX
	 gQ1HSAHsg+8IGQjsYudOYP+0grEJSRyZ5Mm9Be6v0UJjAfjnUvA2K1z4+zS2Zp2NG8MgO
	 57uOKR5cazWMUi1nEM9c/RiEB0VEuqlQ3QmJqnvniOxoI1L443U0F6JBdt1j070JYxz2r
	 Rylr8Wv1GMEYPcDcghHfAcbfaJGBDzsYVsjZAfXnBa6E9kQSkHtSIwm/nnFbWNUtRWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C9hYt8rAhB4r+a+s19WieTcDjCYPKF370/NYlxj7cIc=;
	b=g9yp0cZjRtV4YJVznueYVLaU23KIvdA3JQgAdlDcWVT1Yo4Pzo+7o4YIb1JDsXkAuSdt
	 P90K2YKCwvzXtQisiLdcKVartrBIowcK4xb0DZ30Rh2tk/4XefMRYH88ZFtkbyOOEl77j
	 OFAnFLW6nbUEoEkVHUhk7J71g9C4OHWZtoV3u1rVHqgsIK6uhCyDa6zRuuC8WD3VVRNvh
	 mgt11qnQAd6LY8eCqg4NRL5zGSTXmHwnyI4yzeAo7HlxMRRm9IlHawwP6gAbIYAPywFqJ
	 f3oNbpZQlf3AX1yiSbtm+EeSBH8eSt6mGkD2hD8WPY02zJnw9Yhw5JLzWHvoYlQ5BVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gitlab.com;
	spf=fail smtp.mailfrom=gitlab.com;
	dkim=pass header.d=gitlab.com header.i=@gitlab.com header.a=rsa-sha256 header.s=google header.b=TYnlLsWR;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91789606A33A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 10:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91789606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gitlab.com header.i=@gitlab.com header.a=rsa-sha256 header.s=google header.b=TYnlLsWR
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso962715f8f.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1793269678; x=1793874478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C9hYt8rAhB4r+a+s19WieTcDjCYPKF370/NYlxj7cIc=;
        b=TYnlLsWRwwAvyWsL1Lu2ZvbKt+tG3QeXNHDRVbHYSXQpPB6DWJ2YSJpOkz56WeBEVe
         /kgdwG1k1utZyyiYQJe66FiqpNKJnlfc4Et1ko7nbMqkFU/TeaMqAXppr3d6A9I9lO3r
         6e1nWKH3tyss8jwbWGuKEgFwdFDk2dSD1NqqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269678; x=1793874478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C9hYt8rAhB4r+a+s19WieTcDjCYPKF370/NYlxj7cIc=;
        b=Z1x72n5TL1MjsleuBRlkRcoWWQm+BOSh/JHFgoGxqJx417fjph05YM9LvDWErJ+RfG
         9UtsEh7gN9bn+m3ljumvSb9KGjCTzN6HY2eZVXF1RpuLAW3BVrEjqHtz2/JdPftNBUN4
         zA518+KW+3YgEcMBxCu1/ze9p9Z3GOvRqRZUp48Nm5j00LIPyz9VPDBBxkveCKW2rUxn
         GNTB/MaQa7wm0K3798QD+EdO7qWQX60kSgQR6+rh+f3sz6715LNCF6qCkjqdUvOd+UHX
         9OVSliMRjouS992cmWSZZE4LGLcFK7d2IULb1jNeLopPIpYFOhpOj8GTx2Jw+YId4Cgz
         VfYw==
X-Gm-Message-State: AFq9FYJmWOPcLkhf7v1tYItT9OB31GjjvII2Q0z2tvfKfDEbN+/+9PIV
	Im3LCdbbsgdDa8gU2ZM2XqIH5rQHbMU6gNzHXH5CB/9AKm1H4KNLhEj+KvLCfoc513E=
X-Gm-Gg: AYBFou3eKic4hAaayJ0bKfI2LUzbEUfjjrljBhVK9ScZTILp49BYqGtib9MLMzRtKHG
	E9wu0HLgxL12iMV3NziWQurMqB3hOYqpLZ+DSAxlUyPU49Z0Mzwza8pPX609Wgh5W66qBjeEcMh
	AIUbUOCcFA4QuUNRtF7NrqsVEHwWz12alDnhX1rJADCam+ErQ57+FjJ8OBL/Q9fWcB9ordl1yjY
	M6fzBkHhxZYYXQcCkKURPssxzS8pnh6jmpmMT08jlzsc9L2L1FgBsr6AiNy8tO/+1lfBJgX0ZRs
	YfSrAh9LxMqIknBZQVZGnnfukBGlsOEnAnMjiri/JupBVfaUGdpuZ3uP3if7l+FhjMB5cUjIoZr
	Ec+77GIbHjZW16ERWZwLhX8Zs/eo0+EaGP0wBg5KngTWxXRRgpJWsz6WkUe0YXubqyKi2DXXDZl
	WvusXKWswhplHvulXZweDPsvDR5GLD6px5+mN97ctzT9sklqUCeZbi5cbKQrfBrgi6doR7fzFX3
	2KtBuOQI3n7iNiFogf4p+qHDp/5DBpGnxpB4r7rE8rhe94mehRcPSD3wwGHhXS7jKjnNZhhfBTJ
	3lvBaXM4ec1IXUFkTeG0IPRFTxnvHEY0lbvWHETqF5VKecjy7nNwtlgWtnpgftdx3+hz
X-Received: by 2002:a05:6000:2313:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e5d2f087bmr13010292f8f.28.1793269677783;
        Thu, 29 Oct 2026 03:27:57 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a83:ff82:d4f4:c123:c569:718e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3a1csm34028252f8f.16.2026.10.29.03.27.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 03:27:57 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.im
Subject: Re: What's cooking in git.git (Oct 2026, #09)
Date: Thu, 29 Oct 2026 11:27:55 +0100
Message-ID: <20261029102756.35612-1-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqy0blwbyt.fsf@gitster.g>
References: <xmqqy0blwbyt.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 25, 2026 at 05:18:50PM -0700, Junio C Hamano wrote:
> * iw/connected-deepen-fetch-no-alternate-refs (2026-10-19) 2 commits
>  - odb: ignore refs of shallow and grafted alternates
>  - connected: negate alternate refs in deepening fetches too
>
>  The post-fetch connectivity check in 'git fetch' has been corrected
>  to avoid passing alternate refs as positive revisions during a
>  deepening fetch, plugging a severe performance bug.
>
>  Expecting a reroll.
>  cf. <20261020075536.49286-1-iwiedler@gitlab.com>
>  cf. <ats6VLXUqKwKZzIY@pks.im>

There have been no code changes since v3 was reviewed. Do you want a
reroll to fix the threading of the patches under the cover letter, or
is there something else I missed?
