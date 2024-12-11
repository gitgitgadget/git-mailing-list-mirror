Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECC23FD23
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922686; cv=none; b=ukRmXyoYnnIcD6Fzd85ZJGhf3wbEveWtuHXjXhvJdsx8bBlsoOf/nJHgV6PDiPow4N7Y1RgrtR4vR+8UlWcIh1em9I04EYl52BsO8ea+T2EbDtWodNV32Uzn6emX/f7r3ppQ7N5lH9qUYAuny/S4PxsI19hXdP/n2IjiDkew5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922686; c=relaxed/simple;
	bh=UfheXLy5G3mphXdh2dN1DmJRJVRfNJojc+oENplO8ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5VQcLHrX2YCDEoNZewFC3+4uwCVQODotkCilje9X5t+IRx0gt6lSyDaYJszQmIElFJ6OXfQaDOYGyB0YsCL621tpeRXybKFV4N3t+W+YwJ+NoyH103zT0S2A5ZEMK3om9erC+NMgVUWoLyOjvtJRmAWfMMPGBiDN7PTQuZb2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=tq2j7RKr; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="tq2j7RKr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1733922680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NVuQkWC0lkmsrZDvXA553DP6fJMXpdoF/+Yog3GSie4=;
	b=tq2j7RKriq0TTTO+ILAcXxNQ9tix0ms4iLDlECP9vPjQxnmnRKz7eAnUT00Gvb/ZK9Wvdl
	LpsbWfKMb2qJW2RVlAeNVSRJjWtfgrVjgZKw+G8yfhy1Zgf1HuT8sz0jIsusOm/RXAiv64
	84XsJ12rervJ++pTWP3Uw8KllecVHSE=
From: Toon Claes <toon@iotcl.com>
To: karthik nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2] reftable/writer: ensure valid range for log's
 update_index
In-Reply-To: <CAOLa=ZRYDqhAPMiuAS-HGaC1huiUGgLW3hL_dDNwrFA5c8ewEQ@mail.gmail.com>
References: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>
 <20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>
 <xmqqwmgcv23b.fsf@gitster.g>
 <CAOLa=ZRYDqhAPMiuAS-HGaC1huiUGgLW3hL_dDNwrFA5c8ewEQ@mail.gmail.com>
Date: Wed, 11 Dec 2024 14:10:57 +0100
Message-ID: <871pyejrfi.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

karthik nayak <karthik.188@gmail.com> writes:

> I was reading the reftable code and noticed it. So mostly luck. Agreed
> with what you're saying, I'd say this is mostly a 'safeguard'.

I was wondering as well, thanks for that info.

> Totally, these kind of specific changes are perfect for unit-tests. Plus
> it was very simple to add one too.

I appreciate you're doing this, that makes it easier to reason about
these changes.

>> Will queue.  Thanks.

Junio, thank you for the quick turnarond on this patch. For what it's
worth, I've given this a review and I approve these changes.

-- 
Toon

