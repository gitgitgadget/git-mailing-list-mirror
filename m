From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Fri, 01 Feb 2013 10:52:52 -0800
Message-ID: <7vr4kzamt7.fsf@alter.siamese.dyndns.org>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
 <20130201050343.GA29973@sigill.intra.peff.net>
 <7v7gmsd26o.fsf@alter.siamese.dyndns.org>
 <20130201073352.GB970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 19:53:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Lji-0001ML-DO
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab3BASw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:52:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab3BASwz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 13:52:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC4FCBA1;
	Fri,  1 Feb 2013 13:52:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4OSFKlsAWQPawXH2gEcK95UBliI=; b=nHVYWK
	0w6jhdSdgb2jtIA2mmAJWM0nyf6BVeHwdi2sm42/+v5tdPSKO8AyeZ3nY95JFRWK
	gcs42fT27KJIb1p8Wlb5GblFdqxvDU7jRuYyLg6PvemiIe4TiVwvL0wIjbYePYBx
	leBbmKEIPHybqrBS9gnqq879TmOL4nqlXjodE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vc3Q14hSbJ+lskY8BCaz8s5x9FaLxjn5
	F69vjDimO3E7CO9RTFmDSzaYHjxqHAkjfMO1JW8fJYxD7aeSb9nNKlXV/7CEZSZm
	M3OZUoAsctL2IXWjCek8U7tTLpC/25Q/r9VGNm+kQFKnl9G4N3uiPdSY0kEk2YBD
	23j5xw+6mr4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 005F9CBA0;
	Fri,  1 Feb 2013 13:52:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61309CB9F; Fri,  1 Feb 2013
 13:52:54 -0500 (EST)
In-Reply-To: <20130201073352.GB970@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Feb 2013 02:33:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 962460B2-6CA0-11E2-B60F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215250>

Jeff King <peff@peff.net> writes:

> Right. So we have some that must be "gitfoo", and others that do not
> care. If we turned "githooks" into "git-hooks" and removed the "is it a
> command?" magic from "git help", then "git help hooks" would still find
> hooks. And likewise, "git help gitignore" would still find "gitignore".
> But you could no longer say "git help ignore" to find "gitignore".

Which I think is a good thing ;-)

> Which personally I am OK with. It is not a sensible thing to ask for;
> the concept is not "ignore", but rather "the gitignore file".

Yes, exactly.

>   4. Replace the rename "gitfoo" above with a "see git-foo..." pointer.
>      Users of "git help foo" would not ever see this, but people who
>      have trained their fingers to type "man gitfoo" would, along with
>      anybody following an outdated HTML link.
>
>   5. Update internal references to "linkgit:gitfoo" to point to
>      "git-foo".
>
> Hmm. That really does not seem so bad. The biggest downside is the
> people who have to see the redirect made in step 4.

Yeah, I see that a show-stopper in the whole sequence.

This is one of the "if we had perfect knowledge we would have
designed it this way, and we could still migrate our current system
to that ideal, but it is dubious the difference between the current
system and the ideal will outweigh the cost of migration" moment,
isn't it?
