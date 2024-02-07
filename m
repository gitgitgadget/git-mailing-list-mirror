Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982B80047
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321742; cv=none; b=AdR+xt8T2chCY4BMSa1nnmjZVZa9zbI8aw56oFz0hxzfEnfN81lX9/+1m+Np0mXtnYzHRqxtjdG2/V9iTDSMmpyo4Nr/5JWrvtMtQ8f8KI8knrRMfMRxpfyiDH/HVDBRgOtLwXoJ3V3CHa4KSsbGz/XAALTepZE8BqSn6IcS7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321742; c=relaxed/simple;
	bh=we1S6uEh93gDphKD4MWDPyFt7OcQrzbY4fiiNvP9D+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcnW4tMWgqQHsM1UbrXWuIGPglDSre/7ql6KK3JcOaDE1fgJ//UHQIC8NtxWS7QZSLzozSB1XkeEk68t/nH1azjA/wCHza7zqBUjGuqqMv9be7/7okgAXJ7jwxAwtkljQ2PvBVnDhL+3pG4MjC7JzgRHtuSoJMDGKkJG1pIhUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eivge7ez; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eivge7ez"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 049351D6DD5;
	Wed,  7 Feb 2024 11:02:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=we1S6uEh93gDphKD4MWDPyFt7OcQrzbY4fiiNv
	P9D+8=; b=eivge7ezacX+kw4UV0ZnPH6kGm/jvec+JN5c/1tHQLQ6nYpbhFPlJf
	uSMVAA5Ozcfp/zxIoLxMkR+BWN25LHhvOsa2aE32Ru17kJshdvycVKSHca/bDP3y
	g5POB1a7jbEIjbtHoILPedBfZDWWaCLn2f9CIDQfFj3hUPb5E7kjw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFAA91D6DD4;
	Wed,  7 Feb 2024 11:02:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 542821D6DD2;
	Wed,  7 Feb 2024 11:02:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [PATCH v4 3/3] add -p tests: remove Perl prerequisite
In-Reply-To: <df1fc65f-8716-47bb-b379-1e1f1eeece8b@gmail.com> (Phillip Wood's
	message of "Wed, 7 Feb 2024 13:51:39 +0000")
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
	<20240206225122.1095766-7-shyamthakkar001@gmail.com>
	<8baa44ef-4960-4f0d-8cab-38d3d6ff971a@gmail.com>
	<df1fc65f-8716-47bb-b379-1e1f1eeece8b@gmail.com>
Date: Wed, 07 Feb 2024 08:02:17 -0800
Message-ID: <xmqqsf24clfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 44D45586-C5D2-11EE-9EAC-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 07/02/2024 10:50, Phillip Wood wrote:
>> Hi Ghanshyam
>> On 06/02/2024 22:50, Ghanshyam Thakkar wrote:
>>  > The Perl version of the add -i/-p commands has been removed since
>>  > 20b813d (add: remove "add.interactive.useBuiltin" & Perl "git
>>  > add--interactive", 2023-02-07)
>>  >
>>  > Therefore, Perl prerequisite in t2071-restore-patch and
>>  > t7105-reset-patch is not necessary.
>> Thanks for adding this patch. If you do re-roll I've just noticed
>> that one of the tests in t7106-reset-unborn-branch.sh and another in
>> t2024-checkout-dwim.sh still have PERL prerequisites as well. I
>> don't think it is worth re-rolling just for that as we can clean
>> them up separately if needed.
>
> I didn't cast my net wide enough when I was grepping earlier,
> t7514-commit-patch.sh and t3904-stash-patch.sh also have unnecessary
> PERL prerequisites

Thanks for helping usher this topic forward.  Very much appreciated.
