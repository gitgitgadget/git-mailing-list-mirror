From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support non-WIN32 system lacking poll() while keeping
 the WIN32 part intact
Date: Wed, 22 Aug 2012 10:48:13 -0700
Message-ID: <7vfw7e95sy.fsf@alter.siamese.dyndns.org>
References: <002101cd8078$eb2eb4f0$c18c1ed0$@schmitz-digital.de>
 <7vd32ialzo.fsf@alter.siamese.dyndns.org>
 <003501cd808d$bd21b7a0$376526e0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "'Erik Faye-Lund'" <kusmabite@gmail.com>,
	"'Johannes Sixt'" <j6t@kdbg.org>,
	"'Marius Storm-Olsen'" <mstormo@gmail.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:48:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4F2U-0007Pq-C4
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab2HVRsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:48:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676Ab2HVRsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:48:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50D1697F1;
	Wed, 22 Aug 2012 13:48:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XmmWp39KA6zoewiy2EqvK8gRuSk=; b=s7nDOb
	kP4Fo9lIZKlEwG+iquk39EuGzilnmMTns76i28qzt9aeqKvWT7yoIY4J17AWYJjZ
	3qWK2gYs/RTT56iBTQ6nkoOSm5Dzj/M/L+QbSE8Ai3JZYsKjzFjOKNBobfOwTE+t
	/lxg0OrhPKHy8mua73o8cqXL9fWl7DQL71yX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MuMK6KJyAGZlrjRBsqiLXOFtunc6EYlY
	RbuXvjFTqMzqnwWxRW0b5zobk+6DdyO7+XZvdIFSyYU1jONH9+JotZw0tAke1NcW
	euES3eq7fI6JwAgTMaQMHF3N7VPT1R8J9xEy5XZwVGiLTIpPYG05hLbcgAVM3Jlw
	dL3J9DbnssU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E3DD97F0;
	Wed, 22 Aug 2012 13:48:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFB5D97EC; Wed, 22 Aug 2012
 13:48:14 -0400 (EDT)
In-Reply-To: <003501cd808d$bd21b7a0$376526e0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 19:44:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C571826-EC81-11E1-B2F3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204047>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> Do you really need to have both?  I suspect "If you do not have a usable
>> sys/poll.h, set NO_SYS_POLL_H" may be a simpler alternative, but there
> must
>
> Hmm, Not having <sys/poll.h> and not having poll() are different thinks,
> aren't they?

Ahh, OK, I forgot the other combination: working poll() but inclusion
of sys/poll.h is unnecessary.  OK.
