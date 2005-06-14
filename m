From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Adding Correct Useage Notification and -h Help flag
Date: Mon, 13 Jun 2005 22:52:25 -0700
Message-ID: <7vaclt8oyu.fsf@assigned-by-dhcp.cox.net>
References: <1118713641.8712.10.camel@localhost.localdomain>
	<7vmzptbrsg.fsf@assigned-by-dhcp.cox.net>
	<1118726714.8712.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 07:49:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di4Iw-0007B3-VB
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 07:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFNFyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 01:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFNFxq
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 01:53:46 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5340 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261233AbVFNFw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 01:52:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050614055225.NCJX20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Jun 2005 01:52:25 -0400
To: purserj@winnsw.com.au
In-Reply-To: <1118726714.8712.22.camel@localhost.localdomain> (James
 Purser's message of "Tue, 14 Jun 2005 15:25:14 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JP" == James Purser <purserj@winnsw.com.au> writes:

JP> When running git commit I am told to run git-update-cache
JP> against the files I want to commit. Would it be easier to
JP> have the git-commit-script run this itself? Take out that
JP> second step and all that.

That's a question better asked Linus, not me.  My preference
would be (1) to ask the user if he wants us to automatically run
git-update-cache to all of those files, giving him an option to
decline and sort things out himself; or (2) leave things as they
are.

The core GIT treats the index file and the working directory
contents two logically separate entities, and we always require
the user to consciously tell us what to put in and remove from
the index file.  The core GIT is all about committed tree
objects and the index file, and the working directory is merely
a temporary area the user can use to build the state the user
wishes to have in the index file.  From this point of view,
running git-update-cache ourselves without asking the user is a
definite no-no.

