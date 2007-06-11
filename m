From: Scott Lamb <slamb@slamb.org>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 16:41:46 -0700
Message-ID: <466DDDBA.6060500@slamb.org>
References: <20070608202236.GJ25093@menevado.ms.com> <200706111656.33696.simon@lst.de> <81b0412b0706110844i12ebe52m21735815cc06effa@mail.gmail.com> <200706112042.16331.simon@lst.de> <20070611201232.GA4649@steel.home> <466DBCAB.8090006@slamb.org> <20070611231648.GC4649@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 01:42:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxtWM-0003Yq-2F
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 01:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXFKXly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 19:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbXFKXly
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 19:41:54 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:45777 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbXFKXlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 19:41:53 -0400
Received: from slamb-mac.dhcp.2wire.com (slamb-mac.vpn.slamb.org [172.16.0.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id D4BD7980D1;
	Mon, 11 Jun 2007 16:41:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070611231648.GC4649@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49901>

Alex Riesen wrote:
> Scott Lamb, Mon, Jun 11, 2007 23:20:43 +0200:
>>>>>  git-p4 clone //depot/project/path [libs/project/path] [rev-range]
>>>> I'm not sure I understand the libs/project/path part, ...
>>> Your client contains the mappings. It defines how the pathnames on the
>>> p4 server relate to that on your computer. In the example above file
>> >from the depot path //depot/project/path can be found in the directory
>>> of the p4 client in the subdirectories libs/project/path.
>> git-p4 doesn't even use a p4 client, ...
> 
> I didn't say: "using p4 client, figure out where to put the files".
> I said: _here_ is the mapping, put the files where I told you to.

No, you didn't say. The words you used would make equal sense with "the 
tool should look for //depot/project/path in the working copy at 
libs/project/path".

>>>> Han-Wen implemented also support for importing multiple depot paths at 
>>>> the same time (and tracking them in one git branch).
>>> And where does he put the depot paths? As they are in depot? How does
>>> this corelate to the setups done by genuine P4 users (the poor souls)
>>> where the mappings are not always 1-to-1 right from the root? Or you
>>> haven't got any?
>> Could you give a concrete example of what you have and what you are 
>> trying to produce?
> 
> Get the p4 file //depot/project/file and put it into git as
> libs/project/file.

Okay. Keep in mind that you're the first person to find this important.

> 
>>>> The environment I'm working in is not too big and fairly liberal and 
>>>> reasonably disciplined.
>>> You must be very strange environment indeed. Carefully balanced.
>> Not that strange. My company's setup is pretty simple, too. The project 
>> I'm working on just uses has each branch under 
>> "//depot/project/BRANCH/...".
> 
> It is not a branch (as a "line of development"). It is merely a
> directory with server-side backup. Why do people continue call them
> branches, I wonder...

You're being deliberately dense, but I'll explain anyway.

We have several branches of our code. We keep each one in Perforce under 
//depot/project/BRANCH/... with appropriate integration history between. 
We follow the best practices outlined in the Perforce manual. [1] We use 
the same terminology as defined in the Perforce manual.

 From your comments, I would guess that you have badly mismanaged your 
Perforce tree. Since the other people working on the tool apparently 
have not, you may have to do your own work to migrate away.

Subversion has a very similar model to Perforce (the main differences 
being that svn does not track merge history and does not have a separate 
tag system). I have a Subversion repository in which I did not follow 
the recommended practices for branching. Who do I blame for that? Me. 
Who will fix it? Hopefully me. I may ask for help, but I'll do so with a 
better attitude than you.

>> Maybe your environment is the odd one?
> 
> Just what do you think is a client view? Ever wondered what the
> right-hand side of lines in the "View:" section is for?

I know what client views are, and I know what they are capable of. I can 
say the same thing about symlinks. Is an importer tool broken if it does 
not follow a bizarre reorganization of the source working copy through 
symlinks?

[1] - 
http://www.perforce.com/perforce/doc.072/manuals/p4guide/06_codemgmt.html#1065698

-- 
Scott Lamb <http://www.slamb.org/>
