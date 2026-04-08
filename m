Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A0322A
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687729; cv=none; b=dRsPdtiVeBxmPy75TmYTxW+qJKSmQGxFwZDwkJA0jPaXXwblbgoDg86m3X9UrKaQGcO2hPgr8GoFFs0WTPdkfZtpQjZ1+Lkn4TX91XKioEepr8xg92D9xxmPYxeDpUac3i1N6i7np/8FsOJbH5PuCVOjYxzlLK3Yu7dJC1It02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687729; c=relaxed/simple;
	bh=o5FBILZ9LKadzw9ryvnkPCcvtR05BrxPnVtzFNgdkWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAgGZdE3eaqY3fvhqdDJRX8JGBksJKjOoCAWY7fVudFjKQNcMDAgFLbwsWZjHop+FE44gcA5IlNMLm7aMN04KJkeMpQYFowkZ42AFQIg2SzYwsbWtbxBS/b2IGA/91DlMcxSSdWubKM6k8Uwx4Gbz4zD5/Z9d85wDyLyfqS+25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MpIcbQIX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o21dH53v; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MpIcbQIX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o21dH53v"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D8FAEC03F4;
	Wed,  8 Apr 2026 18:35:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 18:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775687727; x=1775774127; bh=avTsntXZHc
	A6JCUNxfW6UZf8Bsx7yqMyrVxLTJeSr+s=; b=MpIcbQIXvvPVOwaLd9lP083rsY
	BAKvDm/d5eXDWUAuNnGNeRt+jMEWtD8JnVcWgjxBhTWIcXUnw4eS54uWMIe9t6CR
	KwK16wPa7XHX5ZfJRths42CfyGprEJlSzCOYdiRXUeMxSl4UQZ9ppzM9sKrYfyHq
	rNdgibJ+8mLld8aKizylrU1B68DuI1J6kJEufj7A4d90drvh/b5Djhu2zPGU3nsE
	cHL+jzxhzsIA9PBMJ1MG/OlgYxOPac7FWztbW8Jb6hlMUEjICuG98FCCKB/Ma6DS
	H3mt538WHvv+8RPvEkRH+/xHouSiwd7WNXLlxCjy/0AJHM7jqK7ZiKbnN8JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775687727; x=1775774127; bh=avTsntXZHcA6JCUNxfW6UZf8Bsx7yqMyrVx
	LTJeSr+s=; b=o21dH53v2lOTL7G0X5E52mlZcSV+OVd/e2oCxVa+6JI6Uarpv6z
	WknB+ibUk9Lm4rnY/Bf0qbAb/WrWY9NPLmmEidPULUgKhh8ur8c8vvfN6D9WYxla
	P32+U6DlYD7zQm3kYkp6lST+GEmVovi3ZDfWf0AjHcE0ye5yTUkuMB0SC4sBwy53
	rAqkUQxl/s7R6/oXzNl2g/QyHLpTpVWDfwe0LhC/pxmt6qKVXitYvbj0hB5HQkHp
	0YoXwoGqevt6rUJBaOTQqim57qPoKgya59m2XSsAuCPwou/qtEz9T4SwSYbS2sO5
	EmbHf5Y/AxbTrx+uH4I7CAaf6LxlbsoJnCQ==
X-ME-Sender: <xms:LtjWaY83A6sZpRtsZOAWtwDHq6CML1uVCWCgkPM0UUm-u-U8fvJasQ>
    <xme:LtjWaXkISgnYaYLv76bqNJckk8u_LQo2fkHmWc1RCMHb52juIOYsxqfGyFjMzKODN
    epPcCQWN_vLEaZIcYiLlbmFVuxEBW7v3LbatN5eF46aM1hg8W9j0w>
X-ME-Received: <xmr:LtjWaWXkwNgmOWtHhigHnsq_dJkvwjtz4KDpRjcmXI9OJvGPLn4APyVKO_3v3-L_cHLqelB_WJZ31Du4vajiXo3y-eC_KzteDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LtjWaUEnEUCygO5rHGZBKmoY61voah-95-MIIHQ6Q5sHcIZQ2DPbyA>
    <xmx:LtjWaafZk3NuvjBQ8g9ADmYnsp8wbwihqxeXVbpREZnoZqSx6Sixaw>
    <xmx:LtjWadIPcIeu4qEQjtzxnQjRuWh1o2v3ds4-um460IQla8ixXFhnsg>
    <xmx:LtjWaXGwvmDujBgNIXfjw8i89qm4CxF5PKo_stWqFsV2MLdVNK441g>
    <xmx:L9jWaUVfNFDITiLs9gp1RBZkv-eidlET8m3xN59QwifKXLP6_GlDyDpZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 18:35:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "'Jeff King'" <peff@peff.net>,  <git@vger.kernel.org>,
  <rsbecker@nexbridge.com>
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
In-Reply-To: <xmqqzf3dw0o8.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	08 Apr 2026 15:24:23 -0700")
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
	<20260408041716.GA1324339@coredump.intra.peff.net>
	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
	<20260408173949.GB2850002@coredump.intra.peff.net>
	<xmqq4illz5g9.fsf@gitster.g>
	<014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
	<xmqqqzopxkxa.fsf@gitster.g>
	<016b01dcc79e$87472860$95d57920$@nexbridge.com>
	<xmqqcy09xh53.fsf@gitster.g> <xmqqzf3dw0o8.fsf@gitster.g>
Date: Wed, 08 Apr 2026 15:35:25 -0700
Message-ID: <xmqqv7e1w05u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> To be quite honest, I am not sure if it is even worth using writev()
>> if we need a loop that protects against shrot writes, so unless I am
>> grossly mistaken (e.g., perhaps there is some guarantee that there
>> won't be any short writes for writev() that sends data smaller than
>> 64k that I missed in the docs), the best course of action might be
>> to revert the change to use writev() and use the two write(2)s as
>> before, *if* we actually observe that the current code is broken by
>> short writes.
>
> Ah, sorry, I should have double checked the actual code.  We already
> use a looping writev_in_full() that wraps writev(), so there is
> nothing extra that we still need to do to prepare for short writes.
>
> Unfortunately, comparing write_in_full() vs writev_in_full(), there
> is nothing that corresponds to xwrite() that can be used to hide the
> short writes and chomps an originally larger I/O into smaller
> pieces.

Oops, the beauty of having xwrite() is *not* that it hides short
writes (it doesn't), but it can be used to pretend that short writes
happened on platforms with unreasonably small I/O limit by setting
MAX_IO_SIZE to unusually low.  But the point that ...

> Unlike write() that we may receive a single linear large
> sequence of bytes, which we can choose to chomp into artificially
> smaller pieces and write them out (up to 8MB by default), writev()
> API lets the caller to prepare chunks of memory and I do not think
> there is a good way for the writev_in_full() at the lower layer to
> chomp these into smaller pieces, and even if we could, that would
> defeat the whole reason why we rewrote the original code that used
> write_in_full() into using writev(), i.e., to avoid extra allocation
> (and extra system calls---but if your I/O layer is limited to very
> small writes, no matter how we chop it, you will have to issue extra
> system calls to flush all of the data out).
>
> So, I dunno.

... I doubt that there exists a good way to have xwritev() that
wraps around writev() and pretend that a short write happened,
instead of issuing a large I/O, still stands.


