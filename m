From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] Git.pm: Support for perl/ being built by a different compiler
Date: Mon, 26 Jun 2006 10:24:29 +0200
Message-ID: <20060626082428.G52c9608e@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 10:24:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumOZ-0004Ac-WF
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWFZIYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWFZIYd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:24:33 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:65233 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S964868AbWFZIYc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 04:24:32 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id C9C30AEBA065;
	Mon, 26 Jun 2006 10:24:27 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 510BC11043F; Mon, 26 Jun 2006 10:24:29 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk676orjy.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22659>

Junio C Hamano wrote:

> Do things link and work fine if we do not have the GCC specific
> options?

Yes, with this patch I can compile Git with GCC while the Perl module
gets built with Sun CC.  The result even works.

If the git commands written in Perl will be converted to use Git.pm,
Sun CC will become a new dependency for Git on Solaris, unless
people build a separate Perl with GCC or manually edit the generated
Makefile in the perl subdir to build the module with GCC.

> I would question why the rest of git is not built with Sun CC as
> well if that is the case.

Well, GCC comes along with Solaris on the CDs while Sun CC is a
separate product.  And usually it's easier to build free software
with GCC, because many projects use GCC extensions.  Often GCC is
the only compiler installed on Solaris machines.

Until the patch series from Florian Forster removed a lot of GCC'isms
a few days ago it was not possible to build Git with Sun CC.

Yesterday I could build the next branch with Sun CC 5.8 with a few
trivial changes.  I will send four patches in reply to this mail.

Junio, please consider the first two patches for inclusion into the
next branch.  The third patch is on top of Pasky's changes in the pu
branch.  The fourth patch is a strange workaround for a strange
problem of which I think it is an error in Sun's compiler.  That one
should not make its way into Git, but maybe someone on the list has
an idea about the problem.

Regards,
Dennis
