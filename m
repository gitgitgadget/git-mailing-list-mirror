Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10BA3CA4B7
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438125; cv=pass; b=kfChUMHsf/ojT+o1xtSGNJkDPdclZJsfL3Gtea3zpxZ1ORSDgaYj5cpkMDqGRfn9Vz49N7Vsry66h2pk6oTv4r9tcWvJUyhA4TnY4NwYCqTQlWTp9uCUjx67/EBuQPmdUlesmbwDdMxv6mdaifa5Vc+rW4BPlq2HdfhBnzQgtsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438125; c=relaxed/simple;
	bh=aq2YiTQnF2lhP9FD0dhfqKxwqjCBPjNGShs2LWSMNZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dWMpBi+xfFNI0NIR45FOv/76frEwLqfv03UsEhky0FLqSQFYXTpKl2d4+7o05bmlXDQnL1z57eoGvA/aszURdKyZqToFEB5a94RbScZZMoySKR2vwOXGqokGU6WixuVhsgl4CiZ/xzwS3oO6HKtCTK1YrTQihxsUoNpJrpm/r/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HM/r6q0/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HM/r6q0/"
ARC-Seal: i=1; a=rsa-sha256; t=1774438110; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nTII3GaE581T0Vy3UA0SBKCFJbAk5119go8qzj5ECTxx2lD2m09jFO88DNQXOK0rEOMAn3E9L60Pn1SoGccYvN6gcxB4bFHRn8q6bnS5BbL+Qf8/Zc2KJ1x0y3Zz65Tf6k+g6IeQKYHA6L4klklAWVT5ErQBHQSrMzzgUIZClsk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774438110; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ssBt4fztw4QwQxEeD8AbLX+WtTwT+UXCTUGksVVwWLk=; 
	b=YdrYpCVFccbY2A2T43ACGoNTHhs78MVw3fgXMm8TxlEa+2Tr9Pzh5nPnzeJVjrlXjhh7QSGoHViVZZC0rd8MQBHx4MiJWoj63RdfHK1AISNxtRk4OKGg5YdnJ6mMrqB2pHzdVBzMzEDGGBmI+tVaZL5gzwMWPdP4sQQE0JQCllg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774438110;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=ssBt4fztw4QwQxEeD8AbLX+WtTwT+UXCTUGksVVwWLk=;
	b=HM/r6q0/k+2oF/1K11oL30WZg+KvvZoTIGzsWlkp9HvvpELUfx+fgYWh4sa3GxRS
	JDgy4895RXQq95z03aDuqLNcZuiDTOpPwJ8C9H22xBJqgSrW2cf2iSzLiObX01yn76V
	PC4b4YIypaWH6HllHcYMEpmGAdv+pkLl8i3rEuR4=
Received: by mx.zohomail.com with SMTPS id 1774438108785490.11550248991125;
	Wed, 25 Mar 2026 04:28:28 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 09/10] hook: show config scope in git hook list
In-Reply-To: <acJNZ6Tu71YSL57o@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-10-adrian.ratiu@collabora.com>
 <acJNZ6Tu71YSL57o@pks.im>
Date: Wed, 25 Mar 2026 13:28:24 +0200
Message-ID: <87v7ekrvvr.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 24 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Mar 20, 2026 at 01:52:10PM +0200, Adrian Ratiu wrote:
>> diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
>> index 966388660a..e7d399ae57 100644
>> --- a/Documentation/git-hook.adoc
>> +++ b/Documentation/git-hook.adoc
>> @@ -9,7 +9,7 @@ SYNOPSIS
>>  --------
>>  [verse]
>>  'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
>> -'git hook' list [-z] <hook-name>
>> +'git hook' list [-z] [--show-scope] <hook-name>
>>  
>>  DESCRIPTION
>>  -----------
>
> Taking a random patch that relates to the git-hook(1) command. I was
> wondering whether we want to introduce another change here that will
> cause git-hook(1) to bail out when given an unknown hook name.
>
> I know that we explicitly want to allow having custom hook events, but I
> would argue that 99% of all invocations will use any of Git's own hook
> events. And given that it's really easy to misspell the "prereceive"
> hook (which really is "pre-receive") I think it would be nice if we told
> the user that it's an unknown hook instead of silently doing nothing.
>
> To cover the original use case we could then add something like
> "--allow-unknown-hook-name" to make the caller explicitly accept non-Git
> hook events.

I think this makes sense.

I just wrote and tested the implementation and it works nicely.

I'll include it in v3.

>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
>> index 7eee84fc39..22cca15fda 100755
>> --- a/t/t1800-hook.sh
>> +++ b/t/t1800-hook.sh
>> @@ -408,6 +408,25 @@ test_expect_success 'configured hooks run before hookdir hook' '
>>  	test_cmp expected actual
>>  '
>>  
>> +test_expect_success 'git hook list --show-scope shows config scope' '
>> +	test_config_global hook.global-hook.command "echo global" &&
>> +	test_config_global hook.global-hook.event test-hook --add &&
>> +	test_config hook.local-hook.command "echo local" &&
>> +	test_config hook.local-hook.event test-hook --add &&
>> +
>> +	cat >expected <<-\EOF &&
>> +	global	global-hook
>> +	local	local-hook
>> +	EOF
>> +	git hook list --show-scope test-hook >actual &&
>> +	test_cmp expected actual &&
>> +
>> +	# without --show-scope the scope must not appear
>> +	git hook list test-hook >actual &&
>> +	test_grep ! "^global	" actual &&
>> +	test_grep ! "^local	" actual
>> +'
>
> Do we also want to add a hook discovered via ".git/hooks" to show how it
> interacts with the new flag?

Yes, good catch, I'll add it in v3.
