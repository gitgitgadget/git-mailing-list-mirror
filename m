From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] pack-refs: add fully-peeled trait
Date: Mon, 18 Mar 2013 08:12:38 -0700
Message-ID: <7v8v5kpwrd.fsf@alter.siamese.dyndns.org>
References: <20130317082139.GA29505@sigill.intra.peff.net>
 <20130317082829.GD29550@sigill.intra.peff.net> <51468615.70503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 18 16:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHbkJ-0004md-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 16:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab3CRPMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 11:12:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518Ab3CRPMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 11:12:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2045AAAB;
	Mon, 18 Mar 2013 11:12:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XBey09W97dGX1H6P1UsMgb9XF94=; b=RxycS2
	wd/vMXyooNDQLi8wPaLAHICTpPEhwtev7MJIDahH+mTFAMLM3WVk2SiUhalf1RN4
	GlWnZRiSmrYvT2VGcNrCHZDGNDjfggeJ89D7xYzUG4U5Y6BI4gLlK5SAdRPO5ELh
	SjAejFNiYr9kvgnBkOLwxG5j9lA5n1vH1lDts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wHQf4ORE3U7VILpZTwwpkhh8FKMN5rlV
	1UmfD+8Rjttr8atybJ+iRMS1yp91U+I9cOnmWZ/ryYx1Gj4WQIPAL/xe4554dzV0
	62hjWeFwXOgR8WjIxDBXMn8h9fTsvABTivGN67649stR5Wz7OAQiQlynTDndIQ2B
	6WZ2JrTbYKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96EE9AAAA;
	Mon, 18 Mar 2013 11:12:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 195A1AAA8; Mon, 18 Mar 2013
 11:12:40 -0400 (EDT)
In-Reply-To: <51468615.70503@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 18 Mar 2013 04:12:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4665B51A-8FDE-11E2-8F3E-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218423>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>
> and ACK for the whole series, once Junio's points are addressed.
>
> Regarding Junio's readability suggestion: I agree that his versions are
> a bit more readable, albeit at the expense of having to evaluate a bit
> more logic for each reference rather than just once when the header line
> is handled.  So I don't have a preference either way.

The way the conditional is written, in the longer term we
will almost always compare "peeled == PEELED_FULLY", and otherwise
we will do the same !prefixcmp(refs/tags/), so I do not think there
is "more logic" that matters compared to the original.

Thanks, both; will replace what was queued with "SQUASH???".
