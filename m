Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB73E009D
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913179; cv=none; b=f0w2wqQxKqIlW1+6nlJgrQpP1OA4nMewlGYRL+3qdbPkB98TMNhtYmdGckHTgB8narhQvWB+KxfliUcXp3pw8QRVe2JcdxVGMVhYD2Wx11G3EcNe/B6ArZJdA0TE8uHZdkFEU0ktUQ8VZJ3L2tSrJG1XvrClcAzwS1VRPNF8zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913179; c=relaxed/simple;
	bh=RZ5TESBkoGD8N7rBe8eZWA06Nz8lajtl/9yukUt1ezU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNG4XmUwAiEwcxlCXBpcpUE8laiTt57YGwsCfPOqeMOvCqKAXR1j1YAFrfe1oXzGvTO5n+mllC2t63x88Q2MJRmHiCuSGOzS5SVOY2J2KmqCW3OdTLZTxgQ8xnzCoTKBIspAcDes8OaxNSV7hIqm7j+B+lG+6DTXMLOrfriRBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hFLr06ZRSz7Qw2l
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 08:59:28 +0200 (CEST)
Received: from [192.168.1.102] (unknown [89.144.223.124])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4hFLqq5S7zzRnlW;
	Wed,  5 Aug 2026 08:59:19 +0200 (CEST)
Message-ID: <82e59e71-5cb0-4a7f-9fc1-e66b367670f0@kdbg.org>
Date: Wed, 5 Aug 2026 08:59:14 +0200
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
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2371.git.git.1785879839766.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.08.26 um 23:43 schrieb Tim Wiederhake via GitGitGadget:
> Allow users to define up to three custom commands each for the commit
> list and the diff display area.  Commands are configured in a new
> "Commands" tab in the preferences dialog, with a name and a command
> template per slot.  Non-empty slots appear in the right-click context
> menu of the respective area.
> 
> Command templates support placeholder substitution (commit id, commit
> title, author name, author date, etc.) and are executed via "sh -c"
> to allow for background execution by appending "&", and pipeing.  If
> a command terminates with exit code 42, its output is displayed;
> otherwise only non-zero exit codes are reported.

Thanks, but this commit message is a bit lacking: it does not explain
why it is a good idea to have this feature, what purpose it servers. For
this reason, it is not possible to tell whether the design is sound and
whether the implementation follows the design.

> Signed-off-by: Tim Wiederhake <twied@gmx.net>
> Assisted-by: Claude Opus 4.6
Thank you for being explicit about AI assistance. Note that this code is
going to be downstreamed to the Git project. Therefore, their AI
rules[*] must be obeyed.

Equally important is that I want to be sure that you have checked and
carefully reviewed and understood everything the AI produced. I am not
going to look at the code until there is sufficient insurance that you
did. (Blatantly put, I don't want to review code produced by someone
else with AI.)

[*] https://git-scm.com/docs/SubmittingPatches#ai

-- Hannes

