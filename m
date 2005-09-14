From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Wed, 14 Sep 2005 11:16:18 -0700
Message-ID: <7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net>
References: <20050914124206.GC24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 20:18:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFbo0-0005W5-Ox
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 20:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbVINSQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVINSQU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 14:16:20 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24764 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932732AbVINSQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 14:16:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914181619.SYP2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 14:16:19 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8549>

Sergey Vlasov <vsu@altlinux.ru> writes:

> The problem is caused by the behavior of fetch.c:process_commit() - it
> skips parent commits which already exist locally.  This is a good
> optimization if your repository is OK, but after an interrupted fetch
> there will be some missing objects in the object tree; the only way to
> find them is to scan the whole tree, so stopping at the existing
> commits is wrong.

Hmph.  I could almost swear that I've seen the 'recovery' fix
from Daniel and merged it some time ago -- but I do not see that
in the git-whatchanged output.  The only '--recover' I see is
the leftover command line option description to recover from
delta-fetch failure, which would not happen because we do not
have deltified objects anymore.

Thanks for the patch.
