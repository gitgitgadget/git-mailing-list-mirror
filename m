From: Theodore Tso <tytso@mit.edu>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 21:32:08 -0500
Message-ID: <20070228023208.GC2178@thunk.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org> <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com> <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org> <7vejob9l70.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 03:32:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMEcH-0002RP-Jc
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 03:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbXB1CcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 21:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbXB1CcT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 21:32:19 -0500
Received: from thunk.org ([69.25.196.29]:45179 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbXB1CcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 21:32:18 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HMEhR-0004IL-EG; Tue, 27 Feb 2007 21:37:49 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HMEbw-0004gw-SA; Tue, 27 Feb 2007 21:32:08 -0500
Content-Disposition: inline
In-Reply-To: <7vejob9l70.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40875>

On Tue, Feb 27, 2007 at 04:31:47PM -0800, Junio C Hamano wrote:
> Back to serious my self, I am wondering if this is a sensible
> thing to ask:
> 
> 	$ git show master...maint
> 
> which your patch now forbids.

Well, the other design alternative is to make git-show take a list of
objects, so that

	git show v1.5.0..v1.5.0.1

ends up displaying the same thing as

	git show `git-rev-list v1.5.0..v1.5.0.1`

... but I'm not really convinced that's really all that useful.  

Also, at the moment the git-show man page states the following:

       <object>
              The name of the object to show. For a more complete list of ways
              to spell object names, see  "SPECIFYING  REVISIONS"  section  in
              git-rev-parse(1).

Note the use of singular.  That would imply that it takes a single
object, and not a range of objects.  Of course, if the above behavior
were actually shown to be useful, man pages can always be easily
changed.  :-)

						- Ted
