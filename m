Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815213;
	b=nWqVQZ5NIPOpK11OhgUGZ7+8s9AwxucBSBUVYCtDdS8dk68gpT7K1eSfoYVkyMkuybGy
	 L2a87AmRut5hBMqXtJgifoLP6rWYugEOr5i8rEhW7gsGY8YSKznoPr5jE+U6ZzS1XPdFf
	 Qvgi15CTPgfUZ/HhQ2BUwoEnwviP8D6v98jISTd1J3PrYjSg+1lSVDNNKrP8YoSFBYxyV
	 yb39woXj9Nv9topJt/fAz6xo2TKBTnLb+r5VH7pULXMpRq4psZBAcdKNQ1G/PRYcYnCDu
	 Jbh3SEVUg5JZISmFAUoj4Nawu6g721Q7W3yexVpkaDS64mJ8cF+2rrKlpRbf+ayLgtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kYS6q0f2b3k5vlQb6OjD+sEPsdDHk5cr+1xBfW95bsU=;
	b=yWeUBIrTBU27sVoOqBVG+xQi56OAdPQDJniBhRy5r4dAKYr9WfPq01YwV6nRZa2W3i6Q
	 shNMppqd3gjINF85Mjks0EDRiciQm49+duYdxziEQ659B5q0FjgT7I1MEwyqdXUQMUyuZ
	 lsgi3NgjVmdLu/XG++fBk+KRWNcq4h8OAlO69xhB4jzKmXw89+b4kq0qTjIX9rg6gVblw
	 kGSs1BR3/f24XxnX9oBH6fW15dRV3MZpe0H7CYuzVsFGdiYVuaoXXxt5wYDpS05OMSnci
	 0fmf/2+4KprdMa3gN6SIKsz4W5mALdystzC38DcG8rt2fZMsAT0Dr6+7rOME+xgJgoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdA+OfRa;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2B606B0AE
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F2B606B0AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdA+OfRa
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14394530ec6so1400678c88.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 10:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815212; x=1794420012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYS6q0f2b3k5vlQb6OjD+sEPsdDHk5cr+1xBfW95bsU=;
        b=VdA+OfRaqcxwoA2OcCCV6Qc1EmVdyf72p46h0QMV2iHFmgWT67uSv0Odvb3CkyPr/1
         Gx1zF6G6W7fEDQSKntorr35kQX+t8x+YY7JwPnLwGXO7gNCXWitTTzZo+y268gcdxXQl
         yU6IBvQvI9ibr7bqPWmxJri7MiP4PQY6Gq+8qUP+Fcs8SBbvVFebi8f3FnJAH0zKhsFr
         VR8KfdwcgdL0tjy5ZdkQQjhCIn0NUimhAle2maLpS0hYLHIVvgNJYJHroMDVYclmvTfn
         E9+XfMFYbb0N8+eM3Bjr/Jj+GQD2zUi4T+/M7fX39muAKsLUxQ6wjEkNaERRII6N/vh5
         OlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815212; x=1794420012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kYS6q0f2b3k5vlQb6OjD+sEPsdDHk5cr+1xBfW95bsU=;
        b=CRIkBKeFJed7nZkRM0BSk80kwXR4D1PgwQmf1eLIUO7hrg4W/sPQ0oybruzBMp4yWV
         pxqMDT5OErxeHTuKoF/4g1ELe06IHnlZJNHYpc7fDmvmY6A5sriepgsDXhw4veeSA4Uo
         6cmrd5XnutCBLMcd4ByYrANdOlPxQ+xYxXwH0ByZQ2RHk9gGTUmPJI3fYbEGSugCwTNn
         KgPqqVi5c1lxW4wwC0g6IP+HhLtzBoKqoKDbxAaa43jNS2cunLWcWSL7EhyaAt8ZzKHR
         whEhy9mGzH2useRbuQKCHdZrvc0hfkPuGBk/N63JxAzTY7v8eVLjk/DHgVf2mZJeRiQk
         yBmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkiEgzzst8Ibi4CMDCq1x228F+HhJl2PVgG5J7cOiUMr42fB/+GK26xYItvismdUGpeGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UezFXcAFQqKzuuo/FAcqrsTxRMM6EU5b7UWDSYzP9YS5sQuwM
	HyiRkFlRT6CH+E3kaRFV00penIqTvZP8cGEN+p/d2hJ9hqa4o9ki0OhH
X-Gm-Gg: AYBFou15v2BWXYXpVlqcA5vrUOH8u/cjLd/FgLf9L+0V54BVYP/pqnpDXDHHssZWuCc
	UUW7CVV66j8Gxin7pia5U3lWXKWppgs/rfmA9cY2QIRGaIOjnutr0aF8R+I0eCcmJRxKBhlqYcL
	MQVmJV2HTfHS1iSpTGtqauJGQM1ErdfwIoQhj6FCNpBCUxRSMqYUHhZzQCiSaPADZhxvbghhva1
	fB0JhyDaRvqT/I/GOLPluNyZSn+zzv/RpVNv+GiRPRWAHTZTqKy03bL5fdaupPTMJ0dR83cHTQN
	Zy19cbncwFSBVHp/uucCkSVsgZUd0LgiKJE206Onht7i+orcvJTRVW13wyGHA4ziwprGYE+NgYU
	4loBQ9ZWMUf2EC3Uf58rqZx26IuaHG1aWACVjSOp2tcvTF4tbCU+8urZS2pMJBexFxgxOqV83Az
	8OM/PZSdC2xrmF47P/kbIzl7FFRx/lW0HfnBvjejdujYpGbNuPbouvk8zCwN3LjC4oUwEiANGoW
	UqvIWLRej1GL7GhYpquw2Elbc1VSmqf3Hyjye99PR13+loMpo0nXDUGZp2CyeqMQrrsGftZAK1s
	0WeFcp+QM80gxFR8jClSqaPupuiuxxslhtUMeJ3y3vfHrOpftrIwGH4sBchGwsWkubxIfgCSipv
	WWSMGncaHqQlfiCQQwtk=
X-Received: by 2002:a05:7022:ea57:b0:196:c1ca:3489 with SMTP id a92af1059eb24-1ac50799c22mr22227921c88.0.1793815211738;
        Wed, 04 Nov 2026 10:00:11 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b8822fsm11168766c88.2.2026.11.04.10.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:00:11 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] maintenance: improve handling of lock acquisition failures
Date: Wed,  4 Nov 2026 18:00:06 +0000
Message-ID: <20261104180006.404-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.342.gea0b8383c0.dirty
In-Reply-To: <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>
References: <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>
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

Hi Pushkar,

I tried v2 while another maintenance run was holding the lock. The
scheduled background runs, the ones set up by "git maintenance start",
now exit with an error instead of 0. Two overlapping runs end in a
failure where master just skips them and the docs say it is normal.

Also, running the prefetch task by hand now prints a lock warning and I
think it comes from the fetch it starts internally.

Thanks,
Aniket
