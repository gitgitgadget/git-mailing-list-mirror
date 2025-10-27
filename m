Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F742F5B
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548620; cv=none; b=Z2H1Wvd8y1fOOv+2L63YF5BpzXbyaWDi0yXGhow7/ejUnAfW5N6wAkXP0ncPFhwQb6X5EIDoG2v94BXcZgUdt4ndGZ3msHtCR8GGnjJT4t8oG97tIm/G3yPPFgwI+mDhY6QBJu9ugU55KArpgGu2+LeX+ylxZkXd9pt4e6BIK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548620; c=relaxed/simple;
	bh=N6KTzPVlMQODA51VXaZemrBIr4kdVxX2VVI74VQOd0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d73glKpnhjYgrAaE7gYjQoHECM1OuRaI6ueHpT25L2SU5UgHPMBC1dK13FjvFVuNm2x1LlfFyaBG+SuJ+usXB/AtJNS1noT0zOcFGfpkwzC0FPSjTPCV2C3EDIjfqWOquQZHVDeuu3ZnkQExBZGJ8Ux6uWicg1AaWYU6Yyc7zhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5bHR+IGS; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5bHR+IGS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761548611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zl9gw5VpiEJ3p/zVb6GjuUcQs6YEylUDqLFvpojcG+A=;
	b=5bHR+IGSMlrYkuYcqrXyw01nUgAIGdU/cyUjC1YRsY2Tgz12uJNxP4/u+3Yt2ru9aPyOju
	KUgryGVaqbY8BzINZeNhbeLy4z/KN6XCvd9YhvhfHb8bDFLhLT+xJL90vrsAXX32uun/oE
	aPiCTO4AGKAWcH4MoyTH4VVml9FNxa0=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] last-modified: implement faster algorithm
In-Reply-To: <aPrCaSOA/dclWye5@nand.local>
References: <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
 <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
 <aPrCaSOA/dclWye5@nand.local>
Date: Mon, 27 Oct 2025 08:03:18 +0100
Message-ID: <87sef4q11l.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> This version looks good to me, thanks for porting it forward and
> cleaning it up, so it has my
>
>     Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks for confirming!

> As an aside, do you plan on upstreaming the blame-tree cache, (which I
> imagine would get renamed to last-modified cache)? Just curious.

Currently that's not planned.

-- 
Cheers,
Toon
