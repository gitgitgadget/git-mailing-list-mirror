From: Jim Meyering <jim@meyering.net>
Subject: Re: synchronizing incremental git changes to cvs
Date: Sun, 21 May 2006 15:40:10 +0200
Message-ID: <873bf3jy2t.fsf@rho.meyering.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<Pine.LNX.4.63.0605210104470.3148@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 15:40:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhoAT-00029X-5z
	for gcvg-git@gmane.org; Sun, 21 May 2006 15:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWEUNkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWEUNkM
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 09:40:12 -0400
Received: from mx.meyering.net ([82.230.74.64]:17851 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S964873AbWEUNkL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 09:40:11 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2D7A034A8D; Sun, 21 May 2006 15:40:10 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605210104470.3148@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 21 May 2006 01:05:46 +0200
	(CEST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20450>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 21 May 2006, Jim Meyering wrote:
>
>> Why am I interested?  I want to switch the development of GNU coreutils
>> from cvs to git.  I would also like to continue making the repository
>> available via cvs, for the sake of continuity.  At worst, I can always
>> cut the CVS cord, but that's a last resort.
>
> If you only want to make a cvs repository available for tracking the
> project, git-cvsserver is what you want. It is even faster than the
> original cvs...

That might work if I had sufficient access to the system hosting the
public CVS repository.  But there are restrictions (like no ssh access).
Currently I rsync the master repo to an intermediate site, from which
it is periodically pulled by savannah.  Paranoia on both sides.

If I end up leaving savannah, can someone propose a good site,
i.e., secure, yet with git and rsync access?

I haven't made the leap to git yet, but git-cvsimport (from git-1.3.2)
seems to do a very good job of converting the cvs module (89MB).

FYI, here are some stats on the resulting git repository:

Size (nothing repacked):
  1051MB (du -sh, actual, on reiserfs 3)
   708MB (du --apparent-size)

Size repacked, (via git-repack -a -d && git-prune-packed)
    65MB (du --si -s)

20k+ patchsets (counted by cvsps)
40k+ revisions (counted by cvs ... rlog cu|grep -c '^revision')

While repacking, git said something about more than 100K objects.
There were 120K files under .git/ before repacking.
