From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Message from git reset: confusing?
Date: Thu, 06 Aug 2009 12:21:07 -0700
Message-ID: <7vvdl0kau4.fsf@alter.siamese.dyndns.org>
References: <vpqab2e7064.fsf@bauges.imag.fr>
 <7v1vnqb2hc.fsf@alter.siamese.dyndns.org>
 <32541b130908051042x5308e8fte7b3ead6bf1f24ee@mail.gmail.com>
 <fabb9a1e0908051125n3e125209n88a9fd86d6fa7534@mail.gmail.com>
 <vpqprb946sk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:21:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8Wh-0005As-Hr
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbZHFTVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbZHFTVN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:21:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbZHFTVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:21:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BFEF923F1C;
	Thu,  6 Aug 2009 15:21:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 08B1723F19; Thu, 
 6 Aug 2009 15:21:08 -0400 (EDT)
In-Reply-To: <vpqprb946sk.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu\, 06 Aug 2009 11\:42\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E5BEC0C-82BE-11DE-86D1-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125109>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This is my biggest issue, indeed. Actually, several things bother me
> (by decreasing annoyance):
>
> 1) It looks like an error message, and user can think git reset
> failed.
>
> 2) It's inconsistant with the usual status display. I'd prefer an
> output like "git diff --name-only" or "git status".
> ...
> So, let's address 1) and 2) only.
>
> Any opinion? Am I going in the right direction?

I think the approach is sane.  I didn't check if the unconditional 

	printf("Unstaged changes after reset:\n");

needs to be protected, or at that point we already know we will talk about
one or more paths (either needs update or needs merge).
