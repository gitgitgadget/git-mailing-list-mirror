From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message
 configurable
Date: Sun, 06 Sep 2009 00:09:07 -0700
Message-ID: <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 06 09:16:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkBzH-0002Q7-5b
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 09:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbZIFHJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 03:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbZIFHJ0
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 03:09:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbZIFHJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 03:09:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7BB6246905;
	Sun,  6 Sep 2009 03:09:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wey4qdTkymnXVN9YD7bGq+JhEz8=; b=F/kOIN
	bdg6QvvBfnc/pbOgSOi475FkDAXQ9g6WwDZmHftDtjGpLvfCRxVXts9LSrJBvpsU
	vHIb97QrVpfWgkZSeuXdX9Dz+8jxSMuXQDG5+1grgr9/CO8QNV0hPR1IGQSHD+IB
	WBHIfZ+wStwtBqU8PM4/q1+VxxHsf1qlilgPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FuyzyX5BehYRyCK3elfXxKg6eXG6JfIM
	oup8rWGP2e4P+/Vr7YFe/0I6qmXKupbbj8sxRtH1h825UOthomCiLvm2kkkH6TU0
	rltR4sxNHC8gJXSAr0Bmv9OC9+IEUx6Tkz+IgAmIRFtj+HyYXgsoFUJooB+OKktS
	rxOEDtNwxyE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34CB1468FA;
	Sun,  6 Sep 2009 03:09:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 41026468E6; Sun,  6 Sep 2009
 03:09:09 -0400 (EDT)
In-Reply-To: <20090906064816.GC28941@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 6 Sep 2009 02\:48\:16 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3336BBCE-9AB4-11DE-97CA-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127840>

Jeff King <peff@peff.net> writes:

> Probably "messages" is too vague a term to use in the code and config.
> Maybe "advice.*"?

I hate to start off with a digression, but one expression from Japanese I
have long been frustrated with, because I cannot find a good counterpart
in English, is "大きなお世話".

J-E dictionaries often translate this phrase as "none of your business",
and it indeed is meant to be thrown at somebody who gives an unsolicited
and an unwanted advice to you, but at the same time it strongly implies
that the reason why such an advice is unwanted is because you very well
knows the issue and does not _need_ (not want) the help on the topic at
all.  It is not about _who_ gives the unwanted advice (which I think the
expression "none of YOUR business" talks about---if the same advice came
from somebody else, it might be appreciated), but it is all about on what
topic the advice is about, and you feel that you know about the topic very
well yourself and do not need any advice from anybody.

Enough digression.

I have always felt that many of the messages we have added since the
"newbie friendliness" drive around 1.3.0 deserve to be labeled with the
expression 大きなお世話.

Of course, "unsolicited-unneeded-advice.*" is too long as a variable name,
but I personally would very much welcome changes along this line and I
think "advice.*" is a good name for the category.
