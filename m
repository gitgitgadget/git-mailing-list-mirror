From: Junio C Hamano <junkio@cox.net>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 13:02:13 -0800
Message-ID: <7vtzyx2s6i.fsf@assigned-by-dhcp.cox.net>
References: <20070111125726.GJ1759@mellanox.co.il>
	<Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
	<Pine.LNX.4.64.0701111109070.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:02:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H574G-00008o-0g
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbXAKVCa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAKVCa
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:02:30 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36890 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbXAKVC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 16:02:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111210229.XHO15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 16:02:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9x1d1W00f1kojtg0000000; Thu, 11 Jan 2007 16:01:38 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org> (Linus
	Torvalds's message of "Thu, 11 Jan 2007 11:19:36 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36609>

Linus Torvalds <torvalds@osdl.org> writes:

> I personally think write_in_full() is totally mis-designed. If you are 
> ready to handle partial writes, you should use "xwrite()". If you're not 
> ready to handle partial writes, you should either use "write_or_die()", 
> _or_ you should expect a partial write to at least return an error code 
> (which is how "write_buffer()" works).

> But that's not how write_in_full() actually works. Write-in-full does not 
> return an error for a partial write, it returns the partial size.
>
> Which is idiotic. It makes the function pointless. Just use xwrite() for 
> that.

I agree 100% with the above reasoning.
