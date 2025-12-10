Received: from mail-108-mta232.mxroute.com (mail-108-mta232.mxroute.com [136.175.108.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57442C0286
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765370149; cv=none; b=Gca+xbxjFpD5k+AuXuDKNz4b72HnlmEaRVomdipHSuZ+p3apYu7k8WcSUFoFRcfoYnID81HqopFTCPfRp/aB7feT4zcJFYdwXqTkjKsz/mdDmnaUs8Ut3AW4RaBLBbYvBkOoK+xBTeQI8qLkr0wv1Ort9s+pVJO/j+/kO6tWl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765370149; c=relaxed/simple;
	bh=8K6NVqQdJukaK3wtaL/ULJm5F9OewPxvKCyjxqnJzu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rJfJMmHkPyOPLH+PStGc9pT0++4c0sdUBul05FtdD1E6KMSMryiXVlRejL1HTySwT9z8km+7veOzYSrzWx/QJfWW39W/cb5theuCgx+vIDLBnvpD+dW3MFfpnFco3OP/mQMmp+wDNsgjT8DB5wvFj5N/FmRD7+DaMy8JixiXzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=icVsXr2m; arc=none smtp.client-ip=136.175.108.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="icVsXr2m"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta232.mxroute.com (ZoneMTA) with ESMTPSA id 19b083df7660004eea.005
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 10 Dec 2025 12:30:37 +0000
X-Zone-Loop: b98f6cceaa99b867a19d7319a0cb42bbe8805b71b466
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
	Subject:MIME-Version:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IJ1wrh5qUf2MtsT6+Oly2krOy+dO8+anzEeJJfktTF8=; b=icVsXr2mVovIihvYfL3DQMl+25
	3vI77O9E/4x9w+V4lb/0HlATqqgbd2Fn8bTjJgGUIXv886Z93Cc5Bvno5MEeOH3VetBf4Q+5JHY84
	bCiG1JZ+/+cJIowYSjwpk7AqfVle8hdoabQQQLhyu2ol/1x6h7iGxxPKx6h6+5Ls1sWDkqw/YX46y
	r62/+xdDZ+d7eXntFLKTRR4oOmYPp7iIP3rCgPnRcXoPj+1VfRNH2wyG0Q2h9kU/gtIJYrp8B5FQU
	w6QF+luC5SW4jl2FgTWGcARDrD2ZYQCccQmWmyLMCDTNtsjWZXQxVc/EuZRxPQXnP5YO6Lw9+TkSN
	oZl39+aw==;
Message-ID: <37c3b31e-900e-4df0-ac30-284e71660487@ashlesh.me>
Date: Wed, 10 Dec 2025 18:00:27 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] http.c: prompt for username on 403
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20251014144354.1457818-2-git@ashlesh.me>
 <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
 <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me>
 <aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net>
 <79d2226c-b568-4385-a618-f0d3c06cd0a8@ashlesh.me>
 <aTjVenutFBprwrrz@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Ashlesh Gawande <git@ashlesh.me>
In-Reply-To: <aTjVenutFBprwrrz@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: info@ashlesh.me


On 12/10/25 07:35, brian m. carlson wrote:
> On 2025-12-09 at 08:22:49, Ashlesh Gawande wrote:
>> I was working on separating the tests and thought about the original
>> proposal a bit more.
>> To stop the credentials from being erased on 403 could something like the
>> following be acceptable?
>>
>>          else if (results->http_code == 401 || results->http_code == 403) {
>>                  if ((http_auth.username && http_auth.password) ||\
>>                      (http_auth.authtype && http_auth.credential)) {
>> +                       // Do not override existing credentials on 403
>> +                       if (results->http_code == 403) {
>> +                               return HTTP_ERROR;
>> +                       }
>> +
>>                          if (http_auth.multistage) {
>>
>> So then we would prompt on 403 only if credentials are not configured.
> Can you tell me what file you see this in?  I don't actually see any
> place in the code that has "http_code == 403" in the latest version of
> the main branch.
>
> I wonder if your issue may already be fixed in a newer version than you
> have.
Oh, that http_code == 403 is my original proposal to prompt for 
username/password on 403 (I did the diff on top of that instead of base).
But you pointed out that it would wipe out existing credentials. This is 
an attempt to fix that by not prompting on 403 if git credentials are set.
So when credentials are provided through default netrc file (such that 
http_auth.* are not set; git credential helper is not set) then we can 
still get the prompt on 403.
