From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Wed, 24 Oct 2007 23:16:26 +0200
Message-ID: <AF6B550F-99FB-4F65-BA07-662AD590D070@zib.de>
References: <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 23:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IknZX-0004rt-Im
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 23:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbXJXVPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754238AbXJXVPK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 17:15:10 -0400
Received: from mailer.zib.de ([130.73.108.11]:46863 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbXJXVPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 17:15:08 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9OLF0ae007777;
	Wed, 24 Oct 2007 23:15:00 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1097b.pool.einsundeins.de [77.177.9.123])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9OLEwPw020155
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 24 Oct 2007 23:14:59 +0200 (MEST)
In-Reply-To: <20071024203335.GJ29830@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62240>


On Oct 24, 2007, at 10:33 PM, J. Bruce Fields wrote:

> On Wed, Oct 24, 2007 at 10:12:29PM +0200, Steffen Prohaska wrote:
>> On Oct 24, 2007, at 9:48 PM, J. Bruce Fields wrote:
>>
>>>
>>>> I want git pull to work like git push.
>>>
>>> That strikes me as a less complete solution, since it only helps  
>>> in the
>>> case where the other branches all happen to be unmodified locally  
>>> (hence
>>> can be fast-forwarded).  In other cases the "git push" will still  
>>> emit a
>>> spurious error.
>>
>> Well, but then there's something you should really think
>> about.
>
> Perhaps, but not necessarily; you may have some branches with local
> changes that you're content to leave unpushed (and un-updated).

Personally, I don't dare to work that way. But if you do want
to keep local changes on branches that would normally be pushed
but you do not want to push them now, you must not call "git
push" without arguments in the first place. Then you'll never
see the error emitted by push.

I put local changes that I do not intend to change right away
on a special branch for/<branch>. I only merge them to <branch>
if I decided to push them, and then I push them soon (maybe
after I prepared more branches and then push all at once).


> So the case where this proposal helps is the case where:
> 	- the user hasn't learned how to name individual branches on the
> 	  push commandline, or has learned to do so, but wants less
> 	  typing, and

Well, as I wrote above "git push" is a too sharp knife for
me. I _never_ have local changes that I don't intend to push.
So "git push" always does the right thing for me.


> 	- the user has one or more unmodified copies of remote branches
> 	  lying around, and
> 	- the user minds being reminded that those copies are out of
> 	  date, and
> 	- the user either has no *modified* copies of local branches, or
> 	  has some but doesn't mind being reminded that they're out of
> 	  date on each push.

I see your point. These are may requirements to make the
proposed behaviour of "git pull" useful. But I'd recommend to
use git exactly as you described when working with a shared
repository:

Just use "git pull" and "git push" and everything will be fine
if you work as follows:
- Use the same branch names that are used on the origin.
- Only check out branches locally that you are especially interested in.
- Only put changes on those branches if you intend to push them.
- Use "git pull" before you start to prepare branches for
   "git push".
- Keep you privat work on branches that are named differently
   from branches in the shared repository.

	Steffen
