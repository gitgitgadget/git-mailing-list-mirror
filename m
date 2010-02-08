From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 08 Feb 2010 14:48:05 -0800
Message-ID: <7vpr4f9wey.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> <7vtytrih7b.fsf@alter.siamese.dyndns.org> <7vvde7h1mn.fsf@alter.siamese.dyndns.org> <20100208213256.GA470@coredump.intra.peff.net> <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:48:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NecP1-0004p6-Ni
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 23:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab0BHWsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 17:48:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab0BHWsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 17:48:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A6AB98F79;
	Mon,  8 Feb 2010 17:48:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+7cJ9jPy6/Jj+8V/2PQin1tZdjg=; b=sHHmS8
	ivrXZUMQP/Y00mYkSATdEqokXj3B0Ef+6WiBysXv+s2ESMoBAD6RzQFC5ZFIAcZd
	FEgkSoxyLZ8gXXpMmSB7iWvSBJKFdku2v+dsV2agUnYCzcKG/rQfZiPuW75kCMew
	6pn2KxXMTQ5yxtb84XG1ku7nbCh1FayzwMSOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZW01Q2ry+2Y9oM2wNo3YGx4z56litQMh
	tOt3m759VXK8R4pmiHfRbkiSGXcc07pNszaq/lo8TiavdY95zZfG7GERj4LIdBBN
	RL+XXN/RfYmZClmTMXz/0UyTE0U0d9fjjHR5yjezvfv+YTYTDR3RbpVM32jL478D
	TZvnL9+A2G8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CBBCD98F78;
	Mon,  8 Feb 2010 17:48:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 008E298F77; Mon,  8 Feb
 2010 17:48:06 -0500 (EST)
In-Reply-To: <20100208223107.GB21718@cthulhu> (Larry D'Anna's message of
 "Mon\, 8 Feb 2010 17\:31\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 08523A62-1504-11DF-B855-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139329>

Larry D'Anna <larry@elder-gods.org> writes:

> also these
>
> X TAB ...
> ! TAB ...
> * TAB ...
> + TAB ...
> SPACE TAB ...

Is this documented anywhere?

Much of what your patches in this thread tried to do does not interest me
very much rignt now, i.e. during the pre-release freeze period [*1*].

If you are already showing '*' and '+' without telling the users in the
documentation, it is a much more urgent issue that needs fixing, and it
would be preferrable if we can do so before the release.

Documentation/git-push.txt seems to say that only ' ', '!' and '=' have
any defined meaning:

    flag::
            A single character indicating the status of the ref. This is
            blank for a successfully pushed ref, `!` for a ref that was
            rejected or failed to push, and '=' for a ref that was up to
            date and did not need pushing (note that the status of up to
            date refs is shown only when `git push` is running verbosely).


[Footnote]

*1* As I hinted repeatedly, I think many of them are mere churn, except
for "don't advice porcelain scripts" (good) and perhaps "exit with failure
status upon only this kind of failure" (I am undecided).  Especially I
want to see the "send advice to the standard error stream" one as a
separate patch, if you insist including that change in the series.

But they are something we can decide after 1.7.0 happens.
