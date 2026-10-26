Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793002904;
	b=V+gqqdmaIAJyCf80+HCqPL8i5qRMtAvc6kfhiTO4KItGlY5VeIBcuzgKgN0y4tt18k8a
	 O6244T9JInED4EO5UHVY/gG2qPVfRlaa0gWg6L3StZ4F9Lzz3plCy89w2L9jP+QAovSS1
	 XL63trd9fsIhM4AF+VERPRyiJig1TGWQwz6gCorGOS8tuMbCPfKKj0Is971x6+n4eIHe7
	 5JLSY3EQKcebA/G2PHbYNXhgjY3TiupEsFqtp4uI++xh/tClmA5sbKMHbFtvE4O8e2yBn
	 +vZbz0V71MycmUMOZVU3Mjr1Mj0mfqTfGpnJvj+aujRJvY9hs4BOuNdH3SCeo6NBCVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=g9oRrXpfkrDsn5OxR8dCqii9rtZuqM7AeBxK6bcoS60=;
	b=LTD7aUsCf6wq1b4M5hKZrVEWdcI5U+Kvx650Tja/h+w2mj5XHViKgxNI7n0wxR2ROQ95
	 5BYZR0c6d6/Sci0h70N1ONU9trto5nspy/eFuZSSmxqpVvmswEp1DlwX0f/km80JqG+jx
	 GDpDHeLa21Ev1kycN/yt4BRAkX2IAV+DaEfqa0kebbpcqjfxabGtp123YPZkyv37vjHof
	 4MPbzJPJbKXGNsXx8cwftwFGU7ro7rjMCSJumASvJmxuUDH6YTKOCT1jJx6sPT9l98Cdv
	 8kNfEFSL0ZGb3Wws4MroNhr5TDEQPdZnsbHi7/6JWCIpRQY7HVC+YopYFSrmBzqT/0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b7rIaXNo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73699606A31F
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73699606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b7rIaXNo
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93efc0452b5so176403485a.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793002903; cv=none;
        d=google.com; s=arc-20260327;
        b=IYWSsHTJYhJkYWm2oW+wM+fsNkUyEaU8XduCNqYbTOANnNC63tU48RXLu4jksDiWDx
         6mPQaENYeLId+lMNMf5oJ2EhwEuVqioDQSiMTQHy0DNFqGmd0r6gZeFApyYI7uQrHFYm
         13rQIHSla27kpo2vAx4GknDdxu0XDWLW10yFkIFG5YwUO7/LN9jQ+AHYOOebdaipqKhx
         GNj5QYAVNEnBJoRnwTQB6LYOAziuZ4HDLPDCSmOUg02jnIwVPW5feqChlLZOFM5zA8Ev
         FL858oVGKvOy73PyaLi3K1cMXAq8gWog3a7uNq7A2FAdCSJOeZmFytZ49pvdrMhxB1Vx
         DtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g9oRrXpfkrDsn5OxR8dCqii9rtZuqM7AeBxK6bcoS60=;
        fh=7olgt18Pe7gN8NSeki4APDH6PkDNF7fbaioB/VKYpgs=;
        b=C55KDc547/Co1OMmksqI6jWYPjBtWQXCXOnBynujN8HERiQCTDJSbWLrwUkzmItys6
         1/08lPk3YS7Irjps6jiok4vOwU2tR0jARxRgZBv5ziYU7dUW3FiKDlbXFi43wgM20s3y
         pN4yqU3sAvVdwK4n0sTLCfyr1UZFSHz5j7fLRTyi/Fl74PZz9Owkxbo/QPofj4fBHUly
         ezIK1qBxd/bpZ/LtBPTqRMc1EjW2kxSoBgHD9dLTS1l1d6D3p8MX6ONO+efCYD8mZ66A
         3EPNRxIryuglYbnqgnpCyqOT4NlTDHua+ZlI+SYEhfUVXgN6WOB8UuZ38sEt/r6eXDI/
         Lmbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793002903; x=1793607703; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9oRrXpfkrDsn5OxR8dCqii9rtZuqM7AeBxK6bcoS60=;
        b=b7rIaXNoJ40MPzq5DJJwE4lzVp05RQE9hRFrIhGa9/gmmfRvZqA9LElbEHnsBgv0tq
         IVeGFbNvDUC4u3pgQTGHVgIddGU1ewv24woqCetjLt5HJKjKSRqACxscPsfW4h58NYTv
         tiOnKY/Y9glB4JzvPmSmWCwad3zHkcFqZYhfxPUV0Vn3Y50JgS6lgaAoT2lko0KXlahe
         ommXW9uEE31+5hwMH3La+kbcdbwWOj7u+fZOYa6NQlPqJe8qqC6mFce74a4+WRNFmD/O
         lrSoUULTqrpNWiIWbEgoIqgus1ObGLgz3T3pIrDcBx1lrS84e+/L8Il7Kqbmz21huCBK
         gvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793002903; x=1793607703;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g9oRrXpfkrDsn5OxR8dCqii9rtZuqM7AeBxK6bcoS60=;
        b=YePji+622FlPI4H9va0K6JOZTgdfePoraE9kj1E3XWRSRzrrVLRm8JkQ/uNGOE6eov
         9spz9+iQES/e7CAjLjoG+9s83PhlzVnjoVTK+typVvEuceJLf0EpGOvXar/Wvt5ALs/E
         A03hUSU5/I59J1y0MOGU5IUyWfb55QoLvZqGDq+hx9BdFqe+u+yjalMzJUorxUb3OHhP
         fgU24SvJjUVr9/NN22uvvKfsO14Qp6/vrgwxjetx7PdrdLi9p/N5+1FBPYy/8bF/1MCM
         wthW22pO87YfCACHD/sjoSKpxDb0ROBhXAlJQnbC58/1SG9Ayog1rWwQkEn7/76Z/YPT
         2uLw==
