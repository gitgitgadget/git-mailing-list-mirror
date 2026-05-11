Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33E2F99B8
	for <git@vger.kernel.org>; Mon, 11 May 2026 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537834; cv=none; b=CV8mR3IvPkVkq0IVskh325n1I/GHu5c/OHiJyzS0pe6+qASo0SqmSL3m2mRu+NwZBugXZjQtmnukXY74tSq4GpQlJZ9v9cZ2pjXf2NA1jd6uc5LeSROLDeMUn+YBkh/24JGwmf7GSp6TsSNv7zLMNZE6DxN8CMJ4BZaB0ADAMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537834; c=relaxed/simple;
	bh=BeQ3+ne0O7D7N88ecWrmSFlx5y3vFVJXby5U4oEk8FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sAjdnQ6ofDihKluPtQqN6uzJfkixREoGacx9GigExXWJtdqDTDYwx8Vq3tyBeHPfYJhLsqTDm+xyHSukh3FG4aNWJ+xJkV0b1bnbupNhlVS4BxCQ8le5pGEfwgJjc4dtVJ9/cepb8v/eE4W+32FNmysXbVv3k4Whk+BIcasJobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fIbHMGZO; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fIbHMGZO"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-6579254f996so2980582d50.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778537832; x=1779142632; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpAqA9onrL4+pFApnicxhKLC8jDBZkHeIPHSxnc85j0=;
        b=fIbHMGZOQemqhN3VHVqA0sekhVtmGj7Uj1nGZDvsHr0iqxOxjlk+knlm0YlWIiKaPG
         xxUBrsPRypUz82Oup/kqJ7wbEHv9qrFdLyjtlsLZEFC3TfwekuLpa8UlMVdzoBYxnU7F
         nDYsENYTzxofyqYUoDuJAgV7VAuZXxMKSITYSYrzpUGNPL7uSADKPchHBTh8Ls+DXXIX
         C/pF4eFOwoAtFeIGVHS2RtvtwC1BOpkNyeiZ8C9X3W9BGrV0qr8QoSmMoppfpJbaHo23
         rYa5q1lSSeJBaEdgYS41PLbo7DNkGQ5HAeT/6ObMzz7gDOBuMHunjeqqM4J1TqWqvZCv
         rC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778537832; x=1779142632;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpAqA9onrL4+pFApnicxhKLC8jDBZkHeIPHSxnc85j0=;
        b=H5DZTxa4/0MhWg3zkOGAmFnFmXphrRYW2+UlRh9UJEyVilq7nf+cOGM2LBkg1Jhzym
         PjLkZwZyRgnjE1ERPw1WyGVjtjYdfQYuBZuCtOK5JSnQBpV3W2gB1KK5X7yK4Ibd68ai
         k4xxSvRHH8vCDmViFxjQ0WC2DzUysJZbSNbwrMwteGN7MT1v8DohZhDr2fqYT9D/2Bp6
         ZiQts0Y248A5NwVw6fIBIi9d3tp1yvltEaJEzjQPeeI1q81DfAWn4sAfrKslk02rmDn6
         1L3aSvhrz6t8qr9ku+rsZwlNjGxI2vFwNI4GSo9XfQrPARnD1cWx5cRfEJdPvGjWu3tK
         asTQ==
X-Gm-Message-State: AOJu0YzGWOayVaQXgr35+Akp1miIsiBV7fcihZHN4HMjfFzI3pSYcmQL
	KmV0Q3Q80Y2dn2BA3G//UGEecor1BXcYn6Zw6jXFKXm9Lz82GOpjDW2uog4yUXq2nVLQ5/0xVbj
	Fkzl/f2LvWhwI
X-Gm-Gg: Acq92OGyR43pTJXWLx4xQivzkENwgZVyiqWLsO9qE4jHo2eFkTgXxu6eQQT/ed9U58z
	u7a5S6bQVxc6N89gudEREtkmEozPYw8nldF1w2NYHUjj20VuCyCtNpEzZGL8ucbeA7GrKa0f/dN
	cp9Hfidue0wKnSHrIhFCiIPhQypw5xrW6OMPhqCAS8GG/8NTN0nEBL/qFYG3SfHoAMND247rdM2
	7biCQ3xCKYZGJ88JkynTuWledyFdaBO1jVqVYQ7PJF5ZAJs6k96PFOJBZPfp/6CVoxxx4tH83kY
	gWKS6wRBgP+yR/HwXcevtiXwKXXetFBV5NyiCiquFOgtYRzZP+uAr+ZxKn4BqDYAnXG16CjTvbQ
	4RSXSB9U2KG/2wXnDxMieinxHZkuVP5lY/6c6E8B0+xeD+RnIS6tXT4q5vKKAAVBiiAH1zBJXha
	o5ec6xPqxaNmy59ji9+TGSJL4rOL05QWTr6LwzXRTXKI/C7x9j9j2riW0Acx3PrF8TWHGCsTydf
	PrPCD56EnNhJ9sH0ZhdFhGCoqaGikGyDJFu/jllWjR7oeB8N531fyM/uktg2LD9nKH90EXllGWK
	vFHXp2wZzv+z1pOr
X-Received: by 2002:a05:690c:7107:b0:7c5:1d66:8cce with SMTP id 00721157ae682-7c51d6691a1mr13837797b3.24.1778537831884;
        Mon, 11 May 2026 15:17:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652750asm154112807b3.10.2026.05.11.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:17:11 -0700 (PDT)
Date: Mon, 11 May 2026 18:17:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <nasamuffin@google.com>
Subject: [ANNOUNCE] Tickets available for Git Merge 2026
Message-ID: <agJVZhTbA/hFUKG/@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Tickets are now on sale for Git Merge 2026!

To purchase tickets, you can visit the conference website at:

    https://git-merge.com

Tickets are available for $99 USD, with an option to attend the JJ day
exclusively ($49 USD) or in conjunction with the main conference ($129
USD).

If you are a Git or JJ contributor, please e-mail me off-list for a
discount code that will allow you to attend for free. For Git
contributors specifically, this option will also allow you to register
for the Contributor's Summit, held on the 18th. If you aren't sure if
you qualify, please reach out and ask!

Purchase of a ticket (excluding the "JJ day only" option) grants you
access to both days of the main conference, including food/drinks/beer,
as well as the after-party.

As a reminder[1], the details for the main event are as follows:

    When: September 17-18th, 2026
    Where: Suspenso, Lisbon, Portugal (https://suspenso.pt/)
    What: Talks on the 17th, everything else on the 18th

(The JJ day will be held on September 16th, 2026, at the same location.)

The call for proposals (CFP) is now open, and we're using the same CFP
submission form for both JJ-specific and Git Merge talks.

The CFP submission form can be found at:

    https://bit.ly/git-merge-2026-cfp

, and will be available until the CFP closes on June 30th. At that
point, we'll go through the talk submissions and notify prospective
speakers of the outcome.

As before, if you would like financial assistance with travel costs,
please reach out to the Git PLC at <git@sfconservancy.org>. We will
accept requests until May 15, 2026, and will inform applicants of the
outcome shortly thereafter.

See you in Lisbon!

Thanks,
Scott Chacon (GitButler)
Taylor Blau (GitHub)

[1]: https://lore.kernel.org/git/aeenTA8efhY6hNvt@nand.local/
