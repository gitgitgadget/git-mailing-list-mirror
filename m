From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --interactive commits order
Date: Wed, 11 May 2011 10:24:24 -0700
Message-ID: <7v39klgng7.fsf@alter.siamese.dyndns.org>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com>
 <m2d3jr1mev.fsf@Spindle.sehlabs.com>
 <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
 <BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com>
 <7vwrhygmrp.fsf@alter.siamese.dyndns.org>
 <BANLkTikV_TSEE1cgr=EOhuD0f8KP2vh-tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	git@vger.kernel.org
To: Richard Peterson <richard@rcpeterson.com>
X-From: git-owner@vger.kernel.org Wed May 11 19:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKD9Q-0003Hb-Ky
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 19:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab1EKRYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 13:24:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab1EKRYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 13:24:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C816145D7;
	Wed, 11 May 2011 13:26:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6GIrP89EAFKJNJcBtXmbYxh6z/c=; b=bfYg0V
	EUObZ41BJRxNennjiURrr571Te/NN4IdDrNgYGTN7s7sKjIt7crYKY6zm44uKShX
	YHYzVWN53VyaQZiEYwruzn5MvqkT53iMill4nZvRUN8eH/Qwj0tQkULEEeJMIqmr
	b7weDxtq942LqciD+szew+qKWj/R/EFq2Qe7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q2mSwkXL1W4gqEks7jsmeR+Imo7BxxZX
	nVWi9HT+TT0FthK5ErBqvF2dTPowrMtEtCKSzpQbAZrLxzupNKl4vWZeSLC7avkB
	or5LiOW3UNc1/cU841ZRcvhTI7VY9xbLGQ8M7vlbiZXN/z0xDdg3Dcn+bJ48WdBL
	m7HvUFIpQA8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8496545D4;
	Wed, 11 May 2011 13:26:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E669845D2; Wed, 11 May 2011
 13:26:31 -0400 (EDT)
In-Reply-To: <BANLkTikV_TSEE1cgr=EOhuD0f8KP2vh-tA@mail.gmail.com> (Richard
 Peterson's message of "Wed, 11 May 2011 11:43:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D35F0B48-7BF3-11E0-BB7A-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173415>

Richard Peterson <richard@rcpeterson.com> writes:

> On Tue, May 10, 2011 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Devils lie in the details.  For example, should squash/fixup come before
>> or after the squashed commit when --reverse is in effect, and why?
>>
>> Should "rebase --reverse --continue" work after it gets interrupted, if
>> not why not?
>
> Yes, it should work,...

Of course, if you start with --reverse, it is clear and obvious that
'continue' should continue with the reversed instruction sheet, and it
probabaly should take --reverse as a no-op when given with --continue.
The original question should have been written more carefully to avoid
soliciting the response that addresses that uninteresting case.

You start 'rebase' (without --reverse); it stops with conflict.  Now what
should happen when you say 'rebase --reverse --continue' now?  Does it
error out because you are not allowed to change your mind once you
started?

That would make it inconsistent for the same "--reverse --continue" not to
error out when the entire process was started with --reverse, but erroring
it out in that case would be awkward.

I am not saying that these small details cannot be worked out. I am saying
that you would need to spend a lot of effort to take care of the details
to avoid making it confusing to the users.  And I am also saying that it
is not even worth wasting the brainpower spent discussing these in this
thread, if the only "benefit" resulting from it is to add an option that
allows some people to have an ordered list of things to do "First I do
this and then I do that" that has to be read backwards. Why spend extra
effort only to introduce something confusing?
