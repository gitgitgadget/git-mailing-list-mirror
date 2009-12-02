From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 02 Dec 2009 11:38:05 -0800
Message-ID: <7vpr6xcgki.fsf@alter.siamese.dyndns.org>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202192614.GD30778@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:38:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFv23-0007t6-3G
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311AbZLBTiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbZLBTiK
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:38:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZLBTiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:38:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 933A384D1B;
	Wed,  2 Dec 2009 14:38:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZgDPNIHxmg8QTgB9hVVfZutT/qg=; b=FdV5fl
	eiz0O2imAZ/9fjY2nZcgWh0Ncz61TqJjVRGnYhigOto9voCdzqFmNx8m47JXCLbu
	jTOTB06ZwxYsMK58tcWuSlbNXtVR/AveFjk900CvS9ncD8iSLY2vitYbNir08Pll
	vWwIIN1vxUZIQN/ihQP17N2eLw8KJbZsduZCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxgNJn6Y+23Zq+1eH4S+4fICTRJGSkU4
	DnoJUAOnNcEN8b49K2pTALHnhQJwY/OvKU9ljs0IxwRkijos3vBUQErKLutlSjuL
	kf+zSOMkICkR01kNFLYxoNJ1r/FQQdyv6yFEhGk9CVOmUe8KMHSW0tLnqcpwb+LS
	y8eMHYtj2xc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4107A84D1A;
	Wed,  2 Dec 2009 14:38:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8157D84D11; Wed,  2 Dec
 2009 14:38:07 -0500 (EST)
In-Reply-To: <20091202192614.GD30778@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 2 Dec 2009 14\:26\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 398DC1B0-DF7A-11DE-B1CF-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134388>

Jeff King <peff@peff.net> writes:

> Do you really want to set the date to something arbitrary, or do you
> just want to set it to "now"? If the latter case, do you really just
> want the recently discussed --reset-author?
>
> Also, is there a good reason why GIT_AUTHOR_DATE is not respected in
> this case?  If not, should we simply be fixing that bug instead?

I expect I won't be on the list for the rest of the day (I've started the
preparation to tag -rc1), but I have two-and-half points before this
discussion goes too far:

 - The "--reset-author" patch will be in 1.6.6 (it is already in 'master'
   yesterday, I think);

 - We should honor GIT_AUTHOR_DATE if --reset-author is given.

 - I _think_ we should ignore GIT_AUTHOR_DATE if --reset-author is not
   given, as --amend/-c/-C is stronger for being command line options than
   an environment variable.

So I do not think --date is something we urgently need, even though it
might be nice to have it to be consistent with --author.
