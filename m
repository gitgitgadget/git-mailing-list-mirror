From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Sun, 27 Apr 2014 18:27:20 +0100
Message-ID: <535D3DF8.4020904@game-point.net>
References: <535C47BF.2070805@game-point.net> <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:27:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeSrL-00070K-N7
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 19:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbaD0R1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 13:27:18 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:36052 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaD0R1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 13:27:17 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 9E20F18A09AC;
	Sun, 27 Apr 2014 12:35:06 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247208>

On 27/04/2014 09:51, Robin Rosenberg wrote:
>> Currently, git records a checksum, author, commit date/time, and commit
>> message with every commit (as get be seen from 'git log').  I think it
>> would be useful if, along with the Author and Date, git recorded the
>> name of the current branch on each commit.  The branch name can provide
>> useful contextual information.  For instance, let's say I'm developing a
>> suite of games.  If the commit message says "Added basic options
>> dialog", it might be useful to see that the branch name is
>> "pacman-minigame" indicating that the commit pertains to the options
>> dialog in the Pacman minigame.  Basically, I'm saying that well-named
>> branches can and do carry useful contextual information that oughtn't to
>> be thrown away.  Currently, when you delete that branch, you lose the
>> branch name altogether.
>>
>> So what do you think?  Would it be good to have a patch to add this feature?
>
> Branch names are usually poorly named, so often you don't lose much. One way

Speak for yourself - I give my branches useful names.  :-)  I definitely 
feel that I am often losing useful contextual information by throwing 
away the branch name.

> some people to is to always merge with --no-ff, that way you see the branch
> name in the merge commit.

But surely, it's recommended with Git that you try to avoid doing 
--no-ff merges to avoid commit noise?  Also, it is a lot more hassle 
(and no doubt, CPU cycles) to track down where a branch was merged to 
try and figure out which branch name a commit pertained to, not to 
mention the fact that the commit could've been moved since.  Nothing 
short of tagging the commit with the branch name when the commit is made 
will definitely record the branch name at the time of committing.

> A very popular way of tracking context is to add some id, such as a bugzilla issue
> number, to the header or footer of the commit message. Often a branch contains many
> issues, but the branch itself isn't very interesting. Tools like gitblit, gitweb,
> gerrit etc can easily be configured to link to the issue using a regular expression.

Yes, and I have done this kind of thing in the past.  However you really 
don't want to put the bug# on every single commit pertaining to that 
bug; you have to go to the effort of looking the bug# up every time, 
you'll sometimes forget, and besides it takes up space that could be 
used for a commit message.  As short commit messages are valued in Git, 
it's particularly bad to waste space this way.  Much better would be to 
include the bug# as part of the branch name, and then if you record the 
branch name upon checkin you always get a reference to the bug#.

Also, you don't always have something you can link a commit to in an 
issue tracker.  You may just be implementing a feature that has been 
agreed upon, independently of any such tracker.  In that case, there's 
no bug# to link to.

-- 
Best regards,
Jeremy Morton (Jez)
