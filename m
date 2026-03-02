Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53C2E093A
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479849; cv=pass; b=MlyI0cC4MVc1LYHcNM4dhQbPYSV97j7DMriUuZ7rN2/94FxWy9xT59o/YFqkENuPNvI1FZ9XS3fCmPi19Ap0nNcc6Ct4ByBnij0DH/dkg3LlLZ5U6dHp4FHT2gkawnW1+5J68uyRcfsp3JXLv9lrfHoRfoBymb9WS5VLztOECxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479849; c=relaxed/simple;
	bh=ljzeBMSsNXRgZ89Ihi37IQIpBZF3aS/krxsHXWbVTJ8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYa+fFg1PwZEkiEvXNRb0etqT8W0QdYdX5IGw4XFKio/0VvJbVUm6cNJPBdtOkebLQ0xi7eEc7dbL1Bsu7glHgYS1zNAQsKDMKlvmuNNnloNlJRtfsPOoCg0kJmnuJMxAKlxy23r9kZ3iC/lepISQLUE51r1phmxk41A4+zOln4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=OzA/rJ9w; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="OzA/rJ9w"
ARC-Seal: i=1; a=rsa-sha256; t=1772479841; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FjYY0ooWWTa9Bes/Lb2wuA7ZmQtWcBOvY/dG9/cZ1vAu5zuRXXMJUulVfkdJRiXpeJ0LE1GvQa5PA823BwIIf8yKZH+jHjqlUB+mriZuG843cupQc3abUeeoeJDTpV87Sv4glwC2IdNHcLskP6FKiF+CVj8Y8ItYy93v/mnO8jI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772479841; h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=pMDWdtjnY5PMzfCbCRWTiiGeWuqqQsf6l7ngetouWGw=; 
	b=dydo/8rFP4OExk8OOfpIo5R/g8i9r9kyfqZ+DxT9BEPrYzPHrZnWpsCrEG8GE16NVV+rFhS8zEaZGucE9fv18w29SXZDVFz9N7a7TI1/5hGNLq5N4AJA5GjTkvNWvuzFoBttryvmi26uCmEARlSscoCHV6kkzgk11AQ2z9xNHaQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772479841;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=pMDWdtjnY5PMzfCbCRWTiiGeWuqqQsf6l7ngetouWGw=;
	b=OzA/rJ9wF6vYW1JfXhTAYpTXKcQTTQ1tn80qavV/1w033lB5g5v6tmflIbZxPRxG
	+eqB7WbL5WUuw+C1QQwjVaxGiigjCh7RBa4Sp7yddESkKT2GcyuQTlPA4rQJK3XbqS2
	EW8q6kFWSMQV6HcGRmSCsE7IHyyAhe1baQhBeS3Y=
Received: by mx.zohomail.com with SMTPS id 1772479839308769.909716170367;
	Mon, 2 Mar 2026 11:30:39 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick
 Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Feb 2026, #11)
In-Reply-To: <877bru72n9.fsf@collabora.com>
References: <xmqq8qcdof3f.fsf@gitster.g> <877bru72n9.fsf@collabora.com>
Date: Mon, 02 Mar 2026 21:30:36 +0200
Message-ID: <87a4wqowpv.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 02 Mar 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> On Fri, 27 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
> <snip>
>> * ar/config-hooks (2026-02-18) 9 commits
>>   (merged to 'next' on 2026-02-27 at 6a04cca28e)
>>  + hook: add -z option to "git hook list"
>>  + hook: allow out-of-repo 'git hook' invocations
>>  + hook: allow event = "" to overwrite previous values
>>  + hook: allow disabling config hooks
>>  + hook: include hooks from the config
>>  + hook: add "git hook list" command
>>  + hook: run a list of hooks to prepare for multihook support
>>  + hook: add internal state alloc/free callbacks
>>  + Merge branch 'ar/run-command-hook-take-2' into ar/config-hooks
>>  (this branch is used by ar/parallel-hooks; uses ar/run-command-hook-take-2.)
>>
>>  Allow hook commands to be defined (possibly centrally) in the
>>  configuration files, and run multiple of them for the same hook
>>  event.
>>
>>  Will merge to 'master'.
>>  source: <20260218222352.55393-1-adrian.ratiu@collabora.com>
>
> Please do not merge 'ar/config-hook' (v2) yet because it still needs
> some work. Can you please remove it from next [1] ?
>
> I just sent v3 yesterday addressing all feedback from you and
> Patrick. :)

Update:

As suggested by Junio, I will rebase v3 and send it as an incremental
patch, no need to revert, since there is no actual breakage in this
series.
