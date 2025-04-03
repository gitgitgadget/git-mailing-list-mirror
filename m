Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC91EAFA
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704673; cv=none; b=VESXG+VaOhu8wySNsJMhZG5uCXCo8IirLZauJJ2B0tpfSChK+9Ar+XSOf98yySCCQaLjqM51++PDyH56mrLBCA6r2DQQVm8PJnJHzEXOI8FnqV/unCNjoasw7CiialdNGiQaBtYbTeM/6o772N5u/91orkuRA8lXwDwL62YxrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704673; c=relaxed/simple;
	bh=pmyq2/2yUSkM7mKa1/gRbj9gncuxCjPwa6fFfn9RzRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fM9COt1brAgbO8Oi9SyzSAqnK0b8qsvdPFCgMk1sutzR3Iuq1qIL2rIiOHKAe8Ma6gRrdO9wcs6N9jfi+WOt8ItACwDqvwbQvAAJyaVH4Cck6tWARoRCNeAhk3tPLgDON0H5Opw+4ibfDHaATWxHDBRs9Ifph/a8eVQdDAsdsXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=NtOijfTf; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="NtOijfTf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743704665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MHyUM/lwpZhS3d4o+HK/bKDZPkJNPGC6I4DOzRoNg8=;
	b=NtOijfTfnR/Cs5+VwqDmNAv/IZo7Fq3Z6J7pFvV80GPK0s0RhE/8kiwF/OU5IVADXrp+aS
	jnw6aBcvJG6Y5a443E914+d8TJSs8YkUP/kYDoKMqMneKeCjn3tbKjXx+VN0+RoHjbDlf0
	mTO2PMULz8FLEVnIPOelSG5ZRSrw5kI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Taylor Blau
 <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/10] builtin/cat-file: deduplicate logic to iterate
 over all objects
In-Reply-To: <Z-0byX56V2E1pGKO@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-9-4bbc7085d7c5@pks.im>
 <87jz84f5a2.fsf@iotcl.com> <Z-0byX56V2E1pGKO@pks.im>
Date: Thu, 03 Apr 2025 20:24:12 +0200
Message-ID: <87a58xf6ib.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Because the payload gets forwarded to the callback, and that callback
> accepts arbitrary types. You can already see this now: we call the
> function once with a `struct object_cb_data` pointer, and once with a
> `struct oid_array` pointer.

Thanks for your replies, it all makes sense now. I've got no further
comments.

I approve.

-- 
Toon
