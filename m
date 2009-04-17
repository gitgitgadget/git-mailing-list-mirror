From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git & ssh on F10 server
Date: Fri, 17 Apr 2009 18:17:28 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0904171812330.8773@reaper.quantumfyre.co.uk>
References: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP> <alpine.LNX.2.00.0904171716150.8346@reaper.quantumfyre.co.uk> <FD77671D77E2465097BD60A1E144BB91@HPLAPTOP>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 19:20:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lurjz-0000hh-5D
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 19:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbZDQRTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 13:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbZDQRTE
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 13:19:04 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36968 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753929AbZDQRTD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 13:19:03 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B07B1132855
	for <git@vger.kernel.org>; Fri, 17 Apr 2009 18:19:00 +0100 (BST)
Received: (qmail 28761 invoked by uid 103); 17 Apr 2009 18:17:28 +0100
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9248. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.039496 secs); 17 Apr 2009 17:17:28 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Apr 2009 18:17:28 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <FD77671D77E2465097BD60A1E144BB91@HPLAPTOP>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116761>

On Fri, 17 Apr 2009, Aaron Gray wrote:

> Julian,
>
> Thanks for the response.

Not a problem, but please keep the mailing list on the CC ...

>>  On Fri, 17 Apr 2009, Aaron Gray wrote:
>> 
>> >  Hi,
>> > 
>> >  we have a Fedora 10 server in SELinux enforcing mode setup running 
>> >  git-deamon and gitweb (with home grown SElinux policy).
>> > 
>> >  Anyway now we find out you cannot do a 'push' over the basic git 
>> >  protocol, back to the server repository.
>>
>>  You can push over git://, but you get no authentication mechanism so it's
>>  disabled by default.  It's only really useful if you trust everyone who
>>  has IP access to the server.
>
> How do go about I enabling it ?

You have to enable the receive-pack service.  You can either enable it for 
all repositories by using the --enable=<service> option to git-daemon, or 
on a per-repository basis by setting daemon.receivepack to true in the 
repositories that you want to enable push for.

>> >  So now am trying to get git to work over ssh. The repositories are 
>> >  located /pub/git/*/.git
>> > 
>> >  Basic attempts using BerliOS'es instructions for client end failed.
>> > 
>> > 
>> >  http://developer.berlios.de/docman/display_doc.php?docid=1812&group_id=2
>> > 
>> >  Could someone please help us with this.
>> > 
>> >  Aaron
>>
>>  You haven't said what commands you tried, nor what the errors you received
>>  were, so it's a bit hard to say what went wrong ...
>> 
>
> git push ssh://ang@git.site.org/pub/git/llvm/trunk milestone1
> Pushing to ssh://ang@git.site.org/pub/git/llvm/trunk
> fatal:  exec ssh failed.
> fatal:  The remote end hung up unexpectedly

Sounds like git didn't find ssh on your path.
What version of git is this btw?

> A clone failed simularly
>
> I was expecting it to ask for a password. Should I try a DSA certificate ?
>
> Thanks,
>
> Aaron
>
>

-- 
Julian

  ---
"It's my cookie file and if I come up with something that's lame and I like it,
it goes in."
-- karl (Karl Lehenbauer)
