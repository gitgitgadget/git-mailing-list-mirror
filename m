Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63B2E0938
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380232; cv=pass; b=HNwgv+/TuaZvrDiael7tdpoudEjXsi2QcTrxehVmc4TCtCJOB+REZcDnlfJZEG+FOfxaUhgYq5xjB47nMfPWvx/aG5qFag+GCd6fw1dPhqUscPaz5mlKweTslS7B034vvYNWkuHM/kLitG550uhuRZ6SqHRi7eDEAK7A/eOPwlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380232; c=relaxed/simple;
	bh=rILCCJXBaJLp19iU01FqhtAsf6XUqVxCn/cUyxPXOpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MmtDbj4kZpKzXgULVEDCUHf/FASQOnfrgDBqztmpYHs5ibhSfQ+yeI1mVqsL8Hs8tb05QMQ4gSlSsU4zF13WIYGL5mvLFJuD0uORifbVMeXw2+3mD8idxlIyPgWzG4SLE/qW/97s5Cod9jNSMV9mI+MWTXdDW3MRbnhY9pzgmlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=gHjLlc8W; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="gHjLlc8W"
ARC-Seal: i=1; a=rsa-sha256; t=1774380216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UbWruieVUS6mgLUAa1MHmcLee4EbNJ/HQ38lJ6GJH5LXScQaDx0vleISiopH+4rpS89ewfW9bH36Yk7qHvwZwS8dkbS64tfyx8d4ynKPu3a/Ex1/HaWYhvVlYFFRLDRKLgR5F7vRYSLEg6A01nAjEiQAqJGXKzltGhVuWF+2hKs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774380216; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bVzR9+q5DifV/FqWi9Hk3Ji5kiQvS6YKUU3DBXLyyKY=; 
	b=Yoz1XBwQH4ZpUhoAAFozS4qiNvcEoU3o6emOZ+Pyol69iwDr1EIlfcc7hO8fwQTOTFo5SSvtaJ7ZslWg/GtB/AUgHrq43opjnIMk1ouhUKQRx8gEuA77FpEtNtRMEb/7i95pZWezYZRVztsQ4TNcjkH/JbCl4JVMLOGhd8Jt+lI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774380216;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=bVzR9+q5DifV/FqWi9Hk3Ji5kiQvS6YKUU3DBXLyyKY=;
	b=gHjLlc8WkBBgW91/s4WyDVB5ICzh100xNCrvq6voK/Mo7n1QP5laO3r5dB7+z3UF
	0/FgMDwbZ/p9AXFMfIf36dqMWoxscqdal8Pvq7ZGaQnMa00cKpPBwNkm2ufznG3cGpI
	/rMkzi5m1LzkcKwlm7tzqKjiwDdRyxuv0//4j6Bs=
Received: by mx.zohomail.com with SMTPS id 1774380214326761.3966273849445;
	Tue, 24 Mar 2026 12:23:34 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 10/10] hook: show disabled hooks in "git hook list"
In-Reply-To: <acJNdKyz-ISsq4fJ@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-11-adrian.ratiu@collabora.com>
 <acJNdKyz-ISsq4fJ@pks.im>
Date: Tue, 24 Mar 2026 21:23:31 +0200
Message-ID: <87ecl9c9qk.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 24 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Mar 20, 2026 at 01:52:11PM +0200, Adrian Ratiu wrote:
>> diff --git a/hook.c b/hook.c
>> index aa08c38c27..0e09b9a2bb 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -119,6 +119,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
>>  struct hook_config_cache_entry {
>>  	char *command;
>>  	enum config_scope scope;
>> +	unsigned int disabled:1;
>>  };
>>  
>>  /*
>
> Curious, this is now a single-bit int. I still would have expected a
> proper bool here :)

Yes, I did it this way because the parallel series also adds another
1-bit int after this one. :) 

I'll make both these a proper bool as you requested in the other series
as well. I don't have any preference and am ok with bool as well. :)
