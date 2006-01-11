From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Subprojects
Date: Wed, 11 Jan 2006 17:44:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43C52B1F.8020706@hogyros.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 17:45:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewj5o-0005zg-EH
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 17:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWAKQo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 11:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWAKQo6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 11:44:58 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48358 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751581AbWAKQo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 11:44:57 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BD191140C7A; Wed, 11 Jan 2006 17:44:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id ADD501C52;
	Wed, 11 Jan 2006 17:44:53 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 8FB14187D;
	Wed, 11 Jan 2006 17:44:53 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 69536140C7A; Wed, 11 Jan 2006 17:44:53 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <43C52B1F.8020706@hogyros.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14487>

Hi,

On Wed, 11 Jan 2006, Simon Richter wrote:

> one thing that I have been missing so far in all SCM systems apart from CVS
> (and there it's just coincidence) is the ability to include a project as part
> of a bigger project. Developing software for embedded systems, I need that
> feature fairly often, for example the source tree for a particular device
> almost always contains one or more Linux trees, some binutils, gcc and gdb
> stuff and so on.

What I do: I call it a branch. While this might seem technically 
incorrect, it is not.

And since the subprojects are really independent, you can connect them by 
an octopus.

> The changes necessary here would be fairly simple: "tree" objects would point
> to a "commit" or a "tag" object when a subproject is used.

Sorry, we discussed similar things already. It is not necessary to change 
the structure. Even more: it makes no sense. Why would you want to have 
two or more commit messages for the same revision?

Remember: trees, commits and tags (objects in general) are immutable. You 
may think that you just commit a new revision of the subproject, and it is 
picked up by the overall project, but that is not the case!

> In the working directory, this would be represented by a .git directory that
> contains a symref to the embedding project instead of the objects directory.
> Head pointers are only required if you intend to push changes upstream to the
> maintainer of the embedded project. Each subproject has its own index.

You can do this like I said: use branches (and possibly a common 
GIT_OBJECT_DIRECTORY to save on disk space).

Hth,
Dscho
