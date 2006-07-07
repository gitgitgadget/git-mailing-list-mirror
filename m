From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff.c: respect diff.renames config option
Date: Fri, 07 Jul 2006 05:17:48 -0700
Message-ID: <7v64i9zk0j.fsf@assigned-by-dhcp.cox.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net>
	<11522670473116-git-send-email-normalperson@yhbt.net>
	<7v7j2p3eac.fsf@assigned-by-dhcp.cox.net>
	<20060707110123.GA23400@soma>
	<7vpsghzmr1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 14:17:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FypHO-00086F-BK
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 14:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWGGMRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 08:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWGGMRt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 08:17:49 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:2243 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750752AbWGGMRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 08:17:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707121748.HDOO8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 08:17:48 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <7vpsghzmr1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 07 Jul 2006 04:18:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23436>

Junio C Hamano <junkio@cox.net> writes:

> I am more worried about somebody who opts-in finds breakage of
> commands that happen to internally use low-level diff machinery
> and expect the diff machinery does not automagically do funny
> rename detection without being told.
> ...
> That is why I said I do not want this at _that_ low level.  I do
> not have objections to have the configuration at a layer closer
> to the UI, e.g. things in builtin-log.c and builtin-diff.c.

Upon closer look I think the revision pruning code is OK.  So
let's cook this as is in "next" and see what happens.
