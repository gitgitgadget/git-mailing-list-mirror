From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Thu, 26 Jun 2008 00:44:28 +0200
Message-ID: <20080625224428.GB12567@machine.or.cz>
References: <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080625195003.GB15077@mit.edu> <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com> <20080625203822.GA7827@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 26 00:46:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBdk3-00049a-O8
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 00:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbYFYWoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 18:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756303AbYFYWoe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 18:44:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58184 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756232AbYFYWoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 18:44:32 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 80FFA2C4C02E; Thu, 26 Jun 2008 00:44:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080625203822.GA7827@mit.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86359>

On Wed, Jun 25, 2008 at 04:38:22PM -0400, Theodore Tso wrote:
> On Wed, Jun 25, 2008 at 04:04:47PM -0400, Avery Pennarun wrote:
> > How about making "git checkout" default to HEAD if no revision is
> > supplied?  There's precedent for this in, say, git-diff (and I think a
> > few others).
> > 
> > Incidentally, "checkout <filename>" was also the way to do a revert
> > operation in CVS.  And the way to switch branches, too, iirc.  So git
> > isn't being too unusual here.  That said, the commands were
> > deliberately renamed in svn because CVS was considered largely insane.
> 
> The one thing I would worry about is the potential ambiguity if you do
> something like "git checkout FOOBAR", and FOOBAR was both a branch
> name as well as a file name.  How should it be interpreted?  I'd argue
> the real problem was we conflated two distinct operations: "switching
> to a new branch", and "reverting a file" to the same name, checkout.
> 
> Hence the suggestion to add a new command, "git revert-file", where
> there would be no ambiguity.

Just to chime in, this reminds me of Cogito - it had cg-switch for
switching branches (like git checkout) and cg-restore for restoring
files in working copy (like git checkout, too; but you would pass -f if
you wanted to overwrite existing copy).

(Though, Cogito didn't quite get it right either since it tried to
overload cg-switch with the git branch functionality of creating new
branches. I still didn't quite come in terms with any UI model of the
branches I know about.)

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
