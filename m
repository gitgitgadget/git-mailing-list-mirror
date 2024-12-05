Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8614A90
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733374747; cv=none; b=KqRE4h2TpKpF8ombq4l1sJeYT6VYrZC/NmHfK7+zinsOLfa/ebWDWGZ+tPM+emFwUViuyq2zVsGQEiGMcUSsyA6P5z/Sj1PZw/5a9Tle5YlHdvry29FTPyCxREHuMFrSgkJz9NF0q8fuwCk/iP6WxtqSSZJl4faKmXjr5UBqOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733374747; c=relaxed/simple;
	bh=8+TbUbeHVJESlSWchYJMvZ2OIOEwc3OLSNGS5ZeSxSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecqrEMZc1dnEu0w+g/L/MY3cjQ8OMMiv/TD/F/k86+RqU4iLbW7SPMeVxBhIkQlsu9sUHFGCf28TQxnBsyMfEuZJBrjCazNaqp2w5TyFUIzETokR6avCBbF2OJcv6grOgsaCrcqCD489J2si/djTTRDw9OMTZOr7U0gUj0DMpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEUY7d0b; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEUY7d0b"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffd796ba0aso3993051fa.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 20:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733374744; x=1733979544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+TbUbeHVJESlSWchYJMvZ2OIOEwc3OLSNGS5ZeSxSo=;
        b=jEUY7d0bdHgAa+dkZrs2+/lAFBqJ/MURqdx9s6v4k6m9PyqtOkszLvEF11xCx1xQ6b
         gxMiJAEmqUqdas0mIIFuokD0dwgnLuk/DRAzxDV3WCro9pSHUwowT9rWpEXfESGELtXs
         MJyGbullKVkAXIUonJRXezCNHja9dG35VnBd2tOc4qjKSQDyDalKYXnDd+tRIDISt6Z+
         NBoWBthyG2YTezckG/yf3kInmeFDskH6JB2VKXuBNBOdG5lMUpLHyHG6lZIkgedyL75u
         PAws6piPFpx06ga/bWaa5LBxPAIs1KQzhMCUmXoP/bEmi/F2voIVrSct7sHKEyLZztnf
         xjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733374744; x=1733979544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+TbUbeHVJESlSWchYJMvZ2OIOEwc3OLSNGS5ZeSxSo=;
        b=ggiU1LEeEkUXee/OkYyG3WZMioGcpLyPUOapDZJwnUjl+CpKuNZLv0I/a6rRrkJDhT
         Q3mnMNgj+kkbbospkmgSwLe441aKZysBA374ErFY5RKviaSaEYUTbjfUaSHxOzFWc+MT
         ImZEycs3jWO2OcJGV5bOu9elOHWfPX2NnLB/mc0gqsiiUdecT4tsFf8lg0E6GlRDO+Oz
         YWiy7N7pRrpxv0c1nxd9hqPRY4gstFIt60nyS1dIxa9ugVsPkblhbuVIvU2Lry1RYvBP
         AWMS5s+VsdTDbanH8uWvH/lx2LEPJ6XnWC4o2vRTFhAH8qdEoYsV1+Abds2o9Z9vMymO
         437Q==
X-Gm-Message-State: AOJu0YwnIseqNfi+U1mrrFJttZD4v/oDbq7ydKgUkUeYRI4+FKEqUj5U
	OH91k7Rb7SUavbX1eRu/QI/jci0x/UIgmUkRoZaYBTBAT6RfcmRwDuHo+sjplR4CMEc2o4M3sr8
	nN/zFesnkfbTaJdcBP7fMzJnDVX8=
X-Gm-Gg: ASbGnctqTqjLC6czjyHjiGO6ajGSNhY78NAi1NzK0vABCPLR9bOYNEdGJtAFEvbLKBl
	cP0ZQPnvxFLh1zgxr+DyVSNvwPwOOHnM=
X-Google-Smtp-Source: AGHT+IGfmc62G9+rT6+fwATVfRJ35Z6cJFsoAg9WGCxn44k5uGomtprkORImkiMecMfXufWq0nV22uH4zh07bGH88Sk=
X-Received: by 2002:a2e:a5c1:0:b0:2ff:e5af:e67b with SMTP id
 38308e7fff4ca-30009cb1899mr58739111fa.35.1733374743905; Wed, 04 Dec 2024
 20:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net> <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
 <20241201213636.GB145938@coredump.intra.peff.net> <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>
 <20241202203451.GA776185@coredump.intra.peff.net> <CAJ-DG_BLtwg51UoBN4m64ejYUcS99zu54oPYGnC5p+55tNtzpQ@mail.gmail.com>
 <20241203211830.GA1423791@coredump.intra.peff.net> <CAJ-DG_AU8cFdLqfAnEE8N2KSqnQgJ47YJszyXWOvXuuKreAbCw@mail.gmail.com>
 <20241205032246.GA2573761@coredump.intra.peff.net> <CAJ-DG_BdAiFk_2eV=JDF7Lth9+Ay=86w-VT26Rt+T5fdN1vd_w@mail.gmail.com>
In-Reply-To: <CAJ-DG_BdAiFk_2eV=JDF7Lth9+Ay=86w-VT26Rt+T5fdN1vd_w@mail.gmail.com>
From: Dmitriy Panteleyev <dpantel@gmail.com>
Date: Wed, 4 Dec 2024 21:58:52 -0700
Message-ID: <CAJ-DG_BC=J3-wc2w_-xLSDbN6B9xkS2aWPUMFJYVRHkE+Ch9Ow@mail.gmail.com>
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hrm. I just spun up a couple of different VMs on my server with old
and new NFS versions, and git works fine from those shares.

I think we should put a pin in it, since I can't reproduce the problem
outside of my specific server instance.

Thanks for all the troubleshooting, Peff.
