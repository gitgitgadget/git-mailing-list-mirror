From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: how to move with history?
Date: Mon, 18 Jun 2007 21:29:18 +0100
Message-ID: <20070618202918.GM3037@cs-wsok.swansea.ac.uk>
References: <20070618191607.GK3037@cs-wsok.swansea.ac.uk> <20070618194907.GA12445@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 22:16:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Ndy-0006lL-2X
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 22:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXFRUPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 16:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbXFRUPe
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 16:15:34 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:40213 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932666AbXFRUPb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 16:15:31 -0400
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.66)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1I0NdI-0005L5-Rt; Mon, 18 Jun 2007 21:15:28 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 9AF9344E9F;
	Mon, 18 Jun 2007 21:15:28 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 7CD9D741B2; Mon, 18 Jun 2007 21:29:18 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20070618194907.GA12445@steel.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50406>

On Mon, Jun 18, 2007 at 09:49:07PM +0200, Alex Riesen wrote:
> Oliver Kullmann, Mon, Jun 18, 2007 21:16:07 +0200:
> > 2. I issue "git mv file new_file".
> > 
> > 3. Then I have to commit the renaming.  I can't find anything on how
> > to do this (neither in the git-mv- nor in the git-commit-documentation).
> 
> Just git-commit. git-mv is only so you don't have to run git add on
> the new file name and don't need to run "git-commit -a" afterwards.
> 
> > So a hack is to use "git commit -a".  Apparently this works.
> 
> Even a plain "mv file new_file; git add new_file" would have worked.
> 
> > 4. Now I have "new_file" in the repository, but without history
> > (except of the renaming operation),
> 
> It does. Try "git log file new_file". After committing, that is
> 
> > and I have still "file" in this history, but I can no longer get
> > access to the history of "file" via "gitk file" ?
> 
> Well, you didn't commit the change yet.
> 
> > This looks a bit strange to me (the renamed file has
> > no history, the old file still lurking around, but not
> > easily accessible).
> 


I think, there is a bit of a misunderstanding going on, but this doesn't matter,
I believe now that I understand what "git mv" is doing (thanks!).
 
So that leaves then 2 open question:

> Git does not keep "renaming history". It does not have to, as it keeps
> how your project looked at each commit (point in history).

For my purposes, that is a bad thing, since I want to get rid off some parts
of the history (specifically I want to eliminate some files from history),
as explained in that last paragraph in my e-mail (with the motivation):

Is this possible in git?

And is it possible to add the history of some file to the history
of another file (in the above application this would be the renamed
file) ?

Altogether, I want to completely change history: It must look as
if the old files never has been there (from the git-history that is),
but as it would have had always the new name.

If this is not possible with Git (this "history surgery"), then
I hope that at least the future "git-submodule" will not have
the files in the history which have been filtered out?

So that in this way at least files can be hidden in (sub-)clones (but
they cannot be renamed) ?

> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
