From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make "git push -v" actually verbose
Date: Sat, 17 Dec 2011 11:34:59 -0800
Message-ID: <7vobv7dmak.fsf@alter.siamese.dyndns.org>
References: <20111217093713.GA2073@sigill.intra.peff.net>
 <20111217094142.GA10451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 17 20:35:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc02i-0008IQ-QT
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 20:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611Ab1LQTfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 14:35:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46163 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404Ab1LQTfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 14:35:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD4E77D0;
	Sat, 17 Dec 2011 14:35:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kwOteJYxXU14xIPiBugDzr/EurY=; b=LZ8IrH
	7/W/7ttYV9XfKAHSNQaEvTfeMeyJsYeFcfd1Y0J7GEk9fOAI+HRio/e/0KGCy2c/
	S1eg8uwkdFXPFVM2RwxHSFYwmHRXSZRHPsZsUUww8kWm0QvtSVNQ1bNW0bltUxuV
	OhtUQMTd9zwdYaLZH1SsktdBcCzciFyrtwxRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VrrWdIZdB8xPffa72yIiDcyvfngIOOTU
	8yv1MYKJQvNoLd3X1dfqGc4fwj+WoYjqgl3QHhqe4kYWfQF9pmy7KCX+q2qyQBUl
	VkUiqz3XS7m+XpUlVqjtkDf0p/faELI1MNs17HkWWfOAI0/S2JtaddQ93yYhqQO1
	z37r8SFTa1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1F4C77CF;
	Sat, 17 Dec 2011 14:35:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EE6077CB; Sat, 17 Dec 2011
 14:35:00 -0500 (EST)
In-Reply-To: <20111217094142.GA10451@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 17 Dec 2011 04:41:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 358F3DF2-28E6-11E1-8D55-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187402>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 17, 2011 at 04:37:15AM -0500, Jeff King wrote:
>
>> Providing a single "-v" to "git push" currently does
>> nothing. Giving two flags ("git push -v -v") turns on the
>> first level of verbosity.
>
> One minor clarification: it is not technically true that "git push -v"
> does nothing. It just does not do the interesting "show a verbose status
> table" operation, which is almost certainly what the user wants (and
> what happened before the commits I mentioned). It does print "Pushing to
> $url", since that happens above the transport layer. But I'm pretty sure
> that is not what users of "-v" are interested in. :)

Thanks, but don't be so sure about that.

When you are so used to say "git push ko", from time to time you want to
check which one of your kernel.org machine you are pushing into; that
"pushing to this exact url" is actually quite useful.
