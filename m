From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Sat, 18 Aug 2012 13:39:41 -0700
Message-ID: <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
References: <20120719213311.GA20385@sigill.intra.peff.net>
 <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Aug 18 22:39:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2poE-0008RC-0w
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab2HRUjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:39:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab2HRUjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:39:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3139B80;
	Sat, 18 Aug 2012 16:39:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z2WfrP2EMqsOziQXiGl8SQzuq4M=; b=w+mjuj
	oCZw/OU01UA61j3WYsSC+sq+AT+i5xNBtw03ZSW7sC/ZUfV9rh4cZmxRJitxcNys
	Pau/W3CyY96OFpKlQGov/1V3TrxL7berI4KrUCuP+7/wl842kZVfr/NeXyw1J6bi
	AOviM5w3f7IWvBRJF/gCapDGeY41IHL33CaI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pr9HVrndZhI7TvwFlDN6tE3iyaTwaY5m
	dnkjY8ZPFBzYRHf+Mru99e5GJGaPAN3sSlnuHFcpiafn78/tKy9L8dEkPwbRSrDo
	WaPjjgF6koxK2iQcYANHUiehqW1Rllv10Yq3KI7GuScVrN4vVwivuYqLDuH/3xy6
	vl6Xt92B2nQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3439B7F;
	Sat, 18 Aug 2012 16:39:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97CB79B7D; Sat, 18 Aug 2012
 16:39:42 -0400 (EDT)
In-Reply-To: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Sat, 18 Aug 2012 19:14:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6C1A544-E974-11E1-A48E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203697>

mhagger@alum.mit.edu writes:

> Given that a flag day would anyway be required to add a d/f-tolerant
> system, I could live with a separate "graveyard" namespace as
> originally proposed by Jeff.
>
> However, I still think that as long as we are making a jump, we could
> try to land closer to the ultimate destination.

Do we _know_ already what the "ultimate destination" looks like?  

If the answer is yes, then I agree, but otherwise, I doubt it is a
good idea to introduce unnecessary complexity to the system that may
have to be ripped out and redone.

I didn't get the impression that we know the "ultimate destination"
from the previous discussion, especially if we discount the tangent
around "having next and next/foo at the same time" which was on
nobody's wish, but I may be misremembering things.
