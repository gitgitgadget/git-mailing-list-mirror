From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Compatibility between git.git and jgit
Date: Fri, 1 May 2009 17:01:23 -0700
Message-ID: <20090502000123.GF23604@spearce.org>
References: <20090415182754.GF23644@curie-int> <alpine.LFD.2.00.0904151443030.6741@xanadu.home> <7vy6tj109a.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0905011616130.6741@xanadu.home> <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 02 02:01:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M02fw-0002bl-LN
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 02:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbZEBABY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 20:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbZEBABY
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 20:01:24 -0400
Received: from george.spearce.org ([209.20.77.23]:59878 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbZEBABX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 20:01:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C414A3807D; Sat,  2 May 2009 00:01:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118109>

Junio C Hamano <gitster@pobox.com> wrote:
> The code looks correct, I am reasonably sure updated server-client
> combination would work fine, and use of the capability mechanism means
> other combinations like old pusher and new receiver, and/or new pusher and
> old receiver, should be also Ok.
> 
> I see Shawn did the same to jgit.

On an unrelated note, someone asked me recently, how do we ensure
compatibility in implementations between git.git and jgit?

There isn't exactly a great notion of "a Git implementation can do
X, Y, Z, and never does Q".  So its not like we have a compability
test suite to run between the two systems.

JGit is really starting to gain some traction in the open source
world.

A lot of folks at Eclipse are really excited about being able to
ship a BSD licensed VCS.  Some of the Maven folks are really excited
about being able to link JGit up to Apache MINA SSHD and have a 100%
pure Java server solution for Git, that doesn't require native OS
authentication systems.  Gerrit Code Review relies entirely on it,
and some folks within Google are now using Gerrit Code Review and
its embedded MINA SSHD/JGit server as their only Git daemon.

Thus far, our compatibility story with git.git has been, "it should
work, uh, we think, because Shawn understands git reasonably well,
and wrote some of JGit, so uh, yea....".  :-)

But I think in another 12 months we'll be seeing people running
only JGit in many contexts, making compatibility between the two
implementations somewhat more important than it has been in the past.

-- 
Shawn.
