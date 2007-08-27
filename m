From: Theodore Tso <tytso@mit.edu>
Subject: Re: git-daemon on NSLU2
Date: Mon, 27 Aug 2007 07:03:18 -0400
Message-ID: <20070827110318.GB4680@thunk.org>
References: <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com> <alpine.LFD.0.999.0708241618070.16727@xanadu.home> <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com> <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org> <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com> <20070826093331.GC30474@coredump.intra.peff.net> <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com> <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org> <9e4733910708261106u3fecde67m8045ddba3aa57650@mail.gmail.com> <alpine.LFD.0.999.0708261118260.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Jeff King <peff@peff.net>,
	jnareb@gmail.com, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 13:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPcNo-000802-Ly
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbXH0LDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbXH0LDo
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:03:44 -0400
Received: from THUNK.ORG ([69.25.196.29]:56892 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175AbXH0LDo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:03:44 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IPcWE-0006qX-Nt; Mon, 27 Aug 2007 07:12:30 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IPcNK-0001g9-7O; Mon, 27 Aug 2007 07:03:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708261118260.25853@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56812>

On Sun, Aug 26, 2007 at 11:26:07AM -0700, Linus Torvalds wrote:
> > How about changing initial clone to refuse to use the git protocol?
> 
> Absolutely not. It's quite often the best one to use (the ssh protocol 
> has the exact same issues, and is the only secure protocol).
> 
> But on a SNLU2, maybe *you* want to make your server side refuse it? I 
> would be easy enough: if the client doesn't report any existing SHA1's, 
> you just say "I'm not going to work with you".

What if the server sends a message which current clients interprets as
an error, and which newer clients could interpret as, "do a clone from
<this> URL, and then come back and talk to me".  Basically an
automated redirect to get the "Linus base pack" somewhere else, and
then to go back to the original server.  It certainly doesn't make
sense to change anything about the low-level protocol, but maybe a
higher level redirect would make sense, just as a user convenience thing.

       	     	      	    	 	- Ted
