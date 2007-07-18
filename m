From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 11:26:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181121520.14781@racer.site>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 12:26:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB6k0-0005wk-AV
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 12:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbXGRK0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 06:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbXGRK0j
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 06:26:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:38909 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754139AbXGRK0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 06:26:38 -0400
Received: (qmail invoked by alias); 18 Jul 2007 10:26:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 18 Jul 2007 12:26:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OE68rIIIOu11eDRSpI2to/Wp4nrQIA9x5N3VRYg
	C5T8jpHjDzaJeF
X-X-Sender: gene099@racer.site
In-Reply-To: <858x9ez1li.fsf@lola.goethe.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52848>

Hi,

On Wed, 18 Jul 2007, David Kastrup wrote:

> The FAQ answer is weazeling on several accounts:
> 
> a) No, git only cares about files, or rather git tracks content and
>    empty directories have no content.
> 
> In the same manner as empty regular files have no contents, and git
> tracks those.  Existence and permissions are important.

We do not track permissions of directories at all.  This is because Git is 
primarily meant to track source code, and most "permissions" (i.e. 
restrictions) do not make any sense there.

> b) The problem is not just that empty directories don't get added into
> the repository.  They also don't get removed again when switching to a
> different checkout.  When git-diff returns zero, I expect a subsequent
> checkout to not leave complete empty hierarchies around because git
> can't delete any empty leaves which it chose not to track.

I _like_ the behaviour that Git does not remove a directory it added, when 
I put some untracked file into it.  And switching back to that branch, Git 
has no problems, because it sees that the directory is already there.  In 
case of a file, it would complain, and rightfully so.

See the fundamental difference between a file and a directory now?  I 
think it boils down to "an empty directory has _no_ contents, but an empty 
file has an _empty_ content".

Ciao,
Dscho
