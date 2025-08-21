Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117503054E0
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775618; cv=pass; b=TipjsIiu3gYxET47ssyfzczmG4Ij/VB2fNBvSFy6U8ppprqzrSo5jXnMlZWuq5cDJxM4TZYKs7rkY4d2YUs9YeFIBHdhzEUxoXi0DIbH7mWxu8gEwuf0QfZS/Lc/GEiM3dTNrLaIdZK7kGGdCyTZcucrZYfmiOUw7XAybJev+NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775618; c=relaxed/simple;
	bh=Wc3E7AJ4DBAw/BKQmFwyzYzbvw1fyl3TNg/r+b2TkBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGel67TX6yzvxeHNkjzyzJwFzqPDwD7rHIkiXFxFEvARZEqQPAtcCxAmS7oUpOnlnk4UC8icBkonfDFtzpjQvT7h5utNVMCysE6Tdst8lgi+DmkhfVmd0qcKjM58JiJ6S+9U4sJjvRNxVSmY9YxhaSU4hhMhHGtz8PLZi3PunxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YEx9Unkr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YEx9Unkr"
ARC-Seal: i=1; a=rsa-sha256; t=1755775589; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jABIo5rKnsicPMzyO1RRfc0/1Uj0hW7jSuc6oQbqHc5ZsGHUjAZZJMtrKqfQ+3xU9Ath3X0VxrhvXWazeHQBxh6VJ/OxYJihyKjypm6WT1z6HeI05ncDDx7ZYasA8C25hbbZtI6OTLyvwLXky1nTkR2R/pRz/ZY9oS78NyGIBsU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755775589; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RPW+5tE63rOVrprUVrtspBGgwOyv9QnBEkp6Hme1LRI=; 
	b=jDI7uwrDoNTINWnLwLMQX6zDcxGYxYX3Ob8Vl3KmyYX/TExZFyV0wo45IxnkRwc8Wu3A55OSd6nsP2SnBDg1npaE1WDZ+b86SXh2wx6Ls7RwD3WW8tYi5/1HLkqArlA5WyGqBB/3Io0ROcOwHPJnSZclBdQ6iVeCHftAR6JOZ3g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755775589;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=RPW+5tE63rOVrprUVrtspBGgwOyv9QnBEkp6Hme1LRI=;
	b=YEx9UnkrNm0o+UpHI54poJXPaPmoy+O0HC0HzeEM3K1TY6uknKXsIxV+HxcmPTHq
	kPulrGKw1Kxtp29wM217mj1o6vtcnH3fx4HRqoG/KD8FOUWE1EOrt1OsqqjsMWfnw4z
	lOI+t78nkpOZvueHGS/N5S/RF3p+7PkL8rGqQqDc=
Received: by mx.zohomail.com with SMTPS id 1755775587192196.93363919153137;
	Thu, 21 Aug 2025 04:26:27 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Stefan Beller <sbeller@google.com>, Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/9] submodule--helper: use submodule_name_to_gitdir in
 add_submodule
In-Reply-To: <qcpwoggznb2hj4kegtnouh3ty2sepuhmqlhhzfbpvm7d2yt33y@6vnui5pnnl7x>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-2-adrian.ratiu@collabora.com>
 <qcpwoggznb2hj4kegtnouh3ty2sepuhmqlhhzfbpvm7d2yt33y@6vnui5pnnl7x>
Date: Thu, 21 Aug 2025 14:26:22 +0300
Message-ID: <877byw9aqp.fsf@collabora.com>
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
>> While testing submodule gitdir path encoding, I noticed submodule--helper
>> is still using a hardcoded name-based path leading to test failures, so
>> convert it to the common helper function introduced by commit ce125d431a
>> ("submodule: extract path to submodule gitdir func") and used in other
>> locations accross the source tree.
>> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>>  builtin/submodule--helper.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>> 
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 07a1935cbe..7243429c6f 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -3213,10 +3213,11 @@ static int add_submodule(const struct add_data *add_data)
>>  		free(submod_gitdir_path);
>>  	} else {
>>  		struct child_process cp = CHILD_PROCESS_INIT;
>> +		struct strbuf submod_gitdir = STRBUF_INIT;
>>  
>> -		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
>> +		submodule_name_to_gitdir(&submod_gitdir, the_repository, add_data->sm_name);
>
> I believe submod_gitdir_path is now only used in the `if (...) {...}`
> side corresponding to this `else` branch, so perhaps we should make it
> local to that block?

Yes, I'll move it in v2. Thanks!
