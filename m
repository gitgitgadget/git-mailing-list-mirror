From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Wed, 9 May 2007 15:00:50 +0200
Message-ID: <3467FF99-9945-4ECF-9282-308759E63ED9@zib.de>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de> <Pine.LNX.4.64.0705091303280.4167@racer.site> <4BA4CF7D-40CB-4A55-ADDC-56DE179FD6C1@zib.de> <Pine.LNX.4.64.0705091424190.4167@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 15:00:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hllmh-00072S-Tm
	for gcvg-git@gmane.org; Wed, 09 May 2007 15:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbXEINAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 09:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbXEINAm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 09:00:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:45171 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbXEINAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 09:00:41 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l49D0dV1020931;
	Wed, 9 May 2007 15:00:39 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l49D0d5b025873
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 9 May 2007 15:00:39 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0705091424190.4167@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46710>


On May 9, 2007, at 2:25 PM, Johannes Schindelin wrote:

> What I was trying to get at: if you commit 900 files, and after the  
> 450th
> file somebody _else_ commits a file, which just so happens to be  
> one of
> your 450 remaining files, that safety check no longer holds.
>
> CVS is slow.

I know. I'd probably apply my patch late at night or on the weekend,  
when the chance is lower to conflict with other commits.

You can't remove the race conditions that you have when interacting  
with cvs. We can only decrease the chance of being hit by making the  
time window smaller. This is a side benefit of my patch. The main  
purpose is to lower the overall time needed to apply patch that  
modifies lots of files.

- Steffen
