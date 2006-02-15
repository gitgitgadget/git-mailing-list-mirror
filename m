From: Junio C Hamano <junkio@cox.net>
Subject: Re: StGIT refreshes all added files - limitation of git-write-tree?
Date: Tue, 14 Feb 2006 22:20:23 -0800
Message-ID: <7vacctnnx4.fsf@assigned-by-dhcp.cox.net>
References: <1139978528.28292.41.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 07:20:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9G1d-0001GA-Vp
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 07:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422865AbWBOGU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 01:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWBOGU0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 01:20:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26541 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422865AbWBOGUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 01:20:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215061854.VDHS6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 01:18:54 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1139978528.28292.41.camel@dv> (Pavel Roskin's message of "Tue,
	14 Feb 2006 23:42:08 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16213>

Pavel Roskin <proski@gnu.org> writes:

> Or maybe git-write-tree and other utilities could be changed to work on
> a copy of the index file?  I would prefer not to move the
> actual .git/index away, but to make a copy for the current "stg refresh"
> operation.

There is no need to change the core side.  

	GIT_INDEX_FILE=temporary-index git-write-tree

would do the job.  See the current round of git-commit and how
it handles "git commit --only these files" case.
