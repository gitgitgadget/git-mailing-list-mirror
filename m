Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C40336ECE
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108534; cv=pass; b=iLnFtzHS5oMhLVe7NPGl9bTMNeZEbj+0N5tSYrUjATjhohIp+G/LQg8a8UjyRAX3Rub1wmBK6z5A8DbEC3T+OpRHECE8cIZ7EOBlITsAEad9+u9zGCUUvGrxY8wHGU+nEAatTFOc5ey7U0DmaOAsok85+M9K8bOdvZUYGyJJJt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108534; c=relaxed/simple;
	bh=AwKMY7CTHA2ApZjrJqpEInpgwTFPw1ZS1TH/WnRcmhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ag0L6/yRh/HIi8cMyhS/ACph3kyW2IDYUgfz7XTRxclN4I0me1fbxxuth2clULiuBu9z9Yl8JIABRzV5Pl7j29cEFPYP6U4BL5dIXSwYQo3ZlVQmJUKNMxBj8wF218l8zy5ZXQNKHneg4IAPkmXMbmwF34Exo8ah7BuaHytSmdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=eKm/px83; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="eKm/px83"
ARC-Seal: i=1; a=rsa-sha256; t=1772108521; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LQ8YjHm/PyvBC367dXbr0oFfO4tTxfGqKKJCSqZikmIvQ4TFFTZPyugUSQ8SQVcrhk+pqn3foClznwF5EIoEJ4O4YZ9QhgZYkzuztdL0QT9rz5K3gG+uR3j5sJKvLlQTfmwt+GEfIa6tAgXk6AIaxk1IT/XLUQnwZ8MqQiFCHr0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772108521; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ybkQSr/ahxwlwXndDST8dAT6y8MC5TCMLj5hgXYlE5Y=; 
	b=Ds3YF+nmIQPGQx+SmLduGWq9is3b8mA12ekkEGdNbCHyvPQOML/kXuXlLlOp4davnIXHusP8J9RSfw51a5z/de8RhJYe3G06+IP2y2lKO7h7axIbz+pzK8IZzc41ai0z1kQ3vqfyNHoF0PeBKWXi+nMhSLp7//BXQSaFp19xxTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772108521;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=ybkQSr/ahxwlwXndDST8dAT6y8MC5TCMLj5hgXYlE5Y=;
	b=eKm/px83ZKeRx+5yBqdzOTLr0haq5LfXe3YmJ0WXHvfWEr10ueifABA5KAla7Hyp
	gA67dp9En3zx2XtD2v7rOt6s4tqLh4FKWpJDgHa1fWUvVfR0oh15eFShCw08ubC34/Y
	q6G7AXhTztw2GXIXQpHdUYvAiDdQI5j8fdeBx3bY=
Received: by mx.zohomail.com with SMTPS id 177210851917530.637955588023033;
	Thu, 26 Feb 2026 04:21:59 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Specify hooks via configs
In-Reply-To: <xmqqzf4wacuh.fsf@gitster.g>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <aZjuTSopOMvwR4hQ@fruit.crustytoothpaste.net>
 <87o6liw4s1.fsf@collabora.com> <87ikbpwr13.fsf@collabora.com>
 <xmqqzf4wacuh.fsf@gitster.g>
Date: Thu, 26 Feb 2026 14:21:54 +0200
Message-ID: <87cy1rbspp.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 25 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> On Sat, 21 Feb 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>>> On Fri, 20 Feb 2026, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>>>> On 2026-02-18 at 22:23:44, Adrian Ratiu wrote:
>>>>> Hello everyone,
>>>>> 
>>>>> v2 addresses all feedback received in v1.
>>>>
>>>> I ask because situations where the hook output is not handled gracefully
>>>> and hooks fight over output or where the existence of TTY on a file
>>>> descriptor is not preserved will result in bug reports and broken tests
>>>> for tools that use Git, which I think we'd all like to avoid.
>>>
>>> Hi Brian,
>>>
>>> Yes, this is all done already. Phillip Wood actually brought this TTY
>>> issue up in his review of the v1 parallel hooks series (many thanks). :) 
>>> ...
>>>
>> Hi again Brian,
>>
>> v2 of the parallel series is out if you want to review it:
>>
>> https://lore.kernel.org/git/20260222002904.1879356-1-adrian.ratiu@collabora.com/T/#u
>>
>> P.S. I think your spam filter is blocking all my e-mails? I get this
>> reply from you:
>>
>>  sandals@crustytoothpaste.net, ERROR CODE :554 - 5.7.1
>>  <sender4-op-o12.zoho.com[136.143.188.12]>: Client host rejected:
>>  CONN:SPAM
>>
>>    Original-Recipient: rfc822; sandals@crustytoothpaste.net
>>    Final-Recipient: rfc822; sandals@crustytoothpaste.net
>>    Status: 554
>>    Action: failed
>>    Last-Attempt-Date: 22 Feb 2026 00:30:10 GMT
>>    Diagnostic-Code: 5.7.1 <sender4-op-o12.zoho.com[136.143.188.12]>: Client host rejected: CONN:SPAM
>>    Remote-MTA: dns; complex.crustytoothpaste.net
>
> So, shall we make this "hooks specified by config" advance, while
> expecting the parallelized execution to further evolve as a follow
> up series that will still be out of 'next' for now?

Yes, that is correct.

These are independent patch series which just happen to depend one upon
the other. Other than that, they are completely separate and should be
reviewed independently, each on its own merits.

(When you have some time please review v2 of the parallel series.)

I do plan to send v3 of this config series, then v3 of the parallel
series after it gathers feedback.

They do not need to evolve in tandem, btw.

We can even put the parallel series "on pause" until this config series
is done and lands, if it makes things easier.

Thanks,
Adrian
