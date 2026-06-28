Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4D2253B0
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782631322; cv=pass; b=meJs38DK0rR8+P/BIv11aYqz7gH0944qNWZNt3MwdCHFbteI/rz0q9g241rMB8HJdLU48JsfYFqZ+DW9bHadTVFjhJ6pehQ1zOlprvXpMcVRG9HAytSHx8ub1FB6r+uhN6ddT9/rwLulvpKnAzCyyNSUKwut+b9SwzLFLYH1ORw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782631322; c=relaxed/simple;
	bh=Fl39zL0p5Et5bftt8vfHShIrbevBS5x6a3eUJg+xGu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERLExZ100yGoux5+rqMgTlho5uZrZi8L+XQs35IQ0646b1FcGg75/N9jE7fejKp64GfCnpBjnTVvw7DNyT2P8O8IPJZllMNABo0zBJsih2ZnOnun9llsYZX6GSLylj+whNjyS172n/e3XXTBQGRQ8uO4DH0iHfKy3NkXhG4z9BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5M9FljQ; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5M9FljQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698587a1335so373961a12.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 00:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782631320; cv=none;
        d=google.com; s=arc-20260327;
        b=q4gkHqIpISv3lh6CR9Mwmu1ExYDSoovJXDJWFiwL7Z9hGaU9GGYfWlYUlwLjxLHRnq
         +N0g08SSw/hS75HaHrapLEp7DQKJh7B/Mx8D+sVzNW/neTIUB3ki7YQi4/F0HLOh/CnZ
         F7fYKkQn2kUgXRj3e3eJhedVOqYtlrsWhY3M7uQTA5TJlM4wOGLrCpWObwxVwp4YuBCS
         dP7iu2LZeur9nfzzq8o0f81WY7K9ivz6DMvMNmAgoi2Gg0SqHav0X5ihYL7hjKcU5EBB
         ll9BjLxiSFVdZD8Mi5Djd0HDdN+FG7pmXByYZyvunJK6gp57wgwtcJA94azwuSR5pdPZ
         o9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fl39zL0p5Et5bftt8vfHShIrbevBS5x6a3eUJg+xGu0=;
        fh=mccTqS9zOoRrHXPW6UKphvHMQ2WxgoDN5GWv0rhdJMw=;
        b=c0+HVTHjD1HrZt0qS9WD+KGTjjUFPpH9n0W8hSR7p+N+qEh4rsza5pV1OdZPY8Iwbk
         oGU+1zc4FAqVFn1qYylMAM+p1mvbgtQf2SxSFFwps6Df6ZT4hbk2ytOyJ6KWO0Wk91R5
         nw/iVnrIutfoYSIlFH1ltQKlKpt+50T7QCMPFGclEFKM/Wh8oKTwxdSIAyepijwpTtp5
         D0Af2zgbSR3oX09BMjqGxZcRWlbFQPIIhuzhR2dpS6x+OTlwJHsBxzRaRHCLHFen4g3M
         xrBb406SlWL+n+ZPAfLRj328Jr3zkyZXlFD7ZAfaQCUBX/9xXimrz1K+ZyHY6bybWPjD
         iZeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782631320; x=1783236120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl39zL0p5Et5bftt8vfHShIrbevBS5x6a3eUJg+xGu0=;
        b=i5M9FljQZRZ3tOyZunY4w7BXkps4fW4knfqdrjQM7q77akCj9mslMCfBFLTWj5zISJ
         zh/05M2fXMPp3QczGTBcuZ6seIvjjkCVFnOcly6yOACyFnkq9VdYCUlJ2ATVYqZ8SSan
         nPznvVdpztRxjGD7GS5yidhvyqtc/rQwnwFOHEcg2PpJnw94RS+SnmmKiI2pgw/OUuAB
         LDhLfiYALCaqxqeH62qTe2QNy5vj+XN6F/bgzmK2JUOY1cwNiwssaM3fLIYut5AIVVga
         bHzLu6IDfhgPv/QexLncwnFpXG5MEpdx20WEdEdizjdiaZ1cEQFuaQ+g3LI2EzrX9tD4
         WMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782631320; x=1783236120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl39zL0p5Et5bftt8vfHShIrbevBS5x6a3eUJg+xGu0=;
        b=CKT1sgQUf7Q+mxN6cNY8ePqXBmLGAXecg4J8ZSir2jlWjwLaD2kyttnvE9Knv2YwUQ
         Nqk24UvRi09jRH4V5t7i7Qnkvtl4kytgjqQqCEcogeAmFlrP+F7O6scy+M+U8ZVG6/z7
         7MmKc+YaekeQR7rvVVore/C2IBeDGEDmtV0NvUVqxl7gwTk3cVxgwAJHC/0wyiGXvCsw
         ygkyOImzxTBVfiz9EYmXOCubHkY0rGj4rYjmeSJWOVXmT+4fLlYUOSy0cfHHCM7X87tr
         frmi0qxZIvwbD7n4MK0y53kKs7D3juXblDhOsghEzTvy+YjSG47VWfpVqXhdxZeJiqZ4
         PyCg==
X-Forwarded-Encrypted: i=1; AHgh+RosPalLKbauZH5GoYjaFWrD1Jntj0H/RYYG9BQV3E6kD/+T6s0SXq67cd11ZCgU+/zTCFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5X3vwcr6zQVW18ex7rxirldF9Fy3M73IXKCc0S8kCpGtY6kG
	twoSB80XAnoIhOGv48Z8icpHiJY9YRzWm+dYBA3f8dv1kVV+z9OwMKLhi5aTDLlaVimPe9QE2cZ
	9T8CgzFnBH+IWQU0TGaFVmj1Sr0/Ga2M=
X-Gm-Gg: AfdE7clyH5uunaSu4UU6uCf/1ayGf4lKeEfRxG6n9Il2Alpp5tlBY3+wLKh9eyuGedJ
	Rib5Gqx1+SHxdTCr0SDMfZJAKcah0uMzmivCZVwQdETqNuVK0fhwiQlRPtqiPNbg1CbY92W7hv1
	ZKt+JRRaD3WnsE8OvLth4q+3JgsLDhUCUdg0Mc1Js5xR5AhAaMZAf1ALD3NgNJLvG9HwU7ADX7c
	v7L6pOlXrN6wSDpNDgLRrMYdTkwb+sdadSW2nGR4zj6ttabL4UAK3kYx2aVqzRXmajpXF8m
X-Received: by 2002:a17:906:eec1:b0:c0d:43b2:e8e7 with SMTP id
 a640c23a62f3a-c1205ee0e4bmr734623166b.35.1782631319345; Sun, 28 Jun 2026
 00:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
 <pull.2331.v3.git.git.1782583345.gitgitgadget@gmail.com> <9883c28482be4ad43f0f999c2e6be9f9dd9fb13b.1782583345.git.gitgitgadget@gmail.com>
 <xmqqfr272lq7.fsf@gitster.g>
In-Reply-To: <xmqqfr272lq7.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 28 Jun 2026 09:21:22 +0200
X-Gm-Features: AVVi8CfmNST7sAMtViq836U2RUqfnMzJqe94Rw91YOtktmtMO_FBJIDDk9cZLnc
Message-ID: <CAHwyqnX+YcHgpfcAZO=6=6HvuivzmrOn6yzx2Bta=kd2xSbe5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] branch: suggest <remote>/<branch> on upstream slip
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's do it!


Harald
