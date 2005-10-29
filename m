From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with cg-clone
Date: Sat, 29 Oct 2005 12:41:27 -0700
Message-ID: <7vacgs157c.fsf@assigned-by-dhcp.cox.net>
References: <1130605726.5396.39.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 21:42:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVwa4-0002W8-TQ
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 21:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVJ2Tla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 15:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVJ2Tl3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 15:41:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41431 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750711AbVJ2Tl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 15:41:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029194129.LKFD9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Oct 2005 15:41:29 -0400
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1130605726.5396.39.camel@blade> (Marcel Holtmann's message of
	"Sat, 29 Oct 2005 19:08:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10803>

Marcel Holtmann <marcel@holtmann.org> writes:

> Previously this was working fine and since cogito hasn't changed the
> last few days, I suspect that git is at fault here or changed something.
> Any ideas?

I think I know what is going on.

git-init-db does not create .git/objects/[0-9a-f]{2}/
directories anymore, but git-local-fetch has not taught to
create them on demand.
