From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take options
Date: Wed, 26 Feb 2014 11:55:20 -0800
Message-ID: <xmqq4n3l4pjr.fsf@gitster.dls.corp.google.com>
References: <530DA00E.4090402@alum.mit.edu>
	<20140226105249.GE25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 20:55:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIkZl-0004AN-Db
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 20:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbaBZTzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 14:55:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbaBZTzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 14:55:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4DF56E78C;
	Wed, 26 Feb 2014 14:55:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PXCLoY0vwRaGZhXf0atqUwu8xLQ=; b=jpzj9Q
	viDkTKY5LVIkfteovyx0y2h4cJUlwlqXOI2ezCR7NdQAJiyGFOy66H/a6P468XoY
	S6jj5scv1l+MAHmDmjg/9+Ttlr8cfvpfJemRb3ZnNp8W+T2IVlE+EGvzMgGpKvDN
	ylR2YGKqDZNSG1FP7tUlQIg5ZcQsY6noDCx58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kn5pFEsPEQhJiUUjKdBZMemd8rCpT1hd
	y6Hx6170TJGwBSkNNRGGvnF60LmuaOk6gXv+4dQbhJi3YkrYlG/Qs5bI1X3N/Sqw
	UJdYRjIFropP9kK+/0fBwPaYi9qHU4jxpmIFdyigsDafO9XdTGL9GQbNl5yt9y40
	EvhcHavlEQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C24F6E78B;
	Wed, 26 Feb 2014 14:55:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6DB36E78A;
	Wed, 26 Feb 2014 14:55:22 -0500 (EST)
In-Reply-To: <20140226105249.GE25711@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Feb 2014 05:52:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED8407B0-9F1F-11E3-93EB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242752>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 26, 2014 at 09:04:30AM +0100, Michael Haggerty wrote:
>
>> It would be nice to support more flexibility in the todo-list commands
>> by allowing the commands to take options.  Maybe
>> 
>> * Convert a commit into a merge commit:
>> 
>>       pick -p c0ffeee -p e1ee712 deadbab The oneline of the commit after
>
> This seems like a reasonable feature to me. All of your examples are
> possible with an "e"dit and another git command, but the convenience may
> be worth it (though personally, most of the examples you gave are
> particularly interesting to me[1]).

I actually had a completely opposite reaction to the above one.  It
took considerable mental effort to decipher what that "pick -p ..."
line was trying to do, and I am not absolutely sure if I understand
what it is trying to do enough to rewrite it to an equivalent
"inconvenient" sequence of "edit and another git command".

> [1] The one feature I would like in this vein is that editing the title
>     in the instruction-sheet would modify the commit message of the
>     relevant commit. For some reason I try to do this every few weeks,
>     but of course the changes are just thrown away.

Every time I thought about this one, I get stopped after realizing
that the title line is only a small part of the log message.
