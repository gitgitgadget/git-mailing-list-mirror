Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B6286410
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769927312; cv=pass; b=ZUpM23M6S59VhWzYJ3Fiph50SyGb85tN5FlRXhQu3N9JAnbLMZX9ufDNN4bBdRfw2C8FTAAqgbE122wxsDLsrm+7iKYS2hHnXtSAqUjcCprWTwLZWIEIo6+1mIp0TB/Yy4vNYBfm9hkPvkNXN2JJ6Ll7JtYbVnMfSBd7VWkW79w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769927312; c=relaxed/simple;
	bh=OImPUmOBHeMGMwlfJxOO+dZcZ3bnaT68XI74L3nzHc8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Bw22fz7MtXnLHXuzWIQqQ3OwOCwgENAmeEKBCcmzWJbib8wbAlgiFsWmcGIDxPXWfkGpLC5Cv5h0KbMvU2FtRNB+MgOdCMrYnMZmnYv3OOyvm7n6/bOX8CHvOmmTELPidEB3OtIwlPanSuwzZ6MuxI6XybKlsd4z3mYgGJnRYTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWZhc7wt; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWZhc7wt"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b884a84e655so503933466b.0
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 22:28:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769927309; cv=none;
        d=google.com; s=arc-20240605;
        b=bUUc1QhM2AKvX+9MZi1kXd4hlfzuyXOxpnMYUTjlR354+EMHWJDX5Kvn6tJVhTBOtb
         /auDFWjmVyMS7gEqQyN3G8kOJkP6CnMXbObD+P4xdUU7No98VLBbySgJWO30OeOmEIbK
         EYx7HbrD/kSxtVXFuI6kDX/6vEYug3y6XxDKsAsaRsPuBZiXOQtKgiK/x8KS0AjHfrio
         HHLAb/DinTeHybay8CRBS/LuUd9x89B1Mw7g3gIH7QF2NuYfTV5k6gjE3TEwCNh1u/R6
         7hgxsnxk4vn9U3SP15fC9r+gl6Ff3i340/C1W4D1XfLG7fLeKuKTrD1+fjgATihvERfL
         8nHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OImPUmOBHeMGMwlfJxOO+dZcZ3bnaT68XI74L3nzHc8=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=MTZSw0zGModQvKre+hdEG2zsjA9e/Kz+IxZETVYEjMgfpdG8TeB3xNTGnfQVqGqQYt
         hy7sPeKEdkvSMEzaKF2Uvc2hefB6WG/RObrZ1XKN7hCwdas2vbwoQk6GsgyVXbTPNGTi
         59EEc6l5+OLYZgfH93yNgDVk90Xjv9k7SRzRsYLjQbud+k1eIafgmuWQRJE+46QMdAQ6
         HRbCX4ETaAsYKqKXBAHWEJ2rX0PYHt5lDITkZrtrdmrqbBXr7MCANUGDMy/s0SYgP6E8
         tGE2A0bm+y7B9fXuN/mF7pXX48gW6pYJkcnYZoZTNRG1fPNS75b6CVfrjKGBzdb9k+EW
         BuxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769927309; x=1770532109; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OImPUmOBHeMGMwlfJxOO+dZcZ3bnaT68XI74L3nzHc8=;
        b=GWZhc7wtWVVs/4QAAc0JvxNuIMTDlVX88Q5NRtVQeaLyqDMNhwnrFEvL3yyxxF5dbz
         LU1rQOf+eabZPu/0rZJ8RPg7cWKpt5laaBH10rSEjVumAytBCYJ5qkyV79ro66T9C2bW
         tPpSLP8yhWwn8vhLrVJPCkV2HcE3jp32AUidQnIDAWR5dgRvBR/ufRGeF2bmp9tKskM4
         uQvN46O263QjIYohn01fJ3Y3wjdaXNhDNendqShUChHYQGUiJgRsV/m3kBiBhKrxegEQ
         wLOUdxHIBhsBIMBwIEBuuBKTkkgObql1aHkWW6Ago8M2rnq1nsNXypKZ/MOhf3yBALrh
         TlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769927309; x=1770532109;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OImPUmOBHeMGMwlfJxOO+dZcZ3bnaT68XI74L3nzHc8=;
        b=tkTqkfUXzcQM1DiPA3oEGayGv4pBj787LqTHRgErvb2cmGhTzq1EE4WOrurrpt6OBF
         4TcV4gvn9IkUodE3hm+QKrlJkTyjmRDxSqywgnQdzJuIA7KAK3t1wc08In5BaC64MfvF
         DttW9dFuS2VDDefM0v3C9WL1xMUWcAyOhQI/STRcsJjzOCxiLgs3IGl5Elqm6ih8wAMM
         Xohlo35FZAAUlVJQh8hX2VApIDk/agSei5qeBSnWX4qPXfpuffqsEn3KDYu7NsOH1Qbw
         Nw7tEcwFCp3hNB6BnKgunajACNVcXCFcKUvZ5aXuTSox7hXrX4xVGre7PtL5O5zDw+is
         x+pA==
