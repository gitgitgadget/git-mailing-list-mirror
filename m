Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DA17A586
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151795; cv=none; b=HW8pGQqj8UgoO3xDkm1vhVzjo723laK3s9/p1YGx5MhthwYNqb8KUrZczEgfLVFiz15jnNOZX7CPLzkvOcMn9RgGMPBG3pXVIxrRrCDSmpzYvw4I/0+l22CQF2qnBjwJ209e0yh/gLiWp8KFeaaxgUHrX3aWU0uD1RZJvRHWtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151795; c=relaxed/simple;
	bh=0MXAhlRXTYWAgcPJnsovczZSitle57KCZLoTfA+8E7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA8ssr5CirGaXuI4h0oP1OP4xRZYukpCLLYk3I9c5U0e6uXngMfwdUtDzAwv9uiTMZotKStQVmdu4P7YazDvke9OqZIYH3xgbwvVP39Ks3NWZSe2xo6GzkrZXTYmJuUypexSpbn4RGdFaQkhHKQ+rknfQmpr9JHjyVXjvD2gKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jutowuLk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jutowuLk"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dea72099eso5227457e87.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776151793; x=1776756593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUuvgOVTcpC9AOXgx7scURRbTwOCUuFmQIiGAsI/Ziw=;
        b=jutowuLkOMq4/Ep3ecxY3jED5FQ4Skb5Rxr3oC41YNZCLxjeR826nMRriGVFsZwLxw
         CNov37UG7Pr0MbVd+CCeMsAqobvpethXMdylYeLL/nqhQYTyhiwNxsr3zMg1ZoqAnUqT
         tvWfa2ERHmg2spQNJrTGtE+KkhBiv8yNpne7TkSw47YHDemMtYxN08wNBgBvUunPhRgM
         bK6CkRLxtPKyR/wV0/VQ7yW8JU3VdaTTLI1zq5Wnaq1fzlqLJZH9+3hoojxuifnYX6FZ
         nsZNsPu48FZNO4NunUrkQS0cOYP0qixG8IpJ5TvdMSiC8HPtqngxu3o0RsapbMqjb8mR
         1++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776151793; x=1776756593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUuvgOVTcpC9AOXgx7scURRbTwOCUuFmQIiGAsI/Ziw=;
        b=c77kJqoLeNUrExJYLGIWb5tliwbpOEiwf5r+clv9CuVpjBDGRlRVSNernQ0K0+NXZd
         WUGCsGnCj0v38bcYthqRpnV6N1llU9L5+r+0T708+igwPV78gVJbBdcON8x2nr7rb+RN
         zZ/jB+vTE6ImfKHtPXbWPt5/u3vfcJeBIofSYzO7YoZ7buaKvI+bvjytPIJo8DVbhTef
         afFC9K4qziBPZU4gBCOsQhV8w+lpQ8WJoAeqfajO5Q+HOco3omO3e7eZU7po5Jh+IaDM
         Rp9Fj41+4ikhC5rUXGJZcy1+kcS6KzH+9kTOCa5+EKIgDEY1vivmDZ2ERQ78N0M4+Mbv
         eVuA==
X-Forwarded-Encrypted: i=1; AFNElJ88EHDHZeGsnGyelFUV+OPWKg6YrmchUV0iP1o0HHC7+Vqz9En5yE3kNS8bxXWOcTSQ15k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTlDcQajqpZsydq7s099/m+24mog937Ixm0qzq17vutDC65PjX
	v1kECkm9i6hUBZvC+isUK0qea+mLqm+6WELl1uEAnq1xKtp0LpjUSmVh
X-Gm-Gg: AeBDiesISD0PvB67lakU8LtPpxZXql/GKAmMnzX2imHu3pH6zd8OKcoRPaZfPRTtGep
	QLkgtFotM+qCXwlnDpa4IKsgBLbwmnF+MbMch/PBiObUL/VJah4j66MBqqHs7VDdanR1G7aozFX
	oSw6iruXvGvG1GdS6YfzE2SJdh41y1azWIxLPnRkVADiQr0PxH3hlMJC1lIkJqiXIXKkIprKK4t
	BIbdUSkzSj8wb0O3kCIOtkYGE1U4LcGU3NFfAHLX+Thso294Fa0AqIP3eY4yJbpKUB/wghvDiux
	eJJ/r5haBJqFVM4hKfJYOj52agQ2EcN3inkhgoK2Q2LeMfE6whG2GAKItCL9wq2J7MeZ6H4wjFy
	nSkhNNL0nbwnzDHXZpEEzJZjRY1kQJZQ6uSiVnqHEbhsk6O91VUwGDmPi+VcarLH8w5Yv6SkUW3
	B7Xmja9ojw7k8zdAn6sIq+afcQ11kks+UJHGzM32fn64WytkZuAuWxS+KnLcdC78Gk2Gy1u9KWr
	Aw8vHlST4tsh2xQjpt/qNUC
X-Received: by 2002:a05:6512:3b9d:b0:5a2:bc51:b3bd with SMTP id 2adb3069b0e04-5a3ef6fe23amr5544937e87.1.1776151792276;
        Tue, 14 Apr 2026 00:29:52 -0700 (PDT)
Received: from Mac.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eeef8dafsm3108808e87.59.2026.04.14.00.29.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 00:29:51 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 14 Apr 2026 09:29:50 +0200
Message-ID: <20260414072950.61240-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.69.gaf13460d94.dirty
In-Reply-To: <xmqqa4v6fpj6.fsf@gitster.g>
References: <xmqqa4v6fpj6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Because I almost always have either 'master' or 'next' checked out,
> when I start outlining a "how about this" kind of change, they are
> made on top of these branches, but when I say "checkout -m topic"
> after that, I _know_ that the rough draft change that becomes a
> stash entry is meant to be part of the "topic", either to extend it
> or refine it.  Because the code that creates the stash entry knows
> that we were in the process of moving to 'topic', it would be nice
> to see the name of the branch we are moving to (i.e., 'topic') on
> the title, e.g., "autostash while switching to 'topic'".

Sounds reasonable, but wouldn't it make more sense to call it "autostash
from master". We should still be able to abort the merge and merge it to
some other branch. I feel like the source is more relevant than the
destination, no?


Harald
