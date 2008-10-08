From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Different svn-id URLs in history
Date: Wed, 08 Oct 2008 10:32:34 +0200
Message-ID: <48EC7022.7030707@drmicha.warpmail.net>
References: <48EB40E1.40506@3d-radar.com> <48EB79D8.6090908@drmicha.warpmail.net> <48EC546F.7060106@3d-radar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Knut Eldhuset <knut@3d-radar.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 10:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnUUZ-0000Y1-1W
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 10:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbYJHIcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 04:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYJHIcs
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 04:32:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39273 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307AbYJHIcr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Oct 2008 04:32:47 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 1B694177D7D;
	Wed,  8 Oct 2008 04:32:46 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 08 Oct 2008 04:32:46 -0400
X-Sasl-enc: nR0p3GgMtjmJif5+d7HkNaSRauFVGL4PwR4me79CJUL8 1223454765
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6686D35545;
	Wed,  8 Oct 2008 04:32:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48EC546F.7060106@3d-radar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97786>

Knut Eldhuset venit, vidit, dixit 08.10.2008 08:34:
> Michael J Gruber wrote:
>> Knut Eldhuset venit, vidit, dixit 07.10.2008 12:58:
>>> Hi,
>>>
>>> After cloning my svn repository, I notice that the svn-id URL is 
>>> different when going back in history:
>>>
>>> git-svn-id: https://server/trunk@300
>>>
>>> vs
>>>
>>> git-svn-id: https://server/trunk/some_folder/project/src@250
>>>
>> I take this is as an invitation for guesswork (given the amount of
>> details)...
> 
> Sorry about that... I'm confused.
>> You probably have commits which don't follow your usual svn repo layout
>> (trunk/some_folder/project/src) but commit to trunk/ directly. The output of
>>
>> svn log -v -r300 https://server/trunk@300
>> svn log -v -r250 https://server/trunk/some_folder/project/src@250
>>
>> should give some clues.
>>
> 
> Svn log shows that the same path has been modified in both cases. I see 

Does "same path" mean:
- same relative to the above paths or
- same absolute path?

> something strange in git, though. Our svn repository has about 6500 
> commits, but git shows over 10.000. Further investigation shows that a 
> lot of svn commits have two entries in git. Some branches off of trunk 
> do not start at r1, but off of a duplicate rNNNN. Could this be due to 
> our unhealthy practice of creating branches off of subtrees in svn? By 
> this I mean create a branch off of 
> https://server/trunk/some_folder/project/src instead of 
> https://server/trunk. If so, what can be done to fix this?
> 
> As a sidenote, during git svn clone, I noticed that each time a new 
> branch or tag was discovered, the "scanning" started back at r1. Is this 
> normal? I would think the history before the branch was already 
> imported. Of course, this could maybe be due to the bad branching 
> practice described above.

svn is typically "abused" in the sense that one svn repo is used for
separate projects (your subtrees). git-svn can deal with non-standard
repo layouts.

I assume you can't share the svn repo publically, can you?
So, in order to help you, we would need to know

- the layout of your svn repo: where are trunk, branches and tags, how
did you create branches and tags in svn, are "projects" entirely separate
- your incarnation of git-svn

Michael
