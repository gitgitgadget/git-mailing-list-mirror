From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Sun, 05 Feb 2012 21:15:34 -0800
Message-ID: <7vty34a6fd.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 06:15:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuGvi-0001Q8-Te
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807Ab2BFFPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 00:15:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab2BFFPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:15:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A9917FB7;
	Mon,  6 Feb 2012 00:15:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b0XlpedEX5bHCMF0fI8eJljlHes=; b=JqKAg4
	AM/31TMsH5hh0hKvSb/R+ZS22HH0v6+9VpsAEoOSF5WYjUcQRqLn4BOM4jVYq1VU
	DJ4geQZjUWQlVX90cL4ivgbMxIsTpB3pdVdz9FBCLjRXcnIrYAle9m4grw8Len/M
	+jJeU/akS+LwhJzZHsrJZ/YsZrzyhb5mHvUvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgSl5wfHwgzDohE2MImfMXC0BeTe81Vb
	B1SIBsxftTyP4rsewvj+5JyJj0HOae83j+2KLidz7JnfKCXtAcwN8tTwzjaxdS/F
	+7KarHiNs/af7nftf98YOR7RPsXM2uk0Z+ro7x7ka/t5wPt0LOneWMHCTniuuZmd
	Mvf/qcz7Szk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F38FC7FB6;
	Mon,  6 Feb 2012 00:15:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FFBC7FB3; Mon,  6 Feb 2012
 00:15:36 -0500 (EST)
In-Reply-To: <20120206043012.GD29365@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 5 Feb 2012 23:30:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A17509E-5081-11E1-BE17-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190012>

Jeff King <peff@peff.net> writes:

> I thought the concern wasn't confusion at the error message, but rather
> "how do I start a new repository with a branch named something besides
> 'master'?"
>
> You would expect:
>
>   git init
>   git checkout -b foo
>
> to work, but it doesn't. And there's no easy way to do what you want
> (you have to resort to plumbing to put the value in HEAD). So the issue
> is not a bad error message or a confusing situation, but that the user
> wants to accomplish X, and we don't provide a reasonable way to do it.

I think the right interface for "I want to use 'foo' instead of 'master'
like everybody else" would be:

	$ git init --some-option foo

I wouldn't have any issue with that.
