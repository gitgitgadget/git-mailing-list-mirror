Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267653019D8
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216220; cv=none; b=kkE5v47BGRx10Xj3pmM+b+bwxoW00AGv4lmqbRdTo631QgUzBiZBHqgEtxolqtfyXbRAGdzlDK1tAu6bJqEniwjdcfYTFhyJlro+0QMRdJ/GUUtfL9SOL0uf7UrQf7y8Pp3MyVa3xMQVG04nCDkTM7fFb5HZqD7Cn1cPCvm5QPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216220; c=relaxed/simple;
	bh=WrDQS0NWls/IkEIlyHrAHIkYW3mZlguf0JDLu9VHExM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8SvRf7e0q6QwqE0SknUj8L3+KY1ucrsakGFcZRBqUQ2Xt5sok6YFe7eAf5NVGHNZTtsFuRl25O8XSsm2wznX90oVjeXr0mRDAvWV4C6oYnGGq4erIvH0MT1Hyfs3LE/9IdcJwXmadd4pahFdQ006xV+iru8eVUFudjtE63CvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=xcnDLQeI; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="xcnDLQeI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784216214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p9JjQcP8REekGEFpjSrwxPtaeUVFH287KXC/URxnX/U=;
	b=xcnDLQeI53fVSrer8Iicx2uc4KwCwXt/Pg9bR5HYRndTpFPHkADnQ2iuYLdujsIqDU+ZAI
	iTs136Yle2ij5JMcoI8TTk0OPRwyHlzShDazO4L0a9XHRJ+aGv7vmScRsWNkXIUpU4EgCU
	Nc4qpydagdsbl7N/F0uYnqflh5AoWeI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] refs: remove use of `the_repository`
In-Reply-To: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
 <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
Date: Thu, 16 Jul 2026 17:36:33 +0200
Message-ID: <87zezr2bge.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v3:
>   - Merge the patch that removes `USE_THE_REPOSITORY_VARIABLE` from the
>     "packed" backend into the patch that removes the last use of
>     `the_repository`.

Makes sense to me.
And the range-diff seems to confirm that.

-- 
Cheers,
Toon
