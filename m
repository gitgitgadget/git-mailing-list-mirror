From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Unification of user message strings
Date: Mon, 19 Mar 2012 14:36:29 -0700
Message-ID: <7vaa3c9ste.fsf@alter.siamese.dyndns.org>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org>
 <1332179503-2992-2-git-send-email-vfr@lyx.org>
 <20120319205300.GA3039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 22:36:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9kFr-0007pr-BW
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 22:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab2CSVgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 17:36:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456Ab2CSVgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 17:36:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F20F967B7;
	Mon, 19 Mar 2012 17:36:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xNOvbZMdEumbd4pH7Sd/dKX6wX8=; b=fXoNh6
	/h4DgHIkQqGcPZhwGp4K8KW8k3J9KUyeIge2WF7XqhreVXn8RmLNC56STLPQmjD3
	V0ZaNjKZuOVDbQIvUgFGb7jaUnUkG3UAF7SJJeYeEJFDIO/j6UJ5AhTla7iwvX8a
	QSwHS03+VVlZgRYAqRp2qTo60HO5u66n7z7x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f2jIAEmViI1Ilm5vN7QkmfdwWxziBe0i
	qemS19SurjZXcZj9DmRnrMWg1qi0/kHlCKCLGNlc1tEorsXnWMDuAxAoRWDZeAF3
	/eYBQCc6AWX7VoCm74Kkt7uhLzZbizsxg7hZab3pgBysDWFnzPWE2H/UvvocVw3G
	HrENMlKF6fk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E305667B6;
	Mon, 19 Mar 2012 17:36:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67ACA67B5; Mon, 19 Mar 2012
 17:36:31 -0400 (EDT)
In-Reply-To: <20120319205300.GA3039@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Mar 2012 16:53:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97C5D7C4-720B-11E1-AC02-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193463>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 19, 2012 at 06:51:42PM +0100, Vincent van Ravesteijn wrote:
>
>> Rewrite user messages to stick to a uniform style for all messages.
>> From the surrounding code, the following guidelines were deduced:
>> - messages start with a capital,
>
> I was surprised by this one, as I think we generally use lower-case
> messages. Grepping shows that lower-case has a slight edge, though it is
> far from decided:
> ...
> PS I was curious if it was simply that some people prefer one way and
>    not the other, but the results are quite mixed. Below is the result
>    of a small script I wrote that calculates "upper-casedness" per
>    author using the above regexes and git-blame.
> ...
>    You can see that some people are usually lowercase and some are usually
>    uppercase, but there are many people near 50%, doing both equally.
>    There's also some inaccuracy in my simplistic sampling. For example,
>    of my 13 upper-case messages, 11 of them are "BUG:".

I had a vague impression that plumbing messages tend to be lowercase.  If
it is not be too much trouble, it might be interesting to redo the numbers
divided into the plumbing and Porcelain messages. Perhaps these "50%"
folks updated both plumbing and Porcelain. Another possibility is that
they tried to follow the local convention when they added a new one, or
reworded an existing one.

If we would be rewording, we would only be doing the Porcelain messages,
so I am OK with either way.
