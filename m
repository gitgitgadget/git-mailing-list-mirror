From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: more good unaligned memory access candidates
Date: Thu, 13 Aug 2009 12:33:57 -0700
Message-ID: <7v63crbja2.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
 <alpine.LFD.2.01.0908130934400.28882@localhost.localdomain>
 <alpine.LFD.2.00.0908131304520.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbg3y-0003k7-9a
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbZHMTeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbZHMTeB
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:34:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbZHMTeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:34:00 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12AF999CF;
	Thu, 13 Aug 2009 15:34:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B8E099CE; Thu, 13 Aug
 2009 15:33:58 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 412F7116-8840-11DE-A5F7-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125859>

Nicolas Pitre <nico@cam.org> writes:

> As it is now, I was about to suggest:
>
> 	git mv block-sha1/sha1.[ch] .
> 	rmdir block-sha1
> 	rm -r mozilla-sha1
> 	rm -r arm
> 	rm -r ppc 
>
> and remove support for openssl's SHA1 usage, making this implementation 
> unconditional.  After all it is faster, or so close to be faster than 
> the alternatives, that we should probably cut on the extra dependency 
> and simplify portability issues at the same time.

Wow.  Is it now faster than the arm/ and ppc/ hand-tweaked assembly?
