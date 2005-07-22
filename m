From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 14:16:51 -0700
Message-ID: <7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722204120.GD11916@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Bryan larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:18:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4uT-0002Y4-QY
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVGVVRz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVGVVRz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:17:55 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:17821 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262184AbVGVVQy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 17:16:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722211649.CPAR550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 17:16:49 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050722204120.GD11916@pasky.ji.cz> (Petr Baudis's message of "Fri, 22 Jul 2005 22:41:20 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wonderful start.

Later on, Porcelains could agree on what @TOKEN@ are generally
available, and even start using a common script to pre-fill the
templates, like:

  $ git-fill-template-script <template> <output-file> var=val var=val...

In your example, I see AUTHOR_NAME, AUTHOR_EMAIL, and
AUTHOR_DATE (I'd use GIT_AUTHOR_NAME etc to match existing
environment variables, though) would be something that are
probably common across Porcelains, and the Porcelain would not
even have to bother passing them as the command argument to
fill-template.  About FILELIST, the default would be to do
"git-diff-cache --name-only HEAD", but if a Porcelain keeps
track of "modified" files differently it can be overridden by
passing FILELIST as an explicit parameter.
