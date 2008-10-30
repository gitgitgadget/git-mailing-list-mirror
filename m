From: Bill Lear <rael@zopyra.com>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 09:42:15 -0600
Message-ID: <18697.54743.601331.133842@lisa.zopyra.com>
References: <18696.32778.842933.486171@lisa.zopyra.com>
	<1225343538.10803.9.camel@maia.lan>
	<18697.41702.241183.408377@lisa.zopyra.com>
	<18697.42140.459170.891195@lisa.zopyra.com>
	<4909A7C4.30507@op5.se>
	<2008-10-30-14-52-52+trackit+sam@rfc1149.net>
	<4909BF58.9010500@op5.se>
	<2008-10-30-15-23-16+trackit+sam@rfc1149.net>
	<4909CABD.1040708@op5.se>
	<2008-10-30-16-04-08+trackit+sam@rfc1149.net>
	<4909D1FE.2080403@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:43:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZgN-0007ZY-PM
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbYJ3PmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbYJ3PmY
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:42:24 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61228 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbYJ3PmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:42:23 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m9UFgJE27104;
	Thu, 30 Oct 2008 09:42:19 -0600
In-Reply-To: <4909D1FE.2080403@op5.se>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99490>

On Thursday, October 30, 2008 at 16:25:50 (+0100) Andreas Ericsson writes:
>Samuel Tardieu wrote:
>> * Andreas Ericsson <ae@op5.se> [2008-10-30 15:54:53 +0100]
>> 
>>> Correct me if I'm wrong, but wouldn't my suggestion of not trying to
>>> push (even matching) branches that haven't been updated since we last
>>> fetched from the remote do exactly the same thing for your particular
>>> use-case, but without syntax change and all the annoying minor parts
>>> that it entails?
>> 
>> Not exactly. I often do some work on a branch which does not mandate
>> a topic branch and have to switch branches to fix a bug for example.
>> This would continue to push unterminated changes as well.
>> 
>> Typical use case, which happens (to me) quite frequently:
>> 
>
>...
>
>>
>> Argh, "master" has been pushed as well. Ok, I could have done
>> 
>
>Ah, I see. I sympathize, although I really do think you'd be
>better off by learning to explicitly push things.

Exactly my concerns when I raised this issue originally.  It's hard to
teach people to do this:

% git push origin master

or:

% git pull origin master

so that when they intend and MUST do this (lest chaos ensue):

% git push origin ReleaseBranch

or this:

% git pull origin ReleaseBranch

they don't mistakenly do this:

% git push

or:

% git pull

the reason being that every manual our users read says "use git push",
use "git pull", the examples being written for 'master' branch usage,
and people just assume that 'git push'/'git pull' are smart enough to
know which branch you are on and do the same logical thing as a bare
'git push'/'git pull' does when on master.

Several times this has happened to us: people make this mistake and
push or pull stuff into a branch they do not want.  The pull is not so
bad, but the push messes up our central repo.  This has happened both
here at my current company, and my previous one, and the persons
making the mistakes are neither sloppy nor inexperienced.


Bill
