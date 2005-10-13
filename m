From: Junio C Hamano <junkio@cox.net>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Wed, 12 Oct 2005 22:50:10 -0700
Message-ID: <7vr7aq55kd.fsf@assigned-by-dhcp.cox.net>
References: <867jciz18w.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 07:51:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPvz2-00029d-7D
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 07:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVJMFuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 01:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVJMFuN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 01:50:13 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14982 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751234AbVJMFuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 01:50:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013054953.LIUE29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 01:49:53 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10062>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> I updated git to d06b689a933f6d2130f8afdf1ac0ddb83eeb59ab,
> then compiled and installed.
>
> When I went to "git-pull" on my cogito archive (which I had edited
> to use HTTP instead of RSYNC), I got into trouble.  Unfortunately,
> I changed it to rsync to force cogito into a sane state before
> I realized that this would be a good bug report. :)

Indeed I wish we could see the set of refs you had and output
from fsck-objects before the failed git-pull and after.

One thing I am aware of is that cogito repository at kernel.org
is not set up to be HTTP friendly -- it lacks info/refs file
git-clone uses for discovery of the available refs.

Cogito's clone/fetch over HTTP uses recursive wget for
discovery, and I presume that is one of the reasons nobody
noticed this.  Another reason may probably be that more people
use rsync transport.
