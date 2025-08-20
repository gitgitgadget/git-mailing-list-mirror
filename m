Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F7258CDC
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723467; cv=none; b=GTtlt7LExN1AYQkG3aXD3ihP6kFRV0xH4xhMGE6mYdV3zEVelplNwaIwihfBDOx6fMsheHvG1/GZXkT3EOHqxAz8jC5WWhpKjS/UfthM5mrOPLnSEg8BcR+kKG6KVrwQG6Z6qDlKtY/QXmSMjXs7H7DJ79on8ShiZPwnc76pFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723467; c=relaxed/simple;
	bh=x/OR86Qpp2k++8ZERnIjBsLRf1BIyq2RDCVub5dq5fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sj/jl2W8yy6kQ7K1RkVC9gKw99cs04s8ws2Yu8bfYfJRjsJ/ju6RPw0dvH6acTxhiWks0C60tgcaXhHwMymtmj74VpNrRXqOoh1MGQskEqzKhdeA4UohgEMPiOhAad4ITI5w2L/aT4wijTno0sfQzC5JZtFrx/SmMiK++VUxMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9bNxFPC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9bNxFPC"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e8704c7a46so36489085a.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755723465; x=1756328265; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UV/VlbnImFhPhoMgjc4tZf+EJOdaVG/tciGsekQj3AQ=;
        b=L9bNxFPCEPd3nn0FLF5uwTCOJd6GlPXXP1JJJPDfveNvCzkRaWtthqHobUJIuF6leY
         KQJoxxU5cwxpuLu/OnEODVouwl67X7Oe+mi4yOPWgzWZ29vMhwKBSVteSZ/KchAxsgkk
         3dyxOSkd2VbpjXloKhHQXGlZ7lG4SLV985MoNyETUODkE7FLpR3gmfqx1mDwDR/WR9HO
         Bww4C3v23WgCcr5miQswilMBOX4KmIwBWJ8d+qBAYrsqp+9O72ygfF6eWkNqBp3weyVm
         Kg1cCSlWD/2yoic00rApJkGowKAJMq9LCNuTVXhZQVJXe24eKJAalVGfFLDBr2Lk7QMv
         4txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755723465; x=1756328265;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV/VlbnImFhPhoMgjc4tZf+EJOdaVG/tciGsekQj3AQ=;
        b=ix+B+FjQROzB3BIv4Kb+7dhkkZqZXbBbSyHn0FKjmEsYGo4hwvDsplXN0H79PSMbLN
         et8wypC/UFv8rWtHae7tBE0Y76nmeKjgmzNs2PNrSorsXzl0McIzHi69zTx940oeXhkb
         EqkCtMhAr4WIJA9VOVZHhLeSrckbD5LN+Xen+ccH7a0ZF7ev5GSd/rifnx2BWeoa/D3U
         ji9pbMVQWJNIFvI9DtSUoAp6+eG9+wGhskEeuijw3fEaVAakg8ELwJ12E+pglbPCVZSd
         J8Dk/kriktQE3PMkJ1mpitGA+ddCg5AJ5KNCbFQ5hkxoLy2JgcI6RJJBY32PKCuk2CtL
         4uLw==
X-Gm-Message-State: AOJu0Yzf73o2aicb/jo7TLNQa6R+MLjtkxjjP0vg3u78D57FXBiJM3b2
	KZoagKqssfdXY7Ukb/48xC6h20WulboqK5+/wDkS7aTplAAxmMkDMDKbHHQYSw==
X-Gm-Gg: ASbGncuFGQHefrvx+vo0xGuOElpZJDFYfXJTufWyKr/dBnhzfE5gbg1F9IEyAD/Xx7A
	UpZrGj4LiKu9LNfA1TK0+LbM3l8EK5TFa7K1uuGG/tQcWeSm51WArKoSf3OnvBbDUnSXFo3Vbf4
	+sqjsooijilYN0hUQLhphlG9OqgBq7UCefjUkPWPNjVbtjLeks4z5RtPB4Yfviu18dq+aIKwbty
	mm/M10Mb+t6JQ6CBHzPCVPWsfo6eEueqZ0xE7NoouKOIQz2OsSKszG6HUtmH+NEJXfGx67qNQod
	7b+2aKUBEUPPyCJ6OJDUdwz5g6NRNO8vJzariS3ho1Yv2B1xMbGB+P/Vr2t3tNj7dkwf5d8U7uK
	VvCjwigOUFYOGZEQv
X-Google-Smtp-Source: AGHT+IHnL01P3fzevJN5RlpDDoPExLGym8gjlvP93ekCgOYHr1rkRAuVccDrYkvWYFCmuhY+uNGE+Q==
X-Received: by 2002:a05:6214:194f:b0:6fa:a4ed:cce5 with SMTP id 6a1803df08f44-70d88f9d380mr456296d6.44.1755723465112;
        Wed, 20 Aug 2025 13:57:45 -0700 (PDT)
Received: from sundial ([2607:fea8:8440:1ce9:d250:99ff:fede:8e08])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9086433sm93584226d6.24.2025.08.20.13.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:57:44 -0700 (PDT)
From: Ben Zanin <bzanin@gmail.com>
To: Dan Allen <danallen46@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: I use whatchanged!
In-Reply-To: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com> (Dan Allen's
	message of "Wed, 20 Aug 2025 13:20:58 -0600")
References: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com>
Date: Wed, 20 Aug 2025 16:57:43 -0400
Message-ID: <877byxbtiw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Allen <danallen46@gmail.com> writes:
> I just updated to git 2.51 and got the spam about whatchanged being nominated for removal.
>
> I run an important python script that uses this to set file times to
> the dates of the actual git commits, so as I browse the files I can
> see their last modified date, and not the date that the file was last
> synced.
>
> Now, if there is a different way of setting a git repository's files' mod dates to their actual date and time of last commit, please let me know!
>
> The exact usage in the script is:
>
>     git whatchanged --pretty=%at
[snip]

Dan,

Would a git-log invocation like this suit your use case?

    git log --raw --no-merges --pretty='%at'

When I test that by running it inside a working directory of the git
repo as of commit c44beea485f0f2feaf460e2ac87fdd5608d63cf0 / v2.51.0, it
looks like the output of `git whatchanged --pretty='%at'` and that of
`git log --raw --no-merges --pretty='%at'` is almost identical but for
the addition of a couple of extra timestamps in the output:

    diff -U0 \
      <(git whatchanged --i-still-use-this --pretty='%at') \
      <(git log --raw --no-merges --pretty='%at')

...gives me..:

    --- /dev/fd/63  2025-08-20 16:55:36.936065126 -0400
    +++ /dev/fd/62  2025-08-20 16:55:36.936065126 -0400
    @@ -39,0 +40 @@
    +1754972997
    @@ -3773,0 +3775 @@
    +1745540054
    @@ -18102,0 +18105 @@
    +1717188675
    @@ -210119,0 +210123 @@
    +1179951046
    @@ -243728,0 +243733 @@
    +1113865892

Is that close enough to support the functionality of your script?

-- 
	Ben
