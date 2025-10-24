Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640981FCF7C
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328023; cv=none; b=sRdYRNL/kQ7lQZhx+eTlRoIIe3zlgd82zpmeJrlnkbzeVvIUTFzH+2bQ08++lqHDBeYD7rvLBPnOzGVaSqaHw3hvUfvbsfk5etKcW25PBd8eSuOcsD9TxA234v0LnzWBoYvGN8SIERtQrjFr07dDN6nYtRxERqS8mZqfBVxEmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328023; c=relaxed/simple;
	bh=TfbZSH/XBS5JC7xUrgPTxix8/T3OoYeSqYDNiS+lEKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHnfDUQXgtrcxtk8eUcrcWs+gSeUCznPfPtTL8FEdj+tzTtcXwZqYWB3JZI4n69Fhvemd6lVCAaDEy6Rd0EB50uUiD5Ymf754W17bw+kKNNPErxQwFUFJY10uUZaRzXRsnsBgcO2Q+zoFCLC48/d6y7NhyzFX3Oq+rmnX+1kFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cumLN2gV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cumLN2gV"
Received: (qmail 326513 invoked by uid 109); 24 Oct 2025 17:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TfbZSH/XBS5JC7xUrgPTxix8/T3OoYeSqYDNiS+lEKE=; b=cumLN2gVV5HzrJzvB/AURQ1obVUB8bmb+Yuy9b3ohM7IaeSM9eD18LQvQFJUNsJ/M3FwICbnDZdyw1/6KsmsJvQL9BKWHTEujvq/VeKFPczI/OIZaVE5K/tqkHGRah5o3aoL3tJO7mZld80kM5PsBzBkJhqTxcJG3qJxVcxmh9jHJ0qaSVwDoQvn3XXIDY549m5JJpR+/tTANH/d1n8w3hR62CJnYRdOMr4yF1hD5rQ/LQ8X6Di+mBipxQ5AYtNARnkRuaRI3bkRDemDliSUrv/zwph7vrittJfBwX08vXZsXC4tLY8GPJqddh7qVLxBtl0ia3KqAEyjAHm/E0q7sA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 17:47:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 513988 invoked by uid 111); 24 Oct 2025 17:47:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 13:47:00 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 13:46:59 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: "'D. Ben Knoble'" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] Strange git notes completion behaviour
Message-ID: <20251024174659.GA3635620@coredump.intra.peff.net>
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com>
 <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com>
 <013201dc42d5$07a71550$16f53ff0$@nexbridge.com>
 <20251022092708.GE853931@coredump.intra.peff.net>
 <018701dc435f$f1dc1a00$d5944e00$@nexbridge.com>
 <20251023124837.GB1163932@coredump.intra.peff.net>
 <029a01dc450c$4318dfe0$c94a9fa0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <029a01dc450c$4318dfe0$c94a9fa0$@nexbridge.com>

On Fri, Oct 24, 2025 at 01:33:02PM -0400, rsbecker@nexbridge.com wrote:

> What I found is this:
> 
> Git drops into sane_execvp and converts the
> 
> git notes show HEAD
> 
> to
> 
> git show 1aa950256829721750e809788e7b858db79a934a.
> 
> When execvp is called, it immediately fails with a -12 - not returned,
> just terminates. The -12 is an NonStop-specific execvp error indicating
> the process failed because the object is invalid (strange and likely
> an artifact rather than a real problem).

When you say "object" here, you don't mean a Git object, but rather that
execvp() could not run the "git" binary for some reason (so the "object"
here is the on-disk executable)? Just making sure I understand.

> When I use the arguments as presented to execvp via bash directly, I get:
> 
> error: no note found for object 1aa950256829721750e809788e7b858db79a934a.
>
> There is no commit with that hash. HEAD is actually 3fc1917e0e69b23265f5c49f90fdb6f4ed98f4a3
> so git show is correctly failing. This is Indicating that notes is not invoking git
> correctly.

Are you sure you are running "git show" there and not "git notes show".
Because 1aa950256 should be the blob that the note for HEAD points to,
and thus does not itself have a note. And "git show" should not be
looking up notes at all (and the "no note found" message is from
builtin/notes.c).

-Peff
