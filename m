Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E423BCF7
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696104; cv=pass; b=QW478ZcrElQ7hOktxSnTyIO0Or60QSRJvA9BRVd3XgJOUKIiCR9QMLG+gCGpwxXR0Z127ZsaRrNCShoyyqyH65/pbD+nSebGDxqIQuvbNA9Yj7LxelUIlb/qFFs0MWqvyHz4jRct3qG6W+hBkJHRG36lE9YBLrtap44mPwZ0AyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696104; c=relaxed/simple;
	bh=y34XuAcVPPsATPT/kzOeEKIqjakFszfska71z1pHdc4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Nz5QSC34+xi2wIoZ6s9Y8ALdEbJZyLfA9YO7XgHBEN+OitD/iOzA/um3ipJxCercUPN9LEc0RYe7tnp1dCjQo+G93gEDuIUAj/YB+stl+83PBsDsjhZokgH3mZf59TQHFRtMGSFbKiQdj3kXVStZs+LOGCLuJddw7xCP//s+SGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTgcAS1W; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTgcAS1W"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80a123ef90aso17226917b3.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783696102; cv=none;
        d=google.com; s=arc-20260327;
        b=MQyQf3pxvSgP+DFFjV/Y3t5cT5v6SF2TyT/JOz9z0kVkPTUOTUlsfCTpADazqM214x
         m1rd5EZeE5wT2Sd8egQDZFah8mYzrtkJtbT8xHQ3BA7JvCRaeD2tixRZpcRIZFtJBuXj
         lagXEmzDWlk5g5w0A1K/6kLqJmnCJqPn4JZhLb4aHqdfj82OGdCOOmejIEHnB81SBR3P
         L5EWuXbd3Rx7ebqBnHJkjWEDTLoDbeLV38OBgBjR0HLrmEZzaPb9HgXXS3g1k5+cGkXf
         h2UocAwybWhnU84zurtzJKzMd8tnEDf61U5EDn1/NPwJYjQ87BTSEX8rDavYfo9yjQTM
         68UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=y34XuAcVPPsATPT/kzOeEKIqjakFszfska71z1pHdc4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=mTR/WXEiJgGI15Ck/rhMabsucLA99m+yi4YwCx3RS+IqICSMKhKzOfkUJKRUC4rdQO
         76KQihqPbYl+wi4/hKxge1qmJjXgS9kzE2UJhI7VjdvTVNfea+jJ2zqlA9lbvWxt2VCN
         21FhaHsIsy6Li4bN5cvmVvrWpH8pBPzd2h9HAHJ0FeSBFg6FTufVIlc+UmljdblOfRKJ
         PDfS+35ex8osePmPBBsrGQo7Jew7leBmAcsrXPHnSVliN7NXrPxt2b1XyGzQAN2OkWFV
         tahjluC+txgeFH6pMZ+TCsaZEacX4RNkEWWJMpcXhfoIHJf8Z6MGSi6zNoKzwlCkDtqc
         fpRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783696102; x=1784300902; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y34XuAcVPPsATPT/kzOeEKIqjakFszfska71z1pHdc4=;
        b=sTgcAS1WyGIQj/0nlt8u2nQIaA2YIfyH3uMY5p0v5MNoCEznJNK1CbPYvaFPxRW2TL
         iP9CHCgTwnuRCW/Wzq8I56zIyABxRuaJFRHWbu8NuIZlVVGdd2BNgPT8DhUymIvjoAf1
         dDC6oO7yc5n6WoUFUZBa6pfpo/GE8GxltpVDXs5dNwpObYpL12BkcRn/F1q36v5PtLMJ
         64YNf0VwAEV/+mXy80S0UIYC6ZmmQ6Eu1ZxHxGiYJF2I2doSjHZ9Q2eIb56OhR3OrFAY
         R7Qf7Od4rj5tNTI4p8w8l9shszHckBbRUl8MExqKIM8afRnRJUoFUtsK7g6Rmlm5c36U
         vUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696102; x=1784300902;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y34XuAcVPPsATPT/kzOeEKIqjakFszfska71z1pHdc4=;
        b=Te9IAdIlvxFrGr4yjofI/eM71ORQd68D0GdgoaH3GUoXuA3poeFRbhgZfq/fuwEfvd
         S2j5Z9J6DyIkeGnl9lwWLDEirUoIXXFBvmXDdWl/DOdoIxPEIO2zGhCgmRButNlMUQYG
         eDNTRSt9AQXit/NyEuNfCu9WyRP6jaA1LfIBSU2h+cfHOWlRP0RBxS6k1yhIIWuFAxpm
         BjPyay+mLBZmFWOUJNfokM1wRPDAfIH/DUMJQBnol0MUwYlwFmmqorYja3PY6nNttEmg
         rE6XPgXr+b7vaMxpOgcmt/flmVpqC2IoxsDSyR4OmR0uoFhNzO7frjjCXd0Kw734JHi7
         HhIg==
