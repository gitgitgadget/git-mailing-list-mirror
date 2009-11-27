From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 10:29:11 -0800
Message-ID: <7vpr73n7ns.fsf@alter.siamese.dyndns.org>
References: <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5ZX-0006Wg-C6
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZK0S3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 13:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZK0S3R
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:29:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbZK0S3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:29:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1AD6833BF;
	Fri, 27 Nov 2009 13:29:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=u0pbSgXzyefRvyd18nQl9ShUrc4=; b=Kv1TC5wELmtanQBXlL+hUZh
	elmD/nhzWrZY1shsuYMhEBsw8KIFisrSeLMDAEwnHIyuyKs6Yk+JzfT3GnZAXmKT
	Sx+nX/sAV9gBnA9OYw1/yrt0Ue9d8OZzTw4jjw+B43SKMgx7MtOx8qRTado/2gQa
	4F0fk46Ubf4OEnAVefN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bLJOkSjQxsqCSq2jVrMvDTC1RM+btYebAsdyInASm47ggBtcV
	CKcqZcJhvgF1gbWWRMr5T2ZZy4VaWHexp6UX5C5AEMkYdM/T4UL/rI2bNZP78uaW
	9pw0JNtuGuOgqPiAdIYIDAE9DXUSGJM0LY4EBZNeHkURlR2LpZbe7KJ/P8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D29833BB;
	Fri, 27 Nov 2009 13:29:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C18A833B1; Fri, 27 Nov
 2009 13:29:12 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C63D2DFE-DB82-11DE-AEC4-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133919>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 27, 2009 at 10:31:30AM +0100, Johannes Schindelin wrote:
>
>> Guess what.  I have a similar problem, only it is that my "git status" 
>> output is _always_ too long, so I always have to page it.
>> 
>> Once upon a time, Junio applied a patch that implied -p with status.  I 
>> was overjoyed.  He reverted that patch later.  Yes, exactly.

It would have been more fair to me if Dscho said "He had to revert", to
hint that it was not due to me changing the preference left and right on a
whim.

>> So I end up doing "git config --global ps '-p status'" on every new 
>
> If only somebody had written a "pager.status" configuration variable,
> you could use that. Oh wait. I did. And it shipped in v1.6.0.

Nice try but, "grep" and "status" are apples and oranges comparision.

A "status" command that pages or does not page the output only when
spitting out to a terminal won't hurt somebody who helps another with the
configuration set differently, as much as a "grep" that shows or not shows
matches from other parts of the tree would, and when used by a script to
make a decision based on the output, the caller has to capture the output
first, and unless the caller drives "status" via pty, e.g. using "expect",
paging behaviour will be disabled no matter what the configuration setting
is.

So neither "it would hurt people who help others" nor "it would hurt
scripts" would apply to "status".  But both would apply to "grep".

>> The further benefit is that we stop talking about breaking backwards 
>> compatibility, and we stop talking about making it hard for Git experts to 
>> help newbies.
>
> I guess you missed the part of the thread where I already discussed
> this. It was here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/133672

This was a very good summary, and was one of the reasons that made me
reconsider placing too much weight on "it would hurt people who help
others" (but not on "it would hurt scripts").