X-Gm-Message-State: AOJu0YzGyJW5ujuwy23O1M2lAAxRiLVJ/yr999RfgPnXqbipZrRfWg8c
	lo/5vOKr8LjWvxpzaqajWFgzPz6ZnZ18kOhWk8DScJqfFeCCfrc9ujTFK43eU3s4txlm8m8j96l
	jUhDZpbV3bdH4j9g/dkW7OhSUQGPftgVUZ+KE
X-Gm-Gg: AZuq6aIAJu0wVDfmmklPU6zZ02bnE2C64Jc/PDpJpq4Co+ecMWhCobPXxIVnHLlJGRE
	6gp+B4kJyKHgct8bzSR/Hw7jETt+DcvYaVJmOPwXRPxkIY1GmuDN8Q2qDKgRpNVUaoweZrDTG2m
	FKKpj4kBCUDxb5cTZkjJxqHEi5oHtBaoFrbfGloN3zSxQjcNurh2y7e4rUin03blQGSjR1s5Jpv
	f6THdojLcRS8YLVOwJyxp9bx0UCTo5YUYKE/F0nHbnPZy8tor+xIll56SlWlhErlwwfcVvwwdH8
	1OK/T2tkxBzWszEqElaRuUqth2uziQ1oiZLR2Zf2lcVRKCCPyKe/PSgGaeWMgiwElYRSLvd9j7s
	4EEeM0M6YG3tvGQ==
X-Received: by 2002:a17:907:9494:b0:b87:34e3:a79e with SMTP id
 a640c23a62f3a-b8dff56a919mr426374466b.12.1769927309343; Sat, 31 Jan 2026
 22:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: soutrik das <valusoutrik@gmail.com>
Date: Sun, 1 Feb 2026 11:58:17 +0530
X-Gm-Features: AZwV_QgnY7b4aN6vefE7sE1MSwFEgalinuAJq5ZuBpKyhSKGpMwfd9sUFBTjbmg
Message-ID: <CAPHqhPmfK6hq6bV4pUsY6hCdVjUb+eR8=LcKKeJxNbaWsjO6Og@mail.gmail.com>
Subject: [Newcomer] [GSOC 2026] Introduction
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone.

My name is Soutrik Das. I am doing Mtech in AI from IIT Bhubaneswar , India.
I want to try and submit a microproject and see if I can even contribute to git.
The last few days I have been reading the pages in
https://git.github.io/GSoC-Participants/ . And I understood the
general flow that I have to Introduce myself -> Make git from scratch
-> Understand and then try to do a small patch which would be a hello
world for me. -> Then I would send my application and the community
would help me refine it.

But I am a bit lost on the First Patch / microproject thing. I am
reading the HackingGit page for now.


Nice to Meet you,
Soutrik
