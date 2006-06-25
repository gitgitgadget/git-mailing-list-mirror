From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/7] Rework diff options
Date: Sat, 24 Jun 2006 20:48:03 -0700
Message-ID: <7vslltopzg.fsf@assigned-by-dhcp.cox.net>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 25 05:48:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuLbo-0003Hq-Pe
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 05:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWFYDsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 23:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWFYDsG
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 23:48:06 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42653 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751108AbWFYDsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 23:48:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625034805.NNIH8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 23:48:05 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624201843.a5b4f7b9.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Sat, 24 Jun 2006 20:18:43 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22585>

Timo Hirvonen <tihirvon@gmail.com> writes:

> This patch series cleans up diff output format options.
>
> This makes it possible to use any combination of --raw, -p, --stat and
> --summary options and they work as you would expect.
>
> These patches passed all test and are for the next branch. Patches 6 and
> 7 are optional.

Thanks, very nicely done.  Tentatively placed all of them in
"pu"; the first "clean-up" is in "master".

Here are a few problems I have seen:

 - "git show --stat HEAD" gives '---' marker as Johannes and you
   have already discussed (I do not mind this that much though);

 - "--cc" seems to be quite broken.  "git show v1.0.0" nor "git
   diff-tree --pretty --cc v1.0.0" does not give the log
   message, and gives something quite confused instead.  I think
   it is showing "-m -p" followed by "--cc".

We may find more minor breakages, in addition to these, but I am
reasonably sure we should be able to fix them in-tree.
