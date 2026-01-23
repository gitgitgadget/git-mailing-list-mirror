Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D770A930
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178943; cv=none; b=Ks3fBzUIK6fiAXNZ5o+EUS1p9VlCChW+1ScGNa5nA5+NETmOpmoofJOmgSgbt3jQgD/3lf28HExF6z0ztktYeYycfZQ54KsyueSv3Nb9Fx6tA6jdhrTBlHk9KO9Bit9Z3l3sE1zzW9PxF3wriIYEUYdkuLDTt9ZJLmPkjX9G3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178943; c=relaxed/simple;
	bh=bDFkeVJld9kNJzEQrHI6MF39J6UHufqlEkAumf1mqlg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lZztLkMbigWg4wvvWhogBMsxPq8wB7m+55tvvvJfqC88Z7Fr46UMqL3qQt0xIrVm6S6y/SBtgjtoks4+N73L5vbNLlxD0Cczakyayj+YZmjrwWZibANdwA+4bk+ht865iSSSb380hdwk441ahkjeD6UeN+fICahFBVR2TfAi1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ClI1tgJl; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ClI1tgJl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769178939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/StBRPDNAHP5Ays3uqCP4sQgjNWaWT5PIRnlbk6gg8=;
	b=ClI1tgJlLLsiaP6Yw6g/vJ88MGTZxZx2K+LlPB81IfK8cMElK67+hU7aNyCD20GQcMyEJ9
	0RF5CWHbQ/SHuAvwAlSp72JEDa1vihSXvCO1/fFGFa3kkxuMhE7uNdN1owr656HnlzZ9+s
	NCQa6RTKHEFodAwRznrjDkk80hJbd8Q=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #08)
In-Reply-To: <xmqqikcsk5qj.fsf@gitster.g>
References: <xmqqikcsk5qj.fsf@gitster.g>
Date: Fri, 23 Jan 2026 15:35:25 +0100
Message-ID: <87v7gsiehe.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * tc/last-modified-not-a-tree (2026-01-16) 4 commits
>  - last-modified: verify revision argument is a commit-ish
>  - last-modified: remove double error message
>  - last-modified: fix memory leak when more than one revision is given
>  - last-modified: rewrite error message when more than one revision given
>
>  Giving "git last-modified" a tree (not a commit-ish) died an
>  uncontrolled death, which has been corrected.
>
>  Will merge to 'next'.
>  source: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>

Sorry for the late response, I decided to reroll this after all. Changes
are small though.

-- 
Cheers,
Toon
