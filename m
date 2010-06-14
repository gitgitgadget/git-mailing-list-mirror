From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: Add an option to prepend a string to the
 commit message
Date: Mon, 14 Jun 2010 11:03:54 -0700
Message-ID: <7vk4q1a3ud.fsf@alter.siamese.dyndns.org>
References: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
 <20100612055831.GA2426@burratino>
 <20100612062812.GA12685@coredump.intra.peff.net> <4C132C7E.5090606@gmail.com>
 <20100612071850.GA2765@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bobby Powers <bobbypowers@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 20:04:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOE1B-0000KG-50
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 20:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659Ab0FNSEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 14:04:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445Ab0FNSEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 14:04:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49955BC964;
	Mon, 14 Jun 2010 14:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uGC/smbQc4T8BrSrg++aCF8WMkg=; b=Iy9e7O
	8+KgWDZXDx+9sLpHsJkpyweBUvSlxx+7T+pJ2T6RMrAuFZS7SVY+/Lo+c90noYV7
	garm74FSJEO7V8jX1S4CFgOnRNDDmZW8jFGMI4j7nCGFVaIyVTQwJVYwNNKYFE79
	4dMx6qvyUFpAXxAnzAACz1ty5I2bLblq1hTjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LqLdlLXnaqvfJYgEBsHRVp4MuqH7PciL
	6Q3jYpYbVpD4L4ySZWHMDxylwg2hE2m7LIY6BfMciCVpaSPXZeuOY24ESmojcsKk
	mLMmAQhzsUaa/8KkpNSNgoSYUOBciZuLnFAHwSH+tkWTH9Y1ijGWL1cqtx1r41I6
	Uf/oL1bNoic=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0647BC95F;
	Mon, 14 Jun 2010 14:04:01 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0696FBC95B; Mon, 14 Jun
 2010 14:03:55 -0400 (EDT)
In-Reply-To: <20100612071850.GA2765@burratino> (Jonathan Nieder's message of
 "Sat\, 12 Jun 2010 02\:18\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 366C836A-77DF-11DF-864F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149134>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +git checkout maint &&
> +git cherry-pick -n bugfix &&
> +git add new_file.txt &&
> +git show -s bugfix --format='%s%n%n%b%n%nAlso add a new file.' |
> +git commit -F -

This is cute, I somehow doubt any sane person would prefer doing the above
over running "git commit" and fixing it up with the editor for a single
commit.

It is completely a different matter if the above were in a loop that
munges many commits, though.  But if that is the case, the example should
probably illustrate that loop as well.
