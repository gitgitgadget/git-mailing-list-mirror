From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 13:25:40 +0100
Message-ID: <4909A7C4.30507@op5.se>
References: <18696.32778.842933.486171@lisa.zopyra.com>	<1225343538.10803.9.camel@maia.lan>	<18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 13:29:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvWdx-0004Ub-4M
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 13:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbYJ3MZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 08:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbYJ3MZr
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 08:25:47 -0400
Received: from mail.op5.se ([193.201.96.20]:58207 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbYJ3MZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 08:25:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 472B41B80048;
	Thu, 30 Oct 2008 13:20:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HMXi4+ZybzfI; Thu, 30 Oct 2008 13:20:14 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 98D6B1B8004E;
	Thu, 30 Oct 2008 13:20:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <18697.42140.459170.891195@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99464>

Bill Lear wrote:
> On Thursday, October 30, 2008 at 06:04:54 (-0600) Bill Lear writes:
>> On Wednesday, October 29, 2008 at 22:12:18 (-0700) Sam Vilain writes:
>>> On Wed, 2008-10-29 at 09:23 -0600, Bill Lear wrote:
>>>> We use git in a way that makes it desirable for us to only push/pull
>>>> to the same remote branch.  So, if I'm in branch X, I want 'git push'
>>>> to push to origin/X, and 'git pull' to fetch into origin/X and then
>>>> merge into X from origin/X.
>>>>
>>>> In other words, we want git push/pull to behave in branches other than
>>>> master the same way it does when in master.
>>>>
>>>> I have discovered the '--track' option when creating a local branch,
>>>> and this appears to me to be the thing that gives us the desired
>>>> behavior.
>>> As things currently stand this is not achievable behaviour.  The
>>> behaviour of 'git push' is to push all matching refs.  If you are lucky
>>> this is what you intended, but it also pushes any changes to *other*
>>> branches that you have made.
>>>
>>> I have tabled a change proposal to make it work as you suggest in a
>>> separate thread.
>> Ok, now I'm confused.  The ONLY thing I want to prevent is the
>> "crossing of streams" issue.  If I am on branch X and issue 'git
>> push', I want X, and ONLY X, to be pushed to the remote repository's X
>> branch --- I don't care if other branches are pushed to their
>> respective remote branches, as long as they don't get merged to X.
> 
> Oh, and also the same thing for 'git pull' --- sorry to leave that out.
> 

This particular bikeshed was painted a long time ago, with the consensus
going in favour of "git push" pushing all *matching* refspecs.

To convince people, I think you need to either come up with arguments
nullifying all the arguments *for* pushing all matching refspecs along
with patches to make the default configurable, with your preferred way
as a default, and a nifty enough shorthand for pushing/fetching all
matching refspecs. For preference, they should be at least 3 separate
patches.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
