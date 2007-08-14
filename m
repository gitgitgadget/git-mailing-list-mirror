From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk performance questions/issues
Date: Tue, 14 Aug 2007 14:39:05 +1000
Message-ID: <18113.12777.164103.302185@cargo.ozlabs.ibm.com>
References: <e1dab3980708130248g1cbab0cej18e260c8bfa2b315@mail.gmail.com>
	<alpine.LFD.0.999.0708130945420.30176@woody.linux-foundation.org>
	<e1dab3980708131018h495c5cf2m76cb8f6ffc4df6dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 06:39:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKoBZ-0007aJ-W0
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 06:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759212AbXHNEjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 00:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbXHNEjN
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 00:39:13 -0400
Received: from ozlabs.org ([203.10.76.45]:55397 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758675AbXHNEjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 00:39:12 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 31442DDEF4; Tue, 14 Aug 2007 14:39:11 +1000 (EST)
In-Reply-To: <e1dab3980708131018h495c5cf2m76cb8f6ffc4df6dc@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55804>

David Tweed writes:

> Thinking about it, I suppose even if you're only looking at the last
> 256 commits you've got to look through all the tags to see whether
> or not they refer to something within that window, so it's not
> unreasonable for it to affect startup time.

Gitk uses a Tcl associative array for that, which should be very
fast.

Could you try this: go to the Edit->Preferences window and turn off
"Display nearby tags".  Then with your ~2000 refs in place, see how
long gitk takes to start up and to display a diff.

If doing that makes it fast, then I suspect that my topology caching
patch will also help.  That's waiting on an answer from Junio or Linus
to my question about making git rev-list ignore negated non-existent
refs.

Also, if it's possible to give me a copy of your repo, that would
help.

Paul.
