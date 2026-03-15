Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB812AEF5
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773569539; cv=none; b=Ixtxvcdr7BwN7B8o4p88J3v+jG3M7mPl8fouNfHxQ4nz54jO8niULZeVzgt2PyXWYomqhHSyY7CqlsacCLkMnk5Yop2lV79wmWKf3OXUD2S3SnLc6bPKP5ZSAyhSJ7mCyhtFbEapeJuNjQeEgp3SQ1oGYT1AP6/f0GXF/E+d2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773569539; c=relaxed/simple;
	bh=SyGFp95cYXgTvAnRYScbJIdQUJfjzqEGIDTlk59AwFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNoqhCUbM0ahxyr8KGs/pAq6phBVCvP79kkOPiC1S0XpSjMVjFdMrNlfgylu2C30Hj0IVysfj3frQ2QxlFwHkdTrxzkMffGlATt1aXnsWJrwHm2MoscE4DsHVum6rQ7QpjDIMSGTsyOHtoEsF+adh2L/gCiSct6XTUq6ZHzrmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOzUq2Uv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOzUq2Uv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1860880a91.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773569537; x=1774174337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyGFp95cYXgTvAnRYScbJIdQUJfjzqEGIDTlk59AwFY=;
        b=EOzUq2Uv481cSwpTPA6amaf+bbGW7DWhE7SYrFHSCPsdMofsE/uINiJ9OjumAjCzU3
         l3NaXXQXkXV7zdlj5UrRsFUQ6XV1Mcp8ediOZEgCx7JeyrKzl9NbsjyA1cuWCJLeV/80
         IE67ZveA1EKgfLNpzcIpvLA+Ws4Sljx+PY616j9z310ahKAyk5CtL4/k/lH8Y9nEM6vj
         3l4iY2pezHtNr0KInK/b0EvgPLnC0YyUWIBfwJZZZ+hKhkSksJY2Fc+CA21qeQg+a6ym
         dVjAJzu4/vwBZe/27ZuafEOldc8Zxn6u15IcmSdkMJEsumaTeRgc36mG78moj0NqYt7i
         YQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773569537; x=1774174337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SyGFp95cYXgTvAnRYScbJIdQUJfjzqEGIDTlk59AwFY=;
        b=XjdXrQwwJb9u3G6ZTYBGUBF2dEaBCkkaiyWEijQV9N1AE8Q44livPRXNEib9lDIAZY
         cliXOPsAcLSoLv6JDRY+pDAC8wDTZw9eKkTNp5PmWORpLkgQIJSVlV6Ti1mFce86i+9+
         Vxht6gzQTVjFKoediKEr1I8rzooDaGtVvv6clRmbZjNGKHz+1C/eBrx2gA1hpRAjA7TM
         apXl4qQO8CIH+B+SvifMST8t+JiM2dxDJ3355Sd51bXw85dio9mkN9qaQRiaStpzyqxf
         TT6h0HUcDV4hXGWLRuNtjMP1Gn+d56EkRdbYLQIUwMVw1qhhdl5/ByTVL60vMH2YLLIg
         OrRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRN66HEcw6kkiNQH4UyoLbjW/Nkv/Ljp96B531CUTOGJY/Mu4D+IiP+oCvQbAyqEN3pq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHJDVcnYoimJ3h+K7Q6JqEHkXfhDM9HHFiGhnYhifwvmojQil
	h1BD4w6EQC/VRKb0/Y20lfIUZ1kmE9QGvhrQkr6qAwmIXXsvzjXot+y2
X-Gm-Gg: ATEYQzwpY1pT3K8DNH6F1nybsUPVbDXW/vv7/7E+o1DfqRjHaEkDCyZeToNsdoDglVX
	4C8D5xLGB4bIgwbykqMaGDX2EQILRiumNU+PB9QUjpF2RBJhEEbkt00zoFI+uiQV/+SYoilQmSA
	uuKsV0jXJw6LHSroQeTBLQCNkR8Y6e8xL5iyjH8hDHHZNYrPi2OuSDNBAJsGdsFZq13wMFBheeR
	3kQfhrCNUsApUtuAiifmdOB5JrqWYRqPx0SOS0V9k9OKIYbHuzuMkuxoSWXdnqli9OjB68ZwyfU
	wQonGg8HiW0nyHFgBzH2+0OYf1S5uSBZTjnDKChxcOowJUJHK7yyaHdRias5BQkKZVvhOFq7enU
	UXA9F62TeL/+dNbSU6EzHBXhCu7O00fbBzbNwIgBtAPh9U8057jieLTNpmjoHLXgaKXlxHLqFzz
	g0vzeImjXlhUS08Kxm3mfBZP/U9Uic9n8UDwavVfwOkEbIh2OxJoDsi687keQ+CCHHq1IDOAboZ
	PgzjJtzZdLhd5aDf5uAc2rqe5HmD7kAKv4ANYCX311AOgKul0Ytgv29kw8UybHU7eMA+MhsIw2v
	ufd8jF/0JQ==
X-Received: by 2002:a17:90b:390a:b0:359:f88d:1e2e with SMTP id 98e67ed59e1d1-35a2206e4f3mr8441969a91.31.1773569537375;
        Sun, 15 Mar 2026 03:12:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e2:102e:e479:4d56:c7d6:394d:6f02])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b94e8baf9sm694204a91.13.2026.03.15.03.12.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Mar 2026 03:12:16 -0700 (PDT)
From: SoutrikDas <valusoutrik@gmail.com>
To: valusoutrik@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com
Subject: Re: [GSOC Proposal] Complete and extend the remote-object-info command for git cat-file
Date: Sun, 15 Mar 2026 15:41:54 +0530
Message-ID: <20260315101154.80383-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305204809.54927-1-valusoutrik@gmail.com>
References: <20260305204809.54927-1-valusoutrik@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi I was wondering If I could get some feedback on this.

Thanks.
