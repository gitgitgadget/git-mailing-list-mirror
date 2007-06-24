From: Raimund Bauer <ray007@gmx.net>
Subject: Re: help with cvsimport
Date: Sun, 24 Jun 2007 11:37:35 +0200
Message-ID: <467E3B5F.5070508@gmx.net>
References: <1182589892.5937.10.camel@localhost> <Pine.LNX.4.64.0706231213020.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 11:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2OXM-0006UG-K5
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 11:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbXFXJhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 05:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbXFXJhj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 05:37:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:38207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753963AbXFXJhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 05:37:38 -0400
Received: (qmail invoked by alias); 24 Jun 2007 09:37:36 -0000
Received: from p549886A7.dip0.t-ipconnect.de (EHLO [127.0.0.1]) [84.152.134.167]
  by mail.gmx.net (mp022) with SMTP; 24 Jun 2007 11:37:36 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1++a2Bhv6K+L9onU2+xS1IUHTXud6Cji5Qz/SaHCM
	kR6YpISey3r5pj
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070604 Thunderbird/2.0.0.4 Mnenhy/0.7.5.0
In-Reply-To: <Pine.LNX.4.64.0706231213020.4059@racer.site>
X-Antivirus: avast! (VPS 000751-4, 23.06.2007), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50784>

Hi,

* Johannes Schindelin wrote, On 23.06.2007 13:27:
> Hi,
>
> On Sat, 23 Jun 2007, Raimund Bauer wrote:
>
>   
>> I unfortunately have to work with several cvs-repositories and was
>> wondering if there was a way to have the files processed on import:
>> - strip trailing whitespace
>> - convert to newline-only line endings
>>     
>
> If you want to use cvsimport incrementally, I'd rather not process the 
> "origin" branch like this, but rather use git-filter-branch (with a simple 
> index filter) to do that.
>
> Even if you do not want to use it incrementally, it seems easier and 
> cleaner (if somewhat slower) to me.
>
> So, something like
>
> 	git filter-branch --index-filter 'git ls-files |
> 		while read name; do
> 			perl -pi -e "s/[ \009\015]*$//" "$name"
> 		done
> 		git add -u' cleaned-up-origin
>
> should do.
>   
Thanks, will try that out.
Tough I'm not very happy about having to create an extra branch for 
every branch I want to work with.
And a git-solution would also respect git-attributes ...
> Hth,
> Dscho
>   
-- 

best regards

  Ray
