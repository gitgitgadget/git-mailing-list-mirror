Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611231AAAA
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395530; cv=pass; b=ZXqmE3915RSSaFwp3pU3qaYMf2UlAkskFk3iap4N37IYLIZWTohh+m3/ypdJSlQNoj7CANlHAVQNWo6ZzBbzESjB+N/ZjriojJSTqiOl8hciHk26kPI7GFrqDOpuq2OqG9rSdf0FKmJYhpU9EVgIH6LYe7+2tl27K221MBKqWAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395530; c=relaxed/simple;
	bh=ghhNkaYDjt/DP6yyYeAmoWTvNLw3ypacs9VU4Y97p/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOKFq0SNDNqY79Gkn/Q7mCCThi3Q0l3bgGZUARPgfccLSaic2iiN3H+Mr7HaySpKMCE84ZFJVFU5jzgsA11KfCCVE7zaEBIyRW10+wdpRmSFBjfUNX0wreerLcFCO24c/cAHTe1cnr5n6qi266CK1bMyD/Drd0im1tqgHMWH0zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeI1YmcQ; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeI1YmcQ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139aff562e1so3180395c88.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 06:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782395528; cv=none;
        d=google.com; s=arc-20260327;
        b=gYHd42a5YSWBycSKWWP0MVMAodn7v5WcK0aXl7T2LBj28L5oPn6nfqPSXhkGEqgzZe
         UorDWQQG2nf0BZLbmQin+moFBpl/+BAqsznjdZIng/mP3pMEJfgQQLwelzQRdUaoYGGv
         UZWJgd7+QU+3Pglkw/zo3GIxDwLmOkhnOSr+rvUfdT0TKIhigjpNhQqaQvAX9GTAvOHv
         cox8RJpMqxg6Esa37eVsJvr8EalsgLe4EkZDlcPRXhYTGvJWYDue1RXg2e2iUQS+fxT6
         a1QxJj8Zb2jVTmlGmV8Bq/7Bi8QA1bfw5Wt0lzZEcStjZRR6Xw3wLMuPsVN4wxCx79pu
         FQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iynmWNBl7lAVOJFX1yJmCvw1pMDxMGjgv2BdX3QgLxA=;
        fh=7EF8lVoseiMbV6oSZr/p+k8C74+zhtoOjLa803uCcrU=;
        b=SYrShnnCX1DmdCeYYqxAec8zKuQ3q4rp9Qr26Cxh95OZb1tkxvWDt/+HzSKQ5pej24
         GK8QlS4H4H4Lw7KP7Bseojbz90lrUfHVl9huwqzEcU3a2AwD3FRvJSN5qS++kTzGPpZM
         mZzwPDFYHU9aomsv/Lb0vxYA8o5OtNeR+PlCvGU0xur8xDb+9aGP/QphmmLhLsegRPNn
         YEo00LFcxwnoCLfRdLwAuU+6PKffaT5jTyl1tIbQMtJH5681icDEzU87cDYRnwL3drWH
         tBwCu5FziWO9w054LeG8Y3RHHr0JiM/OpD/j9yE4eI49Q7zXZlxiMXTJ74nvouYiUq2M
         cnAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782395528; x=1783000328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iynmWNBl7lAVOJFX1yJmCvw1pMDxMGjgv2BdX3QgLxA=;
        b=EeI1YmcQHAsoDQy6xBOmB2oys6lGtYhA7R/30WLSgH8rwJASJ8/nwOPGFo9OREnfMS
         6zltgoeWJkgmrGrdm1RZ7DLbmH5iyIUw8O+WbH5ZBFfJxyfDnShYE/YoBEvjlru0kIEo
         iMWkYNiDzjooiZtkvti0KLnf0nMRqINgfXHT4JMy+JeeyvqF2HAHi+cDf3iThtJ7drRd
         CGydYmDed18ZfbiaQiL6Yf6me5yJrIsh29kA0dUtaLiPB/whsAjm2KPAmcdnFStn/QM9
         GfRpoAThe6qMAZY8kHWXs4BcCWuJj9xz76wGe32Aa/2t6bMNkESjCiZ2tQvH55YIuHxz
         ypaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395528; x=1783000328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iynmWNBl7lAVOJFX1yJmCvw1pMDxMGjgv2BdX3QgLxA=;
        b=sVsJdAPHTHtfl1zOq6e5iooUDWFDzrXcQe13hrguYBKrePrNz0/JVMo5GnwqJOIO5C
         Ho4jKekJ3jorRkfnlUMy+NuENiloA71xoRtMU+YCLSFA23CywmCqxR/Yy4vOzOEKj4eA
         S/Tgl4X2/ILyhGl9uSHHKmVqks4nOhc6ROQlFuQi1OtgBYU2F+Ql3g6qcv0ug06MDSFV
         7MixAgGoCLD07fvNE/5P5aeDgStGDUAdqwlDZBBxPUb8mg+inSCrWVJB4UlnlLqHMguC
         xbKTy7aeWt2PWpvjCFGG5CsQUcbY+/Omy9TKC4OTwYWcIY979DmMDrOAGzXjOMH0AMFK
         /Nuw==
