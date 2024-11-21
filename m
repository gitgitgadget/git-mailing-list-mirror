Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668C1D3634
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184647; cv=none; b=Y9iqNkUeldaqmU6dRr0ip8dySrAEOP4xXwWbFJZJkvy2VeFLDI2YSmdim9AzmmOHzKRjEFiaEF0EvDHsMRcqH5Baj9DtvnmBIXvZuZUkWpjeG3bsUq//NZTUbZQOZT4mDuBZfC3zlBs0q6Ab1GJG6ilwKhfGs95OsXwkGxwm/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184647; c=relaxed/simple;
	bh=iPghjBsn1QcfNPWdNeNj8B7KogLslKydzXXmB0RP7QY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpkkF+Ivo99xUDgsAs0vFTyrdlkK7s+ha1uutBqJK4ZmP6pokXsEroigK11131pXyFk9q8mg0WMIISHcNXXlSTwFitV6rRA2UW/l8S4sBDZr1RT1cIKkJAH9lL1H/oXY0p6O99jrQwc3bSzUUzrr3D69k+GHV3gH7+QBQr2mrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YuPeD3Yb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YuPeD3Yb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1732184639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPghjBsn1QcfNPWdNeNj8B7KogLslKydzXXmB0RP7QY=;
	b=YuPeD3YbZVOagfzbp3woTROcfjHRLqbOBk+IElIWuQ7o+QdTUuYYdbOkqDXpbz88aoH2bw
	CppZoX3g/cuFkozBbLFjX3I/t8prBPc61qRxg/py4ISZK5UUTtVRtXUaLoh/LC/TY8WFde
	IdZ2sgSCS2tStfv1/Ajp1yS7MPqmfWQ=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org, =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Doxygen-styled comments [was: Re: [PATCH v2 09/27] strvec:
 introduce new `strvec_splice()` function]
In-Reply-To: <20241121081146.GA581647@coredump.intra.peff.net>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
 <877c8yti5n.fsf@iotcl.com> <Zz3Y35YI9ysFabUJ@pks.im>
 <xmqqcyipijma.fsf@gitster.g>
 <20241121081146.GA581647@coredump.intra.peff.net>
Date: Thu, 21 Nov 2024 11:23:47 +0100
Message-ID: <87plmosx58.fsf@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> On Thu, Nov 21, 2024 at 08:13:49AM +0900, Junio C Hamano wrote:
>
>> let's not insist
>> on adding/deleting double-asterisks in new code during the review,

Okay, understood.

>> and let's not churn existing code with a patch that only adds more
>> double-asterisks or removes existing ones.
>
> Like you, I would be happy not to see patches adding or removing them in
> existing code.

Oh yeah, I agree at this point it doesn't make sense.

> To me the point of an official declaration is just to
> tell people not to do so. :)

What do you mean? Do you want to formalize in the contribution docs we
will not accept patches only changing the formatting of code comments?

--
Toon
