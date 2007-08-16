From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Thu, 16 Aug 2007 13:08:05 +0200
Message-ID: <46C43015.7080804@gmail.com>
References: <1187026955.2688.4.camel@laptopd505.fenrus.org> <1187037445.6628.98.camel@heimdal.trondhjem.org> <1187054366.2757.0.camel@laptopd505.fenrus.org> <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu> <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost> <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost> <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org> <20070814193333.GI21089@ftp.linux.org.uk> <46C2548D.80605@gmail.com> <alpine.LFD.0.999.0708151846130.16414@enigma.security.iitk.ac.in> <46C30220.6060007@gmail.com> <68B09015-4411-470A-BA88-732969469AA2@mac.com> <46C42DCB.1060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Satyam Sharma <satyam@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 13:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILdHM-0001cU-ER
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 13:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbXHPLMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 07:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbXHPLMU
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 07:12:20 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:49681 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbXHPLMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 07:12:19 -0400
Received: from [213.51.146.188] (port=60263 helo=smtp3.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1ILdGr-0006Bl-31; Thu, 16 Aug 2007 13:12:09 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:33696 helo=[192.168.0.3])
	by smtp3.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1ILdGp-0000XH-1G; Thu, 16 Aug 2007 13:12:07 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <46C42DCB.1060502@gmail.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56004>

On 08/16/2007 12:58 PM, Rene Herman wrote:

> On 08/15/2007 03:52 PM, Kyle Moffett wrote:

>> If you were going to do that I'd just suggest making git aware of the 
>> "user.*" extended attributes and having it save those into the git 
>> repo along with the permission data.
> 
> Am looking at it but am not so sure that's a very good idea. I guess 
> it'd be largely okay-ish to require the repo to be on a filesystem that 
> supports EAs for this feature to work, but keeping the attributes intact 
> over file system operations seems not all that easy (yet). Having not 
> used EAs before I may be missing something but my version of "cp" for 
> example (GNU coreutils 6.9) appears to not copy them. Nor do they seem 
> to survive a trip through GNU tar 1.16.1. EAs appear to not be very 
> useful unless every single tool supports them -- a repo should be 
> resistant against simple operations like that.
> 
> Googling around, I see subversion already has this and calls the 
> meta-data "properties" (svn propset/get and friends). It uses a few 
> properties itself, such as the svn:executable property (which I saw is 
> also the only permission bit git keeps) and svn:ignore, which serves the 
> same role as the .gitignore files for git. Both those would fit into 
> this scheme nicely for git as well, if git were to do something similar 
> and reserve for example the "git.*" namespace for internal use.
> 
> Junio (and others), do you have an opinion on this? If these properties 
> are versioned themselves such as in svn I believe it's a decidedly 
> non-trivial addition (and I'm a complete git newbie) but to me, they 
> look incredibly useful, both for the original "maintainers" properties 
> (and anyone else one would want to come up with such as summary 
> properties and author/license stuff) and even for git internal reasons 
> such as sketched above.
> 
> The git-blame thing as sketched before by Linus would never be able to 
> point out mailing lists, or general lists of "interested parties" for 
> example, but these properties can do anything...

The svn implemention is that a single property is free-form text. As such, I 
guess a property would be just another file, although one that only lives in 
the index and is linked from the file/directory it is a property of.

Perhaps that immediately suggests an implementation to someone already 
familiar with git internals?

Rene.
