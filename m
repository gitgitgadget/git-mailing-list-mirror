Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF80C8EB
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460007; cv=pass; b=PMMlScRcCzwAyKEdbiNiQR3Gq4BNP9aRKYD9Vtn2OePy+hgFs7bkuozV+TVmYO8u8+8C9HW3ODEzP5wVgBvqnvFl2REsmKjNaKUKbolqlFIgPqy6dubwic+hnm/td+hyNTI2NtHQbeR3LlE25wn+18t/a8dY4b9eP+YVDuN/IjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460007; c=relaxed/simple;
	bh=hr8aydSNPbpgJEiWwFKttQLr1RYYoGbGLna2TMbBJeU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HfaJ4SpP58HSEgEQ8+TIa4j12XbeOXosfn6wNjAYgnTPt+nWTahVTC0nA2wQY9BzOeOamycC3EXoiv4TX0ZbWPNc0YcZknLQ9yte3CmqLGPYxZm4mAg0ns5F+yElXIAOr1UU4pLvO8l177NdHn7ZCOlXqusTIG2ThMXYg20vlWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=TF9EaBKT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="TF9EaBKT"
ARC-Seal: i=1; a=rsa-sha256; t=1772459998; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Kv/wvIPJVguNRnJWkygSnDp5g4qVQuLg0MjzMX8Txwoi9VFmQ04H1soEqpxrXiUz2QzUAuGEQIjrtt8K2lg1zwlxqHp5TKI6Xr22mbZQ50P42haMNvXHiAKmuno9jM9zlPTxQWHrPMjrbpOP7jFYhQ5B9oj+V+QyuoHpBTCLE/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772459998; h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=5NsbAX7vcNEal6G4pzf36bzA3cydKOJhlR8SG79Zaz0=; 
	b=jrmNdKZ7APyUZykErqhx8KZttNL97Iltvowef3vS5xJdxHWHujX2GZ8+ukt/pI5GsA/H2YLn9S9OC9JemcsiRk+QrZROxokdfpAtNS+VDeKiEWtcXVEGFynt3PWE5aYWtxu2hlCFZtbwGR8RRnZWg8Wodh8/tbfjdwROUAO1idM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772459998;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=5NsbAX7vcNEal6G4pzf36bzA3cydKOJhlR8SG79Zaz0=;
	b=TF9EaBKTWWzDKHfBq1dvd5nPcSFWGILSrUOwDcQ3XeUToPdeSvB9N1yXY/BLQ4Dq
	1XabVVeJdOhRauS70GLlatLvgr0CqRol6kA/SJZet4t0jUIy84XYpsAAvQW6THy0zAC
	0UGwgA1cnMT7W8e5MYSnEgQWvFzPnzgaoMuO97Qk=
Received: by mx.zohomail.com with SMTPS id 1772459997467794.26620615374;
	Mon, 2 Mar 2026 05:59:57 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick
 Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Feb 2026, #11)
In-Reply-To: <xmqq8qcdof3f.fsf@gitster.g>
References: <xmqq8qcdof3f.fsf@gitster.g>
Date: Mon, 02 Mar 2026 15:59:54 +0200
Message-ID: <877bru72n9.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 27 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
<snip>
> * ar/config-hooks (2026-02-18) 9 commits
>   (merged to 'next' on 2026-02-27 at 6a04cca28e)
>  + hook: add -z option to "git hook list"
>  + hook: allow out-of-repo 'git hook' invocations
>  + hook: allow event = "" to overwrite previous values
>  + hook: allow disabling config hooks
>  + hook: include hooks from the config
>  + hook: add "git hook list" command
>  + hook: run a list of hooks to prepare for multihook support
>  + hook: add internal state alloc/free callbacks
>  + Merge branch 'ar/run-command-hook-take-2' into ar/config-hooks
>  (this branch is used by ar/parallel-hooks; uses ar/run-command-hook-take-2.)
>
>  Allow hook commands to be defined (possibly centrally) in the
>  configuration files, and run multiple of them for the same hook
>  event.
>
>  Will merge to 'master'.
>  source: <20260218222352.55393-1-adrian.ratiu@collabora.com>

Please do not merge 'ar/config-hook' (v2) yet because it still needs
some work. Can you please remove it from next [1] ?

I just sent v3 yesterday addressing all feedback from you and
Patrick. :)

This might be orthogonal to the update regression Patrick reported, I
will look into that separately.

Many thanks,
Adrian

1:
commit 6a04cca28e210f0c51cfefcb52475c7ede6e99fb
Merge: d6ebc97cb1 4b12cd3ae3
Author:     Junio C Hamano <gitster@pobox.com>
AuthorDate: Fri Feb 27 15:16:30 2026 -0800
Commit:     Junio C Hamano <gitster@pobox.com>
CommitDate: Fri Feb 27 15:16:30 2026 -0800

    Merge branch 'ar/config-hooks' into next
    
    Allow hook commands to be defined (possibly centrally) in the
    configuration files, and run multiple of them for the same hook
    event.
    
    * ar/config-hooks:
      hook: add -z option to "git hook list"
      hook: allow out-of-repo 'git hook' invocations
      hook: allow event = "" to overwrite previous values
      hook: allow disabling config hooks
      hook: include hooks from the config
      hook: add "git hook list" command
      hook: run a list of hooks to prepare for multihook support
      hook: add internal state alloc/free callbacks
