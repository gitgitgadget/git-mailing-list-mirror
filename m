From: Junio C Hamano <junkio@cox.net>
Subject: Re: .git/info/refs
Date: Fri, 26 Jan 2007 03:41:54 -0800
Message-ID: <7vireuxbel.fsf@assigned-by-dhcp.cox.net>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
	<45B7818F.6020805@zytor.com>
	<Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45B78836.5080508@zytor.com>
	<Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45B78C55.2030204@zytor.com> <ep83m2$mts$1@sea.gmane.org>
	<45B8E551.9020808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 12:42:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAPSy-0000gw-17
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 12:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202AbXAZLl4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 06:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933205AbXAZLl4
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 06:41:56 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52158 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933204AbXAZLlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 06:41:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126114155.JILB15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 06:41:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fngx1W00L1kojtg0000000; Fri, 26 Jan 2007 06:40:58 -0500
In-Reply-To: <45B8E551.9020808@zytor.com> (H. Peter Anvin's message of "Thu,
	25 Jan 2007 09:13:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37844>

"H. Peter Anvin" <hpa@zytor.com> writes:

> For heaven's sake, in computer science we can *NEVER* use the same
> feature for *MORE THAN ONE THING*.  If it doesn't work format-wise
> that's fine, but "it's only supposed to be used by dumb transports" is
> ridiculous.

Hmmmm... I am lost here....

> Right
> now, git-update-server-index is the command to update cached
> information, and for usability reasons there should be a single entry
> point.

Modulo s/-index/-info/, I agree that would be a very sensible
position, as long as the cost to generate additional cached
information necessary to help gitweb is reasonably small, I am
not opposed to have it generate another file [*1*].


[*1*]

I've been looking for backward-compatible holes in ls-remote and
its users, hoping we somehow could shoehorn this information in
info/refs, as I do not think its file format is sacred, nor the
file is there _only_ to help dumb transports.  As long as the
published way to access that information stays consistent, the
underlying file format is a fair game.  However, I do not think
the ls-remote command implementations in the wild has such a
hole I can exploit.
