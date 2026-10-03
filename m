Received: from heron.birch.relay.mailchannels.net (heron.birch.relay.mailchannels.net [23.83.209.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E838E8AC
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791060946; cv=none; b=KqI8bUqH9wRhw0wpnwpH3nG/HeelUihfyPZHul18wZFQsrBnGXlW9t/3a0XtlRTRi0f+iIV7AVV+/iAIOQ+/8E43fOtN/dcp4Sio93al1NmLWTnWHfsw9Kqaw5rtDrh60QXLQCF0JB2IrChwh2R+lLKSS+iOmOS3W9dM4WFeCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791060946; c=relaxed/simple;
	bh=FJBfrXlheAoKmjyjwRA6DlxcVZWbzy5kQPgCqWVxjU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxAqkPsuZaMmOKNexXXzvWZ8cpQ/zUcKUBQqNMHn8gEpm9/C+yx1foIG+i7zyRRVNOTaREgX/sg2r+Xb4Bpk2zAhrsVE0ULw414wzSrSIFKxxzF1VOSCCCtSjqfWqa+MKgZYLoXGZQYml0CqnKa2xLeoNdGeQhGUFkPUG8f83bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=S+i4HcxV; arc=none smtp.client-ip=23.83.209.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="S+i4HcxV"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3F9614C1C00;
	Sat, 03 Oct 2026 20:48:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-96-12-87.trex-nlb.outbound.svc.cluster.local [100.96.12.87])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 083134C1120;
	Sat, 03 Oct 2026 20:48:49 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Abortive: 573221712a1926b7_1791060529106_818890491
X-MC-Loop-Signature: 1791060529106:2372144120
X-MC-Ingress-Time: 1791060529106
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.12.87 (trex/8.0.2);
	Sat, 03 Oct 2026 20:48:49 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hxyRh2DNjzPw;
	Sat,  3 Oct 2026 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791060528;
	bh=7FBQmtTIsR8Ikb0CrYQmneNngVP7lHp07iXv+yVmHZ0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=S+i4HcxVWSCrvaFbFcuaaDe586eUN7b7dRHGUSqrBvY5T41rTDu1rTcHf12QZdJVT
	 aSYvBaM7nBWZitPmXkh+4/wRc1feoaAz002CASnEBb2J0pS4l/OsYt4oqGSQwwK/U3
	 exdSwTdH3H9OElXXHldUFBO1oyI1Xu3mIIp2G0kKSB5GU2qo6QM861KJ/9Flgbrdkd
	 Pb0q3eC+o94Sw4ux92qMhSXr7p742lNQclK9YHuaOLdlJNw8JthDfHBTCCK78uswK7
	 3lnHGvNlJyoUj5fjHTCbKw150ua1y+fbG61A1fHGwcBjivn4bcWa5UzGhrJSXUc0Ih
	 h6N3YBl+SjIgg==
Date: Sat, 3 Oct 2026 15:48:46 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ben Boeckel <mathstuf@gmail.com>,
	Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFqLv3hMEE7yEOC@ubby>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asFoDZKscLKqaIf+@ubby>

On Sat, Oct 03, 2026 at 03:39:41PM -0500, Nico Williams wrote:
> that it deserves a name.  But also, `git-rebase(1)` should always have
> been this useful, so that argues for this to be either... a new option
> like `--onto-first-conflict`, or even a new default behavior.

I.e., maybe if I run `git rebase $upstream/$branch` and there's
conflicts then it should do this bisection to drop me at the first
upstream commit to introduce conflicts, stop, inform me of this, inform
me that after I finish resolving conflicts I need to run `git rebase
--continue` until that's done, that I should then `git rebase
$upstream/$branch` again.

Additionally when `git rebase --continue` finishes successfully, if
we're not at `$upstream/$branch` then `--continue` should run `git
rebase $upstream/$branch` directly.  This means recording the target
committish along with other git rebase state during the rebase.  This
would feel very natural to me.

If we take this approach then we'd need an option not to enable this
behavior but to disable it, something like `--direct`.

The more I think about it, the more I want this approach to be the
default for `git rebase`.  But maybe there's a good reason not to?
Maybe first ship the option, then later make it the default?

Nico
-- 
