From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sat, 09 Sep 2006 00:27:01 +0200
Organization: At home
Message-ID: <edsqmj$gh3$2@sea.gmane.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> <20060908184215.31789.qmail@science.horizon.com> <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 09 00:30:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLord-0007s3-VX
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 00:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWIHWaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 18:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIHWaR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 18:30:17 -0400
Received: from main.gmane.org ([80.91.229.2]:9091 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751195AbWIHWaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 18:30:16 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GLorL-0007ny-2o
	for git@vger.kernel.org; Sat, 09 Sep 2006 00:30:03 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 00:30:03 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 00:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26721>

Jon Smirl wrote:

>> > Here is another way to look at the shallow clone problem. The only
>> > public ids in a git tree are the head and tag pointers. Send these to
>> > the client. Now let's modify the git tools to fault the full objects
>> > in one by one from the server whenever a git operation needs the
>> > object.  Dangling references would point to 'not-present' objects.
>>
>> Er... that would fault in a gigabyte the first time someone ran gitk,
>> or several other history-browsing commands.  Don't you need a way to say
>> "tell the user this isn't present and will take an hour to download"?
> 
> gitk would need to be modified to only run enough of the commit tree
> to draw what is displayed in the window.  As you page down it would
> retrive more commits if needed. There is no need for gitk to run 250K
> commits when I'm usually never going to look at them all. Of course
> this may mean some rework for gitk.

Or remembering to set --max-count or --max-age parameters to gitk (which are
then passed to git-rev-list).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
