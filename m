Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5E3596B
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899036; cv=none; b=oifWCICDcIzeXdQHYGWjaMiCb/4ES9vO02Lh252IMRkRd8ZpFReRvNhw7Sk9phXKJPHL6NCPXwkLjf8wJtyP+jgk00x/4N/haWS2svJFUWWMqiHz0BWgn0rN3tohss3j3OlYKMVL40vxwGb8yQ2xngJmWvC82B1Sf/pnncBZRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899036; c=relaxed/simple;
	bh=LjV91h10XUMLgo8yD2KcHZPdIn3zaKd4OmPI/JEfj4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID; b=jZQjFK4mYCv0MD6owP9bUe7jtNXhh5TRb8udXEesWbQd0fYhIHW+LUejiarHZeT9PGIYPHMGOsZlXb0XSvqqKHA1U0MeJ5EUjm+9n1K+S7Ak8dTKJ6iPcY35h+zsGbFEi2F+Opq8ni/BCItegBqq77gl87ObKwIkND5i9haqiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=NVlO/P0H; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="NVlO/P0H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1756899027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=QBoBvY2oP9GCviyVYKrzfFVcrtC4KIOUsYhUPq2WVVM=;
	b=NVlO/P0HHCxUcySYTi88zYrPbQY1Hs3L5SeZzYULEB8r0fkG2Imo9kkYkUELxl/50TlbyA
	LT/p9Cr+xEgUcBaNKSx39iXcqO+avnciYGdiBuaPAkV/DbUiiGLShaLUYRNvIzAO7/MLBY
	2iDX5E0u3oWCUKs6rj32EBJW84k04Ps=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t0450: add allowlist for builtins with missing
 .adoc
In-Reply-To: <xmqq5xe0incd.fsf@gitster.g>
Fcc: sent
References: <20250804073002.1586332-1-toon@iotcl.com>
 <20250808095943.3312265-3-toon@iotcl.com> <xmqq7bzdfoxe.fsf@gitster.g>
 <aJs5D2jPh8Uom96p@pks.im> <xmqq8qj3rqgn.fsf@gitster.g>
 <xmqq5xe0incd.fsf@gitster.g>
Date: Wed, 03 Sep 2025 13:26:05 +0200
Message-ID: <87bjnrg4ky.fsf@iotcl.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

--text follows this line--
Junio C Hamano <gitster@pobox.com> writes:

> Toon, did you have a chance to take a look at Patrick's update?  Can
> we move forward by squashing it into your [2/2]?

Hi Junio,

Yes, I've reviewed the changes, and they look good to me. I like the
code more than the /clever/ approach I was attempting. My code succeeded
on my machine, but it didn't on CI (sorry, I only saw that too late, I
was rushing into my time off).

Thanks both!

--
Toon
