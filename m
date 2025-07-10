Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC11E8333
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172968; cv=none; b=Y4+STQoD/1nkkJBe/QI9VjpZu8nzkPTAnteF3ufO1fG8rR1WcvVv6e3BcGTPXshNDdaXG43ja3adONSABuDq0tejs0fFuDNMV02PJI/NckVlcCVwhZsy/VOo5PAmrd2FS3lYyGZlrTf/po+ZAtNAzVTs9ruhTaKUwhu0T3GypJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172968; c=relaxed/simple;
	bh=N0j7jiThmPTJXdSqbugD+a2J2qUc4/lNYjzw1F9gzLs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I4bwbqlUTOhzoUCuMKOOa0z0cHWIai3zb0fWBOq38wFb7WXhuCtTn8HVkSX2U0rAPuQlBhYd5zvYSB+aE7IatDCLGwcUirPI2KYhAI60JTO/VPj6lhETossHxeogPRjT8Otrt0/n4/30Crnp0EE5BH57wAlROwy3VzwouIYW1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=cGVnYRkj; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="cGVnYRkj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752172964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KzfcexT+b8sTmxHQL4/4nPWwSsimj+lQlUocaTRoSOI=;
	b=cGVnYRkjDBPkdLd05HqHeETu0CS5MjMJGXOOGXE5QEwgGSkOYWOE0we7NVv9w6Mx2MbGUq
	RpxRFy2+14pa1iKop1NFXoPC5V365JSz0shq4NSaJmMLHoPShkEe5yAJoh7RXA4B4YlNSb
	CAXBN6o0WBfs8me1E0O03eiKJH12VFc=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 15/19] object-file: get rid of `the_repository` in
 `force_object_loose()`
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-15-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-15-62627b55707f@pks.im>
Date: Thu, 10 Jul 2025 20:42:34 +0200
Message-ID: <874ivjdh0l.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> While the check whether any such loose object exists already acts on the
> whole object database, writing the loose object happens in one specific
> source.

This sounds weird and like unwanted behavior, but you're not changing
that. Makes sense to me.

-- 
Cheers,
Toon
