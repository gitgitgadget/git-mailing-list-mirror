From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git-pull output message
Date: Wed, 28 Sep 2005 04:00:33 -0700
Message-ID: <7v64slxxri.fsf@assigned-by-dhcp.cox.net>
References: <72499e3b05092803027175bab0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 13:01:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKZhA-0003q2-8i
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 13:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVI1LAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 07:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVI1LAl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 07:00:41 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62626 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751215AbVI1LAk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 07:00:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050928110033.NVRO16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Sep 2005 07:00:33 -0400
To: Robert Watson <robert.oo.watson@gmail.com>
In-Reply-To: <72499e3b05092803027175bab0@mail.gmail.com> (Robert Watson's
	message of "Wed, 28 Sep 2005 11:02:38 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9425>

Robert Watson <robert.oo.watson@gmail.com> writes:

> Notice that the git.git directory is truncated.  It seems the
> intension is to truncate at the .git directory level.

c5434dead6a52a48c520dfa3d8ed24dc3673ab1a commit introduced this
behaviour, and we kept it ever since.

It may look a bit weird when it is applied to git.git/, but the
intention is to shorten the log message without losing much
information.  ".../torvalds/linux-2.6.git" is similarly
shortened to ".../torvalds/linux-2.6".

You can see 'git log' output in the kernel repository and look
for commit log messages of merge commits, and notice all those
repository names with trailing ".git" stripped.
