From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 16:02:44 -0700
Message-ID: <7v7gjjaagb.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
	<7vehdrbrvz.fsf@alter.siamese.dyndns.org>
	<CAMP44s3osZJO1P6_KoPVON0cOSAD5D-OZmL=aKGkcWReortiCw@mail.gmail.com>
	<7v1u9rbrb4.fsf@alter.siamese.dyndns.org>
	<CAMP44s3K8BOfnUdc0514KgvYsbncSBO4DRSyfqhFQJomGrZN0A@mail.gmail.com>
	<7vobcvabxi.fsf@alter.siamese.dyndns.org>
	<CAMP44s26oZf0=xdqp5sr_J1TNhK83=88A7KH5n_LnstFe6o5gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 01:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJZT-0002eh-PH
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 01:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785Ab3D3XCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 19:02:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933643Ab3D3XCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 19:02:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 380BF1B042;
	Tue, 30 Apr 2013 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iMLRx04R8aLOAylSlw+eG8mcifY=; b=LynWBO
	02X5lX2F4xUnXRJpWRnvOZIOIm+8cEdSJ5S1Uo1Yx5KDIuqz5aQDK2VcEGRhWv/M
	LG8OoLaQY+Bh07d6DC43ZRG/PLn4YF2746m4lqBUxn6w+X9p0DdjE27m730A8sth
	tykFQNrm3ML+Nh2/4VUQLxuZ/QejnVGn3H8r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NZK3pk6Vg04lY+OiPiz/vWjmisBCFU0q
	J6menK62jXTqt7XmscQ5krOjmziGsEpOsGc6N5W3KiEx8RF86c/r3IT1sePYGtHE
	BVOCsORRcRgAD+6KQw/eyAskp9MEYDcGKQtkIN2eAFrlQLK+WmiP4KVobqWSVGB8
	p1Y8UaPxQVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A68E1B041;
	Tue, 30 Apr 2013 23:02:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AAA01B03F;
	Tue, 30 Apr 2013 23:02:45 +0000 (UTC)
In-Reply-To: <CAMP44s26oZf0=xdqp5sr_J1TNhK83=88A7KH5n_LnstFe6o5gA@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 17:45:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11F7D7D0-B1EA-11E2-A173-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223040>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Yoda speaks in reverse "Stopped they must be; on this all depends".
> "if (0 < len)" says "if zero is less than len", which is in reverse,
> as reverse as "if 1.50 is taller than you". It's all reversed: "if you
> are taller than 1.50", "if len is greater than zero", "They must be
> stopped; all depends on this".
>
> I don't understand what is not clear.

I never said anything is "not clear", did I [*1*]?

I've retitled it to "compare variable with constant, not constant
with variable" to make it easier to understand to those who did not
know the jargon (like me ;-).

By the way, after web-searching "Yoda condition", all mentions of
"Yoda condition" I found were of the

	if (constant == variable)

form, and people's justification why this form is bad, which I
happen to agree with [*2*].


[Footnote]

*1* "zero is less than len" and "len is more than zero" are saying
exactly the same thing, even though people may find it harder to
read.  While "blue is the sky" and "the sky is blue" are not saying
the same thing in the first place, and that is why I said it is not
a good analogy.


*2* I do not write equality comparison in the "constant == variable"
order myself.  For people reading from sidelines, the previous
thread on this topic is this:

    http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=3907

which explains why these were written as "if (smaller < larger)".
