From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 1 Aug 2007 05:24:29 -0400
Message-ID: <20070801092428.GB28106@thunk.org>
References: <200708010216.59750.jnareb@gmail.com> <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org> <7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 11:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGARm-00008l-Pv
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 11:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759449AbXHAJYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 05:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759432AbXHAJYq
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 05:24:46 -0400
Received: from THUNK.ORG ([69.25.196.29]:46722 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758987AbXHAJYp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 05:24:45 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IGAZy-0000kG-6x; Wed, 01 Aug 2007 05:33:18 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IGARR-000297-2r; Wed, 01 Aug 2007 05:24:29 -0400
Content-Disposition: inline
In-Reply-To: <7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54423>

On Tue, Jul 31, 2007 at 10:50:48PM -0700, Junio C Hamano wrote:
> I would call aversion to -l a superstition, while aversion to -s
> has a sound technical reasons.  The latter means you need to know
> what you are doing --- namely, you are making the clone still
> dependent on the original.

So would you accept a patch which adds a git-config variable which
specifies whether or not local clones should use hard links by default
(defaulting to yes), and which adds a --no-hard-links option to
git-clone to override the config option?

I could imagine a situation where if you are using a git repository
exclusively on a local system, with no remote repositories to act as
backups, where you might want git clone to to make full copies to
provide backups in case of filesystem or disk induced corruption.  But
most of the time there are enough copies of the the repo on other
machines that the need for making separate copies of the git
objects/packs isn't really needed.

					- Ted
