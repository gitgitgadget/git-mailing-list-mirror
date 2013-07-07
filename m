From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #02; Fri, 5)
Date: Sat, 06 Jul 2013 21:00:28 -0700
Message-ID: <7vwqp3589v.fsf@alter.siamese.dyndns.org>
References: <7v4nc98jbc.fsf@alter.siamese.dyndns.org>
	<20130707003531.GG30132@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 06:00:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvg9L-00033O-NP
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 06:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab3GGEAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 00:00:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3GGEAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 00:00:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EDDC25AA2;
	Sun,  7 Jul 2013 04:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=br2cit+WglQheZnPL3RPgtosW6E=; b=CcitzA
	gL5IgT6VLP5yi8Aga2l00gag1OuBaeE2Mne2cXKu47kulLQJnlMSB/3Lt8N3p1qr
	dNrKgYTVZrXgsu3szWwgWalFZFjvTaVHr6/EyKZ2N8N8IpJnmikpsyJUINUinw5X
	l1/cNrYCEZttreaD3OydSHUnKmqh0DsBB+GGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0LbJYjsjSeH8STJ1/KBJ5t2Xg+HgHag
	nMNel9jh5cvFLarUaZDHp9kwfrU90qWMwJQeQLuOUFDgiGiuqhWW+lxoGuRnsNVt
	Pb2WMQWjK/BAOhUBEtVtpVAI9sQRjq9kbB4iFw9r6LFHMDnsocDSdw3zRfcEO7Bs
	+9nFZmlXCho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86D3825AA1;
	Sun,  7 Jul 2013 04:00:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D8FE25AA0;
	Sun,  7 Jul 2013 04:00:30 +0000 (UTC)
In-Reply-To: <20130707003531.GG30132@google.com> (Jonathan Nieder's message of
	"Sat, 6 Jul 2013 17:35:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3B531DA-E6B9-11E2-841E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229724>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> We are in the middle of 5th week now in the 11-week releace cycle
>> for 1.8.4 (http://tinyurl.com/gitCal), and quite a few topics have
>> graduated to 'master'.  I'd expect the rest of the week to be slow.
>
> I'd like this or the next release to be 2.0, so the common user
> trouble with "git push" pushing more branches than they intended can
> be over.  Am I crazy?  If not, what can I do to help make it happen?

There are currently three topics slated for 2.0 that changes the
default behaviours in a big way.  The default of the push behaviour
switching from matching to simple is one of them, and it has been
advertised with advice messages since 1.8.0 (Oct 2012).

The other two, "git add -u/-A" without pathspec to operate on the
entire tree, and "git add" with pathspec acting as if it were given
"-A" option to also record removals to the index, haven't had enough
time to be imprinted in users' minds.  The former was only mentioned
in the release notes of 1.8.2 (Mar 2013), and the advertisement for
the latter change appeared first in 1.8.3 (May 2013).

I'd prefer to see users have enough time to adjust to these big
changes, at least 6 months (but preferrably 9 months).  I would say
that the change to the default "git push" behaviour may have had
enough preparation period, but the other two that are scheduled for
2.0 is way too young.

With recent "triangular" addition by Ram, the "simple" mode, the
future behaviour of "git push", was again changed, and has not have
enough time to mature (isn't it still in 'next'?).

Regarding that "simple" thing, I am not sure if the "if you are
pushing to a remote that is different from where you fetch from, we
do exactly the same as 'current'", which is what we tentatively
agreed to implement, is safe enough for new people.  I suspect we
may want to tighten it a bit more (it would update the branch with
the same name as your current local branch, but never try to create
such a branch at the remote, for example).

So in that sense, even the change to "git push" default may not be
old enough for the upcoming release or the next one.
