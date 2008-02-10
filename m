From: Paul Gardiner <osronline@glidos.net>
Subject: Re: All I wanted was git-fast-export
Date: Sun, 10 Feb 2008 10:07:24 +0000
Message-ID: <47AECCDC.3050500@glidos.net>
References: <47ADE275.3060109@glidos.net> <alpine.LSU.1.00.0802091803580.11591@racer.site> <47AE2CDF.4090208@glidos.net> <alpine.LSU.1.00.0802100054490.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 11:08:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO96a-0000IU-Sg
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 11:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbYBJKHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 05:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbYBJKHf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 05:07:35 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:9395
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754367AbYBJKHe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 05:07:34 -0500
X-Trace: 37703377/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.163.7
X-SBRS: None
X-RemoteIP: 62.241.163.7
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAApcrkc+8aMH/2dsb2JhbACnJw
X-IP-Direction: IN
Received: from blaster.systems.pipex.net ([62.241.163.7])
  by smtp.pipex.tiscali.co.uk with ESMTP; 10 Feb 2008 10:07:29 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by blaster.systems.pipex.net (Postfix) with ESMTP id 1B9A8E00008F
	for <git@vger.kernel.org>; Sun, 10 Feb 2008 10:07:27 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802100054490.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73328>

Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 9 Feb 2008, Paul Gardiner wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Sat, 9 Feb 2008, Paul Gardiner wrote:
>>>
>>>> With your kind help, I've been able to convert a cvs repository to 
>>>> git, but the last several years commits start with a line saying 
>>>> "Summary;" :-( I thought it might not be hard to put a filter 
>>>> between git-fast-export and git-fast-import to sort it out.
>>> The better tool for this should be filter-branch.
>> filter-branch does look to be brilliant for this sort of thing,
>> but I don't think I can use it in my case.
> 
> I beg to differ.  filter-branch does exactly the same as the fast-export | 
> filter | fast-import you prosed does: it rewrites history.
> 
> The thing is, filter-branch was _written for this purpose_.  So if you 
> know what commit you rewrote last, you can make the process faster/safer 
> by issuing
> 
> 	$ git filter-branch --msg-filter="<blabla>" <old-commit>..master

That does look just what I need, but did you see the reason I thought I
couldn't use it? I need to repeatedly sync the git repository from a
live cvs repository, and repeatedly filter the new commit messages.
I'd imagined that filtering the commit messages will mess up subsequent
syncing. That's why I thought I'd need a chaing of repositories

cvs => git => tiedied git

What do you think?

> There's also a further upside to filter-branch: at least until recently, 
> it did not use any special features of newer git, but could be extracted 
> (e.g. via gitweb) and used with older git (any git >= 1.5.3 should do, 
> maybe even older ones).
> 
> Hth,
> Dscho
> 
> P.S.: but you seem to be dead-set to upgrade.  No problem for me: just go 
> ahead and do what you must.

God no, not if I can help it. I've been performing surgery on my
packages over the last couple of days, and I'm sure the whole
system is going to fall over any minute. I'd love to be able to
use the version I have. It's 1.5.2.4 Is filter-branch likely to work
with that?

P.
