Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041D18FC92
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036479; cv=none; b=amRIqo41n1UNfFoEZ9d4lqtUXuEdgToCTYaa3ki0BVsiYJwyJ3TDxzpoDlqTo35Yy3ANeqchiN7kEMqJHRO1eRTWaGyrYwzFTeHbI7Sjy+7F2Y9GwsjBfUMKDupsdblmxqiSzVtfFUHQOETmfqRnMUWHdg1i/m0ACxLWqUyqpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036479; c=relaxed/simple;
	bh=aDT8z0MAxhmpUNJFQ3iIUs5FYXSGAwLRw4paQIs4jLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVCYFlavZrjHuClXbpTDuxl5SISwk7ZMxWi9LKCJuq0X6iq7/YdXcLueSiPxygQ5IgF0EJ6YNhishh0FeXHs5UvAIfKs5FEkJP4645v4kPj1GVFSXilBZxC/AYLgJIDau049RjccQgHAJU/qTw2jEflhQ5xdAVB9BlGKZ7J+vqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ri01yy92; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ri01yy92"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1735036471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4c0t3uK0Elslp4yE4LC1qqBdCufUA7Tjh21Wlz9IWNA=;
	b=ri01yy92raCo16gKotxbjSiZO16FC4cNRRG299nqK38+Do9X1hiFBOKhKSngB1x6/OH8LX
	n00i+sTT9iYBBbioxeyLaDS4r8pQowQ0QGtp/FgB+RhPui+fhevpWk48+fY9DAxFrCutEh
	Ru/3dI1YmJAOhbZSJpsxknE5G+LQzj4=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs: mark invalid refname message for translation
In-Reply-To: <xmqqzfkqe4g7.fsf@gitster.g>
References: <xmqq4j2zifmy.fsf@gitster.g>
 <20241220125837.2774153-1-karthik.188@gmail.com>
 <xmqqzfkqe4g7.fsf@gitster.g>
Date: Tue, 24 Dec 2024 11:34:14 +0100
Message-ID: <87zfkl74k9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Since the reflog migration topic has been merged to 'next', I am sending this 
>> as an individual patch which applies on top of 'kn/reflog-migration'. 
>
> Thanks, that is the most sensible way to fix up a glitch that was
> discovered too late ;-)  Will queue.

Thanks both for dealing with this so swiftly! Error messag is way better
like this.

-- 
Toon
