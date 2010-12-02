From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Proper way to checkout a tag?
Date: Thu, 02 Dec 2010 09:33:18 +0100
Message-ID: <4CF759CE.5010705@drmicha.warpmail.net>
References: <AANLkTi=b12n0J+Qg4S7i9dnbMHoWvPS3OXP0CDZevT_4@mail.gmail.com>	<20101201195125.GC27347@burratino> <AANLkTim=0dqH=gqbM1xQOWQPCZb78wfsn9wf5WRJJ9vt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 09:35:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO4dg-0004rb-Jr
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 09:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab0LBIff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 03:35:35 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56430 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752274Ab0LBIfe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 03:35:34 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 320005FA;
	Thu,  2 Dec 2010 03:35:34 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 02 Dec 2010 03:35:34 -0500
X-Sasl-enc: y8lQibCCfNS3HZ/KRGT4USDPDSB+cWmBCMSGTscRZpCG 1291278933
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 09D805E6CA1;
	Thu,  2 Dec 2010 03:35:32 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <AANLkTim=0dqH=gqbM1xQOWQPCZb78wfsn9wf5WRJJ9vt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162684>

Dun Peal venit, vidit, dixit 01.12.2010 21:16:
> On Wed, Dec 1, 2010 at 1:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> The idea is this: when you check out a tag or a remote-tracking
>> branch, it is not to make changes to it.  Tags are unchanging,
>> remote-tracking branches track remote state that the user does not
>> directly control.
> 
> Yes, users checkout a release tag just so they can build parts of it.
> There's definitely no intention of creating new changes on top of
> them, and if there is then it should properly be a head (branch).
> 
> I guess that's exactly the use-case for detached HEAD, so I guess the
> answer is that we should all stop being afraid of that superficially
> scary term.

It's really one of the most useful features of git (as Jonathan
explained). There are two things which make it scary:

- The name. We could call it differently (free head, unbound head,
branchless head, west coast head...).

- The garbage collection. It's easy to commit on top of a detached head
by mistake, and once you switch away from that, it's difficult to find
it again (reflog) and easy to lose (gc/prune).

Though the "throw-away" nature of detached heads is a useful feature, we
could possibly help users who commit on top of them better.

Michael
