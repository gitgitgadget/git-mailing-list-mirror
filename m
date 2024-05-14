Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77D181BA9
	for <git@vger.kernel.org>; Tue, 14 May 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723446; cv=none; b=lV+nAy+UVlndOVNJPDcuJ7nbUMo52kLSPXZZ0enVRKb24rNNP6wumxUvdUx0l40VqubXQhs2c/91fmOsTzGvEd4cSpFnpLsPZTFrD9bFVMmzxgQ+fjJQKAIDONmEEzoCcyh2/WdXcOQFOjjgfPqMhyVZ3SAaG90x64mgrwUf5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723446; c=relaxed/simple;
	bh=eEXRljTkz4WcftgCdr/pAFkcRFN9ahSdsfjBqRcj08w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iqQHRBC4SzfTDEiBTZLVAX1w2LjDBbc3/6xrECGRoTi6pagbjsvFpJOq9XqAR70UIhbSJf5cbTuKJUJxd4paqnN5XGZH9/R8FC8yAKJ9u4kG+134UV7o1vxxwo2LDcT3mLvXCeru9I+pI907qx+iI+EW3DP7ws+/193RWEdWcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QcJW9cQ5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QcJW9cQ5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D3C3146A;
	Tue, 14 May 2024 17:50:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eEXRljTkz4WcftgCdr/pAFkcRFN9ahSdsfjBqR
	cj08w=; b=QcJW9cQ5ubpT2hyUTARLMMLcb3zGaprJDIX5S3byt+DkqfpvCdIrNP
	c831lOdr1OjwTjaDBHiGCoSVHtqQgt4rMfjt3NdWbaOmcOtZYBWReZGsjevtFzmO
	/UBp0q16F14GK8dKz6oN32yPcXNbI2BdfLkDF1wer03g/oapaAouo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DF1031469;
	Tue, 14 May 2024 17:50:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0973931468;
	Tue, 14 May 2024 17:50:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Timofey Vasenin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Timofey Vasenin <timofey.vasenin@gmail.com>
Subject: Re: [PATCH] gitignore.txt: fix slash-rules example
In-Reply-To: <pull.1720.git.git.1715705582609.gitgitgadget@gmail.com> (Timofey
	Vasenin via GitGitGadget's message of "Tue, 14 May 2024 16:53:02
	+0000")
References: <pull.1720.git.git.1715705582609.gitgitgadget@gmail.com>
Date: Tue, 14 May 2024 14:50:41 -0700
Message-ID: <xmqqseyk2hce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 031146DE-123C-11EF-9FEF-25B3960A682E-77302942!pb-smtp2.pobox.com

"Timofey Vasenin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Timofey Vasenin <timofey.vasenin@gmail.com>
>
> Fix an apparent typo, introduced in:
> 1a58bad014 (gitignore.txt: make slash-rules more readable, 2019-06-04)
> ...
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 5e0964ef419..7142fa10acc 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -100,7 +100,7 @@ PATTERN FORMAT
>     will only match directories, otherwise the pattern can match both
>     files and directories.
>  
> - - For example, a pattern `doc/frotz/` matches `doc/frotz` directory,
> + - For example, a pattern `/doc/frotz/` matches `doc/frotz` directory,
>     but not `a/doc/frotz` directory; however `frotz/` matches `frotz`
>     and `a/frotz` that is a directory (all paths are relative from
>     the `.gitignore` file).

Are you sure this is a typo?

The text added by the same commit (taken from "git show 1a58bad014")
has this passage:

+ - The pattern `doc/frotz` and `/doc/frotz` have the same effect
+   in any `.gitignore` file. In other words, a leading slash
+   is not relevant  if there is already a middle slash in
+   the pattern.

So, if your updated /doc/frotz/ works as described (i.e. match
doc/frotz but not a/doc/frotz), then the original doc/frotz/ should
behave exactly the same way, no?  If you have a good reason to believe
that doc/frotz/ described there should be /doc/frotz/ instead, then
you need to also update that "have the same effect" paragraph.

There should already be an existing test that checks it somewhere
under t/; finding one is left as an exercise (or punishment) to
readers ;-).

It is easy to construct a test case from scratch.

    $ mkdir -p doc/frotz/ a/doc/frotz/
    $ >doc/frotz/foo
    $ >a/doc/frotz/bar
    $ echo doc/frotz >.gitignore
    $ git check-ignore -v doc/frotz/foo a/doc/frotz/bar
    .gitignore:1:doc/frotz	doc/frotz/foo

It seems that doc/frotz seems to work exactly as described, matching
with doc/frotz/foo but not with a/doc/frotz/bar, without a leading
slash, thanks to a slash in the middle.

So...

