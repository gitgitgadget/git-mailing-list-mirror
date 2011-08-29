From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that
 start with slashes
Date: Mon, 29 Aug 2011 15:22:55 -0700
Message-ID: <7vwrdv503k.fsf@alter.siamese.dyndns.org>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
 <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu>
 <4E58710B.60507@alum.mit.edu> <7vty92adv0.fsf@alter.siamese.dyndns.org>
 <20110829185011.GC756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 00:23:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyAEQ-0001Ke-Pg
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 00:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab1H2WW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 18:22:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56699 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab1H2WW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 18:22:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291AC4F94;
	Mon, 29 Aug 2011 18:22:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=79udPzLceT4tMyjDN4svrWVMb/c=; b=a2X3fs
	7KtzUSShUNq7pJIbjlQiU5Spg8dASFhloVC0L93WjzP73u3DXHqVROnNe4OcwZSr
	t++pIw86uRNEWPaZ5QavohGyi6kXQBMsKPMa19irNBGxWS4t9Er/Jg1qU1s/8k7X
	4TT4JrCCGH/1pvGEW7DJNUbybmTzaX+f934dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SVtl2EGzmWP7RJfK1xaViDB4HVqdFvdG
	PAn23njVfo363VstgiocFwpYvZnZyHHv1+nhIkAUsAN+NOzxaAB0ajZEpmezHoIg
	XlQOcbg4HiHnmh2sXiQE9BIOb0QXb+w2ce5WuQSEdPh7z2NKKHmZKnQblz+8D/Kj
	Ll5ogL8Qiwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 206344F8E;
	Mon, 29 Aug 2011 18:22:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A68A94F89; Mon, 29 Aug 2011
 18:22:56 -0400 (EDT)
In-Reply-To: <20110829185011.GC756@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 29 Aug 2011 14:50:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 720F3C00-D28D-11E0-827F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180368>

Jeff King <peff@peff.net> writes:

> ... I always assumed that you did one of:
>
>   1. Comment on the patch via email, just as any other reviewer, so it
>      can go into the re-roll.
>
>   2. Fix-up the patch or commit message during "am", with the assumption
>      that it is ready to be merged at least to "next", at which point
>      re-rolls are no longer OK, anyway.

Not really.

I usually amend patches queued to 'pu' (or queue fixup! separately) when I
am reasonably confident that my suggestion had enough merits.  Also I roll
in suggestions that are obviously (to me) good from the list, which may or
may not be the same to the list concensus. Maybe I should try to be less
aggressive.

> I mentioned "it takes effort" above. I don't mean "submitters shouldn't
> be expected to put in extra effort". But we should make sure the effort
> is well-spent, which means:
>
>   1. Giving them some indication that you tweaked things during
>      application. It doesn't have to be an inclusive list. Even saying
>      "Thanks, applied with some spelling fixes" instead of your usual
>      "Thanks" is enough (actually, I think you frequently do so
>      already).

Just started consciously doing so yesterday, after starthing this offtopic
therad ;-)
