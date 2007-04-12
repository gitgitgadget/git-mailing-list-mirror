From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [RFC] git-clone: add --track <headname> support
Date: Fri, 13 Apr 2007 11:50:52 +1200
Message-ID: <461EC5DC.6060903@catalyst.net.nz>
References: <1176372539871-git-send-email-martin@catalyst.net.nz>	<87veg1tuuv.wl%cworth@cworth.org>	<461EA8C5.1070503@catalyst.net.nz> <87slb5tbvu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc94J-0002f3-QJ
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 01:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbXDLXvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 19:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXDLXvI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 19:51:08 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:40441 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbXDLXvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 19:51:07 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hc94A-0006x0-Bp; Fri, 13 Apr 2007 11:51:02 +1200
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
In-Reply-To: <87slb5tbvu.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44369>

Carl Worth wrote:
> Is this correct sequence for the operation in 1.5.1 ?
> 
> 	git clone <repo>
> 	cd <project>
> 	git branch --track <branch> origin/<branch>
> 	git checkout branch
> 	git pull # as needed
> 

Actually you don't need the git-checkout line

	git clone <repo>
	cd <project>
	git branch --track <branch> origin/<branch>
	git pull # as needed

> I'd love to get that down to:
> 
> 	git clone <something with <repo> and <branch>>
> 	cd <project>
> 	git pull # as needed

That's what this patch does.

> and then adding a subsequent branch to track would be:
> 
> 	git track <something with <repo> and <branch>>
> 	git checkout <branch>
> 	git pull # as needed

If your tree is reasonably clean (so that the implied git-checkout won't
fail), then on 1.5.1 this Just Works

        git branch --track <branch> origin/<branch>
        git pull # as needed

cheers,


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
