From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Tue, 18 Sep 2012 12:11:58 -0700
Message-ID: <7vsjafm9hd.fsf@alter.siamese.dyndns.org>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
 <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
 <98180D4AA94C468887029389CC535D4F@PhilipOakley>
 <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
 <20120918001522.GA10283@sigill.intra.peff.net>
 <7v7grsqi98.fsf@alter.siamese.dyndns.org>
 <20120918185530.GB20498@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:12:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3DS-00047N-D6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab2IRTMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:12:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957Ab2IRTMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:12:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C853194B0;
	Tue, 18 Sep 2012 15:12:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gterw3mmCsY06IYOJ1arwZWKBi0=; b=RxV6IU
	R5/hSyG3+I0zPvqP7hx3otrHUShCgF5pbKlpkmFiNX/QwTelMbrUo/QHBoxSVt9k
	qpJtg8XvvUYAkdlxnph8xhoUD0N5rnrK+Bk4Y9bN1Vxyqn8zpJ42um8FEZVzshYb
	2hT+Jg/zYcXEfgz4QhaKG6eAnfDJMgxXTg8bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1DHfxqsjb65jJCKV3PmGVOK2GWTs8mH
	o4eJTFHQZblSay/9a9WhezWZtDtMKcvdIEefO10b2tdX7usb7zRaBrg4oR45pWU+
	iJ+JW2pmlbrFDR1AS/heo0JYD2Xx4RIBZOaicH+yl+y3HQG/a8ERXv7kLGn4XDi7
	RMeQvuZNutU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B734B94AF;
	Tue, 18 Sep 2012 15:12:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2234794AD; Tue, 18 Sep 2012
 15:12:00 -0400 (EDT)
In-Reply-To: <20120918185530.GB20498@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 18 Sep 2012 14:55:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8E09928-01C4-11E2-AEC8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205850>

Jeff King <peff@peff.net> writes:

> But even without that, I still think format-patch is a reasonable time
> to do it. It is the time when I proof-read my commit message and patch
> in its final form, and think "do I really want to send this?".

But it is not like "I cannot sign off because I think it is still
iffy".

> seems to me like a reasonable time to make such a conscious decision to
> signoff (or not).
>
>> But your point still stands; "commit -s" will not see through that
>> official trick either ;-).
>
> Yes. :)

Actually, no.  "commit -s" does not have any need to see through it.

	... hack hack hack ...
        $ git commit -a -s
        ... editor opens, you see your Sign-off at the end, with
        ... the cursor sitting on the first line
        ... edit the title, move to the line below the Sign-off,
        ... and do the "---\n\n * comment" thing.

And this survives "rebase -i" (but not "format-patch | am" for
obvious reasons).

So I take it back.  The time you do the "git commit" for the very
first time for this change that may need to be rerolled number of
times is the right time to say "-s".
