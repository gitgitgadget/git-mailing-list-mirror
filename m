From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix gcc-4 warning in accept() call
Date: Thu, 29 Sep 2005 22:49:13 -0700
Message-ID: <7vachv9kbq.fsf@assigned-by-dhcp.cox.net>
References: <1128027901.24397.57.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 07:50:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELDm9-0005E1-5n
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 07:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVI3FtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 01:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVI3FtR
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 01:49:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:10424 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932443AbVI3FtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 01:49:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930054912.ICSH29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 01:49:12 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1128027901.24397.57.camel@dv> (Pavel Roskin's message of "Thu,
	29 Sep 2005 17:05:01 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9538>

Pavel Roskin <proski@gnu.org> writes:

> gcc-4 warns about sign mismatch in pointers.  Third argument in accept()
> is socklen_t, which is unsigned.  Since Linus doesn't like socklen_t
> (see commit 7fa090844f7d1624c7d1ffc621aae6aec84a1110), let's use
> unsigned int.

Based on the list comments, I'd drop this patch -- it appears
that gcc-4 warning is useless in this case.
