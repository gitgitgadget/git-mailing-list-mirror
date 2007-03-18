From: Petr Baudis <pasky@suse.cz>
Subject: Re: Libification project (SoC)
Date: Sun, 18 Mar 2007 14:57:06 +0100
Message-ID: <20070318135706.GF4489@pasky.or.cz>
References: <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> <alpine.LFD.0.83.0703161145520.5518@xanadu.home> <Pine.LNX.4.63.0703161710400.22628@wbgn013.biozentrum.uni-wuerzburg.de> <alpine.LFD.0.83.0703161218140.5518@xanadu.home> <1174069353.2599.13.camel@mejai> <alpine.LFD.0.83.0703161433300.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve =?iso-8859-1?Q?Fr=E9cinaux?= <nudrema@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 14:57:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSvsu-0008Qt-5p
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 14:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbXCRN5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 09:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbXCRN5L
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 09:57:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57328 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbXCRN5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 09:57:09 -0400
Received: (qmail 23426 invoked by uid 2001); 18 Mar 2007 14:57:06 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.83.0703161433300.18328@xanadu.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42494>

On Fri, Mar 16, 2007 at 07:53:06PM CET, Nicolas Pitre wrote:
> A good way to define the lib API needs then might be expressed as 
> follows:
> 
>   Each existing plumbing commands must be turned into the minimal 
>   implementation required to interact with the libgit public API and
>   display results.
> 
>   In other words, the public libgit API should provide the same 
>   functionality as existing plumbing commands such that those existing
>   commands will only need the necessary code to bridge the C interface
>   with the existing command line interface.

I think this is good definition if interpreted well - that is, git-log
library equivalent shouldn't spew out textual output but provide
interface to retrieve revision information in easy-to-use format.

> Then, of course, there is the matter of reentrancy.  But that's still a 
> minor API detail even if it is not a trivial issue implementation wise.  
> But the API must be right as this is what we'll be stuck with even if 
> the implementation may change.  And as far as an API definition is 
> needed I think that it should reflect the current plumbing which is 
> actually the real API that grew naturally and has been proven useful.

Well what you said about reentrancy is that "it's minor API detail but
even minor API details must be right because we will be stuck with
them". And I don't think it's minor at all either. :-)

Also, even if the implementation won't be completely re-entrant
initially, the question of re-entrancy is something we should decide
since it still affects the scope of the librarification work.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
