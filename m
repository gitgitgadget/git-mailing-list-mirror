From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 9 Jul 2007 07:50:29 -0400
Message-ID: <20070709115029.GD16032@thunk.org>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org> <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 13:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7rlN-0004ip-Ay
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 13:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbXGILum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 07:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbXGILum
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 07:50:42 -0400
Received: from THUNK.ORG ([69.25.196.29]:37432 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbXGILum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 07:50:42 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I7rtD-0003hA-Cg; Mon, 09 Jul 2007 07:58:51 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I7rl7-000681-LA; Mon, 09 Jul 2007 07:50:29 -0400
Content-Disposition: inline
In-Reply-To: <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51984>

On Sun, Jul 08, 2007 at 10:39:41PM -0700, Junio C Hamano wrote:
> Are _identifiers with leading underscore Kosher thing to do, I
> wonder...  We do have ones with trailing ones (mostly qsort
> functions) and I think they are done that way for the sake of
> standards conformance.

_[a-z]* is kosher for file scopes or function scoping:

	http://c-faq.com/decl/namespace.html

Some Projects' coding styles prohibit use of _[a-z]* altogether, as
_[_A-Z]* is reserved for C libraries and system header files, and it's
simpler just to ban all identifiers begining with an underscore just
on general princinpals.  It's not strictly speaking necessary, however.

	       		     	    - Ted

P.S.  Note that the Linux kernel does not worry about such rules; in
particular, _[a-z]* is very commonly used at the global scope level,
without any problems.  It doesn't have to be as portable as git
probably needs to be, however.
