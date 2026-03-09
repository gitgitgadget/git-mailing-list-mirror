Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7C358388
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773040422; cv=none; b=MfXC/X+vTFJTgiY32uBpu4U56Eg4ISJF5rOqPbVkaAD/0boIFvw+E0OwKT1lSUK5g2O3ZQ4PPhEGEoqNvQDust4bCKVBkdifjLRWIxR5k2bueyInZIxR3k/aDbzwdqOt/KowFhR7Fdf1g2Yo8DBvmm4GS1f0D02QQA5qkRrHe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773040422; c=relaxed/simple;
	bh=aqTLuo6oCbuerjFzTYbZpdtbrsgiCWEnyfI/XgCNqUM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DxG7jrYQ5q+KeHt7vCPOoYFtmbs42Dr0GPc4Qus77rIck4lUK96hM3Q+yCBxm3vfhzKwmvzpzf44ht1qatAD4E2IEiUpTn2Dqy6J3dtmdAetEMHSM0f4sicZxgNIDfDbbBj1u5s7fjvEQbbCSo1IGfyWzlzVdr59PfuAam4wcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=SDjVHkgI; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=T1x21w5i; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="SDjVHkgI";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="T1x21w5i"
DKIM-Signature: a=rsa-sha256; b=SDjVHkgIF3lu+aQBtl6c6fUlZi9RlrEwblG9vbRxTeVOUkCkatuXkoOEu2qzl+rmdMaTqN7JzUOFrgupTLMSt3zrhO8I1+u+FMkIJ58Ijf14UKImZbFnD1KIvSkEl2EIhrSJdv3EhlkwJ5HU+GfPoTKKwxChAhnDEVd4XkxGJXX/ZCwB4HJ+HJuIxQG9Yl7HZCRN+MWFVuNhzPrR9RcCJJZ9QlJkcU9COq1sN9vZtsxWgrSzdACFhWtrxEQf2E6I1PmPdZOlO0ZbAO3+FTjNFBFReVaN/DbSBHfc2SDUW75epNedWO1isrVqZf5ZhpKWIIRROzIJrIgjARxzNmNVbg==; s=purelymail1; d=malon.dev; v=1; bh=aqTLuo6oCbuerjFzTYbZpdtbrsgiCWEnyfI/XgCNqUM=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=T1x21w5iu+VVgivZ3C32npb9eR+l3m7NRmaMWLYwWqFiZAEs/I9l2UHjXqLoea4o7+1x7kWQRzHue5madeQCaUUtf7U+aNWS+x1pkGVfmuw06jAGeYJGnZVKgGsiJFLutQ3mbk5sZwE+Ml/mDTubuQ1Msoo5aW3KFcrQYirUXdLsMXT8YR2BIPO+zRPnJI0UPDSlFDmlMSkPWr8jejYsKUC+CJ3FHJMiR1qEPNKNrP7qW7sf6epptahKViQj1Dvz62eXJcnW5XTwA3WwnrO/ChH+8Gnxr77ZpLz6HuDdVjwyJ9cG22a7VYz0ubmrzFXQFFc5HVBx12uk3xI2a+vuxQ==; s=purelymail1; d=purelymail.com; v=1; bh=aqTLuo6oCbuerjFzTYbZpdtbrsgiCWEnyfI/XgCNqUM=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPA id 1092770464;
          Mon, 09 Mar 2026 07:13:34 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Mar 2026 15:13:34 +0800
From: cat@malon.dev
To: drona <dronarajgyawali@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH v2] Make 'trust_executable_bit' repository-scoped
In-Reply-To: <f03d40072ab106d1a0a7852718d42f56@purelymail.com>
References: <20260301190017.53539-1-dronarajgyawali@gmail.com>
 <20260308183756.31860-1-dronarajgyawali@gmail.com>
 <f03d40072ab106d1a0a7852718d42f56@purelymail.com>
User-Agent: Purely Mail via Roundcube/1.6.11
Message-ID: <6e3d373f2f41232ca9015c39ae0ea67d@purelymail.com>
X-Sender: cat@malon.dev
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> Hi drona,
> 
> Thanks for the update! Just a quick heads-up: it looks like
> you forgot to CC Junio (gitster@pobox.com) on this iteration.
> Additionally, I think it's a good practice to respond to
> reviews before sending new patches. What do you think?
> 
>>  	if (!strcmp(var, "core.filemode")) {
>> +		prepare_repo_settings(the_repository);
>>  		the_repository->settings.trust_executable_bit = 
>> git_config_bool(var, value);
>>  		return 0;
>>  	}
> 
> Regarding the code, calling 'prepare_repo_settings()' inside
> 'git_default_core_config()' defeats the purpose of lazy-loading,
> doesn't it?
> 
> if (!strcmp(var, "core.filemode")) {
> 	prepare_repo_settings(the_repository);
> 	the_repository->settings.trust_executable_bit = git_config_bool(var, 
> value);
> 	return 0;
> }
> 
> I think the standard practice is to drop the variable from
> 'environment.c' completely and read it directly inside
> 'repo-settings.c: prepare_repo_settings()' using
> 'repo_config_get_bool()'.
> 
> Regards,
> 
> Yuchen

I accidentally clicked the wrong option and didn't select Reply All.

I'll CC Junio on this message.

Regards,

Yuchen
