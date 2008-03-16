From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: integrity of a repository
Date: Sun, 16 Mar 2008 07:32:15 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080316063215.GA6067@ins.uni-bonn.de>
References: <20080315132645.GC17579@ins.uni-bonn.de> <7v4pb7migk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 07:33:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JamQv-0007K3-87
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 07:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbYCPGcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 02:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYCPGcW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 02:32:22 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43894 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYCPGcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 02:32:21 -0400
Received: from localhost.localdomain (xdsl-87-78-165-50.netcologne.de [87.78.165.50])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 41E4940002235;
	Sun, 16 Mar 2008 07:32:20 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JamPn-0001t6-U6; Sun, 16 Mar 2008 07:32:15 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4pb7migk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77355>

Hello Junio,

* Junio C Hamano wrote on Sun, Mar 16, 2008 at 04:54:51AM CET:
> Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:
> 
> > I am aware that git provides integrity of a commit (and thus, a branch
> > head) via its sha, which covers both the tree and its history.
> >
> > But what about the integrity of a git repository as a whole?
[...]
> > Would I need the in file listing all local and remote branches?
> > What about all heads in .git/*HEAD (such as FETCH_HEAD)?
> 
> That's an incoherent question ;-)  First you talk about snapshotting all
> the refs, as if you would want to make sure you can detect anybody moving
> the tips of branches after that happens, but then you talk about something
> completely unrelated.

Well, maybe they are two different parts of the larger question how one
can fully characterize the state of a repository.

> So the answer to the question in your later part of the message is that:
> 
>  - FETCH_HEAD, ORIG_HEAD and MERGE_HEAD do not protect anything from
>    getting pruned;
> 
>  - Objects that are not reachable from the tip of branches will remain in
>    the object store after pruning, if they are reachable from non-branch
>    refs (e.g. tags and the stash), reflogs, or the index.

OK.  Now, is there a way to quickly ensure that a repository is in a
pruned state, short of running 'git gc --prune'?

Thanks,
Ralf
