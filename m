From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 0/5] More ref logging
Date: Sun, 21 May 2006 01:09:44 -0400
Message-ID: <BAYC1-PASMTP110591AAE415FBD1523110AEA50@CEZ.ICE>
References: <20060519091456.GH22257@spearce.org>
	<20060519071603.11d3be5d.seanlkml@sympatico.ca>
	<20060521005009.GA7179@spearce.org>
	<20060520224344.7ebca48b.seanlkml@sympatico.ca>
	<20060521045146.GA8269@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 07:15:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhgI0-0005dE-8N
	for gcvg-git@gmane.org; Sun, 21 May 2006 07:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWEUFPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 01:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWEUFPf
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 01:15:35 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:50064 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751451AbWEUFPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 01:15:34 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 20 May 2006 22:20:23 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 09AD2644C28;
	Sun, 21 May 2006 01:15:33 -0400 (EDT)
To: Shawn Pearce <spearce@spearce.org>
Message-Id: <20060521010944.78903774.seanlkml@sympatico.ca>
In-Reply-To: <20060521045146.GA8269@spearce.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 May 2006 05:20:23.0765 (UTC) FILETIME=[43000050:01C67C96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 21 May 2006 00:51:46 -0400
Shawn Pearce <spearce@spearce.org> wrote:

> Any chance we could get some details on why so many tags were useful?
> You have a good argument here but I'm not sure how a better tag
> store could be structured.  :-)

It is a conversion from another SCM.  So every one of the ~16K commits
was tagged with the reference number taken from the original SCM.  This
has some very nice benefits in that you can refer to every commit
in git by the original changeset #.  For example, if someone reports a
bug mentioning the original scm's reference id, you can say something
like: "git show p4/1234" without having to go back to the old scm.

Also, qgit, gitk and gitweb display them nicely which can be helpful
during the conversion.  And if/when they're not needed any longer,
you just delete them without having to rewrite the history etc..   
  
> Yea - despite being the author of ref log I'm still slightly unhappy
> with the fact that it doesn't make reuse of existing GIT plumbing.
> But I'm sort of OK with that right now as you can't map two indexes
> into memory at once currently, nor is there a way to easily update
> multiple refs at once if the ref log must serialize access to create
> a string of trees and commits.

Well it's not the end of the world either way, and sometimes it's just
better to implement a workable solution rather than wait for one that's
theoretically cleaner.  It just seemed like it was worth mentioning in
case you saw a way to make it happen without a lot of grief.

Sean
