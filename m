From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #08; Tue, 28)
Date: Wed, 29 May 2013 10:45:23 -0700
Message-ID: <7vvc61u1cc.fsf@alter.siamese.dyndns.org>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
	<CALkWK0m+t9DPrUbGBnaJ7jTqTVHohGgiiR-bjcTTRNmbT-Oq8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:45:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkRM-0004GU-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934207Ab3E2Rpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:45:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965047Ab3E2Rp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:45:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE06822A11;
	Wed, 29 May 2013 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Xxei9lMPU0p6hSqzqwZtN6cXm4=; b=cgafL9
	AekI87nX5uCU82BfRymNedgMJmCDRcnQXRNfeAdfURsSBElKvLRtNFaM0y9RSTxh
	Svayluda2ZNAaNjEtRjB+kGUa7Gkub+7qYOBAyZBT9THtdXp+x4oLTDHpIdF/VDR
	dL1X7Yv57ehea9iUcQFhbBj2XmTGvWkSsxnqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X/QS8BKI46r+M/U0j8WDuBOQfMbIDE+K
	p+lxmpXDLwWP7MDuBtdpqJVVFHRB+S446N1Brn4NvIl0nnR46BUQRHQOdtmqo6Mb
	vCDILdjNI3KQnjrY/D5rve2YDtof2veoEIB9Ij2vC6kHeWlStPmsbcykEgQJrbW9
	/efhXPPm7IE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C385822A10;
	Wed, 29 May 2013 17:45:25 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BC0922A0D;
	Wed, 29 May 2013 17:45:25 +0000 (UTC)
In-Reply-To: <CALkWK0m+t9DPrUbGBnaJ7jTqTVHohGgiiR-bjcTTRNmbT-Oq8A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 29 May 2013 16:57:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AF3A354-C887-11E2-BCFD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225851>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> * rr/die-on-missing-upstream (2013-05-22) 2 commits
>>  - sha1_name: fix error message for @{<N>}, @{<date>}
>>  - sha1_name: fix error message for @{u}
>>
>>  When a reflog notation is used for implicit "current branch", we
>>  did not say which branch and worse said "branch ''".
>>
>>  Waiting for series of rerolls to settle.
>
> I'm happy with the version in pu, and I don't intend to send any
> re-rolls.

OK, then I'll take a final look at it (I may or may not have
comments after doing so) before merging it down.

> Is there something you're not happy with?

By the way, you probably should stop thinking in terms of "me" being
(un)happy.  I am just trying to help by preventing (collectively) us
making silly mistakes.

> * publish-rev: the @{push} thing is still in the early poc stages.

I presume this is the one that may someday lay foundations for Tytso's
"do not rebase beyond this point, as I have published it already"?

> * for-each-ref-pretty: not ready; working with Duy.

I haven't been paying too much attention to it, but my impression
was a "superset" syntax is coming?  That would be going in the right
direction.

> * push-current-head: ready but for the commit message: in your
> opinion, it doesn't "fix" anything other than the output.  I'll
> rewrite and submit soon.

I do not recall what this one is about, but we'll see when you send
it out.

> * pickaxe-doc: you had some more comments in latest iteration, but the
> returns from a re-roll are diminishing.  Frankly, the work is too
> boring: the first few iterations were interesting, because I was
> learning;...

Yeah, some parts of the project is boring and that is not a news.
Think of documentation updates as helping others to learn.
