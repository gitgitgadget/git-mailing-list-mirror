From: Junio C Hamano <junkio@cox.net>
Subject: Tool renames and 'ls-files -t' output
Date: Thu, 08 Sep 2005 15:14:52 -0700
Message-ID: <7virxbtder.fsf@assigned-by-dhcp.cox.net>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 09 00:16:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDUfZ-0006gY-HR
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 00:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVIHWOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 18:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVIHWOz
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 18:14:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3054 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965028AbVIHWOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 18:14:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908221454.UHGI7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Sep 2005 18:14:54 -0400
To: git@vger.kernel.org
In-Reply-To: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 07 Sep 2005 17:08:31 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8224>

The "master" branch post 0.99.6 already has the renamed tools
with backward compatibility symlinks.  I'll be sending a
patch to address an issue raised by some people separately to
see what the list thinks, and also will attempt to send out a
patch for the Pasky and Catalin heads later this week.  Also
I'll remove the ancient backward compatible environment variable
names from gitenv.c.

There were discussion on the tag 'git-ls-files -t' output uses.
I got a feeling that we might want to change them to match what
other tools give.  Here is the proposed changes:
	
    Meaning	Current		Updated

    cached	H		.
    unmerged	M		U
    removed	R		D
    other	?		?
    killed	K		K
    modified	info unav.	M

I may also be tempted to rename 'tag_removed' variable there to
'tag_deleted' for consistency.

Comments?
