From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff: add --no-diff-deleted to make -p more pleasant
Date: Sun, 29 Jan 2006 12:12:32 -0800
Message-ID: <7vy80ykd3j.fsf@assigned-by-dhcp.cox.net>
References: <20060129142403.GA15482@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 21:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Iub-0008HM-Qz
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWA2UMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWA2UMf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:12:35 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17370 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751149AbWA2UMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 15:12:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129201239.GZRZ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 15:12:39 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060129142403.GA15482@Muzzle> (Eric Wong's message of "Sun, 29
	Jan 2006 06:24:04 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15235>

Eric Wong <normalperson@yhbt.net> writes:

> This is a feature I've stol^Wborrowed from svn that I find very
> useful since I usually don't care to see what I've deleted.

There is a thing called --diff-filter, and 

	git diff -p --no-diff-deleted

is equivalent to

	git diff -p --diff-filter=AM

when you are not using rename/copy detection (and a byte
shorter).  Or maybe improve its syntax to also take:

	--diff-filter=-D

That is, a minus followed by list of undesired change class
letters.
