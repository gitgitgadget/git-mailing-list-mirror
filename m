Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6E45091D
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920137; cv=pass; b=s0+I+BSrkaXk6ecGoUZWnExTfUIA0RXh3kX0T1+qCTcUOeFGpStBLVAILDsofI2kslqdF8Yqieqc+aNansljD12DAUCm+KeQz0E60iilI6uqQZck42W5ZDZfKAQZCbY8TqGa+1M2ZIIlEiRm/EGkRGrWeHtvabim/Qd2AXuK27g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920137; c=relaxed/simple;
	bh=qlycOrCbTWn09slaEZyvKXhoyrD2c9otY+QgX4dx6MA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BMIKnkNPe5oIfmxDtfnHJ1UDOzsVlgQK94frOC4z1kHsZN8sXkAw4TMydInKA6qDle7VZwqCFZ4TAq6LKjEAWOLyRQ6h/NVX3Z9ogS+TSBBC+b1Jd0mRuBOEeq8EEFOJ9o1XKcmFx3GOzMey1mBxuRiajZyeugrO3HPOaH9aGEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViP70lp5; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViP70lp5"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-123320591a4so5446711c88.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:42:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768920135; cv=none;
        d=google.com; s=arc-20240605;
        b=HqHPslN5HLtthKbSKABDNZ72uNnxONoicNqyyQm19o1pvyCMNwCDVIxsHd/c/cCfWQ
         zISro8kRdLm1RKeP/+Ejb37chQAONsyFjSVsC68LD3w/aLEYRK9doSd90ApWnOp4MXDj
         DMFL0O/LCvu5NnJJdF8AjUeN1dITWfQyqxPFfMj86umbl7zTGKvlO2VqO7ZiBOIMFOg0
         7yrYvUHh8M4vuCJzTmHWZC2bGSzNfEAszaHhAI8DG8sN/kXCnQv3Bui5rHq9/G/LZkV3
         NH6Q6fuS7EaBGUGbNUMk8jy149CLYiZfzQMW09tK/iG48SOJvmr0dZDmFhruZpIdH3/Y
         U4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qlycOrCbTWn09slaEZyvKXhoyrD2c9otY+QgX4dx6MA=;
        fh=wsvoWvBz3+zI3cO8xbdreD5Z3aI/wpKopH/flyQpgVg=;
        b=e58NA0w3yDmUGsCQlzpxVGNMza8ELsNnPQJDFzKKxxIek4C5/sYF5DQixR06TE9Q7l
         Giw7ysC96nlTSpGONPHDcFJbEEEKcwDvihVkSdeq6w1tTJflxL12Os/rfhNgcY1NU1WJ
         cNUoFFwXklBAc/Df8tlEw64iKNZz1Vo4DDLnZ/4BcDOadi1tXf7fzCySTPqSw2NXIqU6
         lDSlUUB+deNIJEgN2DTEaYBg11CHUMDOispGwESW02qfZoi+g8dT9wHbEUz/kw7MIinl
         gro0LoE5XxXYeLYRlHqVMTehcbw3Z1HagWy2mBZCzsM+mB1qc7fHhFBeVlI3U/iGepNW
         eNsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768920135; x=1769524935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qlycOrCbTWn09slaEZyvKXhoyrD2c9otY+QgX4dx6MA=;
        b=ViP70lp5NLDBKiweh5a92TqwEw6mdlg7r0idtugwbVQkElwXjKQT/YX7oZfeD96HBl
         jMBhXZREzFaEDCy49Ook6i7QmAqYpxs2qOvf19pHd5Y9ugEaJ99C8L4jZNRyvPXCSqE0
         VZj5wngYUSeXWdklVQlX69oiQdNLOx9SiZj5zG8eZUfBJVxxa4pw9EGvnafGXjVfuXGR
         fGUbh3xgGsk2vnn/wXrDBbgcZPP2HTrU81iw8iD/wodciLbjDIV+w7ahr8151pKXoCJ+
         jj8giqx3cpwxhA/d3PYebvr0/zxpG9zm/OdPGO9qfRf+hUM3zydXLXYvKoVEcgDsThKq
         6j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768920135; x=1769524935;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlycOrCbTWn09slaEZyvKXhoyrD2c9otY+QgX4dx6MA=;
        b=R18jO/8LiO+iwfteR4I+N2E4OQECovrLoyHAWV5wSLxsKZ9Fk6CTV9JGhBABvpla+w
         YtjrC2uGvZgjbJTEv5D1qglN4Z7HVNLEu/FnPsKgnwysX9EfqShuzsWV6n7J4038C4C2
         /BH4DnXnB+fvFdZOpSas7LVk5rD+3kYkozAfEkbV1EJDoxydyeWFkFluFdcTY6HaIkQ+
         RsYzlRwcNWFJD+TvH2kPaGr/azH/PQLoaHonuM9nkmkEsTzNBGfmFZYjPzGyVR/a4n9o
         Nofave0hwLK0TR8gFxkn+XEywa8todFmzsd1kJT8Kt9UxaiwIHaJX/oC0UlsQpOuVU+s
         HHGw==
X-Gm-Message-State: AOJu0YzcoAVgh4ZhzZ1/B0dbUBl/A7AKEWmMDNaA6aJ/i8kJ5ibkmPu+
	MtzV8V9aJ9ZC7ECND1d0L2r9aZjTZflcz50yjfpygPmOrHpOZwsSoJZKI8POipEU5Sg6Vk47NLZ
	XbCKCqNEPLbHMieGWYF9YFRpx4jwLPWOH9QCSGfKAjA==
X-Gm-Gg: AY/fxX7X/Fja0hePpSljvlEAsRwpn5bTpbkBqIETuvto7UGlFunvEif6YKO3xTnlm/0
	GpmraFwe810+M8gs89SXJ9UA4HKZAc+kAEQ2k7ZDXGl2L9NFaMJnHJ4OdNWJpDk48zO5fmLkt7n
	SYk1kBSwD+4itrN7aXYbctMQXY1dTDpfw9ZSnB9W4BzrCD4Ignj5t5vSCIaCmvPpMxDK5RRTCs3
	/p7FVccLNOZHyTFgiKGlE3Fay95SFfci4/cBGIK4gi1gAf9sw5ooKJw7m+4oYuTybE+xJ+K
X-Received: by 2002:a05:7022:f105:b0:124:65f7:2c2e with SMTP id
 a92af1059eb24-12465f72d12mr2170211c88.43.1768920134969; Tue, 20 Jan 2026
 06:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 20 Jan 2026 15:42:03 +0100
X-Gm-Features: AZwV_QgLxjnKijH69NoIkCYSSYsq2CywaiYcKfNAUwUS1WDkhMGiKGyrD5LiQo0
Message-ID: <CAD=f0L_DGgpr+kxRjZY4KLGjdKn8zTfhq2gZWSY4Jm--yqJeWg@mail.gmail.com>
Subject: =?UTF-8?Q?=5BOutreachy=5D_Blog=3A_Refactor_in_order_to_reduce_Git=E2=80=99?=
	=?UTF-8?Q?s_global_state_=28week_5_=26_6=29?=
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Weeks 5 & 6 of my Outreachy internship were all about design, not just code.

Lots of reviews, deep discussions, and learning when to pause,
rethink, and send an RFC before moving forward.

I wrote about the lessons here:
https://hashnode.com/post/cmkjgvu5t000302jyfon53h7l

Bello C. Olamide
