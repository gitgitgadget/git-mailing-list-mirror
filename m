Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792869204;
	b=IfXPcnkBf4mRzCI+1at66tLkyDcMPcl5LMkcZDFLcSbiTOE9Yr2yZ3YuCRC+a05DbSlh
	 pEs/A88X+hsqBlWoRAR7njCtBkRYgfijkXBI6iDS7pt7KiSfi9spD3rnAQ1iNIvTWNzRu
	 ezigjbwkaIsRG6+CItq/d2/0iKw/EeWBtQyWr8to389YNprTKpTthJgR4U+l9Kr76i20l
	 ACSWogdAWk6wfbygBlic83X7UqJFjo9jiFFX2QGwLXid+cm2ZpgJ1h6epKfuP2LMfB4K9
	 ZOXuEJR4LaReivDtzqUljcPTAhx6nqylsgAgq2Sme3lb30Li8gRJ+uaqM4lfO2cSTFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792869204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Y2OTl+8gcz/UnL8a+JiEwmCgFoEkZV/xoPGluAIfKKM=;
	b=iXDDP/7r417GbnP4oZ4xknhYgIPIfIwTxAQ/W1cbW6at8qxR9I+6DemOnmh1o3q4aOf/
	 3ANVMJqpS8Uh/XYQ7auo1QaHVGgfSlbxYQ6FEqxxk58/Tid9qAU97itHIKLodLzNixl3W
	 1QJwywxUWrE8rjjV3dcisTQMHymDlPZTRYzCMs4jLmOUEZxFQwum9QJeCBBXe0GXl3qVP
	 3jSnk033KtICdPiG6FmxlMiSMMHhENnmPHyLfFqcZHzpLT4Tqn2Gs954lfOyippangn7O
	 0mZQJRl+nKw98wFrrcSih5fF3xIYcvrk68sdGoAeuHXLYlSw8cCIzVNZyX0ECnqAJ+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GRItas+B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47023606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 19:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47023606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GRItas+B
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c468bd799ecso236326866b.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 12:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792869203; cv=none;
        d=google.com; s=arc-20260327;
        b=arI/zp7WdLJjKXdi1HHVWyeMhL2zBHFmadthF0rBSRTq+jDiXsUhHWWTRpVLIEwxCx
         9PwdhCuzJIrAnHHjVqULSHP6A+EFrXWyj/hmav0V7WSd7A/6ATqgnHlb9USGpWyMWYoF
         hiuh52tEIE3z6UNaSmCaU516F5IUc8xRhnC20SJvXMYvIQMdQLnh9Zd6ZdXeDLceiKyU
         IQaHiyhLaDbbzrHChayB+qO3/5kTqztbYKZ2sI09GqCNGRAGbwgM2C6yq+6xBhzoGzai
         ZY52KcHR/JOXDUlJxMZBUmwZySkwkm4xnAZF6frRkitQnL/KVyPFaikULIGnIrSlur5A
         7M+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y2OTl+8gcz/UnL8a+JiEwmCgFoEkZV/xoPGluAIfKKM=;
        fh=OvN4jAPih90UzY9L3QbjiGkAC8G43zjHGdZgWa8w6FU=;
        b=G6/33mm1uUzz297f0JQwcj7RUz69SE1K/qj5pHmxI+Mem7Ux0Rx/h31LBydUX0D30l
         M3JGTHGVjiKjb9jK1OvSVYOKzYJzfwpucNiAEvw3dAm/e0DhFqzWyN18262bBm+3uYIh
         KTaAi3BW2F3c9B2IAxTOtRDEkTVUknkm7Ah0TeZCzckhOWIjfgPyThKkeS3NyzGSA0d3
         hxazcxImMsb69ir6908BJgglSeIDBHS+fc+RvcbDYs7bUpWCF32Vd3exe6fA9AOddmFk
         Djq2pqRkMCP1MDraJGIeFl8V2v89u3YhJEhh5+1fJsvVRFlgE3Xb0dqM4a2RryWAlvON
         xvcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792869203; x=1793474003; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2OTl+8gcz/UnL8a+JiEwmCgFoEkZV/xoPGluAIfKKM=;
        b=GRItas+BuR2//EKyIAr8I84QbPmHpQOwgR8v4tselsmmUR1jTjFzUnFmP99LIhDbv/
         H4k3GIhE/GoCGbAJGJfp0A5XPV8AWmHq1EKC0WLzQt7uK++p43GIqwAMZnd4vruYZ65E
         nK1ou9mWxpX6nUjJJtkkTALa2MMBTZSTSufL+qCQVLPsOaGpOH9O29q9XeGnEEDSSSQo
         RlpbZBnkSLSU9FoB+263clApJi5w9gf+r18Fd+IBF0h8iaNX5YTtIVAs7GyxXdg/OabH
         HTiSrNDnb8rMS2sI+g9HJgGIKKOksvrHfHOE49y3QRn354D1TDDjc4H4okdv7ct8tb4i
         Ibyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792869203; x=1793474003;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y2OTl+8gcz/UnL8a+JiEwmCgFoEkZV/xoPGluAIfKKM=;
        b=dNRRP/BV0u6EHTzqI6EUI5Xixuf2ThxrqeY2SMVcAFwWBNMwOx0wWMzpfurQSo4dnH
         xq/s7BD6OL+YPr+ueE4MhhacaImiZ+Vymy7eQ8uWz5ESQ+YiSEp5XbYCjKHT/GaOtQ/7
         iF5nENEMcuAzRIiOyM5ai5fZU0fb8IdNy/AeeKsqJfsE5KNciiKNJebVlkp3YVX1GuBy
         GJluAkAj8M/Cynsov0H46wCgxIQX2J1YWkes1XXm4Iv+DMYFBBxqOCW6vcjBwwsszvsx
         pvPrdHA51dYfZwlyaggqWcrVYL75qbD5pRmg6TEJrU1yLhARKg1KD8FapMB9t4DrwQ8o
         5OHw==
