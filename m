From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] check-docs: update non-command documentation list
Date: Wed, 08 Aug 2012 12:24:29 -0700
Message-ID: <7vwr19rxua.fsf@alter.siamese.dyndns.org>
References: <20120808183132.GA24550@sigill.intra.peff.net>
 <20120808183433.GB24574@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzBrx-0000sE-JQ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 21:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758703Ab2HHTYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 15:24:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2HHTYc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 15:24:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E3249752;
	Wed,  8 Aug 2012 15:24:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R6iYfVNZWzrl3c9RmesFdH5Nr4s=; b=KuzST0
	3L2I8FXk9wNlCRJ3kOtVzm4GcHJjolYeIk/w5D0unLpitkATr9mu67IzAbjQMf3q
	v+8fPnDX6ksHCIPJ6TqE0XJ28r20Tm2GEWt5MIF6hS1LS7e+6ZxBj8e3BT0DsoTU
	geRmJitYD8XzIGAsliQCBGb+RlfBiZT+iYgTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h+Z4Pn5rNnQoYeLshCJ2WJ2pBsJPtYDe
	PQvqmjFt2EbRCUyBnys5bjjH4H2YFSTMrWzb3ugHIpTBOfsaklYmTV2WGPcumRkH
	HDSTX9H7OJQ6G0mpTpcd2X6OLpe8vfhefoObiU+y9VHbz6SZBnAXf2JBZ+94t1hx
	SmBTwMw+E+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BBA39751;
	Wed,  8 Aug 2012 15:24:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE4CF974F; Wed,  8 Aug 2012
 15:24:30 -0400 (EDT)
In-Reply-To: <20120808183433.GB24574@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 8 Aug 2012 14:34:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD6F4D42-E18E-11E1-95FE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203117>

Jeff King <peff@peff.net> writes:

> The check-docs target looks at Documentation/git*txt and
> complains if any entry does not have a matching command.
> Therefore we need to explicitly ignore any entries which are
> not meant to describe a command (like gitattributes.txt).
> This list has grown stale over time, so let's bring it up to
> date.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I really wonder if we would do better to match git-*.txt, since most of
> the ignores are gitfoo(7) types of pages. We'd probably want to add back
> in "git", "gitweb" and "gitk" explicitly, but they are already handled
> specially above and below.

Quite possibly, yes.

Also "git gitk gitweb" may want to be made into a Makefile variable
to be shared in the "above" and "below" (I do not know what to call
them offhand---they are programs with special build rules that are
not covered by ALL/SCRIPT_LIB/BUILTIN).

By the way, do we have a documentation for git-gui?  Perhaps it may
want to be added to that "git gitk gitweb" list as a reminder that
it lacks documentation.  One of the goals of the person who runs
"make check-docs" should be to reduce the special case that appears
at the beginning of that case statement.

I also wonder why "help" is not treated as a built-in?  Perhaps we
should throw it in to "git gitk gitweb" list?  After all, it is a
command that is available in "git foo" form, is documented, and is
listed in the command-list.txt file.

Thanks.
