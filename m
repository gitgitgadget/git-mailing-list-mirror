From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-pull to pull branches, not the whole repository
Date: Wed, 14 Sep 2005 15:05:12 -0700
Message-ID: <7vu0gne25j.fsf@assigned-by-dhcp.cox.net>
References: <1126733516.10827.54.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 00:15:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFfOJ-0007Sd-J1
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 00:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVINWFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 18:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVINWFU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 18:05:20 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42704 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965028AbVINWFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 18:05:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914220512.MTX9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 18:05:12 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1126733516.10827.54.camel@dv> (Pavel Roskin's message of "Wed,
	14 Sep 2005 17:31:56 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8571>

Pavel Roskin <proski@gnu.org> writes:

> ...  Unfortunately, listings are
> still needed to get refs/tags and refs/heads.  Any fix for that would
> involve git core, and I don't see an elegant fix.

All the necessary "core" support should already be there, except
for the client side support.  Please look at yesterday's thread
with title "dumb transports not being welcomed".

> For git+ssh protocol, git-fetch-pack already provides a server side
> solution.  Client side support would be needed for http and rsync.
>
> I'd like to hear comments before I attempt any hacking in this
> direction.

Personally I think Cogito should be able to just call git-fetch
to implement cg-pull -- I do not claim the current git-fetch has
everything needed (incapable of using objects/info/alternates is
an example), but we should be able to fix and enhance just one
program to make everybody happy, not two.
