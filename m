From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: start warning upcoming default change for
 push.default
Date: Thu, 21 Jun 2012 10:00:51 -0700
Message-ID: <7vobocsipo.fsf@alter.siamese.dyndns.org>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
 <1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vehp9x3yz.fsf@alter.siamese.dyndns.org> <vpqpq8t96zw.fsf@bauges.imag.fr>
 <7va9zxvkyp.fsf@alter.siamese.dyndns.org>
 <7v62alvk2e.fsf@alter.siamese.dyndns.org> <vpqd34su0io.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:01:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shkkd-0007ts-5E
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 19:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759905Ab2FURAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 13:00:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759902Ab2FURAx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 13:00:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 440718DE4;
	Thu, 21 Jun 2012 13:00:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jvT0LWzoNjPGizpMmNIR0SazJ/s=; b=oD2AE8
	TOQ6fltCn/ChG+wg424108UAMToPvazMPyHG7iar7HNT87exuJAfZg/J4dKIYQ88
	egYFjB4aY/YGhms20h10+OHLggOYqaJ/t6u6EWHX/Oum0kzuQfH9ajUYJzpUpVGF
	EdbAWV9Z5ZQvcQQ5/3F9U5+59CKfWD37puNMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FG3xABxbVRPkI+uwmm+RGRqTeh5yBiL7
	/n62WgxGK5QrR06GyAAymdYFgWHz61kV7AlbhZBVZ2plLnWB/EPoa0DOyQu1qnbj
	CBJvIUJQ/214uRERgnJOI8w6FMQVU9dHmEX3P0u6iQ+j9DG4yYVMNXnvYx/cuL3m
	bupnp4n3wR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BA268DE3;
	Thu, 21 Jun 2012 13:00:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1DB58DDF; Thu, 21 Jun 2012
 13:00:52 -0400 (EDT)
In-Reply-To: <vpqd34su0io.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 21 Jun 2012 17:50:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8CF7C5E-BBC2-11E1-9778-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200407>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Perhaps we should say more to help people decide which one to choose
>> in this message.
> [...]
>>     You can squelch this message by picking your preferred default now,
>>     e.g. running one of these:
>>
>>             git config push.default matching
>>             git config push.default simple
>>             git config push.default current
>
> I don't see any added value. Seeing this, it's less clear to the user,
> and he may chose 'simple', and then complain that it breaks his older
> Git. 

Re-read the part you omitted with [...].  Doesn't it say something
about "only available"?

> Really, if 'simple' isn't an option for someone, why should we make
> this someone think before chosing between 'current' an 'simple'?

This is not about choosing between simple and current when both are
available.  As [...] part tries to clearly state (and if it is
unclear, please clarify it further), the new default "simple" is
only available in certain versions, and 'current' is the closest
approximation for other versions.  So even though there are three
choices, it is really about choosing between 'matching' (push all
relevant and current branch does not matter) and 'simple/current'
(push current  branch only).  We could make it like this:

	e.g. running one of these:

		git config push.default matching
		git config push.default simple (or current)

and it may make it clearer what choices are suggested.  The only
reason I made it three lines is "(or current)" would make it harder
for people who want "current only" but runs older version of git in
the same repository to cut and paste.
