From: Petr Baudis <pasky@suse.cz>
Subject: Re: Revamping the git protocol
Date: Fri, 21 Oct 2005 03:04:29 +0200
Message-ID: <20051021010429.GC30889@pasky.or.cz>
References: <43571DA1.6030907@zytor.com> <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net> <20051020091245.GY30889@pasky.or.cz> <4357BCBC.1020706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 03:05:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESlKw-000587-3r
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 03:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVJUBEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 21:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVJUBEc
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 21:04:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4234 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964836AbVJUBEc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 21:04:32 -0400
Received: (qmail 30850 invoked by uid 2001); 21 Oct 2005 03:04:29 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4357BCBC.1020706@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10402>

Dear diary, on Thu, Oct 20, 2005 at 05:50:20PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Another issue is that currently there is no error information propagated 
> back to the client; the server logs an error in its own logs, but the 
> client is simply disconnected.

Yes. I agree that while it seems quite complex compared to what we have
now, your proposal has good points. But if we are going with the
challenge-response at all and if we are going with the simple form,
I was merely trying to make sure that it is as compatible as possible.

> Anyone noticed that either of those schemes aren't actually 
> backward-compatible in any way (old client talking to new server will be 
> disconnected), and that unfortunately is the best thing one can do with 
> the current setup, exactly because there is no option negotiation phase?

Yes, option negotiation would solve this for us. But my scheme _is_
backwards-compatible in the way that new client taking to old server
will not be disconnected, so it's 50% better than the original proposal.

But I think that considering the long run, we should either not do this
challenge-response thing at all, and fix the problem by other (Linus')
means, or go for the "complex" scheme. I'd prefer the latter - sending
the error messages to the client alone is a huge improvement.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
