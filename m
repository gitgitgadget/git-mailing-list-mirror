Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A2313E32
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767785724; cv=pass; b=ghLk/mTr7n/uxKZoTHScVHlYwUSAsj6u7yBg5jk9bs/C0GMF2bA1utIMwceck0gUHaPlODE0KTPMXCCz6pJ3LcvueNISDa0K8prE3vxQpfKxjG2YtnJF3I+TeVrY9jb91K3FhN7OvWf6zm46P+pCVBtKq5LV9mb4O9uSdp3vGzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767785724; c=relaxed/simple;
	bh=GW4P3WJbfUukyGsM3mlIlIfOdsbpbJJ/dyq7mLkv7WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PX17RLMmvhgMm/QbSckKnZO+Ohc6MQLwQder1TDCRtl+JdMB8dc56sf1wlATAKvLWcC68g0VdBXboQGxWdnmRIqG99TCtfl+7Awlnv49FpjMWH5bARnPlCuJ81mmaus9ExPbraszujapIWZ/lwW6WkYeZt5fXOeb4hcCeB4ETNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=dWiubnQZ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="dWiubnQZ"
ARC-Seal: i=1; a=rsa-sha256; t=1767785705; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jFToZmCvIlBeepjQvP99Zfts/Bn0L8WGkMtuDHC45Ae186aLQkZdkygelWOoMI5vOjjeSlCg/yXPQxxbPx1ySi18TTMN0oILxXK+12+/C/54E4qpIaiXztBqZSIuOKh6JnBlWy5Gy3Or6hGkWfZZ5reOzmZEo2BxAMsmApuyRtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767785705; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RpUioM4gt+wE54IdxYohlf2zIBeLu3LXi8MIwwbAdM4=; 
	b=U4Zjzmx500A1Jux4y5j+u3wB3mscZQG6q+ajQEc840wOW9+iG2KZdejr7wLlGY3+5Jjd1VUKhH5QNvtmnEDdkCLYcZOJPuwGiNF5qtE7Xjy7hzjRNt7ohUCO/JAPd9Q61CeDxrCbq/tt8lYQu4s3H9RefGW5fv8pVcN1Uw3DMPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767785705;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=RpUioM4gt+wE54IdxYohlf2zIBeLu3LXi8MIwwbAdM4=;
	b=dWiubnQZx+JrHvvOHUNtEO8Go9Jwcy8Ja/8ZD1ijP/1Rqu2Mxwd3m+uyvcRw+QyC
	wlSGASoByTywpOHNCFCJCEzj3IMZOHTupVTkDSSfMDBwrx0ikKgaiHDi3khRKuptuGa
	XrAw8gC3zvkgeSJ+CJhOfl20zs4CrzVSViMn0F0w=
Received: by mx.zohomail.com with SMTPS id 1767785703696208.63571030455194;
	Wed, 7 Jan 2026 03:35:03 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>
Subject: Re: [PATCH v2] ws: add new tab-between-non-ws check
In-Reply-To: <xmqqsecii327.fsf@gitster.g>
References: <20260107013051.312291-1-adrian.ratiu@collabora.com>
 <xmqqsecii327.fsf@gitster.g>
Date: Wed, 07 Jan 2026 13:34:59 +0200
Message-ID: <87a4ypirks.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 07 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> The check is a bit complex because we want to detect places where
>> a SP was intended (HT can expand to more than one display column),
>> so we need to count both the display columns (col) and the string
>> character columns (i) to determine if a HT looks identical to a SP
>> or can cause confusion.
>>
>> +/....adoc text eol=lf whitespace=trail,space,incomplete,tab-between-non-ws
>
> The name of the whitespace rule does not quite match what we want to
> catch.  Can somebody find a phrasing than "between non-ws" that
> conveys our intent better?  We want to catch a tab that is used by
> mistsake when the writer would have used a space, and "between
> non-ws" is one of the heuristics (another is "it is at the 7th
> column to make it indistinguishable from a space") the code uses to
> tell if a tab is such a mistaken tab.   "tab-instead-of-space"?
> "tab-in-place-of-space"?  "tab-that-should-have-been-a-space"?
>
> The last one is horrible and not a serious suggestion, of course.

I like "tab-instead-of-space". :)

Will wait some time in case others have suggestions and if we can't come
up with something better, then I will use "tab-instead-of-space" in v3.

>> +test_expect_success 'check tab between non-whitespace (tab-between-non-ws: off)' '
>> +	git config core.whitespace "-tab-between-non-ws" &&
>> +
>> +	printf "1234567\tb" >x &&
>
> I notice all these printf create incomplete lines.  It is true that
> the detection of a tab that is used when it should have been a space
> should work even on an incomplete line, but using an incomplete
> line, which is of course rather unusual, for these tests gives a
> false impression that somehow this requires an incomplete line to
> trigger, which is not what we want to give.
>
> 	printf "1234567\tb\n" > x &&
>
> or something, perhaps?  I dunno.

That is a good idea. Will fix in v3. Thanks!
