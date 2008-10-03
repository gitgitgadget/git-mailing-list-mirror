From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Fri, 3 Oct 2008 12:00:28 +0200
Message-ID: <200810031200.28697.kendy@suse.cz>
References: <1221120192.8962.7.camel@heerbeest> <1222175590.10363.14.camel@heerbeest> <20080923132728.GV10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 03 12:01:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlhTf-0007U9-Im
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 12:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbYJCKA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 06:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYJCKA3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 06:00:29 -0400
Received: from styx.suse.cz ([82.119.242.94]:53916 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752974AbYJCKA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 06:00:29 -0400
Received: from ben.suse.cz (ben.suse.cz [10.20.1.143])
	by mail.suse.cz (Postfix) with ESMTP id 6205A628154;
	Fri,  3 Oct 2008 12:00:40 +0200 (CEST)
User-Agent: KMail/1.9.1
In-Reply-To: <20080923132728.GV10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97407>

Hi Pasky,

On Tuesday 23 September 2008 15:27, Petr Baudis wrote:

>   But if you scenario indeed is totally generic, I'm afraid I don't know
> how to make TopGit remove dependencies, except perhaps for the price of
> massive complexity and massive slowdown (pretty much redoing all the
> history walking etc.). Maybe someone else comes by with a genial
> solution...

Still thinking about this, and I think we [ooo-builders ;-)] could live with 
the ugliest of the ugly way of doing this:  When you have a topgit branch 
t/b1, and would like to undepend it, just

- tg patch t/b1 > save.diff
- commit a reverse of save.diff to t/b1
- tg update everything
- remove t/b1 from all the .topdeps
- commit save.diff to t/b1 again ;-)

Yeah, it creates 2 more commits in t/b1, but that's bearable I think [we do 
disable patches, but not every day ;-)], you still have the history, and you 
are able to add the dependency later again.

What do you think, please?

Regards,
Jan
