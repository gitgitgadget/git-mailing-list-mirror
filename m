From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: use a strbuf to scan the log for boundary
 commits
Date: Wed, 22 Feb 2012 12:50:51 -0800
Message-ID: <7vhayia8yc.fsf@alter.siamese.dyndns.org>
References: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch> <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch> <7vlinuaaab.fsf@alter.siamese.dyndns.org> <87hayivcmm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:51:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0J9R-00077a-DS
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab2BVUuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 15:50:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab2BVUux (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:50:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D902B6B2A;
	Wed, 22 Feb 2012 15:50:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=APjGXys7YHH8dX0Ib2NM1i1FQ04=; b=ROL/1L
	ACOAhEn7+LEQwEC4/y7x2SWEtxLTrbQq95brwYhjkLXYuqxXSRcUNosFNh0KI+MP
	ghN55KrNwJFDhyzsyvXBh4nxWEEfF8/g18R8Fz8wYlu3Tu930bn78LMYASzdsqn6
	h5GdPTH4u31lQZV1aJEzdGfZqCDHudjOgD5/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Miord+3AJfwYiY2xsQeehdMuPIb1yqqh
	gahvz/SIDlIepr4+vWpiDsfhqS/U9EKO1T/VDKaokx/5IZXfwa9FmwxL4ttxOq1I
	X1dLN8rhdiK1ePHZJwUWTFWHP/r24+MIYyu6HZZ/13pL5wjrMM8AZ//BO+vb6Ykq
	iygXG7ixFYM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFB786B29;
	Wed, 22 Feb 2012 15:50:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64EB46B28; Wed, 22 Feb 2012
 15:50:52 -0500 (EST)
In-Reply-To: <87hayivcmm.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 22 Feb 2012 21:25:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8746606-5D96-11E1-838F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191285>

Thomas Rast <trast@inf.ethz.ch> writes:

> In any case the --pretty=oneline is very deliberate, as we can see from
> the commit below.  It just doesn't give a reason :-)

Thanks for digging and I hope everybody on this list who would ever send a
patch learns the importance of describing _why_ in the log from this
lesson.

I'll amend your 2/2 with a note that keeping the subject material is not
justified and we may want to remove (or at least reduce) it in the future.
