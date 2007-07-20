From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 23:36:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707202320300.16498@reaper.quantumfyre.co.uk>
References: <858x9ez1li.fsf@lola.goethe.zz> <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707201210550.27249@woody.linux-foundation.org>
 <200707202302.57788.johan@herland.net> <alpine.LFD.0.999.0707201421110.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 00:36:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC15d-0008HT-LO
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 00:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761196AbXGTWg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 18:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756937AbXGTWg2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 18:36:28 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:56288 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755583AbXGTWg1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 18:36:27 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 5477FB0EBB
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 23:36:26 +0100 (BST)
Received: (qmail 27845 invoked by uid 103); 20 Jul 2007 23:36:25 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3701. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.032634 secs); 20 Jul 2007 22:36:25 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 20 Jul 2007 23:36:25 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LFD.0.999.0707201421110.27249@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53125>

On Fri, 20 Jul 2007, Linus Torvalds wrote:

>
>
> On Fri, 20 Jul 2007, Johan Herland wrote:
>>
>> Does this mean that you are firmly opposed to the concept of storing
>> directories in the index/tree as such, or that you are only opposed to
>> (some of) the implementation ideas that have been discussed so far?
>
> I've already sent out a *patch* to do so, for chissake. It handled all
> these cases perfectly fine, as far as I know, but I didn't test it all
> that deeply (and made it clear when I sent that patch out).
>
> In fact, in this whole pointless discussion, I think I'm so far the only
> one to have done anything constructive at all. Sad.

There was Dscho's .gitignore based patch too ...

>
> So here's my standpoint:
>
> - people who use git natively might as well use the ".gitignore" trick.
>   It really *does* work, and there really aren't any downsides. Those
>   directories will stay around forever, until you decide that you don't
>   want them any more. Problem solved.
>
>   Sure, if you export the git archive into some other format, you might
>   well want to do something about the ".gitignore" files (like just
>   delete them, since they won't be meaningful in an SVN environment, for
>   example, but you might also just convert them into SVN's "attributes"
>   or whatever it is that SVN uses to ignore files).

Personally I quite like this approach - I'm going to use it to keep all 
the empty directories from Subversion in my importer.  It seems to address 
everthing quite neatly.

I don't really understand the objections ... especially since I can't see 
why you want an empty directory if you're not going to put _something_ in 
it - in which case, presumably you want to ignore it (so maybe a 
.gitignore containing * would be better than an empty one)?  However, I'm 
sure that if people want it, they have a reason.

> SCM is too important to play games with. Git gets things right, and I
> doubt people really _realize_ that the "tracks content" is why git is so
> much better, and why git can do merges so much faster and more reliably
> than anybody else.

This is the thing that made me interested in git back in April '05.  I 
couldn't see what we were going to end up with at that point - but I was 
_convinced_ that due to the underlying design it was worth watching. 
Being a python type (sorry ... :$) hg looked interesting when it sprang up 
- but they threw away what I considered to be one of the most compelling 
features of git (at the time there wasn't the wealth of really nice tools 
that we now have).

In fact, I really should say "Thank you Linus", since I came that close to 
writing an SCM from scratch myself - having been using Subversion with 
branches for quite some time (and CVS before that - and yes I do mean 
branches + CVS).  Now I no longer feel the need to write an SCM - just a 
longing to use git.  git is probably better than anything I would have 
come up with too. :D

-- 
Julian

  ---
She is descended from a long line that her mother listened to.
 		-- Gypsy Rose Lee
