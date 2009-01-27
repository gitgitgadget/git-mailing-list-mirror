From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: connecting existing local git repository to svn
Date: Tue, 27 Jan 2009 14:02:15 +0100
Message-ID: <497F05D7.3060607@drmicha.warpmail.net>
References: <497E8927.1060506@gmail.com>	 <497EE386.5050805@drmicha.warpmail.net> <497EE4E8.8070705@gmail.com> <bd6139dc0901270416u22b60fefp472935470b1db929@mail.gmail.com> <497F0280.2070400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 14:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRnbV-0003jT-HL
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 14:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbZA0NCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 08:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbZA0NCU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 08:02:20 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40537 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061AbZA0NCT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 08:02:19 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.fastmail.fm (Postfix) with ESMTP id D8CAE25B329;
	Tue, 27 Jan 2009 08:02:18 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 27 Jan 2009 08:02:18 -0500
X-Sasl-enc: rh547+i6OVDc4Jbnn11sWDGiXIf9ZRMFiSjUjYFbGA+x 1233061338
Received: from [139.174.44.153] (sobolev.math.tu-clausthal.de [139.174.44.153])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DE27B3CF88;
	Tue, 27 Jan 2009 08:02:17 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <497F0280.2070400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107341>

Ittay Dror venit, vidit, dixit 01/27/09 13:48:
> 
> Sverre Rabbelier wrote:
> 
>> On Tue, Jan 27, 2009 at 11:41, Ittay Dror <ittay.dror@gmail.com> wrote:
>>   
>>> git: ----v1----v2----v3--v4---v5
>>> svn:                     \---v4--v5
>>>
>>> so the svn history starts from v3, but the git history remains unchanged.
>>>     
>> Create the new branch from v3 then, and use git svn to pull it in.
>> Then you can do 'git rebase that-svn-branch' on your git branch to put
>> all commits (not as one big commit) on top of that branch point. Now
>> you 'git checkout' that-svn-branch and do 'git reset --hard
>> the-git-branch', which should now consist of
>> v1--v2--v3--v4(git)--v5(git), etc. If you do 'git svn dcommit' from
>> the that-svn-branch now it should dcommit to svn each of your git
>>   
> sorry, my ascii art was confusing:
> 
> git: ----v1----v2----v3--v4---v5
> svn: v1-4---v5
> 
> v1-4 is v1 to v4 squashed together. (e.g., if i added a file in v2 and 
> removed in v3 it will not appear in svn history)

Well, for git and svn "revisions" are really "versions" of the complete
tree, not changesets. Have messed around with hg lately? ;)

On the other hand, a commit that introduces a new version is the
difference with respect to the previous "version".

Ususally it's clear what is meant, but you seem to mix both notions.

So, if v? denotes a version, then v4 is the result of all commits
leading up to v4. It *is* v4. "squashing" applies only to commits
("changes").

In any case, Sverre's as well as my suggestions should do what you want.
Why not try it out if you doubt it?

Cheers,
Michael
