From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: question about git-submodule
Date: Sun, 05 Aug 2007 16:59:22 +0200
Message-ID: <20070805145922.GC999MdfPADPa@greensroom.kotnet.org>
References: <20070713214630.GB7106@genesis.frugalware.org>
 <20070715083959.GC999MdfPADPa@greensroom.kotnet.org>
 <20070715104712.GF2568@steel.home> <46B3B3D2.6030000@tromer.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, VMiklos <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: Eran Tromer <git2eran@tromer.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHhZu-0007Es-6j
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbXHEO7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbXHEO7Y
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:59:24 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:43527 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbXHEO7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 10:59:23 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMB003SJ2YY41@psmtp09.wxs.nl> for git@vger.kernel.org; Sun,
 05 Aug 2007 16:59:23 +0200 (MEST)
Received: (qmail 13143 invoked by uid 500); Sun, 05 Aug 2007 14:59:22 +0000
In-reply-to: <46B3B3D2.6030000@tromer.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55030>

On Fri, Aug 03, 2007 at 07:01:38PM -0400, Eran Tromer wrote:
> $ mkdir super
> $ cd super
> $ git init
> $ git submodule add ../sub-to-be sub

You probably don't want to do this as this URL
probably won't work for anyone who wants to clone
your superproject.

> BTW, is there any easy way to create a submodule directly inside the
> supermodule's working tree, instead of cloning it as in the above example?

Do you want to use the submodule porcelain or just the plumbing?
If you simply want to add a submodule locally, "git add" will do that for
you just fine.  It's only when you want to make it easier for people who
clone your superproject to get updates of the submodules that you
should set up the information required by "git submodule" in .gitmodules
(see end of module_add in git-submodule.sh).

Note that the "url" can be set directly in your git config
(without specifying it in .gitmodules), but then anyone who clones
from you will have to modify his config "manually" too.
For some reason, the "path" element is required, even if it is equal
to the submodule name.

skimo
