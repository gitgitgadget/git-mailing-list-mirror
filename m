From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 06 Apr 2012 14:42:58 -0700
Message-ID: <7vsjggzgd9.fsf@alter.siamese.dyndns.org>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
 <7v7gxs1ud4.fsf@alter.siamese.dyndns.org>
 <CAMP44s0xAvc9aTeBP81tXhX6Q67+7cQ-51C1AWrKPN7bc7=JXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:43:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGGw0-0002NU-73
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 23:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545Ab2DFVnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 17:43:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab2DFVnB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 17:43:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 678B269EF;
	Fri,  6 Apr 2012 17:43:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kp0LiPM2viKJ0gtG5R8QRv/Fkfc=; b=wnNNjZ
	xTfgmqLAadML3mjw2jt0L0wt0W/x6zhq3RBD1ZYP7CvgvtIOqOrRsqdfCFn06UIT
	qxy0sXzb8C0aW1pm5nuOtLMMJz3wCYXugWrXrplgrXZpmmhBhU2cR9N23iFBeh6X
	mu3qK1TMsyDzGTnKjgaOjrB/4MK6ZTfJrYTUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FmoAqSazyCa5f8HXd9L2ZBYmm9cjEOBO
	MuQTZv4yvbTQ+sKO5hJMUnzuFWA2MPfZx4+is2tOp8bx8GmQJpM2S6CQRh+pBm4y
	4pkG+fK1CK9xB6SSTcUJXrDsqQ4dmQVAQWZyOAg4ao7I72al+Lnm+zT11gbfBaiO
	oz36rNuAWG8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E7D969EE;
	Fri,  6 Apr 2012 17:43:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E243369ED; Fri,  6 Apr 2012
 17:42:59 -0400 (EDT)
In-Reply-To: <CAMP44s0xAvc9aTeBP81tXhX6Q67+7cQ-51C1AWrKPN7bc7=JXQ@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 7 Apr 2012 00:28:05 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AC613B2-8031-11E1-B1FD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194913>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Apr 6, 2012 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:
>>>
>>>> Something is better than nothing.
>>>
>>> Yes, but...
>>
>> ;-)
>>
>> This is a good example that sometimes something is worse than nothing,
>> unless watched carefully by a competent reviewer.
>
> And this is a good example of why you shouldn't blindly trust what a
> 'competent reviewer' says, as I'm pretty sure the comment is wrong.

We run the tests under whatever is configured as SHELL_PATH, so whatever
you have on #! line does not matter much (except as a documentation).

But it would not make any sense to running the bash completion tests if
the shell that is running the test script is *not* bash, would it?  That
is the point Peff made---the primary thing his message cared about is not
to cause "make test" fail when your build does not use bash to run tests.

And that seems to have escaped you.

> But hey, if you prefer nothing, fine, drop this patch;...

Adding a test for bash completion is a good thing, and blindly modifying
the completion script without having good tests is a bad idea.

Just add the tests in the right way. Don't break tests for non-bash users.
