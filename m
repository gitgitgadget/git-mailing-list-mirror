Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD0137750
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473248; cv=none; b=um4bmQxNbKATMWFFE0+v/iyRKYnHzObjyn8vfPYtf+SQj8uLQHwIbpFGBzxZ0tyv1LjnBoEvTf3XrnfVeBJ0lqYb/Ie69qB4AqhqPyYRMYq51Qc/deHsBEq/K9cmlBEW21BFA2mQwidx/2zWgZXoWmCZuXm/8l2mnWYapYs94O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473248; c=relaxed/simple;
	bh=Iz/ULG9sXGtSi2t+8/gd2DVlQoYWt515aqBusyX/iTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruM8wq0xw969g7Nvlqd4VCUDB2OeB43yqo1Ra3/Yy1uvG580HZN8/6ZKtY/8c5hYbdHE7ji0n4B7s3puAbaCJDNUqcm7Y2sQrl8FjFowcWM35gr4l9YuJUUZ1QIqfB9uYM82Mc890+1HXfxE5xDIZ2gqQy7oyWqJgShmfNSkb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=ePxa35cl; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="ePxa35cl"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1uwB4a-00HSeL-Cr; Wed, 10 Sep 2025 05:00:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=rU+JhvvoUcB/te6Y0g0yur95IlqGZW5ZE7H4P+6W1UE=; b=ePxa35clTfVNMFb8eXHanJ03bR
	dGr9CoGNIlVbUT27Rds9PUvrl4cVpx3SVu+Oi7OPueyFAm0V0XMPybBDc7FnNoOee3YrpozBNnafu
	TJSUHt7o360t7DogaVSi53SliqqaPa26qHBYMI4X1xO3hXr7ZN5xkqspqyHponqHS0IQ7e2BxQ9H0
	vVSuqVAG76Vb9cz6mG3Y5IuTHmWXY94r9+5XMpCm+5/7hDgrZeeuNrrf3/KkixhV2YptNAAHPFb0T
	va/xjINCwL1EzG8JrJdw8/8qgr4bFG6J4Nkpwx8YAc5i5XQqA8nWot5ZWLwZN6W9koThvK3AdRn1t
	xGCYqxag==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1uwB4Z-0007P9-Dq; Wed, 10 Sep 2025 05:00:39 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uwB4G-00FvQW-MY; Wed, 10 Sep 2025 05:00:20 +0200
Message-ID: <641aaa9b-2b23-4faf-a13e-f6205e9ef5a2@howdoi.land>
Date: Tue, 9 Sep 2025 22:00:18 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/subtree: fix split with squashed subtrees
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
 Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
 <20250905022728.940664-1-ask+git@howdoi.land>
 <b78639ee-021d-49fc-8b8d-0140ed8fc010@gmail.com>
 <8d341a51-2135-4c62-9df1-5be351e73275@howdoi.land>
 <xmqqbjnjt67y.fsf@gitster.g>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <xmqqbjnjt67y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 21:02, Junio C Hamano wrote:
> Besides, "if test -n ${subtree_dir-}" without colon would be the
> more proper way for those who care about "set -u", wouldn't it?  It
> is not that you want to substitute with an empty string that comes
> between that "-" and "}" when subtree_dir is unset or set to empty.
> You are preparing for the case where the variable is truly not set,
> and the variable being set to an empty string is not something you
> are worried about.
Yes, "test -n ${subtree_dir-}" is definitely the more correct expression.

At the very real risk of embarrassing myself in public today... in the 
particular case of a "test -n," is there actually an appreciable 
difference? Either way, the output of the substitution is empty if the 
input is empty or undefined. Here, "test -n ${subtree_dir:-}" is merely 
less efficient. Right?

The difference between "${x:-}" vs "${x-}" really starts to matter if 
you want to permit the empty string (or not). It also matters if you 
call a command that has side effects.

(And in the context of this patch, neither are necessary.)