X-Forwarded-Encrypted: i=1; AKwUvBysCaeLt72YnHJ2/KoF9MqOPHYw9tDGC/nhM+bphx9mdaOT93NLuwChy8zsTI8FpmMelW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKn4vnJabYw9whpkPQcsjS+AhBqBiYe4fyf1X+QL02wKMg847TP
	xcy9rHQc6F9rFBL78GidyQPLgPWViOTURA5zH2yTCH3I04rgi0CoNHQ73JCTTu67xxZeFG8jWtb
	ODog+Q9mE786+NX6KQLzZ+eaG6BY6bG0=
X-Gm-Gg: AYBFou206nENUk6T5Vw8OiEY5LQ8zK0DqEc3QVmmf0hj4MPpSNEhVOiul30szsRA4qI
	n7yApM4Q3J7CTri1MVhO8XTF6pZ6HktOjAgcNX31yDEO/5j7BbjOKmG8qzLJu+vFjyb/GXhb+X4
	q0dcgBdgLkDSrmhUCJqPsGcm9pzYm0HCo/Fou6NtXcViD5+pvGWM6J2nhV34NmJfzlyLfWzHa/O
	WNfRIRABgh6GqkxdgE2r0ORMWjfBKrsrARQYFjRPGQ8RhclCFuuKNiPgS+0mts2QBJqCHVPTqsy
	umCVRPOoNLPhpvmOYhFVRDQsAQUM7/wDzBJhhY6ZLvmjM+GrZpp1NMMAMtz/1iBzwkHOBQW4A24
	syAPAsHvr8CvkAiPJe45OstRuui2RLWfWfi+WWQ==
X-Received: by 2002:a17:907:9490:b0:c40:4965:72bd with SMTP id
 a640c23a62f3a-c46bde0a9eemr302553066b.19.1792869202667; Sat, 24 Oct 2026
 12:13:22 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com> <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
In-Reply-To: <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 24 Oct 2026 21:12:45 +0200
X-Gm-Features: AclHuK_dgXvnoAMMxTf4zP0kM30a0grU6lavUNn0Vn-eUsT5yjbBNWHUWQs2F9U
Message-ID: <CAHwyqnX5sbmL_2tJ59KoBzMiTiz5OVzJXuwV+hUxU_b3YrXo-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

> >   * --historical-branch decorates each entry with the branch HEAD was on when
> >     it was recorded.
>
> I quite like this idea, but think it would be nicer implemented as a
> format specifier ("%gb" seems to be free) so that users can use it in
> their custom formats. I'd be quite happy to change the default format do
> for HEAD to include the branch name after the reflog message but I'm not
> sure others would be so keen (perhaps we could get away with guarding
> any change by isatty()/GIT_PAGER_IN_USE?).

Seems like an interesting plan to do `%gb`, instead. It radically
changes this series and drops `--operations` altogether then.

> If we're going to do this we should make sure it supports "git rebase
> <upstream> <branch>" so that the branch names are accurate. That is a
> bit involved because you have to compare the name of the branch being
> rebased (which is in the "(finish)" reflog message) to the name of the
> branch that was checked out before (which isn't in that message so you
> have to go looking for a previous rebase or checkout). It also needs to
> take account of rebases that checkout a detached HEAD which don't have
> the "(finish)" message and those that checkout an up-to-date branch or
> detached HEAD where the message is "$GIT_REFLOG_ACTION: checkout
> $revision". I've got a patch [1] that fixes this for "@{-N}" which I
> think works, but it needs some more tests.

Nice, looking forward to it.


Harald
