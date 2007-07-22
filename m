From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 22:50:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjJu-0003bM-Fg
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbXGVVu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756040AbXGVVuZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:50:25 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58729 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755145AbXGVVuY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 17:50:24 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id EA2CDC610F
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 22:50:22 +0100 (BST)
Received: (qmail 28711 invoked by uid 103); 22 Jul 2007 22:50:20 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3722. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.030479 secs); 22 Jul 2007 21:50:20 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 22 Jul 2007 22:50:20 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0707222223460.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53330>

On Sun, 22 Jul 2007, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 22 Jul 2007, Julian Phillips wrote:
>
>> On Sun, 22 Jul 2007, Johannes Schindelin wrote:
>>
>>> 	IMHO this is a better syntax than what is in contrib/, and "git
>>> 	branch" is probably the right place for such a thing, from a
>>> 	user's perspective.
>>
>> Surely checkout would make more sense than branch?  You are effectively
>> checking out into a new directory ... also you may want to get an
>> existing branch (certainly most of my usage of new-workdir is checking
>> out existing branches, e.g. to look at - as in build and play with - an
>> interesting branch that someone else has pushed out).
>
> My rationale here was:
>
> - to make sure that the user cannot check out the same branch as in the
>  current repo, _or some other workdir of it_, and

Since you can checkout any branch you like once you have the workdir, 
this is really an artificial limitation - you are protected when you 
create the workdir, but not after.  This seems more likely to bite 
someone than just making them aware of the pitfalls before hand.  One of 
the main reasons that I aimed for contrib rather than proper git 
originally was the ability to do bad things with realising.

If you want to have a workdir for an exisiting branch then you have to 
create a new one, and then switch it over.  That seems like a really big 
usability wart to me ... certainly it would make the option pretty much 
useless to me.  My original motivation for the new-workdir script was to 
give me the ability to flatten out branches from a single repo for when 
I'm working on multiple branches at the same time.

> - to have finer grained lock control, as well as respecting has_symlinks.

Not really sure what this means, since I am too tired to have read the 
actual patch - is it referring to the fact that checkout is shell rather 
than C?  If so, surely that is not really a good justification for putting 
the option in the "wrong" command?

-- 
Julian

  ---
Thud. Thud. Thud. Splat.
         -- (Terry Pratchett & Neil Gaiman, Good Omens)
