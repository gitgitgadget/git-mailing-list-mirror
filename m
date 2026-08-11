Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D803803E3
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473816; cv=none; b=gMwSBwz/adDDn92OMLH/lpbUlvgKZa3WX+5weXtxNJEgLlrUUDi9UYqWCG0R9P0MzCvEcmfxQ+V0Y3Vo0YXsIZyjYl5SxllyT/jOBYckxYvS+2aI0vsVrKz2SyRML65lH8aieVSxwKJ8b3ArqgMjGUoW9mjKMoLuv8gK5bo/C1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473816; c=relaxed/simple;
	bh=OWsVN2I6wnTXuuIKbBOg/6EWRZ9QYbLIKBM6HNl6zao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABqLvKgoceN+IQtwGbX7fRaregeb21aFB5ltX7B7Fh05GuMYSMClVSUrwuB+IzsHATM09df5tIIoKVq8+lrKuvLM0ipuUKKUB/FNesVrdZdEujx+iJJH210n8+pGZTbHmlqecF4Z1RRvk0Qr/GRDQJ76ImYNEpNDj197l7O2nKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.103] (unknown [89.144.223.124])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hKL9S69xszRnmG;
	Tue, 11 Aug 2026 20:43:24 +0200 (CEST)
Message-ID: <84dd36eb-bc7c-4a35-b0c3-238e6d3c08ed@kdbg.org>
Date: Tue, 11 Aug 2026 20:43:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: add user-defined custom commands
To: Tim Wiederhake <twied@gmx.net>
Cc: git@vger.kernel.org,
 Tim Wiederhake via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2371.git.git.1785879839766.gitgitgadget@gmail.com>
 <82e59e71-5cb0-4a7f-9fc1-e66b367670f0@kdbg.org>
 <76636876b815ac4aaac77eb7b772e2e55234e11a.camel@gmx.net>
 <00ed1592-b2cf-4844-8174-fb087fe0b0fe@kdbg.org>
 <ba558d0c5e08190b4a130efe43b5644c8c0bd571.camel@gmx.net>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <ba558d0c5e08190b4a130efe43b5644c8c0bd571.camel@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 10.08.26 um 21:38 schrieb Tim Wiederhake:
> I think there may be a misunderstanding about what this patch does. I
> am not proposing "add an edit-file button to gitk." I am proposing "let
> users add their own commands to the context menus." The rebase+edit
> workflow was an example of what becomes possible. It is not the feature
> itself.

I totally understand that you are proposing a way to supply generic
commands, and I do not ask for something else, but I was a bit too terse
in what I said. I meant to say that you can use "invoke an editor" as
the justification for the generic command that is called from the diff
panel. And "git rebase" can be a justification for a generic command
called from the commit list. (These two kinds of commands should really
be added in separate steps, BTW.)

> Shipping it with only %f but not %i or %t would produce a half-useful
> extension system that nobody can actually use, existing only to satisfy
> the review process.

You already get something very useful with only the %f (filename)
substitution, because it can invoke an editor with a suitable file.

Do not underestimate the review process. Presenting the features in
digestible pieces is absolutely beneficial. The substitutions lend
themselves to be their own commits each (or in small groups per commit).

-- Hannes

