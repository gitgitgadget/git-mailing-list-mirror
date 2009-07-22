From: Mark Blakeney <markb@berlios.de>
Subject: Re: git rebase stops on empty commits
Date: Wed, 22 Jul 2009 12:29:19 +0000 (UTC)
Message-ID: <loom.20090722T120617-839@post.gmane.org>
References: <33e2b2760907220022rbad30d7x255bcb63c5b8cc2f@mail.gmail.com> <loom.20090722T073645-17@post.gmane.org> <alpine.DEB.2.00.0907220907550.9220@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 14:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTax3-00039H-I8
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 14:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbZGVM3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 08:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZGVM3d
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 08:29:33 -0400
Received: from main.gmane.org ([80.91.229.2]:42029 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145AbZGVM3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 08:29:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MTaws-0006Ix-GQ
	for git@vger.kernel.org; Wed, 22 Jul 2009 12:29:30 +0000
Received: from 124-171-150-213.dyn.iinet.net.au ([124.171.150.213])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 12:29:30 +0000
Received: from markb by 124-171-150-213.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 12:29:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 124.171.150.213 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.11) Gecko/2009060308 Ubuntu/9.04 (jaunty) Firefox/3.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123748>

Peter Krefting <peter <at> softwolves.pp.se> writes:
> If you edit the commit, you claim ownership of it. You should probably try 
> using the -C option to commit, it should allow you to edit the message, 
> while keeping the authorship and timestamp intact.

Thanks Peter, that works well. E.g.

    % git rebase --continue
    Finished one cherry-pick.
    # Not currently on any branch.
    nothing to commit (working directory clean)
    Could not apply c33a375... Stop LNCC until OPC connection
    % git commit --allow-empty -C c33a375
    [detached HEAD e7d66f4] Stop LNCC until OPC connection
    % git rebase --continue
    ....

So rebase can actually do what I want but my fundamental issue remains. I said
"pick" in the rebase for all of these commits but rebase is forcing me to do
each one manually! And it requires some rather arcane git magic that could only
be procured from a guru on a mailing list. :)

Surely something like an option --allow-empty on the rebase -i to skip over
these no-brainer picks is trivial to implement - and makes sense? As a simple
user, and knowing the original commits required --allow-empty, it was the first
option I went looking for on the rebase -i when I encountered this problem.
