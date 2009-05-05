From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Question about rewrite commits
Date: Tue, 05 May 2009 21:46:25 +0200
Message-ID: <4A009791.6010704@dirk.my1.cc>
References: <15aa6cf30905050445k21f8317bt7be65857604cc101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Anner van Hardenbroek <dwlnetnl@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 21:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1Qb6-0003XE-SD
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 21:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbZEETq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 15:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbZEETq2
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 15:46:28 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:50222 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbZEETq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 15:46:28 -0400
Received: from [84.176.79.177] (helo=[192.168.2.100])
	by smtprelay10.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1M1Qax-0001av-1Q; Tue, 05 May 2009 21:46:27 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <15aa6cf30905050445k21f8317bt7be65857604cc101@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118311>

Hi Anner,

I had these 'cosmetic' problems as well and did the surgery like this:

I assume that your commits
    'Introduced...',
    'No HTML...', and
    'A page can now ...'
are on branch 'master' and the righthand track is on branch 
'console-mvc' which starts at 'Introduced...'.
Finally you did 'git checkout master; git merge console-mvc'.

I did the following:
     - give a tag (say 'foo') to the 'No HTML...' commit
     - rebase the console-mvc branch to that tag:
         $ git rebase foo console-mvc
       this will yield to a weird road map in gitk. Don't bother.
     - rebase the master to the new console-mvc branch:
         $ git rebase console-mvc master
       the history will now be linear.
     - remove the tag 'foo'

You may, of course, omit the tagging when you know the sha1's of the 
commits. In your case you will, as they're displayed in gitk.
[ In theory there's a way to identify commits by their commit message 
(see manpage of git-rev-parse), but I didn't make it work. As I 
understood "git show :/foo" would mention the latest commit whose commit 
message starts with 'foo', but I only got error messages. ]

Be noticed that rewriting history isn't a good idea if you already have 
published your work. Your coworkers may get disturbed. ;-)

Hope this helps,

     Dirk


Am 05.05.2009 13:45 schrieb Anner van Hardenbroek:
> Hi!
> 
> I've a question about rewriting commits. I'd like to change the
> branches so that "Introduced BTRmxSoapArgument, second fase + code
> cleanup." is right below (a straight vertical line) "No HTML errors
> because we have nice ones!". How can I do that?
> 
> Thanks,
> Anner.
> 
> --
> Anner van Hardenbroek,
> dwlnetnl@gmail.com
> 
> 
> ------------------------------------------------------------------------
> 
