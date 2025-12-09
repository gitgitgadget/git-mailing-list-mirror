Received: from mail-108-mta45.mxroute.com (mail-108-mta45.mxroute.com [136.175.108.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC326E715
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268907; cv=none; b=Qkp4k3veUXJy4hEmpze/XyVOfbt9sMeSN71/ZH9XdCDnseQPxMHYCwcxEIgjdbOD4THSxIRqi7lpCVmH29++Zitd3sHLUxJ0/vDoRobW9KsSWTR/a/buI68N+b6a3nzRs1Him33OY6ZmCU9Vypw6HbFd0QLk1tQBOa0aKJf3jiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268907; c=relaxed/simple;
	bh=J+zCOv//nQ2hBxhnPPNCsUuJyb+TOkUqNTKcsxA1M5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ila7cOsgSjIVlryjGtQYKBhXEwPDUrs41GhZhm7H8ZPwElQcIceZVa2AvfAz11RpGluJFTGgM8ExxTNMuhwv543HgS3FwOdOxE8jrwbpNY59q20SwJCZxAatdm8H4Yy895QvmGjEbgbW/eJDPZkLKnHNl5IiRhs4/SK9vYzaR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=IXw1Bjv5; arc=none smtp.client-ip=136.175.108.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="IXw1Bjv5"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta45.mxroute.com (ZoneMTA) with ESMTPSA id 19b023515d50004eea.005
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 09 Dec 2025 08:23:12 +0000
X-Zone-Loop: 18705f61ac389ea94bea98258ba569b7929f0fdfc38e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
	Subject:MIME-Version:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UZn+eJUV83s8+pE5zkJP0UQJIU1ESZ8xNTAMYJlz10g=; b=IXw1Bjv5IGvqKc5c7ZjCV//DA6
	GtblaUAeqOdUnrkpqVVAtjx8uN5VCbKXOyn8vG39RhizD/XCXGttX2Z0un9QZfZatyCZ/PSuI7ujr
	jlyj6mdV9TuXiNgI1+dpy5CBDwNfnd6N53CZejC4ToNX6QvAzcJs1GM0gn4OoAqOIGwtJoOZXsJCr
	AsEotpSc00gYRDWmk4FKFypbeNRkQi25A5bwJvuYk3FIpwxuF88dfb4Xagw5CxuH8Y4mxAFVI/akb
	yKfeJXL0BxmkM0STt2ut7a4ReI+3qN0wO/tYY8YquwfJtu61HpJ5BnO+CI7uakEg9LO7NJ1RuihV2
	qvksyvKg==;
Message-ID: <79d2226c-b568-4385-a618-f0d3c06cd0a8@ashlesh.me>
Date: Tue, 9 Dec 2025 13:52:49 +0530
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
Content-Language: en-US
From: Ashlesh Gawande <git@ashlesh.me>
In-Reply-To: <aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: info@ashlesh.me


On 10/16/25 04:01, brian m. carlson wrote:
> On 2025-10-15 at 14:12:09, Ashlesh Gawande wrote:
>> Oh I see - yeah don't want to erase the credentials.
>> Was trying to figure why 403 was happening instead of a prompt (as I was not
>> aware of netrc file being used).
>> Thanks for the detailed explanation and suggestions Brian!
>>
>> Is it worth it to include the netrc tests in git that I wrote as part of
>> this
> Yes, I think if you have patches to test our netrc handling, those would
> be very welcome.  I was complaining a couple months ago about how we had
> no tests for netrc after I accidentally broke the code that makes it
> work, so I would very much appreciate any tests we could add to make
> that less likely in the future.

I was working on separating the tests and thought about the original 
proposal a bit more.
To stop the credentials from being erased on 403 could something like 
the following be acceptable?

         else if (results->http_code == 401 || results->http_code == 403) {
                 if ((http_auth.username && http_auth.password) ||\
                     (http_auth.authtype && http_auth.credential)) {
+                       // Do not override existing credentials on 403
+                       if (results->http_code == 403) {
+                               return HTTP_ERROR;
+                       }
+
                         if (http_auth.multistage) {

So then we would prompt on 403 only if credentials are not configured.

