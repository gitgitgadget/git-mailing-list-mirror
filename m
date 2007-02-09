From: Theodore Tso <tytso@mit.edu>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 9 Feb 2007 18:27:51 -0500
Message-ID: <20070209232750.GE10484@thunk.org>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com> <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org> <7vr6szt71j.fsf@assigned-by-dhcp.cox.net> <118833cc0702091229qfa0a3bcyae40b5e7ff70262b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 00:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFf9s-0001di-7P
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 00:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbXBIX15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 18:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXBIX15
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 18:27:57 -0500
Received: from thunk.org ([69.25.196.29]:55034 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbXBIX14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 18:27:56 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HFfEr-0006f5-On; Fri, 09 Feb 2007 18:33:09 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HFf9j-0004Mr-0u; Fri, 09 Feb 2007 18:27:51 -0500
Content-Disposition: inline
In-Reply-To: <118833cc0702091229qfa0a3bcyae40b5e7ff70262b@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39201>

On Fri, Feb 09, 2007 at 03:29:16PM -0500, Morten Welinder wrote:
> >Running refresh internally in runstatus without writing the
> >result out _might_ be an option, but that would largely be
> >a hack to only help qgit.
> 
> I might be overlooking something, but couldn't that updated index be
> saved elsewhere?  And subcommands be pointed at that, of course.

You should be able to set the GIT_INDEX_FILE environtment variable to
point the index somewhere else than $GIT_DIR/index, so it's not
located on a read-only filesystem.  See the git(7) man page.

						- Ted
