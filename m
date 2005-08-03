From: Junio C Hamano <junkio@cox.net>
Subject: Re: Very limited pathspec wildcards..
Date: Wed, 03 Aug 2005 12:02:36 -0700
Message-ID: <7voe8ec08j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508031038320.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 21:05:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0OXO-0004vn-Ib
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 21:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVHCTDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 15:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVHCTDn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 15:03:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15815 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262414AbVHCTCi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 15:02:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803190237.IKXJ1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 15:02:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508031038320.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 10:48:03 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, I'm not sure this is a wonderful idea. I found it useful for doing
>
> 	git-whatchanged -p drivers/scsi/aic7xxx/aic79xx*
>
> since I was interested in seeign if only that particular driver had had 
> changes. But it's hacky and pretty limited, so I throw this patch out more 
> as a "maybe others think it is a good idea" thing. 

Wouldn't something like this work equally well?

    #!/bin/sh
    git-whatchanged -r |
    sed -ne '
    /^:/s|aic7xxx/aic79xx|&|p
    /^:/d
    p' | git-diff-helper
