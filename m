Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071030;
	b=ulCFUqBBRsz93bW/2R4/UuUExj46vznX8GDPlt+vJrcPf+SYW9w3g3Aew+FSr629aAKK
	 lMBSGGdWj5S9XFNuXRlJwZY5TukDtCZdDLc4++etf1/ULKQ0Eve4wt+nWRreqEclEviJF
	 04Ssu/ZjVcvwhKHsWYtvDbRcdkoLrV9Kb6hSaoGL3LPJ7uXBH3/4DaBhm0/DKmzXijUHg
	 MtEFWLEwqwqy6A3V0tUhzZAAcqsjbJMEsdlrN3O9tX3ZPS5OO7n+bFBWwyicLso5Y5Zwy
	 de9fxH+n+4jso8rPD0+R9Isdue+SWh3EoumZh3xJFGjeqOwoxJMGmOMCgLeTAZg6Ytw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0698PEwkye5fB74zmDoC5XKAdv2OhBbSBVgNtlM/kHQ=;
	b=CdEOJbeVvm/kPO4B3W1bmGU+eWU08ZHiK1D0Hut+Se5/4Ep59hPvwqDf1gj7wp3n+QpD
	 wSsFqDZi87wl7dcUK6+a09u2AfPXqzZxOPKjgNnUDpC43mZlY6HDj9r/tbYoQMcot5hsE
	 HB7JuhApsJ8m7sXBhbiofquJAEJBujas/z2J9KxUqYjNmkS/jVMyPg1hjj2o3KTtF2QJR
	 BEL3h7caKM20Lx5mCb9y9e4iL7lu9xg1em2t3uHrXC45aL2oIArC7B5W5+8mJMn8MmZZl
	 y0ZE9W1wGRrT8lFEViziByKoyjHnxmTCPTTh1R4Je3ljNCUr+RxP0Vqv8KPoSIyAqrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evfYeCNo;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F5606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A2F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evfYeCNo
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso13955845e9.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795071028; x=1795675828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0698PEwkye5fB74zmDoC5XKAdv2OhBbSBVgNtlM/kHQ=;
        b=evfYeCNoV+TTqpv6/DyJxIlAZ926ZIn1nJJlKwtJXv7A1Py7nS/f2j0VBb0aVeAUu9
         +ms5hhfGeayTndprvAO5nHx5qwCrPM/ePu7VmIl/NrizCOvAEGTZ9YDh4pWyKLXnV3gA
         QdLcld9nbv9uL5+4qLz30bNVmkEW5apMKgqHinwaFt4xHAGk0youlIT89Spo72HgQi+2
         3d1IWCm/k6az41IcY6MgqwApboP2bdkXxESfeQWCtaJ7RGfWyYXjx+B+b6r5JXQB9d1a
         rAi2/ZjedGe0jk0RckVV8Gy4Qna9XoklnsVWFc5p+m/BGWfiZXsLyWSuAogVrUyen1vR
         HoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795071028; x=1795675828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0698PEwkye5fB74zmDoC5XKAdv2OhBbSBVgNtlM/kHQ=;
        b=Tekf0OwruuFdG8HSkKCBAHMcdxcci/KksaEatfpfiv4sLt2kvhkOpb4TI+4w7u+qcY
         K8EFPGZuIgpQ1bfREByZjeHthKtRq21A1t1kwQRlWiMfLzbzumSkcFgGEqr7trRqgCCl
         YVGrr5jqWLErPKjmxW9TWrqvIs6gK7FGJq+6lMPowcQPG4Yo4EB24axZ+vsIpEfVEBXK
         y5a0ISHDf1fIbM8ONws69Z6lhykRdZS/XfnPn3N/dcnOL2vjkY1NhUbGP6SWqwr0vkIl
         +ozg6qBaMjIksoLvg6H0hSDYCtEaqdF/ENo7h99qwbW3QyZOZUSELWnrfA8YLHR1NUvF
         FyvA==
X-Gm-Message-State: APuU4Z8I5nD9lnm5NlcKM40v47l+YtmoOe1A2q+95fJCHsXpw4wndtF3
	fPjG076bH4BNRGvRaQOa1o7EFhI64oCsxv3PwtqH4dBeIZBDqT11EFDYabIHvg==
X-Gm-Gg: AYBFou2mdq4vqGAGMkCa0YOK15ZKvqFbCMX9oeWtluTF1iFFB2JlwUllTGFuT+AlseM
	p2o10q9RIQKKuaM8DbXmCnBWZQ/JRWBGy4Z/PXfcc+pA4ZO/jpQLYim5LIyKmrR0E9bn3TXEPGv
	64DSNhwRlCZml8OrluGBm5UUDTI+kJHelyDK/FUvubSjWv10MxLCgqfEcXd8a0Fk7SPQvGPjlII
	ahKg1K1zvbCCROtfzlAItxR5LgZzTx21YL/8cIGu/pAWwfVW2L08eKGh2CI01nA1s2i4Xi2QlO7
	GZPfOyzUBOltHXqzD6IRWWLp9bTJaU73fzm2byYrwdXqOTtbZICrsof3e/48HmVZYJT63iXtBKE
	WcXVvHnYykA33DDe5DhS8E7StqhYSWlVx/3Kn9ET0Ool+hbUQ07EGib2WtmGQ3+vwhuEdQRUoqO
	3MsQmpr9VzCuN3su/lyvN9a1bwCCgWrN8Na8XimQ9xFFMBS3yJ1rvtkkkm9p9Krl+TlYu6yW5CL
	Q8HVyEZhRUSkXVtnOMN2AgzsOrj5cwcv6EuLy9lfDwt6h1X1TdsBjTC7KXWr5Xq6HiT+ZP9+lLF
	gePsXXDD04CLHTToE2p51bu55ZskscYlvP3qR2hlwW377rwc05BrDC3qHHWIiWw=
X-Received: by 2002:a05:600c:6092:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb7da1dab6mr92425215e9.16.1795071028388;
        Wed, 18 Nov 2026 22:50:28 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm14379625e9.1.2026.11.18.22.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:50:27 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH 0/4] use size_t when parsing and checking objects
Date: Thu, 19 Nov 2026 07:50:24 +0100
Message-ID: <20261119065024.826502-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793444420.git.gitter.spiros@gmail.com>
References: <cover.1793444420.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A gentle ping on this series, which has had no comments on the code so
far. Simon's remark on the cover letter was about the use of size_t in
general, and I answered it in this thread.

It still applies cleanly to current master (e1ec09b23c) and merges
cleanly with 'seen'.

The pack-receive series now depends on it. There I agreed with Patrick
to hold back two patches until this series lands [1]: unpack-objects
could then pass the size to parse_object_buffer() without a cast, and
where "long" has 32 bits while size_t has 64, "git fsck" reaches its
verify callbacks for objects of 4GiB or more only once
check_object_signature() (1/4 here) stops reporting them as corrupt.

Is there anything I should change for this to move forward? In
particular, would you like the EXPENSIVE tests guarded by
!LONG_IS_64BIT that the cover letter offered, or is it fine without
them?

[1] https://lore.kernel.org/git/20261119060524.775205-1-gitter.spiros@gmail.com/

Thanks,
Elia
