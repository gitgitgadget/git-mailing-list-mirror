From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH] Fix rebase -p --onto
Date: Fri, 17 Jul 2009 15:00:44 -0400
Message-ID: <20090717190043.GM7878@vinegar-pot.mit.edu>
References: <20090716230031.GM7503@vinegar-pot.mit.edu> <4A601C59.8040108@viscovery.net> <7vk52767el.fsf@alter.siamese.dyndns.org> <4A6038E8.1090402@viscovery.net> <20090717164845.GL7878@vinegar-pot.mit.edu> <alpine.DEB.1.00.0907172029230.4495@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 17 21:01:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRsg3-0005If-EH
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 21:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbZGQTAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 15:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbZGQTAy
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 15:00:54 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57538 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144AbZGQTAy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 15:00:54 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6HJ0jQL008771;
	Fri, 17 Jul 2009 15:00:45 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6HJ0ibu028674;
	Fri, 17 Jul 2009 15:00:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0907172029230.4495@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123482>

On Fri, Jul 17, 2009 at 08:32:20PM +0200, Johannes Schindelin wrote:
> > I don't believe rebase -i -p has ever worked with reordering commits.
> 
> It was not meant to.  Actually, it was never meant as "rebase -i -p", but 
> always as "rebase -p" (which, for technical reasons, would be implemented 
> in git-rebase--interactive.sh).

Understood.  The -p functionality is invaluable already without -i,
and reordering commits with -p raises substantial new questions about
what the behavior should be.

I wonder if it might be worth giving an error message when the user
attempts to reorder commits under -p?  The current behavior is
surprising (reordering A after B, C, D causes B, C, D to be dropped)
even when no merges are involved.  I wouldn't want to give an error on
just the combination of options -i -p, though, since "edit" is useful.


> Having said that, I am working on a rebase-i-p series which _does_ allow 
> reordering commits, putting commits on newly-created topic branches, 
> redoing merges explicitely.

That would be excellent.  I'm using git-sequencer from Stephan Beyer's
seq-builtin-dev branch for some work because I need this kind of
functionality.  It would be great to see it in mainline in one form or
another.  I don't doubt that it will require a good deal of work.

Thanks!
Greg