X-Gm-Message-State: AOJu0YzBhDIbEn2qp1npywSi7qJbyYY/in6kC4SASq0ylcRUsOngtpqW
	347RqI/M4o1or7f2JFtSmDXIYuYcpNh154iqIlYrkbm7m4PynWaE8oBigouN8bpI+A2yBRgxYvt
	eU7f0YGTHBG98unygirotTWVdAjV0loUp8M+h
X-Gm-Gg: AfdE7cnyHQKckqL7InRk9s8wu19pQMr7oNg8DS3oXHKoizpHzHBHCRBi56qMCjAcNw2
	xKKGnNxx6UVaSh1X9w43QSFX/32SmvHSkcRyS4xKLPlGzmNaUQ2AtS/BzytjUBaxUfh2g2BJi83
	xuWKBlUP/RneSFvlp76L3lMXhQUk+Og0mb2W/ay4RIk/0FVSghjOd7GcRIjoITy7hMqu9ttNDvx
	vb9hmwJ5qdLmws9kKIY4LMNedQwxEDbi+VN9aDHRfOlUoY/RROp44mhh1UTPkmfWtys+g==
X-Received: by 2002:a05:690c:4a0a:b0:81e:5d2e:7a2a with SMTP id
 00721157ae682-81e7c006014mr28675487b3.17.1783696101894; Fri, 10 Jul 2026
 08:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Omri Sarig <omri.sarig13@gmail.com>
Date: Fri, 10 Jul 2026 17:08:11 +0200
X-Gm-Features: AUfX_mzKSiRGZqgQZmBfzjzWdHrv97kbIvAlzvj1yaPQmccbYHAcMTZQ1IQKUss
Message-ID: <CAP9es6tyaGwfTguz5zgBmE5xN7MLDN3-rxRfo_JJBf79RCNzgg@mail.gmail.com>
Subject: Understanding why Git defaults to show author date and not committer date
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I've had several discussions with fellow developers, and I found out that many
of them are somewhat confused about the date shown when they look at the Git
log.
In our main workflow, we are mostly using a rebase strategy to get commits into
a main branch, so I can understand their confusion when looking at the default
log view - dates are moving back and forth, and it's not possible to know when a
commit was introduced to the main branch.
I understand this is one of many workflows, but in my personal experience, I
find that in most workflows, the committer date is the one that I find relevant.

Within our teams, we usually end up creating aliases/updating configuration to
make the Git log show the committer date by default, and find that it makes the
log/commit viewing easier to understand for non-super-users.

I understand the distinction between the 2 formats, and I can see the utility of
both. I'm curious about the decision to show the author date and not the
committer date as default one in Git commands.
Are there some workflows where the author date is more relevant, or is that
mostly a legacy decision?

I'd be interested in hearing about workflows where the author date is the more
useful one, as I use the committer date almost always.

I've tried to look for information regarding this decision (both in the
documentation and through the mailing list), but couldn't find any discussion.

Looking forward to hearing your thoughts,
/ Omri Sarig
