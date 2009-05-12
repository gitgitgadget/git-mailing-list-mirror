From: Jon Brisbin <jon.brisbin@npcinternational.com>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 12:56:42 -0500
Message-ID: <7444645C-67E8-424E-9073-E831C8DE8656@npcinternational.com>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com> <e2b179460905120940u2d87a591kefbdf659e1badd0c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 19:56:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3wDo-000409-FD
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 19:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbZELR4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 13:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbZELR4n
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 13:56:43 -0400
Received: from mail.npcinternational.com ([63.76.154.140]:29452 "EHLO
	mail1.npci.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752866AbZELR4m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 13:56:42 -0400
Received: from [172.16.0.131] (mail.npcinternational.com [63.76.154.130] (may be forged))
	by mail1.npci.com (MOS 3.10.5-GA)
	with ESMTP id COQ34784;
	Tue, 12 May 2009 12:56:42 -0500 (CDT)
In-Reply-To: <e2b179460905120940u2d87a591kefbdf659e1badd0c@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
X-Junkmail-Whitelist: YES (by domain whitelist at mail1.npci.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118935>

First, thanks everyone for the cogent responses. After a big salad and  
some chicken enchilada soup, I'm now energized to tackle this problem  
with renewed vigor... :)

On May 12, 2009, at 11:40 AM, Mike Ralphson wrote:

> I'm not familiar with the AS400 or SEU but do developers currently
> have a complete copy of the tree to themselves, or do they only check
> out the files they're editing?

They only check out the specific files they need, unfortunately.

> I'm not sure what Rational Developer is likely to want to do in terms
> of getting the edited files back to the AS400 (assuming it supports
> that directly). Are you planning to run (j)git on the AS400 or have
> another step to get the code from a central git repo back to the
> AS400(s)?

Since I work with, but am not a part of, the AS400 group, I don't have  
a copy of Rational to play with. I have used Websphere Studio before,  
though (which I think is the precursor to Rational/eclipse) and it  
used the toolbox utilities (JT400 et al) to transfer files locally,  
allow the developer to work on the file, then put them back on the  
server where they can be compiled. I would assume Rational works  
similarly. This is making me wonder whether any open source scm will  
work for this scenario. We may be tied to IBM's tools or nothing.

> Is any deployment done to a test server? Is there a release process
> you need to integrate with?

We have a test/release cycle that the AS400 group calls  
"implementation" that is basically copying stuff from a development  
400 to the production 400. I'm not sure what role an alternative scm  
would play in this scenario. There's also a fantastically cumbersome  
reverse implementation process called a "refresh", which copies data  
files from production back to development and basically clobbers  
whatever is on development. Only developer libraries are left  
untouched. This seems to me to be a process which could, shall we say,  
use some improvement. :)

> Our devs expect their changes to go live at midnight after they
> 'release' them. Are there similar assumptions for you?

Our deployments have to go through some SOX-compliance ring-around-the- 
rosie, so they don't really have any assumptions as to when changes  
are pushed to production. I could see hook scripts filling doing some  
of the work here. But some manual intervention will be required for  
compliance reasons.

Thanks!

Jon Brisbin
Portal Webmaster
NPC International, Inc.
