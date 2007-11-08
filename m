From: Andreas Ericsson <ae@op5.se>
Subject: Re: Inconsistencies with git log
Date: Thu, 08 Nov 2007 01:16:47 +0100
Message-ID: <4732556F.30105@op5.se>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>	 <Pine.LNX.4.64.0711072242230.4362@racer.site>	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>	 <Pine.LNX.4.64.0711072255420.4362@racer.site>	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>	 <Pine.LNX.4.64.0711072309380.4362@racer.site>	 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>	 <Pine.LNX.4.64.0711080003080.4362@racer.site> <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2ge-0001Ua-78
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbXKHIYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbXKHIYD
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:24:03 -0500
Received: from mail.op5.se ([193.201.96.20]:49316 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbXKHIYA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:24:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9BF711F0870B;
	Thu,  8 Nov 2007 09:23:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -1.43
X-Spam-Level: 
X-Spam-Status: No, score=-1.43 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, DATE_IN_PAST_06_12=1.069, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fmt+Zy4BQD2a; Thu,  8 Nov 2007 09:23:35 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 2F4511F08709;
	Thu,  8 Nov 2007 09:23:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63962>

Jon Smirl wrote:
> On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> It is consistent, when you realise that the path arguments are interpreted
>> relative to the project root.
> 
> Then why doesn't this work?
> 
> jonsmirl@terra:~/mpc5200b$ git log Documentation
> all the log for Documentation....
> jonsmirl@terra:~/mpc5200b$ cd Documentation
> jonsmirl@terra:~/mpc5200b/Documentation$ git log Documentation
> fatal: ambiguous argument 'Documentation': unknown revision or path
> not in the working tree.
> Use '--' to separate paths from revisions
> jonsmirl@terra:~/mpc5200b/Documentation$
> 

Because your current working directory, relative to the project root, is
prepended to the path you're in, so git sees "Documentation/Documentation".
I'm unsure why

	cd Documentation; git log -- /Documentation

doesn't do the trick though. I know that particular trick used to work for
some other command a while back anyways.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
