Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947E2586E8
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070843; cv=none; b=Yapu0H6ULwzyfqRvFXCko6/oGM0oc3MAh0QumJUwwvMtB6Jxg6Rgyg8AMiHVLQAFwKWMIlQAQrZsq1LE4vSugE9MDF/qOKJ/Kz+pIkDQDzfn3xyvBfTnumndJqUFRkdPju2GgcxATsf5gC9KOcTSANh6yNBX93Ji8thO3bHS0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070843; c=relaxed/simple;
	bh=dNRtFr3wyUpJbDfo8prBsYg3S5tE1nofoprO6WhGIgc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SNAiRyEmfs1Yqnaj4062TgPX3ZHMSntp8OOfAIubB3ttu2rGq3ZqUVCyeEz82ZZ2/cNPNJHIbmD/loYk3a+jWlXTKv4KRBflTu8QFvi5nqps8loaSt9Fj89+8gev01o1xjXkefeIxu0DpU8AMgo8sQRJPLsYPRLINC5tjU5j5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=FXS5oTip; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="FXS5oTip"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764070836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=maxOBN/+cvanD0riwF+6/444eqsh1MoCJEIkkQv33wg=;
	b=FXS5oTipEhQQ2PRxNDmHvKeqOr5KXU1UFMb6gdga4Z/T5OBk8LGWAOkNIMZ3GWKt+PdIf6
	xonJram2UHSLV++aL97Ge1YDVu/bGe+SqsquE9amdV1QLtvr4/PVIKOJT7BSxRbddG81+3
	5xcasQ1IZQ6k8a5F6oVudd9VFxvyrcM=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #07; Sun, 23)
In-Reply-To: <xmqq5xb0yqj9.fsf@gitster.g>
References: <xmqq5xb0yqj9.fsf@gitster.g>
Date: Tue, 25 Nov 2025 12:40:17 +0100
Message-ID: <87ldju5oim.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * ps/object-source-management (2025-11-18) 14 commits
>  - odb: handle recreation of quarantine directories
>  - odb: handle changing a repository's commondir
>  - chdir-notify: add function to unregister listeners
>  - odb: handle initialization of sources in `odb_new()`
>  - http-push: stop setting up `the_repository` for each reference
>  - t/helper: stop setting up `the_repository` repeatedly
>  - builtin/index-pack: fix deferred fsck outside repos
>  - oidset: introduce `oidset_equal()`
>  - odb: move logic to disable ref updates into repo
>  - odb: refactor `odb_clear()` to `odb_free()`
>  - odb: adopt logic to close object databases
>  - setup: convert `set_git_dir()` to have file scope
>  - path: move `enter_repo()` into "setup.c"
>  - Merge branch 'ps/object-source-loose' into ps/object-source-management
>  (this branch uses ps/object-source-loose.)
>
>  Code refactoring around object database sources.
>
>  Comments?
>  source: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>

I've read through the patches, and I've got no comments to add.

-- 
Cheers,
Toon
