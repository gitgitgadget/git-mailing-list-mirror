Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AE2F7EF9
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251485; cv=none; b=ay1Y8k8146XXh4AANJiuWAl6NxW8HvsgeD0+Z7DUXTVQSsTgJnuIbBeDBqJYZJekGxEi/7dtKiLMmA5eH3yieEYgRewK97mazDpJbMRKNAWbxJsrUPOTZ1yqqf1lVkKCDd+0EXDMD71AcVaAPESIPnfwqq/vPWOw4i5j4SiEkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251485; c=relaxed/simple;
	bh=WngOlzoqct66sGomyAGrl9yWq4nm78ASDLDIQ8aE7Ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSTkNFUVFhVkUfwOEwCw+HAijc1HmbCzwbN0zD4EpSdy5GmLfOJiGU9FN2witeTBbr09uROj4A+X11kb1aqcW0oHzL3oEXGbq/3SWk4alhhp6uuJkzf/oxreESROuX/mDtuFUa+OYmKrA1aM4z6AGoQLc/cSBUfL7l1HRwfi3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=a2bUDaUP; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="a2bUDaUP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781251479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sc9e10HKBhQDvfvaP2eg3RLPAKKPeWL8i5IQbirT8R0=;
	b=a2bUDaUPgtjt29ApyIugEKktA2zn35DFnTY3FgkDMxNxk7n8TJVmZadvY9bvtuPwYV9p9R
	VOy2efT+VAjqMhKt7M9XOZx4MXCU6Fc7Fc77QVpcltp2uzZZUsoanoObpftBGF585UCivJ
	OvtBsFs0fuHGpZJhlLLSLI9HpyKAN6w=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/7] builtin/init: stop modifying global
 `git_work_tree_cfg` variable
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-1-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
 <20260611-b4-pks-setup-drop-global-state-v2-1-a6f7269c841d@pks.im>
Date: Fri, 12 Jun 2026 10:04:35 +0200
Message-ID: <87pl1wyyjw.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When executing git-init(1) we need to figure out the final location of
> the worktree. This location can be configured in a couple of ways: via
> an environment variable, via the preexisting "core.worktree" config in
> case we're reinitializing, or implicitly when reinitializing a non-bare
> repository.

Do you mean:

> case we're reinitializing, or implicitly when initializing a non-bare
> repository.

So the second 'init' without the 're'?

Obviously not worth a reroll on it's own.

-- 
Cheers,
Toon
