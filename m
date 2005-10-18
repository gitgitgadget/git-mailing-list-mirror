From: Junio C Hamano <junkio@cox.net>
Subject: Re: [CORRECTED PATCH] git-fetch-pack: avoid unnecessary zero packing
Date: Tue, 18 Oct 2005 11:49:05 -0700
Message-ID: <7vmzl6r78e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510181049050.17201@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 20:51:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERwWU-0005JM-HN
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 20:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVJRStI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 14:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVJRStI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 14:49:08 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4314 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751162AbVJRStG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 14:49:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018184855.TFIL16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 14:48:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181049050.17201@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Oct 2005 10:52:45 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10222>

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, this should be the trivially fixed (famous last words) patch, which 
> should correct the case where we don't have a local name for the remote 
> ref at all.
>
> If you already applied the previous patch, you just need to fix the

No, I haven't (not my git day today).

It strikes me that we could walk from our refs, depth reasonably
limited to say 20 or so commit chain and/or last 5 days of
commit time, to see if any of the remotes are reachable from our
refs and omit issuing "want" quite cheaply.  Do you think that
would be a worthy change to make things more efficient?
