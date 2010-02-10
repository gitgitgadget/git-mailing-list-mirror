From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 14:21:14 -0800
Message-ID: <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:21:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKw5-0000Iy-Sc
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab0BJWVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 17:21:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0BJWVX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 17:21:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F6B398D0A;
	Wed, 10 Feb 2010 17:21:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DU5uJ8MChWVfPrskgr0U90qIWfU=; b=e3TgvC
	UNYGJvyqgGesLUpGhO7rx1RKxm9yS8dhg5Qzo2sFJ0l+lbI6pWiIRBFu0ki43QmQ
	5Bx/aYqytpLlEFCW4iyCqcQFa5tATaU02hr+F+FpgIXvamPRjiYN/2DENY+/Dl1P
	6x5Wf4PnZk0TriKH1cVCStBVvX+5wYXQckV4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AhHo7RMXGkFdu9F8TRbmNtVQth1+sRC+
	updhrTDkBGBnof5OyxxYwrqZCMWIYRrl150OczsupPo7vv+/gXiVnBbE4FK7zF4g
	ghR1giWFnqo15NTf0KebGdzqQwFpcqn1Deg5nw8zY/Nq/ZROsPBkaL2odLBQNT4c
	UAN4k4ul8CE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE88F98D04;
	Wed, 10 Feb 2010 17:21:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B43CD98CFC; Wed, 10 Feb
 2010 17:21:15 -0500 (EST)
In-Reply-To: <7v63644uoq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 10 Feb 2010 14\:01\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CFE6318-1692-11DF-ADD3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139559>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Hmm. I was thinking "am" was the odd man out, but really there are only
>> two sequencer commands that I noted: rebase and am. So you could perhaps
>> argue that rebase should also learn "--resolved". Or am I forgetting
>> one?

Having said all I did in the previous message, I think "am --continue"
would be a good addition.

And "rebase --resolved" would not make any sense if the reason the control
is given back to you was because you ran "rebase -i" and marked a commit
to be "edit"ed.  Of course, we could add "--resolved" and "--edited" (or
perhaps "--amended") to "rebase", and have it make sure that the correct
one is given.  For example, when it stopped for "edit", it would reject
"rebase --resolved".  But I do not think it is worth the hassle.
