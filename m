From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn: Having a "rare" structure
Date: Wed, 05 Nov 2008 18:41:46 +0100
Message-ID: <4911DADA.4010902@drmicha.warpmail.net>
References: <2686a05b0811050204v59edc4a3h7f9ce6c6ecd13058@mail.gmail.com>	 <49119AAD.2010803@drmicha.warpmail.net> <2686a05b0811050736q520f1771t6ffa2840bfb3c308@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Fargas <telenieko@telenieko.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 18:43:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxmPK-0005kG-A2
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 18:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbYKERlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 12:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbYKERlw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 12:41:52 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:49838 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752379AbYKERlv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2008 12:41:51 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A65C41A3354;
	Wed,  5 Nov 2008 12:41:50 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 05 Nov 2008 12:41:50 -0500
X-Sasl-enc: y6kbp/AAaXVyQQMLCOfyiR9y/iK5ohFejEvjNHSjrTZA 1225906910
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0993E28BA7;
	Wed,  5 Nov 2008 12:41:49 -0500 (EST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <2686a05b0811050736q520f1771t6ffa2840bfb3c308@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100165>

Marc Fargas venit, vidit, dixit 05.11.2008 16:36:
> Hi,
> 
> On Wed, Nov 5, 2008 at 2:07 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> git config svn-remote.svn.branches
>> 'django/branches/features/*:refs/remotes/svn/features/*'
>>
>> git config --add svn-remote.svn.branches
>> 'django/branches/releases/*:refs/remotes/svn/releases/*'
>>
>> In fact, you should be able to use your previous branches config when
>> fetching up to r9093, then switch to the config I suggested, and the
>> fetch from r9094.
> 
> I'll try it right now, I have one q... I've been fetching from svn so
> I now have "like a mess" in the branches dir (and their history) is
> there a way to make git-svn forget about everything after r9093 so I
> can do the config change and re-fetch since then? That'd be awesome.

You can delete the bogus branches (using git branch -rd or git
update-ref -d), but I'm not sure if you can reset git svn's state info:
You may try messing with .git/svn/.metadata.

I tried the approach I suggested in the last post for real, and things
seem to work. Only gotcha is I don't know whether django folks will
stick with putting branches under {releases,features}, that would create
problems.

Cheers,
Michael
