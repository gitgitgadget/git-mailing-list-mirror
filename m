Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4E3DA7CA
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876671; cv=pass; b=Ja+XH1rN9Y07bjOhHDwpPmn0pdmFob+mW2+ZVg08+WPLi1ZiHwZOp2JqtKlD8xgwgn6V/HbLBP9jsKnryjPGb+N9X8oY0IzKoB+23dbg9slLwRrKlR7sMJNUYA1m3VnS5/Qw8AwMxZ7XsAuukpHGj0G2FFEl9QBHgmQwosC2cs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876671; c=relaxed/simple;
	bh=EvS4WJQnUzWONyJq1bPbJcydS/lCuj2X3LAJOQ5it+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUcEaBr52pDAfbosczGybDYSvTz+w5SamaS1jQWcWnJXNExJdCVpYWzQ150dCz+hvD59I94twKiaPT/6DE55KeZR7F9gIHRBQh5agNoao6kLG/qgyJTY4psvtvQHTVaFDuqznZKq2Nt/Qb5AjsVfUMztVfkJUlXBp6sj5/KrQZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1DGHT5O; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1DGHT5O"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15e03c2763so67867966b.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 13:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785876665; cv=none;
        d=google.com; s=arc-20260327;
        b=k04nBAoQp7KqD3HWGdPUQh5GNf5NESuDVAUiuR1kp1ZEjkM4psUbzo3tsail5th5Of
         Hpdetn7deTqug1gu1Nm+GyDmpWzIfTKIXeTYyB2Wa9mYUtD41N1VKY84pPCsLIRrn0sJ
         b0PPtryqk2AY9fVWqbkNhYRjs18IicNT8U2gUPHBM+NOnRQ33Lsv3SZtJYA9twNsXJqN
         rVRFX+zaDLCso+bdXuPO9Vu9avcpz0hlUcAFbDLx/3jAEQs6S6X2rC1loDbJCMkHPVJz
         Ixtx6qsVz1yYDgr1b6kicIjZJKHKyjG5z3yYJGd26rRGrWxjnuE9MqFsPAhItpQ26PcB
         yR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EvS4WJQnUzWONyJq1bPbJcydS/lCuj2X3LAJOQ5it+A=;
        fh=lkSJT3VdY6giCua5ZLXwzcDDE243ZC6M0vqwpSWUDAQ=;
        b=RP5ivlxBXFvoQjOTQNRsiL0Y9jbLNBpRGbDrGAG92FyPkyYWFTI+0kVKnxicyrrydh
         fXThTmaPjBYHuOEwILICn5ByEPSM4w8ooVLePLw3Sjtt+1zC0+XqsXcNNBnnpgzMR9pp
         7OJeoSLYE79Bzi5byHZe7ukmS75XhTExmAtJXnWCI+9tZI96MiQgMvr71nhEuRuygwOm
         7WVOyYzT8ni+Abw6yu63SsYTtLeNPKC0W+Wfvo9QgGg+z6FaUrwmSkfYrzrURK1LPQ0S
         XC1p5zMqaJ57WMhAGB9WQzo/pY6olq0kv/WFxw2Um1kBA5tNaSEUy/CS+FI3th5Sk/3Y
         xunQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876665; x=1786481465; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvS4WJQnUzWONyJq1bPbJcydS/lCuj2X3LAJOQ5it+A=;
        b=k1DGHT5OjrHf4OgWYrzCQKE4BiYmUHHrKhi0hXIIN0hG4BK6E+bI9/ehN3iZ/CjhlE
         dwx8NhAL2mn8Ve90EKgqTuEIO0KcS9YYklU5+hzXMYjs3copoL5H0tqFlO+MxZiiTSeM
         FCDYPXPxJIZX1qIn06Ev6LGgHENWzwCw7jzjte85SysRLb+YUs8dREeuHnlH+UV+fnnf
         4u5HuTZvgBJDlWSOpML3j5PjHhRTVOkVh23X+GaVJdVrAzpYsuG8E+vJExWbLfkx4J/E
         j9UDSz4BGI9A3WyLdDBvl/fwoMR6+2t7Gx/rgekSTWvkgoNEa43HjRIjHMfBvOiyYAK8
         eP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876665; x=1786481465;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EvS4WJQnUzWONyJq1bPbJcydS/lCuj2X3LAJOQ5it+A=;
        b=M3y2Op6ZHNqIO8KfrcDOs3I2XXodFP5kpLc3hZ/3PYbXV9O3Yt5JXbseBPBun3QYHd
         gr1Sxn/oBUC8/fgiomYy2tZ3bpyI1byUWfPIVGVlZfDemKq/ACfxr6mQ27pKiXtoCro7
         eBqPdnUyHLH/I0d/EjNJmQ9hhz/xGqwsZsEtXkMCKyDlSCN9mxKorsVhrt/Ml73dCjXX
         FfmbypQmhzR3Eh+r9ldYBiIYV2jSz7mYo6WsBD9q2AyEBgl+p63cTzDgtDn82avqVA0d
         MPhbw8yv+QZPCXgUHCSApIQfNCnBK7ot91gGoaesAYQ4O5jyvVCZ2GTsrXZ4W36GjiMa
         ug+g==
