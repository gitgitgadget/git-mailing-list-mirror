Received: from cyan.ash.relay.mailchannels.net (cyan.ash.relay.mailchannels.net [23.83.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74104A68BC
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881201; cv=none; b=Wh3E3BROk3Wpp+hPNgR9miaBvdSnSrRG6G3qPXT/jnPW45kNY8Dk6GxFm6yQNx43OxKzbLgfuxTBTqI2w7dDyfZKH7LvuH9bIdfYrZWmRM5ERbCztJepGs55JFUNfY/P+GIUb3Jb3x2hu2EzEYySaSOIOwMFautt4Na+AwVMpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881201; c=relaxed/simple;
	bh=zwZd5eAjzMpbHXDLwmgbU2qIPe9Hr/YO0Bw1E3YCdTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9kkIABGsPDPeUjn3HKTnKSVw6XgA2WnXnjnw+nj17EoJgxlnYcO11XEmm5GBVMgYL5YpiYH0s29qt+hzB695Ch1k1W90/K3LaaFrw51GEOuO9tGCPznnthLJoCjUOzDwimG7kquFEaOABh6fk/j1davqDIbnuwkq2RnrhcYzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=qzhIqXuF; arc=none smtp.client-ip=23.83.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="qzhIqXuF"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3AF987E1192;
	Thu, 01 Oct 2026 17:40:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a215.dreamhost.com (100-96-207-69.trex-nlb.outbound.svc.cluster.local [100.96.207.69])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D3BCB7E1349;
	Thu, 01 Oct 2026 17:40:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Slimy: 2847fc9141b61428_1790876407103_835002839
X-MC-Loop-Signature: 1790876407103:1035435168
X-MC-Ingress-Time: 1790876407103
Received: from pdx1-sub0-mail-a215.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.207.69 (trex/8.0.2);
	Thu, 01 Oct 2026 17:40:07 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a215.dreamhost.com (Postfix) with ESMTPSA id 4hwfLp2Wntz4D;
	Thu,  1 Oct 2026 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1790876402;
	bh=9dtnRrQJXAqxcYyqUuJjOLi/enMh7pZ0cR4oOW4S1Nc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=qzhIqXuF6/s830V2x5yj8/e51GAFB50mnzwEyhevlmBL//Ee/B8vWe7Y+Q3a5jRwZ
	 t5rT7Pd/3RGMoJPVNyHQn7vL4tyaKWzKg9Ft/ai5Nk8180S7X0QF86aSEruONdJXGT
	 4FWx185kqb7BVeG0L5ZiqMhMrD8XCsFwAOX/AQB7V/kvi6M/1niiLcNPtNsZQTur9a
	 QAVi031S6iOFV5oEnqI3HlkQY60um/PH2yOkjPgEzDPZN7mQ4sBDsw/548RxqaHcq/
	 7D8FQg13N/u2MI0u4fNP/9je/OWk0dwzqFl1UnXdnHM/kUlA40oBAY41c+BN9KF/b1
	 OLtlrHTNiZGDQ==
Date: Thu, 1 Oct 2026 12:40:00 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar6a8OkGhmYVoM7E@ubby>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar6GExDLasWWFajm@ubby>
 <ar6LUeH3AjxbiMgd@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar6LUeH3AjxbiMgd@debian>

On Thu, Oct 01, 2026 at 06:50:08PM +0200, Alejandro Colomar wrote:
> > Also, you need some extra handling of conflicts.
> 
> No, that's the nice part.  It works as is.  When I see a conflict, I get
> stopped at the rebase that caused the issue.  I solve that conflict, and
> then can --continue that one rebase.  Or I can --abort that one rebase.

Oh, because of `set -euo pipefail`, hah, yes.

> > https://gist.github.com/nicowilliams/ea2fa2b445c2db50d2ee6509c3526297
> 
> Hmmm, 93 LoC is certainly more interesting than the 4k+ python script.

There is that, indeed.

> I'll have a look.  I'll also attempt at writing a bisect-rebase from
> scratch myself, to compare.

I love that attitude!

> I'll certainly try your script; thanks!
> 
> Out of curiosity, did you offer this script to git(1)?

No, though I think I've mentioned it here before.  I'd be happy to
submit a patch, but I'd first have to get employer approval for it
(which is not a problem -- it will only take time).

> If not, why not?

No real reason other than bureaucracy on my side.

> This is something that would clearly be helpful to people solving rebase
> conflicts in many projects.

I agree!

> Have a lovely night!

Cheers!

Nico
-- 
