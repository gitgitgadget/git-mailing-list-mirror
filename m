Received: from mail-108-mta135.mxroute.com (mail-108-mta135.mxroute.com [136.175.108.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB7125A0
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391857; cv=none; b=QfVEycFZcKBKBs6rA1QksFx1qIXqRAJOjIJK+K8jVZYLaQRdWuZHIhukUk2FIHmsmeQQotl/jSmX/NLxjn7CautW/W5S71F3eXeHlmAfKqwJEPkzVmoGRDb7dGjb+gT0+A8brNDMXfnXVSTvmZFdzcAXeHZYiGwaksZgUqoHJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391857; c=relaxed/simple;
	bh=XOpMqtRodkSzQrXgLgXEK34xGb4FNDAGuEIsqEEorCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6IiBeDveSsBgLeDipC4XbvigTbzCPcf+LWWlT60bUrPLSwxl96QG03J+S6QcmGqMyfI/n2+G4ZPCHacSdrFBf8Liw3gShhkU+RX7ccW+xSrt7l8Zj10hueEkBKXWJYT5W3T5mmDVeJaezvz/f3rxI8BA39lwkeugjsZ7WH9MhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=N70EiO+e; arc=none smtp.client-ip=136.175.108.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="N70EiO+e"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta135.mxroute.com (ZoneMTA) with ESMTPSA id 19c338f2eb10009140.004
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 06 Feb 2026 15:25:47 +0000
X-Zone-Loop: 0725b1911bc724886ad405d8856cfb1b26063ecdcb02
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:
	To:Subject:MIME-Version:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Gz2ymSkxMxH9ZIqcsTH0yGZ4TLzcfJ9Eswtg25OGssM=; b=N70EiO+eehke2X1hcqkNS31Ul3
	+90rF1o3F6Kv4HqaRv2/bkV3T/d5h7mXOb6CtGvbVsAdkJ+zPFqaODBJnT7yTJIuwr2g681EiNhxZ
	Vox+P0a9Bkmx2tpta+25m2rp4Kd2BZHzL7rPC3zc0h3lJB6HoWNW1kNfbUJzjYyROiHdG5yP4MqHq
	2HQZuQOFZ0gJ2LsxZPSRasW+a8uKvHword3ivbdQWLTAdFZCW+hCOtMS9UhYDU5W9yO/MVuVlEyJv
	BTQYnASCvKHMu53r3O70EFhC6SbokVrmQmNCp7s2EYuTtGBqrvp1E1GBmfPcErbZUm4THbOQ4uT10
	XHM2fI9Q==;
Message-ID: <8ac465f8-6fda-43a1-8bfc-3e88f30d1ca5@ashlesh.me>
Date: Fri, 6 Feb 2026 20:55:26 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] t5550: add netrc tests for http 401/403
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
References: <20260106114029.763351-1-git@ashlesh.me>
 <20260107074724.13165-1-git@ashlesh.me> <xmqqms1mihqo.fsf@gitster.g>
 <20260206093840.GC2761602@coredump.intra.peff.net>
Content-Language: en-US
From: Ashlesh Gawande <git@ashlesh.me>
In-Reply-To: <20260206093840.GC2761602@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: info@ashlesh.me


On 2/6/26 15:08, Jeff King wrote:
> On Thu, Feb 05, 2026 at 09:05:51PM -0800, Junio C Hamano wrote:
>
>>>    - Third test case checks that the git clone fails when the .netrc file
>>>      provides credentials that are valid but do not have permission for
>>>      this user. For example one may have multiple tokens in GitHub
>>>      and uses the one which was not authorized for cloning this repo.
>>>      In such a case the HTTP server returns 403 Forbidden.
>>>      For this test, the apache.conf is modified to return a 403
>>>      on finding a forbidden-user. No prompt for username/password is
>>>      expected after the 403 (unlike 401). This is because prompting may wipe
>>>      out existing credentials or conflict with custom credential helpers.
>> Nicely summarised.  So we say 401 when we do not know you, while we
>> say 403 when we know you and do not want you to be accessing the
>> resource.  We test for both.
> I think it is fine to check the 403 handling, but note that this _isn't_
> how GitHub would respond. If you try to fetch from a repository you
> don't have access to, it will return a 401 first (so you try to log in)
> and then a 404. The idea being to avoid revealing the existence of the
> repository to unauthorized users.
In the case of fine-grained access token such that the token has read 
access to the repository
but not write access GitHub does return a 403.
(I think this is correct behavior as the token has read access so user 
is authorized/knows about the repository).
>> Just out of curiosity, do we test for these codes with other
>> credential helpers or is this only relevant for .netrc users?
> The netrc support here should not involve credential helpers at all. It
> is all being done internally by curl. So in this (third and final) test:
>
>>> +test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
>>> +	test_when_finished clear_netrc &&
>>> +	set_askpass wrong &&
>>> +	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
>>> +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
>>> +	expect_askpass none &&
>>> +	grep "The requested URL returned error: 403" err
>>> +'
> ...what is happening is roughly:
>
>    - curl sends the first request with no credentials, which gets a 401
>
>    - curl internally, without returning a response to Git, looks up the
>      netrc value and repeats the request with an Authorization header
>
>    - curl returns the resulting 403 to Git
>
>    - Git calls this an error (just like it would a 404) and bails
>
> But from Git's perspective the use of netrc here is not really
> interesting. We don't even know it happened! And if the server did
> return a 401, we'd happily try to get credentials (from the user or from
> a helper) in the usual way. And that's what happens in the second test:
>
>>> +test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
>>> +	test_when_finished clear_netrc &&
>>> +	set_askpass wrong &&
>>> +	set_netrc 127.0.0.1 user@host pass@wrong &&
>>> +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
>>> +	expect_askpass both wrong
>>> +'
> Curl tries the credential under the hood, but we have no idea, and we
> process a 401 in the usual way.
>
> And in the first one:
>
>>> +test_expect_success 'using credentials from netrc to clone successfully' '
>>> +	test_when_finished clear_netrc &&
>>> +	set_askpass wrong &&
>>> +	set_netrc 127.0.0.1 user@host pass@host &&
>>> +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
>>> +	expect_askpass none
>>> +'
> We do not ever even see the 401, and curl just magically handles it for
> us. We see only the successful 200 code, just as if authentication was
> not required in the first place.
>
>
> So really, none of this is testing anything novel in Git at all that is
> not covered elsewhere, except for the fact that we pass the flag to curl
> that says "you may use netrc". And so there's some value in adding it in
> that case. But trying to answer your question about other credential
> helpers, no, they're not even entering the picture here.
>
> -Peff
>
