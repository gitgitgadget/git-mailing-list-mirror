From: Junio C Hamano <junkio@cox.net>
Subject: Re: time to update with new packs
Date: Sat, 01 Oct 2005 00:18:59 -0700
Message-ID: <7vacht902k.fsf@assigned-by-dhcp.cox.net>
References: <12c511ca0509302140o4263020bsc337594609175173@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 09:19:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELbeF-0003an-26
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 09:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJAHTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 03:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVJAHTE
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 03:19:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60154 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750767AbVJAHTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 03:19:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051001071854.HCYD24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Oct 2005 03:18:54 -0400
To: Tony Luck <tony.luck@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9592>

Tony Luck <tony.luck@gmail.com> writes:

> 1) Link the new pack files from Linus' objects/pack directory
> to my objects/pack directory.
>
> 2) $ GIT_DIR=. git prune-packed # in my directory
>
> 3) $ GIT_DIR=. git update-server-info # ditto

When everybody uses more recent clients, you could say
"/pub/scm/.../torvalds/linux-2.6.git/objects" in your
objects/info/alternates file and not worry about step (1).  git
native transport has known about the alternate mechanism since
the inception.  The alternate mechanism support in "git fetch"
and "git clone" for rsync and http transports is a relatively
recent addition (appeared just before 0.99.7).

So (1) is not necessary for git native transport once you have
"alternate" file, but for other transports (1) is probably still
helpful at this point.

Also, enabling hooks/post-update in your public repository would
save you from worrying about (3), provided if the only way you
update it is by pushing into it, which I think is what usually
people are doing.
