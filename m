From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Also handle CVS branches with a '/' in their name
Date: Wed, 17 Aug 2005 00:02:53 -0700
Message-ID: <7vk6il11wi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508170839030.27628@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 09:03:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Hwx-00077J-PQ
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 09:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVHQHC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 03:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVHQHC5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 03:02:57 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14800 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750941AbVHQHC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 03:02:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817070253.IXMF7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 03:02:53 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508170839030.27628@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 17 Aug 2005 08:39:31 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I track a CVS project which has a branch with a '/' in the branch name.
> Since git wants the branch name to be a file name at the same time,
> translate that character to a '-'. This should work well, despite the
> fact that a division and a difference are completely different :-)

My feeling is that there should be nothing to prevent you from
having a non-flat namespace in .git/refs/heads; i.e. we should
allow ".git/refs/heads/foo/bar".  Some of the existing tools may
be forgetting to call either "mkdir -p $(dirname $ref)" if they
are written in shell, or safe_create_leading_directories(ref) in
C, but I consider that is a bug.
