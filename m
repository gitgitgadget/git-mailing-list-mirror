Received: from karlchenofhell.org (paxle.org [194.26.180.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBBA2B9B9
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.26.180.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524984; cv=none; b=s5N/RhPUkzF5RragoUv8tAgPCe4Hwpw4cVSUPhCgYiturlq+t+M53k+j5xTHFf6TpMeQDwT8eydQr1U7f1SqNHV4GjuofDt2qowTEdeCFaE3Z4yrmC3hcFLhLyaMCSmYoX6OfGIf0pUyNXmJUD8Ul+YdVpwzwTJSj2Kvz6NCSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524984; c=relaxed/simple;
	bh=ATmweMocHrgRL8EWsHKNZ5A/gwlQ3qv+KAuwnZgXGek=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VAeSP2UlfWZUPPywKl7XBzziR1lb2Clm5i30i6eLNmQsR/LrNt5saqdc/gz8K39ZDKdJHD9x/NeGbn7Bc9O1OChP9B1554BMnOq9XRJliY0shMmoBet7IrPN3QhlaaRra44Nrm7vvhJbnSDy7XqSvzUdktdG17dXCnS7CVR/XpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paxle.org; spf=pass smtp.mailfrom=paxle.org; arc=none smtp.client-ip=194.26.180.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paxle.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paxle.org
Received: from cthulhu.fritz.box (pd9fa9fd8.dip0.t-ipconnect.de [217.250.159.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by karlchenofhell.org (Postfix) with ESMTPSA id 647E114A012;
	Fri,  7 Nov 2025 15:16:21 +0100 (CET)
Date: Fri, 7 Nov 2025 15:16:20 +0100
From: Franz =?UTF-8?B?QnJhdcOfZQ==?= <fb@paxle.org>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: git whatchanged
Message-Id: <20251107151620.2663adc25fec743cf1852d32@paxle.org>
In-Reply-To: <671d53bd-952f-4849-9e5e-910e49d4c4e4@app.fastmail.com>
References: <20251107124041.d6aac4345e89a9ac092c59e3@paxle.org>
	<671d53bd-952f-4849-9e5e-910e49d4c4e4@app.fastmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Nov 2025 14:11:52 +0100 "Kristoffer Haugsbakk"
<kristofferhaugsbakk@fastmail.com> wrote:
> This command is being removed because it was supplanted by git-log(1) a
> long while ago. Both commands use the same machinery, just with
> different defaults.
> 
> You can replace it with `git log` in this way:
> [snip]
> See: https://git-scm.com/docs/BreakingChanges

Thank you for the additional infos and the link, I didn't know that! I
suppose when it's being removed, I can resurrect the "whatchanged"
subcommand via the config's alias mechanism (git wh<TAB> is just baked
into my fingers at the moment).

Might I suggest that for future deprecations instead of an annoying to
type flag just a message like "this command is scheduled for removal in
v<VERSION>, see <URL>; use "git log --raw --no-merges" for similar
functionality" is printed in addition to the command still working as
before while it's there? Similar to how "git pull" informs users about
the rebase vs. merge options in case of diverged branches?

Anyhow, thanks again for all your work on this extremely nice tool!

Franz
