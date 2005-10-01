From: Junio C Hamano <junkio@cox.net>
Subject: Re: git on OpenBSD
Date: Sat, 01 Oct 2005 00:15:25 -0700
Message-ID: <7v7jcxaesy.fsf@assigned-by-dhcp.cox.net>
References: <20051001062348.GA7903@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 09:16:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELbam-0002vK-8B
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 09:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJAHP3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 03:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJAHP3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 03:15:29 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:15263 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750762AbVJAHP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 03:15:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051001071524.XPNP19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Oct 2005 03:15:24 -0400
To: Han Boetes <han@mijncomputer.nl>
In-Reply-To: <20051001062348.GA7903@boetes.org> (Han Boetes's message of "Sat,
	1 Oct 2005 08:23:26 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9588>

Han Boetes <han@mijncomputer.nl> writes:

> iconv is installed in /usr/local that's why I had to add it to the
> searchpath.

Is it the standard practice to have iconv in /usr/local on
OpenBSD, or is it just your particular setup?  If the former
that's fine, but if the latter, I am afraid that this change
does not belong to the PLATFOR_DEFINES of the Makefile.

I had to work this exact issue around on a borrowed Solaris box
today (eh, yesterday), and near the proposed update branch head
there is a commit to let you specify where to find iconv stuff
from the command line of the make (or gmake).  The box had some
home compiled stuff in unusual places, so the site specific
things are made configurable via make command line, without
hardcoding particular value in the Makefile.

In either case, thanks for the patch, and please let me know
about the /usr/local vs iconv issue.  If the answer is "yes
iconv is in /usr/local everywhere on a vanilla OpenBSD box",
then I'll queue this patch on top of my today's Solaris
portability patch.
