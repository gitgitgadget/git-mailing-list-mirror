Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B827B32C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902964; cv=none; b=P5APekGtSnGJ+eVukS/reYN8S+gklYjftawYHqBTJiPN6BQd9wwZTdq5WrlfHQlpUxBls+J11lXjT/45GGbyP/wJcKvLT9W5Z5dBG3Y1Bu91aXq+kZsL3jJcbDzCWKKsV7Nh1KpS05CjUgCAAIr40TJijYGyraKQQwKluSq3OWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902964; c=relaxed/simple;
	bh=2W1es8LZFyraxz/jiP4pBW/xbDJNMAdNcDyYp1IZLV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qCorAxxXWfHYAQm2AGSyxxRowM2hj58bEdbYbM13ZHHulUKkYhH40HvtMlgfhLgA7D9MMG20Zrv+0V8HgpBZiSrQ5vhmVKQMzY3e2f+RV98PMk3x22iNVn5m+6wP/QSbJVgp/FXCKnsNaSaQJPqWcpTPROYcuKOENCcyOEPoKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=EtjgNL3T; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="EtjgNL3T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774902959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N57Ay9oDCymGPmwBx73wHYy84h4Y4x0+KdqyZLScBdQ=;
	b=EtjgNL3TlVNSD1dzqGOLoGoSH5celW/5xSZvyLII0Xc6Esk9Qvu3cSj09V3tc5GhhwMHkZ
	lDVq6l3RHJPO9+2R+bvun4fNU8gYwxSwz2lnalpJvCbYzuUeWWgbIp/IXNwG1Yb1tQOXDO
	LAw/K+Don2bdCRQP6Agf8fLmRyOiY10=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] odb: generic object name handling
In-Reply-To: <ab0hy6AitZFMf3RO@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
 <CAOLa=ZSeMS2iKzgMUWix_Sx+e24863PsOazRLrqHtS5hYSUk3A@mail.gmail.com>
 <ab0hy6AitZFMf3RO@pks.im>
Date: Mon, 30 Mar 2026 22:35:50 +0200
Message-ID: <874ilxm4wp.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Mar 20, 2026 at 03:04:02AM -0700, Karthik Nayak wrote:
>> 
>> I only got around to reviewing v1 now, but the range-diff here looks
>> good.
>
> Thanks for your review!

I did a full review of v2 and only got one comment about a stale code
comment. Not worth a reroll if you ask me. Looks good to me.

-- 
Cheers,
Toon
