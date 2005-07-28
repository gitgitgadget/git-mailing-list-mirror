From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Wed, 27 Jul 2005 18:32:01 -0700
Message-ID: <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 03:40:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxxNH-0007F5-J3
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 03:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVG1BeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 21:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVG1Bc1
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 21:32:27 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42138 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261506AbVG1BcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 21:32:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050728013151.MRHN550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Jul 2005 21:31:51 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200507271458.43063.Josef.Weidendorfer@gmx.de> (Josef Weidendorfer's message of "Wed, 27 Jul 2005 14:58:42 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> As far as I can see, there is no support in core GIT to make this ever work 
> (at least with get-send-packs), as "git-send-pack" only updates a set of 
> heads with the same name both locally and remote.

Yes, it is my understanding that "clone" means to literally
clone, not "pull into an empty repository with renamed head
names", to the core GIT.  I do not speak for Pasky, but Cogito's
"clone" seems to have a bit different semantics (which I suspect
is more friendly to the users in many situations).

Similarly, "push" to the core GIT (that is what git-send-pack is
about) means performing a subset of "clone" in reverse.  This is
primarily to synchronise two repositories owned by a single
person.
