From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Multiple SVN Repos Inside A Git Repo
Date: Wed, 03 Dec 2008 14:57:58 +0100
Message-ID: <49369066.7030101@drmicha.warpmail.net>
References: <4753154c0812021222t2886f986id2b775f90d4ea7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Sally <tsally2@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:59:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7sGF-0003wT-3l
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYLCN6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbYLCN6E
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:58:04 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33486 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763AbYLCN6D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 08:58:03 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id AD5251CA843;
	Wed,  3 Dec 2008 08:58:00 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 03 Dec 2008 08:58:00 -0500
X-Sasl-enc: FjhqVyd4C1qPTx32c91YunaZ1XN66kL5dlm0+XUUwnlo 1228312680
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 15EBEA1D2;
	Wed,  3 Dec 2008 08:57:59 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <4753154c0812021222t2886f986id2b775f90d4ea7f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102261>

Tim Sally venit, vidit, dixit 02.12.2008 21:22:
> Using git-svn, it is possible to have different parts of a git repo
> correspond to a specific svn repo? From my understanding after reading
> the documentation, you need one git repository per svn.  My example is
> that I'm trying to set up a git repo to version control everything
> from my classes, but each class has a separate svn repo.  Also, the
> number of git repos I can create is limited, and I'd rather not
> clutter everything up with many separate git-svn repos.
> 
> Example structure:
> 
> class/
> .......... systems/
> .......... algorithms/
> .......... physics/
> 
> class is one central git repository, and systems, algorithms, and
> physics contain data from three svn repositories.  Ideally, you could
> commit/update to/from each svn repo individually, or all at once.
> 
> Tim

You can have as many git svn configurations in a single git repo as you
want (see the "-R" argument to git svn). They will all correspond to
different remote branches. By checking out the branches (or a
corresponding tracking branch) you can switch between the branches, i.e.
between classes.

I don't think a layout as above is possible given your requirements that
- you (basically) want a single git repo and
- you want to be able to commit back.
They exclude using submodules resp. subtree merge.

Michael
