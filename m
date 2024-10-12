Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DA768FD
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728758603; cv=none; b=CDhns1wnbdtR6KRp+/TvWe4+w/acOHkWpB7B7tnCWy9VvQc14CrM+KEkDLv0p8TsWHxyVKH4JZD0mhdIEKT+plPrhgduPPMYrg3cHyYkc9o2DYwza0cw8Q4dRaP40ArojjfYqfBL1yenSv8ZDth79s+rvbTR+cQVlip+LnshT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728758603; c=relaxed/simple;
	bh=9pWcmK6yuDmCwuztIdt/zRzp1GJ0BQtcwKj4yzV0hJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HLLTdkN+fiMP689vSoQXzK1kNPnpZo7fi4qBSc5X/CZTxaC/XQaDYl4gTH+HK74by/yrmp8rA0L2Ka+r2tD+5z7KV4haA1qS9iUT6PkL2xI1EhoLEauET8Axxh3i1meRXSv2RUZioxkMPs/quRmWN/6QQGb1kkkcMkSGQupe9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=W9GP5+pz; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="W9GP5+pz"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1728758597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pWcmK6yuDmCwuztIdt/zRzp1GJ0BQtcwKj4yzV0hJQ=;
	b=W9GP5+pzCVECjMcCq1Shc/vd+j7Z66O831Ra8JkkrBo/li9z4Uj8Aar8Cw9gDQFkdnZ5ri
	S3zNydmxkrTfjtWA+l1Q+E4kCyZU8EO8AIc7UCPXv9MDnUmrf7ZjQAGXbcKRaHSQ+7gTyF
	fnHoKbiblhHhNaqUDafBJXOKx8pwnYw=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Oct 2024 20:43:10 +0200
Message-Id: <D4U1RWVWEW5D.2T853XSBO1FPA@swagemakers.org>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Julian Swagemakers" <julian@swagemakers.org>
To: "Shengyu Qu" <wiagn233@outlook.com>, "Junio C Hamano"
 <gitster@pobox.com>
References: <20240225103413.9845-1-julian@swagemakers.org>
 <TYCPR01MB843751F88AF98DFDB606B0BE98792@TYCPR01MB8437.jpnprd01.prod.outlook.com> <xmqqed4mecrq.fsf@gitster.g> <TYCPR01MB8437CDD2208EA6555117E72C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <
 <TYCPR01MB8437CDD2208EA6555117E72C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

Hi Shengyu,

> Seems you didn't CCed all relative people about this patch so that
> maintainers about this file might didn't notice this patch, you can try
> the script mentioned here[1] and resend this patch.

I did see that, but the output is just Junio, and I assumed as he is the
maintainer, he would be following the list and did not need the extra
CC. I don't know who else could be interested in this patch and is
willing to test and review it.

Regards Julian
