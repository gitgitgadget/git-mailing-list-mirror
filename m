Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F0175A5
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754372150; cv=none; b=lBrbFYi33yAtEqFXVZS0Q4orKcBfNPp21YA5PHLWRLLwFUPL4pmahdDF990TnFRTste21XPqhYjQLAGBTWpiwnSp0Qrrrt0IASbT+n+Oli5Ii6ZhbZFD9fXC1VfnKeSrbMAZyT/B5NnFPGzvWGHynT6NA+Orc1fNl+FO48D3B3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754372150; c=relaxed/simple;
	bh=fBMmD8p9IhQilAhbqfkH+BkNFn6k6Dopaezh+dmfqp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NxPwPyluRn9rzxRTuPlE0cTkP0xaSEffVw5+R6vgaYDZXRzgykxFDb8EBYgXqqvqDJmUMHfO+hFQhfbZCO5TUt2dYCLeYSQ6Qc0ylG0KsO1h23wubAjwub2tD11FYg2pt3OXlckbTllyXiWJrQ4HhPaLUSI05kj0zYEEAr1bXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WO9+VLQw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WO9+VLQw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754372142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bjtitvmc879heM9JPCd5cKWf5SooDBb4ub/hKUxW08Q=;
	b=WO9+VLQw4+hoyJZw3d5TwyuntgWuOinx17JAbpr3x9ovDioHv3oMsQMu5y5N0mlNQAKqjK
	d/Bd+7dVi3dIN6xhT5/+YFeT4yqsb/69zELEoylxI9ZLur8cCeQtpDJ1F9bbdJVRyl7J9o
	r5jqBBa0JAvXjVWYnZgXLmcMTenrpTc=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Taylor Blau <me@ttaylorr.com>, Derrick
 Stolee <stolee@gmail.com>, Christian Couder <christian.couder@gmail.com>,
 Jeff King <peff@peff.net>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <xmqqikj357rl.fsf@gitster.g>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-2-toon@iotcl.com> <aIsQWcHf82ipHoWf@pks.im>
 <87ms8jui3p.fsf@iotcl.com> <xmqq34abm0iy.fsf@gitster.g>
 <aJBUWveulX7HKAMY@pks.im> <xmqqikj357rl.fsf@gitster.g>
Date: Tue, 05 Aug 2025 07:35:31 +0200
Message-ID: <878qjyuy8s.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> I am somewhat indifferent.  We can call the option --show-trees,
> which I suspect would make it more consistent with ls-trees, while
> making it a bit more confusing at the same time.  I dunno.

I like this a lot. Gonna go with this.

-- 
Cheers,
Toon
