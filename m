From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 14:26:55 -0700
Message-ID: <7vr4q562cg.fsf@alter.siamese.dyndns.org>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org>
 <7va9wt9377.fsf@alter.siamese.dyndns.org>
 <20120913210111.GA16956@sigill.intra.peff.net>
 <7v627h7hny.fsf@alter.siamese.dyndns.org>
 <20120913212043.GB16968@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:27:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGwF-0004yu-9U
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab2IMV07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:26:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab2IMV05 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:26:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 618858801;
	Thu, 13 Sep 2012 17:26:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TlsvGdHRvFX2TEKO51/zP7B6MIA=; b=dS8r9Y
	FFwrHQzqxVKmOTGljgkELh5Tdu++FSBQO7AmtANZ/E/hz6mb9oeZEzV0LObaDieW
	0tlHI+bO/4zDIreXOeUHo+gw8zPPl4s9K6Qgy1JHHlocqoKlmoRLwCIug+fQwBzS
	18grWyDj/IlA0FHns122cgyBBzXkdLoJHLGTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hdylqncmXqcKXe1COYEwqPsMjvwMqFJ4
	CTCS5tSgQEZJx+voCVmC0SXrVLQPWYm84MDvuxgNLdyRfEV1oVEK3FdcJtNdSCKz
	Qq3PZgTE6eFVYSziHWA0NrpXmoN8AAlHwL1ODVYR8C0OTP1a9UwiO+Y5RZp/o/tv
	q1uA78Px90I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5D887FF;
	Thu, 13 Sep 2012 17:26:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3C9287FD; Thu, 13 Sep 2012
 17:26:56 -0400 (EDT)
In-Reply-To: <20120913212043.GB16968@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Sep 2012 17:20:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEB842DA-FDE9-11E1-BDCE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205431>

Jeff King <peff@peff.net> writes:

> I do not think they are incompatible if you separate it into three
> categories: machine readable (must never be translated), for the current
> user right now (current i18n), and for sharing with other humans
> (i18n.projectlang).

Anything you see as a user is potentially useful to other project
participants, so I do not think there is a bright line that
delineates the latter two classes.  The output of format-patch is
obviously meant as the latter, but how about the output from show or
log?  Is it worth trying to define the bright line somewhere, only
to annoy users who may want to draw the line differently?

> Whether the maintenance of that three-way split is worthwhile, I don't
> know (and that is why I said "in an ideal world..." in my original
> mail, and left the implementation for people who care more). In the
> meantime, before we have a working i18n.projectlang solution, which slot
> should we put those messages in?
>
> I'd argue for putting them in the machine-readable category, because it
> is less likely to cause interoperability annoyances (and since git is
> not fully translated anyway, we kind of assume at this point that people
> know some basic phrases in the C locale).
>
> And of course it is not fool-proof. The "for the current user right now"
> messages may bleed into conversation with other people. But that cannot
> be helped if we are to do any localization at all, and it does not seem
> to be a big problem in practice. The only practical problem so far is
> with certain meant-to-be-shared messages.
>
> -Peff
