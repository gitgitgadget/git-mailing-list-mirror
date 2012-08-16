From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Thu, 16 Aug 2012 10:57:54 -0700
Message-ID: <7vsjbm1zz1.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch> <7vr4r98ah5.fsf@alter.siamese.dyndns.org>
 <87sjbo63pl.fsf@thomas.inf.ethz.ch> <7vfw7o6p1g.fsf@alter.siamese.dyndns.org>
 <7va9xw55aj.fsf@alter.siamese.dyndns.org>
 <20120816162417.GD2853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 19:58:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T24Kc-0007eB-Ev
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 19:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095Ab2HPR57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 13:57:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932814Ab2HPR55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 13:57:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5D649A24;
	Thu, 16 Aug 2012 13:57:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QQIRt+6mFgTVvnKFLamU0OCzwqw=; b=Q+r9WC
	l5RtbyJF+fWndlSzJev+2OsFHx/K02upajOATRJtlwMKf98Vh2IRhUPPYJrLeo89
	74J9dSQCEmILIzCyrtBMnou6DE4cf64H3n0OWA7WzraAwms8Hu2FvGMfgnKwoKBo
	3PrBM3it1BbP+I6el2ysV28GfzRBDaYp9EtoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ApPQmvpatSN/DhfVj6TJDb2Sq8OBV8p3
	KS2XwcVLeafk9UlwaMy2Ea0RE51Cvpx+A2S13xRvVdeaAyWnURFPLcUl+e/yUM/g
	04G8yJXyuX3fezIvAZpc8WEOVCZpbc9TCELbBqq+QUbaw96v3W6PBSqGLBhExfYS
	525MehkbJ+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C335F9A23;
	Thu, 16 Aug 2012 13:57:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 264AB9A22; Thu, 16 Aug 2012
 13:57:56 -0400 (EDT)
In-Reply-To: <20120816162417.GD2853@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 16 Aug 2012 12:24:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E86CE326-E7CB-11E1-8420-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 15, 2012 at 12:22:28PM -0700, Junio C Hamano wrote:
>
>> > The updated rule would be more complex.  If a remote nickname is
>> > used, and a refspec given from the command line is without colon, a
>> > new special rule overrides the current behaviour and tries to match
>> > with a configured refspec.  You would need to desribe what happens
>> > in that case.
>> 
>> It would be something like this.
>> 
>> When you tell "git fetch" to fetch one or more refs from a
>> configured remote by explicitly listing them on the command line,
>> e.g.
>> 
>>     git fetch <remote> <name>...
>> 
>> each <name>... goes through the following process:
>>
>>     - The <name> is turned into the full ref at the remote that
>>       starts from refs/ form by applying the usual fetch dwimmery
>>       (if <name> is a name of a branch, "refs/heads/<name>" would
>>       likely to be the one that is fetched).
>> 
>>     - Then, configured fetch refspecs for <remote> is looked up from
>>       remote.<remote>.fetch configuration variable(s), or "Pull: "
>>       line(s) of .git/remotes/<remote> file.
>> 
>>     - If the LHS of a refspec found in the previous step matches the
>>       full ref we computed in the first step, then the ref at the
>>       RHS of the refspec (i.e. remote tracking branch), if any, is
>>       updated.
>> 
>> If there is no configured refspecs that match the name given from
>> the command line, no remote tracking ref is updated.
>
> That is almost exactly what my patch does, except I am not sure that it
> respects the "without a colon" bit from your first message.

Yeah, I forgot to repeat it in this message, but the above
three-bullet list needs the 0-th item

 - If <name> has already colon in it, following special case rules
   do not apply.

in front of it.

Even though I suspect the updated behaviour may be more useful for
casual users (while making the semantics a bit more difficult to
explain, like the above documentation update), it is a major
regression to existing users if it closes the last escape hatch, so
I guess with your patch we are almost there but not quite there yet.
