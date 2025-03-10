Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DABA3D
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644580; cv=none; b=h7zNnk9x2/NC9F+xXoPMhd0ixU2Zsv3HBhlsjAWwMTo7L/NSL+D/0K6lwFapiDR7EGCULb3ZUR+QD31mnEpId7dYJIdMvU7Z69UhCImYhBfp6VLXQaU6UGUszwkbiAMq3m9p2bZw5LUae3afWtSGsuENuZ7g8ur7Frdi9x814fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644580; c=relaxed/simple;
	bh=OfC/My1oG2r/zwUKkpansyQP3Pgy3KSMMIcjqdt9mAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtT2a5gZHI1NweG6Ly4t1vkZcYIWgU7i1PElaSxIqI2vMxouCB4nKZIvH+Evg16JeMQExvSnatdZWZq7MQ/FtDci9rRcaAtVWA7We3fKhkqB6hzwYto0v0EYT9V14K87gHUHJeLutmlAuBm/Dp9cqvb9ZIIegCdcieeLNhQQgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=f5aDAiN8; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="f5aDAiN8"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff0c9d1761so1140187b3.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741644577; x=1742249377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwixGEcxTc0/oWRcbIrFpaGhr6aQIMOrt57rcTbXtOY=;
        b=f5aDAiN8Rq1tnZL8W8wqStQky3c1sCo8NLiK1PN2oB1qFur/3PauOjyA5FMqCiMivp
         7Z6ir5DgKcaCQuN3zh6gscIqkeoyo0aeaej3hoPLl8ozkQFHoG8AmXhZGI3uj7TRU2WY
         9ixl8IQWrL5OkX1EmlXMUbWJKI7VRFf9FN9I96MOcgZwErOld/rQLAjSvzxpFAn2V3ap
         lCED9QMff8DueT+gEu/XDk4wUbGmiGYGymBXssvy8FpahHemhlgBOj82NjN66p95h4c4
         4gkttbKMdjnfCifOcwJ1QP88NmI37iUK4s8Wr1oDOCw6stNNyzFupkR+UlQAmca0Osvk
         Mgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644577; x=1742249377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwixGEcxTc0/oWRcbIrFpaGhr6aQIMOrt57rcTbXtOY=;
        b=WblRJe1LIc5jMXqxOHRFlJp3WQETcw2reqkzbY4wppRmsI1yiNrInofl2dEYTzTVHi
         wqx9rMUWL/twtQmrEzCIiTRe5IL8ckZJPycGL7B7jZ5Mp6E3b5St1ENChwYDcfnPbcHK
         WbmtnEHKvC5yolvVRCaUwKfmGuNUdNQ2vR0vT90fQOrwen/WUW1eFZEgkj/SA/mDZ9Yc
         ybH3j1sO1as1U0B36JfGfDUCW9MWsx1K5+pF1Msg32OdS7UIvRI3runLC6wEgWRSfXKR
         cq1jBF29qWKAXSpWDUwwySrAPUgSzxMRW9nuYSjKLoBaGuEGUaQg9Yok3QlxIWbel4pg
         XRoQ==
X-Gm-Message-State: AOJu0Yy94UlXvFSNNrbUqQfDoR6ogYqhP3iEOX/+P0fPyKmRH7D3D207
	cPmuxiQiS3g9bmjr/IhY9/E0JZ339vb2ObdZZkvsAMZ5M8/jPXV7fmPllod3L+bboqufEyFMVL9
	9XBw=
X-Gm-Gg: ASbGncthWwhSztiIoU1hv/Lvs22WJ/lj/QkpmyQ4LIlX4hPxxBrTqltPQAsplNebIjf
	CL5t3mo9zhavXMVq6YxDPNXNG+yE+A4qLg49Eg1n5ehVapRvUDsgfXHTbcyAH2uvgG0In4v02Lv
	ChoB74fhbklWroZQwpetbt+DA3ldv6+aFFPEHARYuqvMph6Er0uEP6hPCja7uTPrWd7YigX6Lb4
	lffitD5L8i+j2nxSvqFgN9FeNUssKTEkhe35u6SMzyQtM5IxXJYXw7sFfj5oZrrGqmU8s37ioB3
	9/dQ4QtDMobdlBMdQQE3b5uo6JrMaStOWVmxysDYK/qzjAfeU3vSNMt/00ApFlCgb08yYPOj2b/
	AvqwvgGkpI+16TAq7
X-Google-Smtp-Source: AGHT+IFTdgLFvnlHg9VW1F38RoxYYaE/ERuEXAkzK88Whk3QlVeU5o1TKbj+5tJ2PMVXv/SE77dQLw==
X-Received: by 2002:a05:690c:d19:b0:6e2:1527:446b with SMTP id 00721157ae682-6febf2a4c34mr217334667b3.3.1741644577025;
        Mon, 10 Mar 2025 15:09:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a6acd7sm23401607b3.42.2025.03.10.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 15:09:36 -0700 (PDT)
Date: Mon, 10 Mar 2025 18:09:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #02; Thu, 6)
Message-ID: <Z89jHhnQfRRjd1nf@nand.local>
References: <xmqqzfhxfym4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfhxfym4.fsf@gitster.g>

On Thu, Mar 06, 2025 at 04:55:31PM -0800, Junio C Hamano wrote:
> * tb/multi-cruft-pack-refresh-fix (2025-03-04) 1 commit
>  - builtin/pack-objects.c: freshen objects from existing cruft packs
>
>  Certain "cruft" objects would have never been refreshed when there
>  are multiple cruft packs in the repository, which has been
>  corrected.
>
>  Will merge to 'next'?
>  source: <6e93471f9a8e6a3dde36342088748ba17e4f7f95.1741133712.git.me@ttaylorr.com>

Let's hold off for now, I discovered one more issue with the interaction
between --max-pack-size and --cruft in pack-objects that will be easier
to address within that series instead of on top.

Thanks,
Taylor
