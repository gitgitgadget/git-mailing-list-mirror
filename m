From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: [PATCH] Add `%B' in format strings for raw commit body
 in `git  log' and friends
Date: Sun, 04 Apr 2010 18:30:37 -0700
Message-ID: <7vljd2y9c2.fsf@alter.siamese.dyndns.org>
References: <19370.53192.313137.191218@winooski.ccs.neu.edu>
 <m3eiiunbky.fsf@winooski.ccs.neu.edu>
 <7v6346zwu1.fsf@alter.siamese.dyndns.org>
 <19385.5077.27968.796350@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 03:31:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyb9e-0000h3-Fv
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 03:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab0DEBaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 21:30:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab0DEBap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 21:30:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71532A717D;
	Sun,  4 Apr 2010 21:30:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=XFCGRC84Cf8gsgNtg3Zb0DTGerA=; b=lpjFcy
	m0uzygJ5WAZhtVq0vmfCLah4CX/Ar0Hte6OqrR9noj/KpChXEMNqwJGJLzRQ2fRm
	010p3j5WAaFQGx+SMSVR+tavqPdXiLDmPzMPBFOsKZavr/rdYw1kA2OnCXD82bft
	kYub9uifde6q9PIsctaO8MBdSK/CjKcBAX09k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cHsENVFP01Zj4Z8iOjliw7FlF7tGGtbd
	ayuG/B87Y67ethJ9XnaqIDEXBlOBqswYMauwcGgo0ereVOQVzHU3i/dLmbV56Nyc
	wEPCqd4FYbuZDC5XV1xG93PfTBnQtoL9M8y9R1JKOqYbRhC5Makt02a3Cn7dCcZw
	2tYrd9J9HKU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FA6FA717B;
	Sun,  4 Apr 2010 21:30:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B20B4A7178; Sun,  4 Apr
 2010 21:30:38 -0400 (EDT)
In-Reply-To: <19385.5077.27968.796350@winooski.ccs.neu.edu> (Eli Barzilay's
 message of "Sun\, 4 Apr 2010 18\:33\:57 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8C324EE-4052-11DF-AF1B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143963>

Eli Barzilay <eli@barzilay.org> writes:

> On Apr  4, Junio C Hamano wrote:
>> Isn't this the same as "%s%n%+b"?
>
> The problem with that is that it wraps the first paragraph.  So it's
> fine as long as it's always used as a subject line.
>
> (I'm migrating a project to git, and some people will never remember
> to do that.)

Ok, but then "rev-list --pretty=format:%B" would not be as a good tool for
migration to begin with (imagine a log message that begins with "commit"),
compared to say "rev-list --pretty=raw".

It also feels a bit funny to list %B that doesn't do the paragraph
pretty-printing in pretty-formats.txt documentation ;-) but that is not an
objection.
