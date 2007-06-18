From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: how to move with history?
Date: Mon, 18 Jun 2007 21:49:07 +0200
Message-ID: <20070618194907.GA12445@steel.home>
References: <20070618191607.GK3037@cs-wsok.swansea.ac.uk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Mon Jun 18 21:49:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0NEB-0000Yy-Ay
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 21:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764105AbXFRTtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 15:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763119AbXFRTtM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 15:49:12 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:34789 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763256AbXFRTtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 15:49:11 -0400
Received: from tigra.home (Fcb3e.f.strato-dslnet.de [195.4.203.62])
	by post.webmailer.de (klopstock mo29) (RZmta 7.4)
	with ESMTP id u035bej5IJCCAR ; Mon, 18 Jun 2007 21:49:08 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0BDF1277BD;
	Mon, 18 Jun 2007 21:49:07 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5AFEEC164; Mon, 18 Jun 2007 21:49:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070618191607.GK3037@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqByfDQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50405>

Oliver Kullmann, Mon, Jun 18, 2007 21:16:07 +0200:
> 2. I issue "git mv file new_file".
> 
> 3. Then I have to commit the renaming.  I can't find anything on how
> to do this (neither in the git-mv- nor in the git-commit-documentation).

Just git-commit. git-mv is only so you don't have to run git add on
the new file name and don't need to run "git-commit -a" afterwords.

> So a hack is to use "git commit -a".  Apparently this works.

Even a plain "mv file new_file; git add new_file" would have worked.

> 4. Now I have "new_file" in the repository, but without history
> (except of the renaming operation),

It does. Try "git log file new_file". After committing, that is

> and I have still "file" in this history, but I can no longer get
> access to the history of "file" via "gitk file" ?

Well, you didn't commit the change yet.

> This looks a bit strange to me (the renamed file has
> no history, the old file still lurking around, but not
> easily accessible).

Git does not keep "renaming history". It does not have to, as it keeps
how your project looked at each commit (point in history).
