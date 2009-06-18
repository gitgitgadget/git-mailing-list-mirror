From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Clarify the git-branch documentation of default   start-point
Date: Thu, 18 Jun 2009 09:57:09 +0200
Message-ID: <4A39F355.8020200@drmicha.warpmail.net>
References: <1245303673.24201.3.camel@localhost.localdomain>	 <7vprd2148u.fsf@alter.siamese.dyndns.org> <1245305061.24201.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Nordholts <enselic@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 09:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCVG-0002No-Iu
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 09:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496AbZFRH5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 03:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757066AbZFRH5e
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 03:57:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46246 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756525AbZFRH5e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 03:57:34 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0513E361FE5;
	Thu, 18 Jun 2009 03:57:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 18 Jun 2009 03:57:36 -0400
X-Sasl-enc: WFek5Do4kk8iZDdAIuLpcpc9uaF4G7aHhgDEMgiA09xS 1245311855
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B7B3EB905;
	Thu, 18 Jun 2009 03:57:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090617 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1245305061.24201.12.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121805>

Martin Nordholts venit, vidit, dixit 18.06.2009 08:04:
> On Wed, 2009-06-17 at 22:48 -0700, Junio C Hamano wrote:
>> Martin Nordholts <enselic@gmail.com> writes:
>>
>>> -	is omitted, the current branch is assumed.
>>> +	is omitted, the current branch is assumed.  Note that checking
>>> +	out a remote branch does not make it the current branch.  If a
>>> +	remote branch is desired as start-point it must be an explicity
>>> +	specified.
>>
>> [...] "it" in the second new sentence is unclear.
>>
>> You probably wanted to answer "If I wanted to have _my own 'next' branch_
>> that tracks 'next' from the remote, what should I do?"
> 
> What I am trying to clarify is that a remote branch will never be the
> default for the start-point argument to git-branch, so if someone wants
> a remote branch as start-point, then the branch must be explicitly
> specified.
> 
> For this, the first sentence might actually be enough. If a remote
> branch never is the current branch, and if start-point defaults to the
> current branch, then the start-point can never default to a remote
> branch.
> 
> Should we just stick to the first sentence then perhaps?
> 

I think your usage of "start-point" is a bit unfortunate. What's a
start-point? It's the commit where a branch forks off, or more
precisely: the commit which the new branch's head is set to initially.

So, the start-point is never a branch! Or else it would be a "moving
target".

If you specify the start-point using a branch name it's really the
branch's current head which is used as the start-point.

BUT: If you specify the start-point using a branch name the DWIMery can
kick in and figure out a good default for the upstream branch (see --track).

Michael
