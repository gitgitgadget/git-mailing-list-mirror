Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A3395276
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520510; cv=pass; b=s3cxBJfuaNQduzMgJcgesDeJQ3wlXwL32zIVkW++ZQZnHwRQo7P5lg5nTb4Ve75cauJqthTEaHlG/oTrh7sNcoRU0mGtG2Yi/6sP/cmNBG6oe7YlMhr8SPRmEMfgdlBf93b8m3b8bisagRUd53su9NHnqRwx5NRtT8awPcflSB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520510; c=relaxed/simple;
	bh=UxNT1rQyZzt3i48Tq77KTIClMjYYVECO96CqHf8jvgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQzL5Zz10w2O4tV0xWVqSoHmlLILo5oSowJki3yjL5ADCmrdOZ+HK7zYnTHXb/RKfgzoBTs+ce/2Zt9HWMK3QHvvtMBb+j8qbDTzaaLrt32jRxtwsKlHaiv6N4zoj5mUUJPmkqBWH7uIICcgXnU2NVguUBXI1jqbNQXRl7Kf7d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XrVu/TxK; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XrVu/TxK"
ARC-Seal: i=1; a=rsa-sha256; t=1774520496; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BlehvcLyMjhnmacfBuKzSiB0nNS4MHu5dTyWNsJMKXvsmN27VLoLOd98Mpt5qX1zh1RVSK+9CgWJpgl6Gf/TLgi1d8bXvDVc0kD9xMtpaJLEFfAEIwgzYIG6TYrWPi7kIzJ1RE9Fua6gr48kC6wBbRwyEY7FowtKfEaqoZMp7zI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774520496; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k7kPpaC/rt3LyYzgvNtk+LSO2Joe8jxaAGtQf2Zxy0U=; 
	b=hE3fkHheHknKXUanTwVjkNwnjS8ljI4lxEGt42TMUkGepz93nEkB7sqYt0kW3D3khkFiX6dmc3bg9Jt37obCqEg+Xy63eGe4FkHFvfp/Zz1OzEnLr5GiKyeIb/vtZ4AOBby6ycdNYfyxWix01seCYI0iokAFWUxodwN666R7gjM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774520496;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=k7kPpaC/rt3LyYzgvNtk+LSO2Joe8jxaAGtQf2Zxy0U=;
	b=XrVu/TxKu6kC26m2oWL2fV//5K9egBSX/g1E5RDOscZk4Xde6AKL4N++5z1hKRoo
	/KNxtuWHq/OHD/ga0SKr5uFfnooD6/mG9G2bYo9oK3tBjscztWoDb4DcPde2SviL+2l
	7vsncAvTPWI7uAL8PZkoxcn5mgzdJD+ATtvHIfjc=
Received: by mx.zohomail.com with SMTPS id 1774520489081731.8986099559813;
	Thu, 26 Mar 2026 03:21:29 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Patrick
 Steinhardt <ps@pks.im>, "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 00/12] config-hook cleanups and three small git-hook
 features
In-Reply-To: <xmqqse9nsj6g.fsf@gitster.g>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
 <xmqqse9nsj6g.fsf@gitster.g>
Date: Thu, 26 Mar 2026 12:21:25 +0200
Message-ID: <87fr5mdh7e.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 25 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Hello everyone,
>>
>> v3 addresses all the feedback and requests received in v2, many thanks to all
>> who contributed.
>>
>> Let's please stop adding features since this is getting rather big again. :)
>> New features can be added in subsequent patches.
>>
>> This series is mostly for minor cleanups, bug fixes and refactorings + three
>> minor feature additions to git-hook, which resulted from review discussions:
>>
>> 1. The ability to show the config scope (--show-scope).
>> 2. The ability to show which hooks are disabled.
>> 3. The ability reject unknown hook names with "--allow-unknown-hook-name" as
>>    an escape hatch.
>>
>> The series is based on the master branch.
>
> Replaced the old one, and then rebuilt ar/parallel-hooks on top.
> Please sanity-check the latter when I later push out the result of
> today's integration.

ar/parallel-hooks is expected to break with this v3.
Sorry I didn't make this clear in the cover letter.

What broke it is the new --allow-unknown-hook-name feature and the
code-review changes (I'd be very surprised if the old ar/parallel-hooks
applied cleanly on top of this, I fixed quite a few conflicts).

Please use v5 of ar/parallel-hooks which I just posted and should apply
cleanly on top of this v3.

> One thing I noticed a bit annoying was that we have "event_disabled"
> boolean in "struct hook", plus a string-list of the same name in
> "struct repository", which means "git grep event_disabled" hits
> both.  Perhaps the caching "struct string_list event_disabled" can
> be renamed to reflect what it is a bit better, like "disabled_events"?

Fixed in parallel-hooks v5.

Thanks!
