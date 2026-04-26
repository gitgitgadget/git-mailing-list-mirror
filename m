Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F32BB1D
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777216533; cv=none; b=Ig6FteS3487/M0wdavKhWuMV4P7FL0jg5g/kBfLpm/vJpSZaql4sn0kuddyTWsVOHxyKYXOGuDwP24AWxv9whAFVLAso0kmyw09FPXqpetesMS0CCkZz1ONVG2h6S5a8A4UMtgfxjt1y7Y56IK65VcMuSFSzifQbqjuASy4lCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777216533; c=relaxed/simple;
	bh=0Dz1ffa/Pv+4tBdOoOJhK2cIK1w2YSN6poem+oBYTzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHIwD2YLOuRxJZuV4oiEf6hrrG+21TPn5aSi9M82MSK6ByPPMa6c2dMZouoqJPdUT5kGRtt5aOkohpt1CqlFfZsToXWyH/QdG658DgbkR3Xg0wGv5DfVwrOC/HjHgAyqFW8TS+BN2ztSY2ZJHofVWIxPIhG+zwEZlO8CZxj7F5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBLUSYw2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBLUSYw2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so7728628e87.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777216530; x=1777821330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ua320nfcZRxcCBBHXHM0Btb/2hMix8GqC/e17+rSaUg=;
        b=QBLUSYw2HQKV0HzeMr0BBMETBLaMe9yZf55Z8EIgyfJUdgUkdRc1bf/DR7kTfwqSV5
         /0TPcyeZ5Qcjc8i4oIBKHq/upPpYqeaCl2yW54BjPEINt48LkW4Sl6uq+0/+37/Z5SmK
         Nr3P0xFGny9yRzjOsCCn0BdQOIS+xhtFhZhDbTSWgzBi+osPQlCUtUMfDasLIcHFhitN
         q/ZsDRxxhAutwmw69krnoMvG+AFD55qQt0ttON7vK08+W8CgFkvp33R7jYqRj39somFN
         4lZbZvTy3aeAeInt5+itIAf2Ahzq3Px5Ahhge8CbcImnzyanO4TM/yxIYopmmt7WyYX7
         iJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777216530; x=1777821330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ua320nfcZRxcCBBHXHM0Btb/2hMix8GqC/e17+rSaUg=;
        b=hAhVvYmiMFLhs/Hyi45yufjCcTXQ7bRqolVKKSX5jcDZbstuecaYTTxQJIuWfC8Tdk
         G/1Utdd33z8Lzh5mARLbJ86OwrMY2CoRqvbIe+Uz+90NcnQaXk7vA8axlAN1uRUgFcwj
         MyqU2z5luyuk3siDIDd392TsW1l1JgK71LCFK5GzXRVWeLzjN2faIqL9pxwC3j4HJq0f
         L9qG5h8LRCa47fYsa5EZt83/8RAFMEy+5MTgcXXdvZ2yxc5Jd109Ks+YzCYQzKVfo3sY
         H/PjlIJNLGwXVV0u3eTmIVHcItmbFKN4aNDFATplrzG75uuYaW5o9UYpKBNTKZXT9B/Q
         CvHg==
X-Gm-Message-State: AOJu0YwdqkhUziZ54fLcV9E0kHXxGkCjXWpOU23zPGGwUrBUYga3SOIC
	UwjN01o5qEnIQrvhYkNATZorAFrTHWH4G8FymaR5DKF9jXLGjL5YwwEP
X-Gm-Gg: AeBDiesMw5ilgspX8kTXukw1y8parm1jjWl2Ur8aM1DdMubDiFLsK2I2JDLN1xoa4Ae
	TT9QydmwQUck5MfJZQ8rC2sFMjUJsurTo0I+xN/rCO8BqX5MKTi55hcOrqP+ljHxRD6Q6iuJjv0
	kAFHY7Y6djL4YfUOXK5+rm0yzjV3UCyDm6kLkDf5Z6s5l93lWi2uzJd8ubTiE/ze+bTyDYCud03
	HCuPnDxhINbNdfxpuHV7MYEukNxum0HX677jr8OxCibj6eJDRx/dDr1/QXfS5iRXbeeRCKXhrPG
	ug72lYPIoha6lqof9Z7cKaqugu3MzTJzzI/yBopdM5vWye7t1kXPrSzgzaHhii9wARRINQF7Occ
	t3QJzbGbdZSGlZUvUpCK/pp26jC9Y/rL0HUjM0Ddo+OU3xlTy5IbM+ItWhspXY83cR5qDMeodeO
	dUrpruuWFanCM7xPTN0mG2iScDwkWcD6WRJ7idT4f+SpilEiilFqGCf8oncb+sKftiQRP8igHJ5
	ivJ3QXe2X7x6b0EHLRLJeKjTJK3MNy3Z0lWhQ==
X-Received: by 2002:a05:6512:39cc:b0:5a4:ab6:81ac with SMTP id 2adb3069b0e04-5a417302144mr15655388e87.34.1777216529918;
        Sun, 26 Apr 2026 08:15:29 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb6f07b3sm63886081fa.22.2026.04.26.08.15.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Apr 2026 08:15:29 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] remote: add --set-head option to 'git remote add'
Date: Sun, 26 Apr 2026 17:15:28 +0200
Message-ID: <20260426151528.49016-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <c61933c9-e489-4f4f-b4f4-74267d5eb76f@app.fastmail.com>
References: <c61933c9-e489-4f4f-b4f4-74267d5eb76f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I don’t understand why you change the email subjects so often. Right now
> I had three “Wrong subject line” in my inbox with lost threading
> (webmail client) with the only way to distinguish them being that I was
> the the CC on this one.
> 
> Most of the time whole 100-email threads like patch series never change
> the subject. And to me it is easier to keep track of those “RE: [PATCH
> v5] florb: drop glorb” than if someone changes the subject to e.g.
> “Regarding memory leaks” because someone found a memory leak in a
> review. Because that was a reply to an email from two days ago, but I’ve
> been a away for a week so I think it’s a new thread about
> something else.

I got some feedback before, not from you, that subject lines should be
more varied, probably there is a golden middle that I need to find.

And I fundamentally agree with you.


Harald
