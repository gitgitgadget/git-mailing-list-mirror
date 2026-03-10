Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A92F1FD0
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153928; cv=pass; b=l2nEce3m/+yuzuBc6Qif7Ms/bmA7Nrt+TJObiu/nBx7g8+TuE/3PCFVPSQU69f1/eHf4lW5q6PWHDpyYACiUVwTpJZ0XZEzAUi3iJPl1NflwA9B7p0YSssTO86e3Jc4SkLuX7qj4279z0nUTWCijghqsyjsYWqPoOb4vjZ+6RGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153928; c=relaxed/simple;
	bh=PejcpX8COEd9E6apxFwfvRz7L+iWfoO8AkA+rYg82kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nzPSzIeIrHRf0IuALkavaBug9tTUBoCW8jcG85k+VEN4ulCesRD2+9kcN0RbPpdxRQKBsdQPctkGYUrxgWTzoyWLGWJQjy5jbgW2XlDVrbZLXsIsUl0lYIpSemP/CDP4NX5cf1xbGSgdexUvhFb2R+Iuo/mksy4rcECx0c7kVIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=fFdd4JJ+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="fFdd4JJ+"
ARC-Seal: i=1; a=rsa-sha256; t=1773153914; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jgb0eXdMjZ7WXApLbz2QoFo5RyygimTjzzqnmHMSgPTD+SfN2oHURPch0Lv0NljolmXqs5iLdP6MM7KW/UBx8vLogDENgl2NXzB2x1PD3jOKtusUU5IR6nCXBRH6ABZSgTkBIfpq388MhqMN0OpXu+pIBPFN6u6H531hhGviFog=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773153914; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qCF/GISqi+pjlORCQV+PUot34apRWFAXbsrf/K/Khts=; 
	b=POM4XSdAFtF46yd/LzDulIkMeurlQqzS2ADn+IjIuN9/rbpVt1AdWdmaFz4cym+Vic1VINXjuydrHUj6/zXkBwFgTUD9ReZtb4KWq0yIFX7dNa5JuZE31xIWkflymbfScmuHhLsl3bceP8GeiSf6pSbpfXmS8flw5J+mjtPLcMA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773153914;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=qCF/GISqi+pjlORCQV+PUot34apRWFAXbsrf/K/Khts=;
	b=fFdd4JJ+B6oLdGbhUn3c1sf+MhZihkX9k4BfI/J63uaCwWsYSkihpbtor1r56s2Y
	cMGOydDpNoevaJ+R10AgkPjyFFgUAt5vfiR07MuCBIYn3T084sdXdRaW8woHD5SyKco
	M3mbbit+Ib4FpmnElA0qJlPXKh+O78POLoWdqrnk=
Received: by mx.zohomail.com with SMTPS id 1773153912195544.9399411482309;
	Tue, 10 Mar 2026 07:45:12 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Patrick
 Steinhardt <ps@pks.im>, "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 09/10] hook: show config scope in git hook list
In-Reply-To: <xmqqpl5c3brr.fsf@gitster.g>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-10-adrian.ratiu@collabora.com>
 <xmqqpl5c3brr.fsf@gitster.g>
Date: Tue, 10 Mar 2026 16:45:09 +0200
Message-ID: <878qbzg2ve.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 09 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> +list [-z] [--show-scope]::
>>  	Print a list of hooks which will be run on `<hook-name>` event. If no
>>  	hooks are configured for that event, print a warning and return 1.
>>  	Use `-z` to terminate output lines with NUL instead of newlines.
>> ...
>>  		case HOOK_CONFIGURED:
>> -			printf("%s%c", h->u.configured.friendly_name, line_terminator);
>> +			if (show_scope)
>> +				printf("%s (%s)%c",
>> +				       h->u.configured.friendly_name,
>> +				       config_scope_name(h->u.configured.scope),
>> +				       line_terminator);
>> +			else
>> +				printf("%s%c", h->u.configured.friendly_name,
>> +				       line_terminator);
>>  			break;
>
> Everything in this patch was as expected (the most important of
> which is where the data is kept, which is in the new structure
> hook_config_cache_entry that was introduced in the previous step for
> use case like this), except for the above bit.
>
> I wonder if this already interacts well enough with "-z", or a minor
> tweak would make it better?  Wouldn't a machine consumer expect that
> friendly name and cope be given as two separate and easily parseable
> fields in the same record?

Yes, out of all the logic in this series, these printf's are the ones
I'm most unsure about.

I'll try to come up with something better for machine parsing in v2.

Suggestions are very much welcome btw. :)
