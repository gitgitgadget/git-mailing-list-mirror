From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Sun, 30 Aug 2009 13:31:47 -0700
Message-ID: <7vzl9h9h70.fsf@alter.siamese.dyndns.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908292116060.28290@iabervon.org>
 <7vskfat07h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:32:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhr4H-00023K-WC
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbZH3Ub4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 16:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbZH3Ub4
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:31:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZH3Ub4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 16:31:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E2F073D54A;
	Sun, 30 Aug 2009 16:31:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xcg/VV4wI+dUSI+ha+HQk5A5dYU=; b=wA/9gT
	QPF7sSVAAJ0zk/FFJnLWf76FxEsXsbKA7sIXfNiXNPvg4KWNzcZJI6aAtUjBtCvy
	0/J5XUfP562WnchAtIZO+ILmLutZFH5eUtDo9p9uR29W11rQCLFw0u+uV+wnf+4F
	XtmPnjipXnqvB3i89T1GpTzpbSFo4RAQgJE+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qwblm1c2FPsv0hmWSm74z/FM27CnPrWy
	aX5afezhvRgR39FRi42HZuC96Ny3ogtLJu/5+NM4FO2uUGQ2bFpGHzZWe2i7sC6a
	AVpTeFd6OWlssZif4D0LGZ22E947OGxj53ygmz0wIzUhkZiGQ+kONLVID0W4igv2
	6zpvTSnVv4s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C58633D548;
	Sun, 30 Aug 2009 16:31:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 517B53D546; Sun, 30 Aug 2009
 16:31:48 -0400 (EDT)
In-Reply-To: <7vskfat07h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 29 Aug 2009 21\:06\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28B22360-95A4-11DE-8207-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127432>

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>>> There was a discussion that suggests that the use of colon ':' before vcs
>>> helper name needs to be corrected.  Nothing happened since.
>>
>> I believe the outcome of that discussion was:
>>
>>  - We want to keep supporting using regular location URLs that are URLs of 
>>    git repositories (e.g., http://git.savannah.gnu.org/cgit/xboard.git), 
>>    and we probably want to do it with a helper which runs when 
>>    run_command() is given "remote-<scheme>". I think installing hardlinks 
>>    in EXECPATH ended up being the best implementation here.
>
> That is different from what I recall.
> ...
> And from my point of view, this is what is blocking the series...

Just to make my position clear.

I brought up the issue of "should we leave it as a single colon that
confuses scp-like syntax and forces us to have three extra hardlinks?" in
the message I am following up to, not because I firmly am on that side of
the argument, but because I thought your version of "outcome" did not
match my recollection around that particular issue.  I am more or less
neutral myself.  Avoiding the confusion seems obviously the simple and
right thing to do, and I cannot think of obvious downsides of such a
change, but there probably are some downsides you have in mind, and I can
well imagine the issue may become "perfect is the enemy of good".

And I said "blocking the series", not in the sense that _I_ demand to
change it from colon to something else, but in the sense that I recall the
issue hasn't been settled in the discussion.
