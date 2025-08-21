Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273CF13A41F
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781554; cv=pass; b=B30HQ73sAJ7C9gY7jdTMfF7hCjZb+XOM/XyId4thhc8C7K6odQp/3pMMOmpHyYP0VAv1zbi0l9IrksC/RCGZJBDxxYbUbhmXddiYv6xc0+/nrnJrN8kPE2x0vb/6EwTkPhSGWdBda1MgZbw48b5NcZvkzN50xg7JjZIqTfIE9eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781554; c=relaxed/simple;
	bh=R0oHQ3CBjaiP9rmwZP1cHw696AoQAQzqh6rPyKyeKHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mUgVh8tMukKIYdfB2uzlbKxZ0x4IcAZB5YGx/AE18JDW+o4bQKRhQGijumg1Ua0yPzuGqiOCQjRXrCq2RrZoyIwiC5pGVj65L6QuNMXUcT4ANplMvT3gGn9UolPUmjbwIl5jPvjUb6uE1Uci/q1qo7Xupex4mFEh7K8R+Fjq+Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Holp8rm1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Holp8rm1"
ARC-Seal: i=1; a=rsa-sha256; t=1755781536; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Byi+QQJqYWk4HKq/qMpBNuOES9DUye2jrb8XxqZEKlhmuJPCKYZA433X6EjdfCyMg+TBXB2roCAo4Uon7niijOvkqSITgT+0qcujz0CeNMsyCkbw17QPD2vrVlWWfCllLifBGBCn2Dw+oWDin/SnundT/u1xb0LAymUsycaMTjk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755781536; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iAEmBWMgCNjXD+TUDuvCnkcrt2dZKCHEt6C2sjovt4w=; 
	b=mE8us+G9fvNZt/wRYz6opBOrNn6O7fnxpnh13fwtS0ihyFRPoqLS8PUV/2+imU3L6pM000Cgqsm5UEZkrFkk+oq2yaJfZ0KakIsLjf3e9d8DeJreYPRynOJh1IdYHIE2OMH250hBR3mUa9OcMjq8tA85Jy7tijwG94OQKikdxh4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755781536;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=iAEmBWMgCNjXD+TUDuvCnkcrt2dZKCHEt6C2sjovt4w=;
	b=Holp8rm18omz+Fda7XBcbdToSMLiCwqNZiD5SnfRYEw7490xWcaxiDE8M4U3erKB
	Mq+ko/WOT2abneQgxr/toW9Qb9/sPPSXUXsz2nGSD1DofoYQvUuo5hWo/fs/uMWcqXq
	f+4l8Gb06EXpJoAyEAN7SmtXrl86oWMHek/ERLPQ=
Received: by mx.zohomail.com with SMTPS id 1755781534620139.5365335862358;
	Thu, 21 Aug 2025 06:05:34 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/9] submodule: add gitdir path config override
In-Reply-To: <km4qhwxpmwld2qw4ihmzjtk7o5yeblfhhm6hqsh4nmzdbkdyyc@mwqb7a76liop>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-4-adrian.ratiu@collabora.com>
 <km4qhwxpmwld2qw4ihmzjtk7o5yeblfhhm6hqsh4nmzdbkdyyc@mwqb7a76liop>
Date: Thu, 21 Aug 2025 16:05:30 +0300
Message-ID: <87y0rc7rl1.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Wed, 20 Aug 2025, Josh Steadmon <steadmon@google.com> wrote:
> On 2025.08.17 00:36, Adrian Ratiu wrote: 
>> This adds an ability to override gitdir paths via config files 
>> (not .gitmodules), such that any encoding scheme can be changed 
>> and JGit & co don't need to exactly match the default encoding. 
>> A new test and a helper are added. The helper will be used by 
>> further tests exercising gitdir paths & encodings. 
>> Based-on-patch-by: Brandon Williams <bmwill@google.com> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> --- 
>>  builtin/submodule--helper.c           | 17 +++++++++++++++++ 
>>  submodule.c                           | 11 +++++++++++ 
>>  t/lib-verify-submodule-gitdir-path.sh | 15 +++++++++++++++ 
>>  t/t7400-submodule-basic.sh            | 15 +++++++++++++++ 4 
>>  files changed, 58 insertions(+) create mode 100644 
>>  t/lib-verify-submodule-gitdir-path.sh 
> 
> Sorry to keep sending piecemeal feedback. You should also 
> document the new config option in 
> `Documentation/config/submodule.adoc` 

No problem, thank you for taking the time to review & give 
feedback.

Will do in v2.
