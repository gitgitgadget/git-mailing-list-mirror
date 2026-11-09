Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212035;
	b=jLsDMvOsVEVW9xKY6T1qi/Pnc2mOShsYL+P305VjokNBUfEwRpnWqPS+7qGM4hpJAEal
	 dyRXqHJxYrV234nOOcKieIqH08AHPlU+uiiV3Rq7p8ikAgQ1ud+ysm8ZRWZbOTHXp6R6g
	 koa6VAQu+5FabLHRDWSw2+T23j/q7wdAn4ccioUVAzrZ6vWenBLE3GIojRthksGCT0E0H
	 YBpgsGw5sImsUG+DeEz2SsuahhwHB/P4cP7nkDZnIrHEogXBuiaZ+q0965pOiDVRXpCXH
	 DfyZosehGQezgeLfJpvMK0uCJMcBWg+lMkrDqJ2aDwmusjkK0CuKx7l96KmFOe30mpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dwoio5uYkhfZXnAjvpgQtCN1rs+YJnL37J6X8K0DT94=;
	b=0bH4gtnkfDfIpm8hjCCjx9QUtFcdMyExJuy3p9UAsKuFQB5cFqTdbAly5F6ZyXvDDbpG
	 PXzqwKVZE9rxZg/EuugmZGJDxVliIwk5onnyfrC3VgmLyCEfEjwg4ZTs2ZJ3H7q/3/qbv
	 zuMayjtP0cxDXdXvfyO7R1ZWWxCFMp4+c32hYYvo66pq8RrrTGA11Enr4Un+XFWOn91sR
	 PxkaSdFFLAS+Bw2XsbV5JI8GUzyiuxKH1iA7gfTnFb04ff7WXD7NPcoUYCN87YxzJtzyY
	 DhIAnIG/NvxYwXe2B+VU9JYXigzTMdshvEAaaNPMVOoQTWeHUedQgwiyzqI/lNVS3cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DNBWSP7i;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674C606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2674C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DNBWSP7i
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso268664a12.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 00:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794212034; x=1794816834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dwoio5uYkhfZXnAjvpgQtCN1rs+YJnL37J6X8K0DT94=;
        b=DNBWSP7ilF4to5W7wVvO/R1T/OAVj0GHCAghWFUMBPard9QosbLUbu17iujUZ5UOlt
         EdykYF662lNRuZiGD8ZjXY1jqyndD0pr6IGr1fMpP7Yccf1bLTfYcYNZ2ir1wAXIcR97
         u1+eEIhHe6dIoF7BNgNRXWgNTgW7mNF4j9Blz7ep/9oVcnVtgmFI54htRz0NuZ4MJumQ
         zWhdlriMQTXrPwRDjgq4cyAW4LOqa+66zSoUpJEprRERTHbLwnzLTmnMX/yMtuKzQWNv
         284b98XuuV/M98/xJXylGoU7rWEQRAJ44TVyhDmkLDlQupHcGivw5O3m+SEVgziB4Me6
         8Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794212034; x=1794816834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dwoio5uYkhfZXnAjvpgQtCN1rs+YJnL37J6X8K0DT94=;
        b=P86rlRHRBzTofjRScZedczj6xYOapdTy5nV+UuQ4Zqg31yV31iTQVw9gAicIrU1t6Q
         u+sWyZfFjT2Qlt2AvYnmCYemg1ateGnmxolAqANIes+Lo261Pvdsql6ruV9Sh/v9Eutl
         rcrbaYNV43p5bcdQ9dl+MghrTIErsOLFJPbYSHepqRlIU102+CLJWM7EEYLW9uFlhjQh
         y5z4FQ2GYHWkQwwL4JDDgXXdugL/YcLSE0kK+ocQ+tZiqdQog1PeKWeJftLagxFCMYCT
         n4LWLl2fAkSzqa7kV70rG43kEYmffo2j06TgAejSLt2bq0howFOE7NCyKiGF0JsU9cII
         2XpA==
X-Forwarded-Encrypted: i=1; AL+hErEuYi54k3NrFLbE9oxBYdY2ZdVYDIZlTST18GcYpKpdpRxeK5S7b+ouHjNBk67XeswrDmQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DWUppxN4QEAkU10VUC58ZpJItPqLguEX6CihbDllqR4TKWbJZ
	9kAvaPDSM//kvB/ctfg6bTfX2gvft23AVttJtLA9L9I6FsYzfKFa7aOmsU2GJ4cK
X-Gm-Gg: AYBFou32SV/OTFhya07sM/otTDB8Qp5fftrrdXK5nk50FgcjKs/V3szir/eNBy9atcF
	9+oZH/2/dIIC/MmkWERj7TC2mIknMpo+91bHiXJMzwQNYgljb6iZlyhqa2JRbJVruok1FxGPI4l
	/qWVbuc8hJxvnZqz+0mPuuuSZK0PVtQsSpfMp41EImVQov+nc7Wi/ZjG5mRCYAhLqkRHMr+1zlm
	Y0S7ue33i3+kPRQs/UYbPBWWwP9T+7u5V387P2Wuqeif146ddwq2paGoYST7e3TQ6EvxPlGvTfb
	PoFxNkSD5nMR+izIPVTpJ3XZbhxn08GS9TqrHgk5zQYxXen0uNGyNV1+tYRPZAPmWs0bY1kyIsg
	T9gu6/QWvK3nnWvncqVduW23xknURGfEc+scNutv4X2d8m5aNCv/mC6Q2x/ptPZ4QKqVog3pp7F
	ytvla7YlJZj+7P61VzVrt8gozm+GpTZvrOdqHyXGhtddLgo5BNzf2WNXbhfovI90EEcqM3QYyXj
	6aAm7Bjo5VmeJpKGrTkfXd/UzquUxMW1MIDMVgyEblrcfwuenqDH/uBAxzNwdH+gpPvLxIO3mz/
	ZWDPoIkbNzb7N5kFc1erySKcUkYxPmAjDC52VQrXNXH3SESgJDNEvaee7PFpOI9uwce8jzQ7DA=
	=
X-Received: by 2002:a05:6a21:400f:b0:3ee:954c:1567 with SMTP id adf61e73a8af0-3eed3c5b78amr3173956637.30.1794212034415;
        Mon, 09 Nov 2026 00:13:54 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b64933fbcdsm1028229b3a.27.2026.11.09.00.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:13:53 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Hannes=20Brandst=C3=A4tter-M=C3=BCller?= <hannes.mueller@gmail.com>,
	git@vger.kernel.org
Subject: Re: [BUG] git apply: pure rename followed by edit fails with core.fileMode=false
Date: Mon,  9 Nov 2026 08:13:48 +0000
Message-ID: <20261109081348.352831-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <avF86vESF26lpNv2@pks.im>
References: <avF86vESF26lpNv2@pks.im>
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

> could you please keep the relevant parts of the mail that you're
> replying to?

My bad. I'll take care of this from now on.
