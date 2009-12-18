From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is
 required
Date: Fri, 18 Dec 2009 12:13:18 -0800
Message-ID: <7vy6l0ujkx.fsf@alter.siamese.dyndns.org>
References: <4B274BDE.8000504@viscovery.net> <4B2B5085.1050906@viscovery.net>
 <7v4onoywws.fsf@alter.siamese.dyndns.org>
 <200912182004.25520.j.sixt@viscovery.net>
 <7voclwxemf.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com>
 <7veimsvz8a.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0912181159u65ae9c6fg1481ab744575475f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 21:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLjQ9-0004m2-PB
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 21:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbZLRUNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 15:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbZLRUNc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 15:13:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646AbZLRUN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 15:13:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83BE58941E;
	Fri, 18 Dec 2009 15:13:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YHtZCXz3rHdF4qclzikxPc3FzM=; b=krJnes
	cPaRuCI0IxmtNOCQDs3/545s8DnrXv+NRyByyQzKFDvVzbojeC/KBsyy7rNAKFVU
	Wn4PssdhZPfsf0su+djhllSDTykYT6uGPss/6VdULT6VhgbzLqujFNHfgJcfVWw5
	8/OPpPvq+HjQKZVcKBZc/qxrqGXfouagWNhPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dLq0kXweAf7xeRVIunn+AM/nnPRTw4F+
	Ww2Rx6+eKsXruI5hUB2Y7S8Bk7VYVdpnX3TdhpbMRcfsS7GkaAU0X5wrX0H5h6gM
	A8ylhf1JGZG7KVtsYWzCfIFmErXjQbBuhzUeuQ0yZAtL0I1Ire7rPe1XAKFeAYX4
	noE3gTHksXg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5978941D;
	Fri, 18 Dec 2009 15:13:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 591F48941C; Fri, 18 Dec
 2009 15:13:20 -0500 (EST)
In-Reply-To: <fabb9a1e0912181159u65ae9c6fg1481ab744575475f@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri\, 18 Dec 2009 13\:59\:50 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB9DDC90-EC11-11DE-96AD-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135435>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Dec 18, 2009 at 13:49, Junio C Hamano <gitster@pobox.com> wrote:
>> You might type
>> "commit" when you meant to say "commit -a" and record an incomplete state;
>> it is "dangerous" in that sense.
>
> Speaking of which, it has hit me multiple times that I craft out a
> commit with 'git add -p' and then do "git commit -am 'foo some bars'"
> and lose all my hard work (because I'm used to typing 'git commit -am'
> for temporary commits). I'd be happy if "git commit -am" learned to
> second-guess me when I already have something in the index.

Sounds like "commit.confirm = xxx" configuration patches are coming?  What
other questionable operations we might want to let users configure git to
ask for confirmation?

> Fair enough, then perhaps it is time for "core.nodataloss" which
> either logs states to a seperate reflog (so that you can go back to
> the state you were in before doing 'git read-tree') or interactively
> informs the user that this will command will result in data loss
> (although that sounds a tad too much like Window's "Are you sure?"
> dialogs).

I somehow suspect that you had your morning coffee yet ;-)  Aren't we
talking about the index, and why are you bringing up the reflog?

More importantly, if you accept that there are non-interrogator commands
in the git command set, I somehow suspect that you will soon realize that
"git config core.nodataloss true" is equivalent to "chmod a-w -R .".  It
might be useful mode of non-operation (read-only historical archive) but I
do not think it deserves a configuration of its own with checks in the
code all over the place that might possibly change any states of the
repository.

"git config user.novice true" to increase the verbosity and degree of
hand-holding is an entirely different matter, but if that is what you are
advocating, you shouldn't call it "core.nodataloss".
