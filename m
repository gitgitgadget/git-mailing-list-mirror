From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
	to "rebase-merge"
Date: Tue, 15 Jul 2008 21:26:19 -0400
Message-ID: <20080716012619.GM8185@mit.edu>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 03:27:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvnj-0000Es-Rn
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 03:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbYGPB00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 21:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYGPB00
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 21:26:26 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:33959 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752326AbYGPB00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 21:26:26 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KIvme-0004vB-3N; Tue, 15 Jul 2008 21:26:20 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KIvmd-0003ue-GP; Tue, 15 Jul 2008 21:26:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88624>

On Wed, Jul 16, 2008 at 02:47:33AM +0200, Johannes Schindelin wrote:
> 
> Since the files generated and used during a rebase are never to be
> tracked, they should live in $GIT_DIR.  While at it, avoid the rather
> meaningless term "dotest" to "rebase", and unhide ".dotest-merge".
> 
> This was wished for on the mailing list, but so far unimplemented.

While you have "git am" open, how about adding an "git am --abort"
which nukes the .dotest aka .git/rebase directory, and resets HEAD
back to the original position?

And another nice shortcut would be "git am --forceapply" which applies
the patch, leaving .rej files for the user to resolve by hand.  That
makes it easier for the user to manually run patch while passing a
filename in .dotest aka .git/rebase.

These two additions would make the git-am workflow much smoother.

Regards,

					- Ted
