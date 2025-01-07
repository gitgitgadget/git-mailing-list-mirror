Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D41F76A3
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284513; cv=none; b=ElDlENvWg7FHlXkjw7ArQM6f5uPsNk0H+p6Qftq3xUwSrvzLE1Qpw4NnvhdRDSzZEqXSlwGe9bVYHifSO5BOvAiRHXQCZi/zR9u0Ws9cyeHYJosoadlfCyQonluHPteWb6fK3NxmJLKZ3+giKfRzP8TIydd9p5K6tSZWYzpAV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284513; c=relaxed/simple;
	bh=guvjPdGIStvuAy2Ez7NfPPOMup/0pUTChI5LFM2xGgs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJinOiVVxNEDDFni8u50KaiEkpCg3+0+AEI1rhC/8N5kuNOUimEfnZHfGM5h/JHO0/ijHe4AlX8zRedL9+tXiw6QWhxeXVqGkmudgbJ48sLC4VXwRGvwgSd4wyUXRx6DHSf125cqVS6eIclQ0CpG0hK1sxQhSJVUsj9OTaRhEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mVPY5c6d; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mVPY5c6d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1736284509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c4/+GKVCqx6bu6NyZiwAdU/A+BTrCPE1btIbHZanfBU=;
	b=mVPY5c6daz4M1pQrTEPIs+/XRL9KW7dEOcyCJhhp4VZiaI2Bi0X8hRfWMyLm/7oFSlLQhD
	piVzM2VvsEbbW8q5djQ2MKnKmnBPGOWvFSsfeT+ws2ihEfXfnvJPH/UzRIsiMxCPP8bJFv
	kisH+B9LPgdUzm07y1t/6yE3k/qJhuc=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #02; Mon, 6)
In-Reply-To: <xmqq5xmryalp.fsf@gitster.g>
References: <xmqq5xmryalp.fsf@gitster.g>
Date: Tue, 07 Jan 2025 22:15:00 +0100
Message-ID: <87o70ijpgr.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * ps/the-repository (2024-12-18) 15 commits
>  - match-trees: stop using `the_repository`
>  - graph: stop using `the_repository`
>  - add-interactive: stop using `the_repository`
>  - tmp-objdir: stop using `the_repository`
>  - resolve-undo: stop using `the_repository`
>  - credential: stop using `the_repository`
>  - mailinfo: stop using `the_repository`
>  - diagnose: stop using `the_repository`
>  - server-info: stop using `the_repository`
>  - send-pack: stop using `the_repository`
>  - serve: stop using `the_repository`
>  - trace: stop using `the_repository`
>  - pager: stop using `the_repository`
>  - progress: stop using `the_repository`
>  - Merge branch 'ps/build-sign-compare' into ps/the-repository
>
>  More code paths have a repository passed through the callchain,
>  instead of assuming the primary the_repository object.
>  source: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
>

Reviewed by shejialuo, Karthik Nayak, and me.

--
Toon
