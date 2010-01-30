From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:45:15 -0800
Message-ID: <7vaavw1478.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <hjvgs1$rep$1@ger.gmane.org> <ron1-953427.13240429012010@news.gmane.org>
 <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com>
 <7vmxzwh906.fsf@alter.siamese.dyndns.org>
 <ron1-6C7BCB.14122429012010@news.gmane.org>
 <b4087cc51001291633l68760880i340d12e865641077@mail.gmail.com>
 <7vvdek70ma.fsf@alter.siamese.dyndns.org>
 <ron1-FA4289.22165129012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 07:45:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb75X-0008PA-DI
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 07:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab0A3Gp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 01:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542Ab0A3Gp0
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 01:45:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0A3GpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 01:45:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 821F4959C3;
	Sat, 30 Jan 2010 01:45:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+lEVRcsgwctblJaE6rA8krH++9E=; b=hD+/ZJ
	zXBGoH1D8ZoyIwT7j0CK6oCBZ3PFOWphfibTq0K1XknWosd3H0Uk8rFCnD8oFVaX
	jPXIC73PfgPIWmBgBEY/Aik57eY3I98ha9WhvVNUmLrGjWXKtWrxvKMNxdNk8Yi/
	SOHKDIgGqY2uC2aq6UGCtyQQw1hQpF2yhW2jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HPXG71okUQcNMjfnE6bzBnjylNej0RR+
	UmjUoFWUm6Cnvh3YKriIcJ57G+1S6A/D3DHArUfyD8fDTfzSdBROLkAONLV6RM+z
	kNqRwcy7YKal6F+Jvf2kLUbCWthPKqn2Wq9GU84qqZ3mrwXhswtCXUYIXp0iUC01
	8cKtq7Z3PiM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 547D8959C0;
	Sat, 30 Jan 2010 01:45:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EC60959BE; Sat, 30 Jan
 2010 01:45:17 -0500 (EST)
In-Reply-To: <ron1-FA4289.22165129012010@news.gmane.org> (Ron Garret's
 message of "Fri\, 29 Jan 2010 22\:16\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 08B3C9EE-0D6B-11DF-8508-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138456>

Ron Garret <ron1@flownet.com> writes:

> No, because it would make it much easier to map intent back into a 
> command that implements that intent.  Don't forget, this whole thing 
> began because I wanted to do something very simple, tried what seemed to 
> be the obvious way to do it, and stumbled accidentally on an advanced 
> feature.  That would not have happened if I'd been able to just do a git 
> update --tree master^.

Doing that _will_ confuse you in your next step.  Can you explain what
happens if you run "git commit" from that state, why "git commit" does so,
and how that is useful?

You may be too narrowly focused on only one single step, but I am more
worried about the whole user experience: "I managed to do this, I am
happy, but then the next step doesn't make much sense.  Now what?"

> What difference does that make?  Sure, there would be ways to shoot 
> yourself in the foot with git update, but there is no shortage of ways 
> to shoot yourself in the foot now.

As long as you have a coherent picture of the workflow individual commands
are supporting, there is no "shoot yourself in the foot".  "git update" on
the other hand is _designed_ not to allow such a coherent picture to be
formed in the user's head, by letting random combinations that may or may
not make sense.

> BTW, nothing prevents you from providing the usual repertoire of 
> higher-level functionality as thin layers on top of something like git 
> update.

That is more or less the same as what I said in the footnote, which you
didn't quote from my message.

The flexibility of "update" may help Porcelain writers to pick and use
only useful/usable combinations to present "the usual repertoire" for end
users.  At the philosophical level of "building blocks", I do not oppose
to such flexibility [*1*].

But.

As the main point of Michael's message was that he thought it may make
things less confusing to the end users, I am pointing out that unleashing
such an uncontrolled flexibility directly to end users will _not_ help
reduce their confusion.

[Footnote]

*1* As a set of "building blocks" to implement "reset" and "checkout", I
don't necessarily agree that "update" would be a good way to go from the
implementation standpoint, but that is a totally separate matter.