X-Forwarded-Encrypted: i=1; AKwUvBxhBt6YJKBtkbinFCeJbgL1okAduE3AF7/HJmvdbfZ//RCCc2sHajfBYMSuEkGjM+ult3Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKrWNi7XgQVcczBmPb64QV9R39VpBqKTh1zbES9C5eBK1mv60p
	uAUdxNSmGe30Lb1F2dmg2t9nb14VSLqX7KXxGSeOD3wXtSqUl+bHi/8qrUoCSO+YGXXbwqHn24D
	+liD4eaKyuRi/y49Rr/i9yTs54kMOYuE=
X-Gm-Gg: AYBFou3Vw3dQ8OQdlTKDfDpPAQBf7IDntEncfr5VD9/EVLdV6eOXY1sJJiXfIYsJSlx
	tUxY58MWukFzHxcBTKVGRmCR4SzAF0TlS+KnR5HrwypH4XpnDes8tlerL7c+fVG8pysJ1wf2hoM
	5J1SgYKuLn4CKXkLJ/I2XfV9iTptxOwP96SvTGmf+wrnBGKFKo3ih+fi7qa/gb2kU+ve97bhqNA
	Cb65IVRxRmvUdxyXi6bUQQijFnrsnqcnIOxkh+kohASXYNeAaOA78EHHx1pXGEoDcg6kEq3m0Jr
	7SVsvyiSyGi7ab05H1X9m6M7GWrwgx1VzF+2M4glCJZdL6Kn1phe7HIzdhb5MgC2rR7qo7pZ1Hw
	TfvTRe3FUSq02IG4Jf1UFYk24MMpeEreKA4Y9NhGmAmTf+5Lcsm7EfL+So3nYfs62E60LVg==
X-Received: by 2002:a05:620a:1a26:b0:93e:c12c:fbc8 with SMTP id
 af79cd13be357-940ef9b9369mr841408585a.68.1793002903330; Mon, 26 Oct 2026
 01:21:43 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
 <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
 <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com> <xmqq33ttxw9h.fsf@gitster.g>
In-Reply-To: <xmqq33ttxw9h.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 10:21:04 +0200
X-Gm-Features: AclHuK_pfz3_MZDNanb1_BKS7i-bX_Jf3ORFtH2TgNZM_vL8UsPgmzm7CB1V5y8
Message-ID: <CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > That does look like it would fall back on the refmap, but to be honest
> > I'm not sure what is "correct" here :) I was hoping for more
> > discussion of the questions I raised to see some thought about what we
> > should or shouldn't do. I suppose falling back might be important for
> > the later step with --limited-fetch, though?
>
> I just encountered a case where I wished to configure both refmap
> and fetch at the same time.  From a second remote (let's call it
> "cabal"), store any branch fetched from them in refs/remotes/cabal/
> but I want to fetch only their 'master', 'next' and 'seen'.  I'd
> want to be able to write something like:
>
>         [remote "cabal"]
>                 fetch = master next seen
>                 refmap = +refs/heads/*:refs/remotes/cabal/*
>
> And, no, this does not require any inferring based on what is
> checked out and what the checked out branch tracks.

Yes, I think we can handle this as well with some extra code.


Harald