X-Forwarded-Encrypted: i=1; AHgh+Rpi6ehDcBwLfHJA08N9V6oamY3yyZO3baoMB+b9ZRRrlXzxGL5DlSreZ4sj/djrpEjGyc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyn4dTQKHXCC1wvKAXlRSqMcUDBs2LsYTalgLvKaXmlt1XlNr9
	Jx2NpF+kRrz/6s2a8NWNLfIudVgmuo1372e/P7vT8wykbg1/+pv9Pt/zsRchBUwTEmQjDcQTSIj
	6xO6eojWD62rvfwvn7HmoK7GNJVRvXeA=
X-Gm-Gg: AR+sD108Hl0OhOHKD8E5fXIJoLYI/OZlt3hZXw3V0ArEnR720lHrp+1MkX3An4+XkYQ
	vlmH4L0uUcmq3G+xyp3AbzoNVNolPLAgV0kgkqUOtxtLuDeaIs71Ts5ayTbqR/7Jb75yYF1ICkd
	hS/LONH0nThWCrJt8p6jzOsklVljODfK0Nk8a3JJ+gVDX5b7/+mHgban5z1oq0U/zqJiquCOLgz
	jsjRKX9tqVFW7F3sDQRHucS4OBY0uTZ4MJH+ncuurH+TWBpM6axONtQ/rqxapfTRN/3XmiU1OJN
	+fSQn31spkadHjHHehGBBYEYBgQX56Px4QAPhjoPP2BV
X-Received: by 2002:a17:907:7642:b0:c16:aee0:5422 with SMTP id
 a640c23a62f3a-c20246a71ddmr461299766b.6.1785876665412; Tue, 04 Aug 2026
 13:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
 <cover.1785750108.git.phillip.wood@dunelm.org.uk> <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
 <xmqqqzkevx62.fsf@gitster.g> <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
In-Reply-To: <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 4 Aug 2026 22:50:27 +0200
X-Gm-Features: AUfX_mzrlhiGtLuJwYSdaZjyuEpZKz_3S3A81kUWYSp3rOwKtPsL7rj9pWuuJj4
Message-ID: <CAHwyqnW-py0QZNWUikzYO3yyqrYWdZcHQ+axW41GMv94hHh0nw@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Matt Hunter <m@lfurio.us>, 
	Patrick Steinhardt <ps@pks.im>, "D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Btw, I have now twice seen this message from Google when using Reply
All, which sends to Phillip's reply-to email, whereas mails are
actually sent from phillip.wood123@gmail.com:

"Your message wasn't delivered to phillip.wood@dunlem.org.uk because
the domain dunlem.org.uk couldn't be found

DNS Error: DNS type 'mx' lookup of dunlem.org.uk responded with code
NXDOMAIN Domain name not found: dunlem.org.uk For more information, go
to https://support.google.com/mail/?p=BadRcptDomain"


Harald
