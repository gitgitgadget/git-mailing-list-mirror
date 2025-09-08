Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1F2E174B
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333997; cv=none; b=XW//mPZNf98Aa+jrE76ZOY/dSaE7sojKMqBDqq807Wx5YBacHgkXxLpt8EHxdy0/W8Wi1XuaDcrYntANCgTjyK23xmI6wYdMnAPDo4Qh2WCrzDmh+h8LyBrN3mE7GyCT1XAq7wuoTmdMP0hDy+usmuR6Ejg9JA1d/2D1rbICoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333997; c=relaxed/simple;
	bh=lB/evPyGqow1qkMdhvDXQMlpuKvuAfpKKVg7eAcEgrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tw7OFMPYGJEXGgl+M5hfmG+JUasB7AFryhb6MxqNdR4ApuOzAIQyQTzfZbQO9QjD8vYa1LG9Cr7HmKNzswFJjZ2pbr6SVa9jElAgrq1qgFp5f1VhJSvI9vWmuhamumEdAkEmArY54Cu1R9IT6L6hA9fZTKeplSTGVwOLCe++ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZYdlcLEY; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZYdlcLEY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1757333991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QA+yW2L1JeWUGWBy9MwbtztWz7+c47lJ5lAvqA7puis=;
	b=ZYdlcLEY06jHs68jZOvuyJTvD3kif+29LZfYysP8JhDSJoTD+BidLahLNRP+6J8eZjisib
	VDNKqzU/0EGZPzjByltMGA/WIV3EJ1OcpLm1fsedS4h55J0qWSGvxKL4TV8JPa72Rm3jfD
	Vpwm/MB3hhXx8BAuqV/1lkri0kpCNxc=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] combine-diff: don't override recursive flag in
 diff_tree_combined()
In-Reply-To: <xmqq5xdw537l.fsf@gitster.g>
References: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
 <xmqq5xdw537l.fsf@gitster.g>
Date: Mon, 08 Sep 2025 14:19:39 +0200
Message-ID: <875xdtw2zo.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> This patch is based on 'next' at 1ba7204a04 (Merge branch
>> 'kh/doc-markup-fixes' into next, 2025-09-03).
>
> Can't you be a bit more specific?  We usually say "do not build on
> 'next'", but what we really mean by that statement are

Sorry, I didn't realize I didn't follow proper process here.

Anyhow, this patch is based on 'master' at 2462961280 (The sixth batch,
2025-09-02) with the following branch merged into: 'tc/last-modified' at
8d9a7cdfda (last-modified: use Bloom filters when available, 2025-08-05)

--
Toon
