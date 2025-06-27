Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2682E2678
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034291; cv=none; b=ExTIz6zp/zIwZ8Okw4e7aauSdvTDVei1FyLcMtJxRomCGTe1x3y5wkD41SuNa3NLyZAKaU61Bnp9zZBWlgSsYBKQkrdlPGqZ9MvCIflwq2HGbsKAWpfC9ZrQgBiYTwNxhNXMLMdrewpmZDueL4y6t2eA6sB2JWLfckKSGdau0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034291; c=relaxed/simple;
	bh=DVvv6rtG4McxhRfuck/+DK12qRIgEvzrmtqWIhxb7JQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fwOa9/EwgmwJLcNBNQuG0MtSglW7wsW+Sc5Elvwin5JdkAEBBq8RqkYoauOfBm4J1A4R/sb1eo6OPcATAJ/JqGKtRMjHoCGTK6hrWnXQP08uGgPopAZI4i+rHu9TM0AFdsPkBocfXkV2WUuV4Xlja0oDoIgqdfJo/XIsjEZW+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz6t1751034262tcdf8ee36
X-QQ-Originating-IP: W+dUJt15NCkcWLEEdoXd6jQa1xPH5XwvR/tQontnWWg=
Received: from smtpclient.apple ( [202.119.44.191])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Jun 2025 22:24:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16089312686821520573
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqy0td8fa9.fsf@gitster.g>
Date: Fri, 27 Jun 2025 22:24:10 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A56A595-55B1-4EEB-9B9E-3E9F7A9A74D4@smail.nju.edu.cn>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
 <xmqqy0td8fa9.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NDtUtlvFer7vmrIEukNSOjPpXtFHDPP/ANNPZXcMc3JK4sYkpZD4BhUA
	5DsgJOpeMHXr14IQ8PNHJmRsqM4e/bnPJu+7voTShUzmoFdMMgbwJ0udC82OU0xzpC7JfVS
	zVN+MlnU5l+8a1EKjP3QJ3pilaEx5Ueu65U5FPm0UqhUPNxqKfHtwbTeolf6VwiC61OEq/a
	CNYU5ozcxqkxQowOZwHNGDJpyKGvomFg3sESRBWHKqKof7IgYCDc+dQV9wRRPkTIZs79C2J
	KHb0RWszmqEYkI9BoxpYttAenkMQyUUroYw+78glec+sFHpY/upJpONax0KNbo/WB7hU2mF
	K6Rf5QBk4nis8w7cQWzTors38JY6JQjwWDgivSKVMRt9cHzj6kH1DgLNDYFWRr9LbC/j50+
	2cialUVWjp/bGYoqeSAg9ke3n9sqDdQeAIOilF5q/bW4NNsVtX7HboaduBc1C7CH2Tf+khZ
	VyjmMCbe8NA5NqFobd8gM420oC70RHleXk3HYBhJEshQE8jwzUOMxhBGnGNkHcK0rbDrp3X
	XhkDwzN634vKTdKZsOQmz6+22lZ5I5PE8Bli82sOHG4HQrbUEZ9b7RSyEpOii+YYF+AAr3c
	QOKFGJk68MT1ZbOz3pXCPq/2pf+tclOfzYeJGiqjXoqb2/z9Aro8MO7xS67I272EEo41eu5
	FQTBVnn6/4YFh37XoypjDiXv9qqvwoQPsTflj45kEmx2ocU/49VDeBgR/uDqmdYVq1eq1is
	fhCvxTvX2rQmdkM9Y5GMG1x82f3P9qV7mWHUtBvGio1BUqGJVJmtXMReW8EIDWANgX8+skQ
	Awr7Y4YDA74ziI+cBxYEPdMbjETW0gFuqzapGqmupBXQIIE+wveClxcp9g9Hi66GRCvbIme
	+57qn/hDssEZHQszxrvZCn1YsdFRGBSntQBUDOMSINO+1lqHGoxTw74ujnj6Uf/BNWsFKVD
	PVQs95SoSbI/kf94apDrGXtTpKudDHvNH3urtuKJi4/NiMIMSIReiSpYvZWwet7ip2jKR+j
	IwMNUpmqJBQHMnPMvJM9sqMsP0BkQ=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes:
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> Remove `if (spec->nr > 1)` to enable bloom filter given multiple
>> pathspec. Wrapped for loop around code in =
prepare_to_use_bloom_filter()
>> to initialize each pathspec's struct bloom_keyvec. Add for loop
>> in check_maybe_different_in_bloom_filter() to find if at least one
>> pathspec's bloom_keyvec is contained in bloom filter.
>=20
> Oy.  That's too dense enumeration but I suspect are all "what the
> patch does" that can be read from the diff.  The first sentence
> gives "why", which is excellent.

Got it. I will simply this log message in next version.

> You'd need to check in forbid_bloom_filters() that none of the
> pathspec items have magic (other than literal), not just the first
> one, no?

Yeah, I never notice that. I would add checks in forbid_bloom_filters().
And add test to ensure we don=E2=80=99t use bloom filter if any pathspec =
item is
not literal.

> Totally outside the topic, but I wonder if we can further optimize
> by adding an early rejection using .nowildcard_len?  Instead of
> allowing a wildcarded "dir/*" pathspec element from disabling the
> Bloom filter altogether, we could say "dir/ is not possibly altered,
> so there may be dir/A, dir/B, etc., in the directory, nothing that
> would match dir/* wildcard would have been modified", couldn't we?
>=20

I think it's feasible. In that case, we would need to add a condition
.nowildcard_len > 0 to forbid_bloom_filter. I'm happy to write a new
patch to address this issue.

>> diff --git a/revision.c b/revision.c
>> index cf7dc3b3fa..8818f017f3 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -675,8 +675,6 @@ static int forbid_bloom_filters(struct pathspec =
*spec)
>> {
>> if (spec->has_wildcard)
>> return 1;
>> - if (spec->nr > 1)
>> - return 1;
>> if (spec->magic & ~PATHSPEC_LITERAL)
>> return 1;
>> if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
>=20
> This last check only looks at the first item.  It used to be OK
> because we didn't look at a pathspec with more than one element, but
> now shouldn't we care?

Definitely, I would fix that in 3rd version.

Thanks,
Lidong

