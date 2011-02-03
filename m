From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FEATURE REQUEST] - extend git request-pull to send email
Date: Thu, 03 Feb 2011 14:59:34 -0800
Message-ID: <7vpqr8zpux.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=kXJF_rYGMyh1gj49J7fh-ZxD7Bo8o_ELHb-2M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 23:59:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl89V-0007Sk-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 23:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab1BCW7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 17:59:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab1BCW7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 17:59:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34FEF4084;
	Thu,  3 Feb 2011 18:00:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Dvq91Qm/GioUQoYnfcMrMQcJvM=; b=mQ4BNK
	gPaSGWKvQEby49fA2Vr2d9ZiA6Jh+3Nqhj/e+qyBUuPX/h3s5wyPLLlIBb6DKKA0
	tTxP3S6uNgrIRv+8L/kGgF+voqy69fqRK5vPaqIJXumnNvN9gDx+BFfPDcHPQBSe
	cBVVvfeYZhfVLoJODgTYT0oE0YOOAUxySYJF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aXx79hk9d3bPByI4mMTwkpwDxzcNxdpx
	e+Ip+DjFIXMpP+aaYXY89p28QBltpjS1s8bFM6U6qusCVjYri4ZARys5JIzjv+2r
	boL6sNgESrbU0DwR93k2sJ6+X0T0kgn9g6l7TwKD8bKMAXxcUp/5zloYLNtE/7p5
	i51/J48vUgY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 115314083;
	Thu,  3 Feb 2011 18:00:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2BD914082; Thu,  3 Feb 2011
 18:00:30 -0500 (EST)
In-Reply-To: <AANLkTi=kXJF_rYGMyh1gj49J7fh-ZxD7Bo8o_ELHb-2M@mail.gmail.com>
 (Eugene Sajine's message of "Thu\, 3 Feb 2011 17\:35\:20 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68073966-2FE9-11E0-AEE6-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166006>

Eugene Sajine <euguess@gmail.com> writes:

> Specifying the "--to user@server.com" could be a trigger for this functionality.
> All additional parameters from git send-mail should be available.
>
> What do you think?

Horrible ;-).

If this were not about request-pull but some other command that produces a
summary of recent changes you have, which you might want to distribute to
people who are involved in the project (e.g. Meta/cook), it might make
sense to have "generate and then e-mail" feature inside the command,
because such a command needs to inspect the history and grab various kinds
of information anyway, and adding "people involved" to the mix might make
sense.

But you are talking about request-pull, which is by design is meant to be
sent to a single recipient.  If the user has to say --to user@example.com,
how is it different from piping the output to "| mail to@example.com"?
