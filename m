From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: error while cloning a remote repository
Date: Fri, 13 Nov 2009 07:10:24 -0800
Message-ID: <20091113151024.GR11919@spearce.org>
References: <811075.82054.qm@web94704.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shameem Ahamed <shameem.ahamed@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 16:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8xpC-0006dL-Uf
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 16:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239AbZKMPK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 10:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756453AbZKMPK1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 10:10:27 -0500
Received: from george.spearce.org ([209.20.77.23]:43286 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439AbZKMPKU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 10:10:20 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1DCD0381FD; Fri, 13 Nov 2009 15:10:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <811075.82054.qm@web94704.mail.in2.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132837>

Shameem Ahamed <shameem.ahamed@yahoo.com> wrote:
> I ran in to a warning message while cloning a remote repository.
...
> warning: remote HEAD refers to nonexistent ref, unable to checkout.
> 

Contact the repository owner and let them know.  The error occurs because
their HEAD symbolic reference points to a branch that does not exist.  They
can fix this by running `git symbolic-ref HEAD refs/heads/$branch` to point
at the correct default branch for their repository.

> After the cloning i couldn't see any remote files. The .git folder
> is created successfully.

I think you may be able to do:

  $ git branch -r
  $ git reset --hard $branch

where $branch is one of the origin/ names printed by branch -r.
Because the source repository didn't tell us what default branch name
you should use (it has a bad HEAD) I can't suggest what name, you'll
have to figure it out on your own, or ask the repository owner.

-- 
Shawn.
