From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Tue, 25 Aug 2009 19:20:26 -0700
Message-ID: <7v3a7fl3it.fsf@alter.siamese.dyndns.org>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org>
 <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org> <20090826110332.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 04:20:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg880-0007xH-Be
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 04:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbZHZCUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 22:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbZHZCUj
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 22:20:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbZHZCUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 22:20:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A09736A33;
	Tue, 25 Aug 2009 22:20:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=t/ly3VfXMF6mOIYaoRqc1X+E8pA=; b=Pbu9+C7ZVz0p3uQN0vIJETy
	xfiP8cAu8NeppGo1/KLdIU20d/gQr1GasxLicCLsPAGYra4SX5EqfnevOdrJGfAv
	1z+0ev7daJQTGLaQLBnVFUzMKCOVsOh8OrAAa8kJeFjus0CGoq+Hcq51GYVn3+SA
	NrMDfneTK/ndYOgHpyNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sDUvn61vA4ZmrAE5h88+qh4jCvHK3H+2dfdr+v0Ao66ufq4dG
	GsWYybHlVpLLzlrfSxNGbsnXNj5g7Qszpj+WJI6Wrbm9IXh6XTQBueltSUMtx5NZ
	h7YGruAdlqLy1/fpvyBYS0mF7wPwfw7YbzgkMPnGMBkTj3on8POZczhY4o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1729136A2D;
	Tue, 25 Aug 2009 22:20:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0252436A2C; Tue, 25 Aug 2009
 22:20:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 097EDF58-91E7-11DE-8E0E-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127060>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> What I meant was that I would not want to spend any more of _my_ time on
>> the definition of the scissors for now.  That means spending or wasting
>> time on improving the 'pu' patch myself, or looking at others patch to
>> find flaws in them.
>>
>> Of course, as the maintainer, I would need to look at proposals to improve
>> or fix bugs in the code before the series hits the master, but I would
>> give zero priority to the patches that change the definition at least for
>> now to give myself time to work on more useful things.
>
> I am hoping that you didn't mean to say that other people on the list
> mustn't look at such patches and help improve them either?
>
> Perhaps you can rephrase your message in a more positive way, just like
> you request other people to do in their proposed commit log messages?

Ok, I agree that the way I worded the message was suboptimal, so let's try
again.

I would appreciate if the members of the list come up with an alternative
definition with a good implementation that they can agree on, and present
the result as a list consensus, with a solid justification to replace the
crap I have queued in 'pu', in the form of an applicable patch.  Because I
consider that the exact definition of what a scissors line looks like is
an insignificant detail, I would prefer to see that process happen without
involving me.

By the way, I already queued your documentation patch, as adding the part
that describes what a "scissors" line is good for is a very good idea.
The "community" patch to replace the definition of scissors line may have
to update the part that describes what a "scissors" line looks like in
your patch.
