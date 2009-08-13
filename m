From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: bad revision 'HEAD'
Date: Wed, 12 Aug 2009 21:36:04 -0700
Message-ID: <7v1vngmitn.fsf@alter.siamese.dyndns.org>
References: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
 <20090810011803.GA435@coredump.intra.peff.net>
 <09EE2E57-626B-4686-A6DD-3B8DF1BC3FE2@gmail.com>
 <20090811015615.GA8383@coredump.intra.peff.net>
 <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
 <20090812032740.GA26089@coredump.intra.peff.net>
 <7v7hx98otz.fsf@alter.siamese.dyndns.org>
 <20090812075833.GF15152@coredump.intra.peff.net>
 <7vab24ve97.fsf@alter.siamese.dyndns.org>
 <20090813023137.GA17358@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Mahoney <joelmahoney@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 13 06:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbS37-0000g7-CE
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 06:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbZHMEgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 00:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbZHMEgP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 00:36:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZHMEgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 00:36:14 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AFC78529;
	Thu, 13 Aug 2009 00:36:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D6088528; Thu, 13 Aug
 2009 00:36:06 -0400 (EDT)
In-Reply-To: <20090813023137.GA17358@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 12 Aug 2009 22\:31\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D57B4968-87C2-11DE-9104-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125774>

Jeff King <peff@peff.net> writes:

> I.e., I have done in the past (but not frequently):
>
>   git symbolic-ref HEAD refs/heads/to-be-born
>
> in an existing repository to create a new root.

I honestly do not know of a sane reason (other than "because I can")
anybody would want to _start_ a new root in a repository with an existing
history.  And doing a "pull" with or without --rebase immediately after
starting a new root is doubly insane, as you say.

I do not think _ending up to_ have more than one root in your repository
is necessarily insane.  You may find a related project that earlier
started independently but later turned out to be better off managed
together with your project, and at that point you may perform Linus's
"coolest merge ever" to bind the two histories together, resulting in a
history with more than one root.

But that is the kind of "ending up to have" I am talking about; it is not
something you _aim to_ create on purpose.  If you want to _start_ a
separate history, and if you are sane, you would start the separate
history in a separate repository.