X-Gm-Message-State: AOJu0Yww+NSn1ztUeL2MWGc4HBNPnAFKcvbDd4/coMYn780VKOeObSHD
	B7BEGZkOYJrfZVGrb6oUuiTK07Iiu7d3In1pkZebeXL8kMQ805ipSNxgfgIUNn4UHiEmRj5Y3bp
	iZrlzBAPBjwrnvqHboDSIm+76bvZBNTM=
X-Gm-Gg: AfdE7cnhl2/9L1mHngST1azmmprimobUptEzVnMY58EKzOcdnRsSP7M8DZfbXqLj+yM
	SuiadKvyXJ4bvqa1hLJkp9CvH9QjZHdFVFnA3oRljdmVwomb8BsG59xObFU4maR//U6xJmCJRzK
	0r/VB9GwE1tIlAIVwPHXcGw6VdpKXXPDiBULPvpXGbufLHadrqf0hKIF25gdHzxhzdXo9hl9aYG
	nMzD5L+t5mSizuLim+s2mbVUbv+Hrbza0kf3eFeMk1rNlDjLJ+vnfjmC52S9k9NOIGUfMrRb+rp
	N5IjjiR7Js9+ptzMF4vlhs4R6WQ0BHgefzW2a6c+sUgm2ysfDUIZvyD//w==
X-Received: by 2002:a05:7022:6726:b0:137:f4ec:29ff with SMTP id
 a92af1059eb24-139dbaa660amr2125020c88.22.1782395528141; Thu, 25 Jun 2026
 06:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im> <20260615-b4-pks-history-drop-v6-10-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-10-2e329e536d78@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 25 Jun 2026 15:51:56 +0200
X-Gm-Features: AVVi8CdfUqL7gihXwTMAS3oiBzxTjvcjQxwYdVleI-m8wsTnWlqB667zlEwh68s
Message-ID: <CAP8UFD3jsepRaiHDen_CzWcse-atvBfCdzAQovk+1csaQeDxmQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/10] builtin/history: implement "drop" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 3:55=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> +       /*
> +        * If HEAD will move as a result of the rewrite then we'll have t=
o
> +        * merge in the changes into the worktree and index. This merge c=
an of
> +        * course conflict, which will cause the whole operation to abort=
.
> +        *
> +        * If we had already updated the refs at that point then we'd hav=
e an
> +        * inconsistent repository state. So we first perform a dry-run m=
erge
> +        * here before updating refs.
> +        */
> +       if (!is_bare_repository()) {

When your ps/setup-drop-global-state series is merged, this will look like:

      if (!is_bare_repository(repo)) {

which is nicer.

So except for perhaps the replay_result_queue_update() duplication,
the series looks great to me.

Thanks.
