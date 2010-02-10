From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 14:34:21 -0800
Message-ID: <7vpr4c200i.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:34:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfL8p-0001Pd-2N
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab0BJWee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 17:34:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0BJWed (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 17:34:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5E6098FAF;
	Wed, 10 Feb 2010 17:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=37CXdTTfQBCU4DrJ8V+MKJmmpg0=; b=sBhdTw
	e52+p0K2rf9DFrAMeGmZ3Cd3fJ6/3x94qqzY2Oj+d4A8K1aD4YFjS62Z5uE976sD
	CYeG8BXS0Y3z/BtsV5NGGdXXdIXnhWnxl3jwdgidqR8kQsphpaPujqFcL+Oyz8Vs
	S8o1zwu9o5p/P8aTLcVa3GtdD3k/X//2cak/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uABtYGvF8cNzKblHElXb6z1kRFRMrqwM
	J9Ujwr8YF4wOA7iX6km+SYIU+tNr59JmlCWuM861U54g7qpPA+nyJBY2MBeTina8
	4iHOvdoUpFVbPlCdProi2mFceT8T6jvif7OQ0pvn9GZaK7m5MJLQBJj1NYGJZiKD
	BD9o82oMpmU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82AB598FAC;
	Wed, 10 Feb 2010 17:34:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC0D398F93; Wed, 10 Feb
 2010 17:34:22 -0500 (EST)
In-Reply-To: <fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 10 Feb 2010 23\:23\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71CE6D8A-1694-11DF-94F6-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139564>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Wed, Feb 10, 2010 at 23:21, Junio C Hamano <gitster@pobox.com> wrote:
>> Having said all I did in the previous message, I think "am --continue"
>> would be a good addition.
>
> How about 'cherry-pick --resolved' though ;).

Changing the insn to suggest using "-C topic" when the original command
line was "git cherry-pick topic" would be a good addition, too.  Currently
we suggest "-c" and abbreviated object name, neither of which is sensible.

While I think "--resolved" makes sense, I do not see much benefit, and it
largely depends on what you do.  If you are suggesting to commit with what
is kept in $GIT_DIR/MERGE_MSG, I would actually recommend against it.  The
message will have "Conflicts:" information but that is meaningless unless
you are recording from what context the commit was cherry-picked from at
the same time.
