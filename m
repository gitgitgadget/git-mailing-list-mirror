From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git blame and cherry-picking
Date: Thu, 7 Aug 2008 11:37:02 -0700
Message-ID: <AA6BDC98-8800-4031-8C8F-A4BD326BEC1E@midwinter.com>
References: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com> <20080807060940.GA15405@blimp.local> <20080807182256.GF11314@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 07 20:38:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRANG-00023V-Dh
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 20:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbYHGShH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYHGShH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 14:37:07 -0400
Received: from tater.midwinter.com ([216.32.86.90]:39665 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751524AbYHGShG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 14:37:06 -0400
Received: (qmail 16135 invoked from network); 7 Aug 2008 18:37:04 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=XbX5UWDKSTgSuhN6lbaY/I9DujqOg1OmP3TemtOY8U3Nu7kDAQ2zA+J+z5GLPv8D  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 7 Aug 2008 18:37:04 -0000
In-Reply-To: <20080807182256.GF11314@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91595>

On Aug 7, 2008, at 11:22 AM, Jeff King wrote:
> You could potentially have git-blame incorporate that information
> (again, if the referenced commit is even still available), but I'm not
> sure exactly what difference it would make. I don't think you would  
> want
> to start blaming up the original commits line of parentage.

No, of course not. But one might want to show the original commit's  
author instead of the name of the person who did the cherry pick.  
That's mostly what I'm looking for here; knowing where the change  
originally came from in terms of the revision graph is occasionally  
interesting but not nearly as important.

One could argue that the real issue here is that while "git cherry- 
pick" preserves the original author and doesn't have the  
misattribution problem, "git cherry-pick -n" discards the original  
commit's attribution (though it does keep the commit message).  
Obviously git doesn't necessarily know whether the cherry-picker made  
substantial changes before committing and should truly be considered  
the author, but one of the use cases for the "-n" option is a simple  
"make sure you don't commit totally broken revisions" where there is  
little to no additional editing of the patch and keeping the original  
author would support that use case better.

-Steve
