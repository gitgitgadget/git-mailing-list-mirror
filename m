From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Sun, 12 Jun 2011 14:12:48 -0700
Message-ID: <7vei2ysqi7.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu> <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
 <20110609200403.GA3955@sigill.intra.peff.net>
 <7v4o3xwe5z.fsf@alter.siamese.dyndns.org> <4DF45769.4020403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 12 23:14:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVrz5-0007aO-9h
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 23:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab1FLVNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 17:13:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab1FLVNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 17:13:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0299A52F4;
	Sun, 12 Jun 2011 17:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tDX+uFb6RIqTCT5Dcwo4YNzZRUI=; b=wE+XEX
	soy6hwosnUm/+svfrmjsiQ95AzXY9ODjLxHeEiZVnZXag0qPdpASWJhDYLQ2Hnck
	e6Uh9rL9Db9Ev/F04dQ/5vRcknSECEreo9w2/Zcy18d2PTt2uGCK3KvY6tQb3wX7
	G+58ZQdM5yPJoXDz3dLvzB25NhU5Z9mg1ZNO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=da/uOYYYvZTAusTT+9AbmDc0bGAruZlV
	PMvaMX1nN+eutbcri4Pfx10rcn23eQrbGrf63CeYicn9PHcY7DmklKMTUfzy23Vo
	s0YhD2WwvrHew9OscViWJgfLIxXxBKnDoFlTKFXLNtbttzTPbw/LkmJarShOqwNv
	PloW0gCngxg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B37A52F3;
	Sun, 12 Jun 2011 17:15:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2A8052F1; Sun, 12 Jun 2011
 17:14:59 -0400 (EDT)
In-Reply-To: <4DF45769.4020403@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 12 Jun 2011 08:06:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C5B3E90-9539-11E0-9D25-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175666>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/10/2011 11:48 PM, Junio C Hamano wrote:
>> In short, the proposed "NEXT" does not help in a situation with conflicts,
>> and makes the user experience worse.
>
> The idea of "NEXT" and its friends would indeed be marginal if it only
> applied to "git diff".  The real gain in learnability comes from using
> the same idioms in other commands where they make sense; for example,
>
>     # More consistent alternative to the special "--ours" option:
>     git checkout OURS -- Makefile

I do not see much improvement over --ours here.

>     # This would add more completeness to the
>     # "git checkout <tree-ish> -- PATH" command, and would remain the
>     # default if no <tree-ish> is specified:
>     git checkout NEXT -- Makefile
>     git show NEXT:Makefile

Now, during conflict, you admitted that NEXT would not be helpful for
"diff", but these are even more dubious during conflict.

The point of index that can keep conflicted state (in fact, contrary to
some misperception, index is where the real merge happens, and updating
the working tree is merely to _help_ users to help the index resolve the
conflicts, not the other way around) is that until you resolve conflicts,
"the state for the NEXT commit" is not defined.

How would it improve the support we give to users when you give NEXT to
them, compared with the current system, if you have to say "NEXT" works
most of the time to represent what you would commit next?  You have to
also tell them that in some circumstances there cannot be "NEXT" until
they resolve conflicts, and then they need to learn how to do so with the
index. They need to learn the real thing at that point, unlearning fuzzily
defined "NEXT" illusion.

I certainly do not have any objection against making system easier to
understand, and I do not think implementation complexity nor performance
should trump the usability (I also do not think various conflicting
semantics of proposed "NEXT" are hard to implement efficiently).

I however doubt "NEXT" would help to give users any better understanding,
and that is the biggest problem I have with this topic.
