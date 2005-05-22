From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 12:20:13 -0700
Message-ID: <7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
	<20050522184237.GG18500@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 21:19:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvyY-0005kv-KY
	for gcvg-git@gmane.org; Sun, 22 May 2005 21:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVEVTUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 15:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEVTUS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 15:20:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11677 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261648AbVEVTUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 15:20:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522192013.XBI550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 15:20:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 22 May 2005 12:05:24 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> The machine readable format has the same issue: it needs to be able to 
LT> distinguish between a "copy" (where the source remains) and a "rename" 
LT> (where the source is removed).

Why?  If the same path appears later as the left hand side then
it is a copy otherwise it is a rename.  Please see what
diffcore-rename does when assigning to dp->xfrm_msg.  

What I've been trying hard so far was to keep diff_filepair not
to be too specific to rename/copy.  What I do not like about
what is being proposed is that it would force me to introduce
this "is this a copy or a rename" flag to that structure.

