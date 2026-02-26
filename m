Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9633B94B
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109714; cv=pass; b=mlMEFmTPzgo6fq5V70yVdc7w5JmJNwwqxufZScc823JuJSQNXi9F3e/XNWNkshen0iMaWetxW4cyyZlQ2lmhc5+mWX3TWAovvaNFFQiC875Q8n+hssi3E/rPNaqbBz2OhiXxPBFi5oGGz6clrizayVOXdCLE0mfz0aASnaM9HsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109714; c=relaxed/simple;
	bh=54jxkySuJqL+5Qof6XslR9s5ChBCbvOdNef0ce31GjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ducup1SmafASswdfsPqaRZ8P9J0BS/HxcxxSwhlKoDgjwHPgezwk2urw71BcnOLz0fJ55cj+kHIVpEmaSA/h+D0iWWAHIDRy5LY9R/FHqjRGV1711g+5rdjnTUfNx86IhNlWl8I52b3EgqiENO1dvGa3UO6Z/0m0eFuz8kTpars=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=SkDZbSd9; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="SkDZbSd9"
ARC-Seal: i=1; a=rsa-sha256; t=1772109706; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ls5d+7/X5WAvLuycw/0gYr0T8MlhFK9VbXajUlrLRpZTqsPG3RCA1/ctWrIGW9MgR/+XkibmpN+WtL0oV3r/3hqaZgRtImZf2QmgEKH+w832/1q+Hkjvy1ALtjuzV6jlI+GPbJSTl6EFLBcrAHcrwSHdOFyqj2Gg9YeFMw2gty8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772109706; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pwMebswdEsGf+/O9JMMpB1a3s6bA7f0rEXPwXDLAZuk=; 
	b=LsqwcKajkl92UiAWPxwCqbJHYERvqXQnwczEiH7sCDyqs4QWsqkefCDhSqE+Ayir0JPQabW/0r4RsOTYVov/oQmwReOpkhZiWw6/1Bo00HN4vofvufe047KZxv53TmR/gU4aTCFGq9L4cxlmvJkGy724hSHwnELJ4FHOx1OU/IQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772109706;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=pwMebswdEsGf+/O9JMMpB1a3s6bA7f0rEXPwXDLAZuk=;
	b=SkDZbSd96qdKuQbkSumSBFgHkNngXfye8eVA4RrIV+mhXzmuFPpKgPeVXRZt28sa
	ewA0LgjnN0jteKwZy1OJA/6kOvPtpCLz8UG5ytjeURo8M17yV6zAkyENYyvdUTqY6Up
	X3FnHh88rb7i2qyBBcXbcXZfPqD7CJXfNnpLXfcg=
Received: by mx.zohomail.com with SMTPS id 177210970380657.744923136503985;
	Thu, 26 Feb 2026 04:41:43 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Specify hooks via configs
In-Reply-To: <aZ94HdcOUGp91UBT@fruit.crustytoothpaste.net>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <aZjuTSopOMvwR4hQ@fruit.crustytoothpaste.net>
 <87o6liw4s1.fsf@collabora.com> <87ikbpwr13.fsf@collabora.com>
 <aZ94HdcOUGp91UBT@fruit.crustytoothpaste.net>
Date: Thu, 26 Feb 2026 14:41:41 +0200
Message-ID: <87a4wvbrsq.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 25 Feb 2026, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> On 2026-02-22 at 00:39:04, Adrian Ratiu wrote:
>> Hi again Brian,
>> 
>> v2 of the parallel series is out if you want to review it:
>> 
>> https://lore.kernel.org/git/20260222002904.1879356-1-adrian.ratiu@collabora.com/T/#u
>
> Thanks, I'll take a look either today or a little later this week.

Much appreciated. I'm in no rush, as I mentioned to Junio we could even
put the parallel series on pause until we finish and land this config
series, which is its dependency.

It's still good to have all the code out, though, and I do intend to
periodically rebase the parallel series on this one.

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
>
> Yes, this is because one of Zoho's customers sent me spam and they
> didn't act on the spam complaint in a timely manner.  I've removed that
> block[0] and we'll see if they've fixed that in the past six years or
> so.  If not, I'll re-block them and you can have their postmaster reach
> out to me at my postmaster address to discuss things further.
>
> I regret that this is necessary, but unfortunately when you run your own
> mail server, you have to deal with all the abuse yourself and many
> companies choose to ignore abuse complaints.

Thanks, much appreciated.

Collabora also runs an internal mail-server behind a VPN, so if Zoho
continues being a problem, I'll just switch to sending mails through
that server. I mostly use Zoho to avoid dealing with the VPN. :)
