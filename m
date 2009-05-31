From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] refuse to merge during a merge
Date: Sun, 31 May 2009 16:05:00 +0200
Message-ID: <20090531140500.GA24862@localhost>
References: <20090527210410.GA14742@localhost> <43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com> <20090530083721.GA12963@localhost> <20090531104359.GA19094@localhost> <43d8ce650905310405k4fa17240se7701e5fab2b22a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dave Olszewski <cxreg@pobox.com>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 16:05:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAlf6-0002y2-8W
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 16:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbZEaOFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 10:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754866AbZEaOFK
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 10:05:10 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:37256 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbZEaOFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 10:05:09 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 31 May 2009 16:05:10 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MAlem-0006Wg-UW; Sun, 31 May 2009 16:05:00 +0200
Content-Disposition: inline
In-Reply-To: <43d8ce650905310405k4fa17240se7701e5fab2b22a7@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 31 May 2009 14:05:10.0794 (UTC) FILETIME=[CF9AD6A0:01C9E1F8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120400>

On Sun, May 31, 2009 at 12:05:31PM +0100, John Tapsell wrote:
> > "git reset --hard" is not suggested, because it potentially removes
> > changes unrelated to the merge (if the work tree was dirty prior to
> > the merge).
> 
> Sorry could you just clarify...  if the user does "git reset HEAD"
> will that sometimes always or never fail?

It will never fail. It aborts the merge as suggested. But "git reset --hard
HEAD" would also reset the work tree, so that "any changes to tracked files
in the working tree since <commit> are lost." This is generally desireable,
since an incomplete merge also leaves the auto-merged files in the work
tree.

But if the user does not already know that, it's better to leave the user
wondering how to clean a dirty work tree, than to suggest a potentially
harmful operation.

Clemens
