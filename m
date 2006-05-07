From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] get_pathspec(): free() old buffer if rewriting
Date: Sat, 06 May 2006 21:50:45 -0700
Message-ID: <7vejz6phei.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605070003430.6357@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0605061532190.16343@g5.osdl.org>
	<7viroipijf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 07 06:50:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcbEJ-00013S-TO
	for gcvg-git@gmane.org; Sun, 07 May 2006 06:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWEGEur (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 00:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWEGEur
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 00:50:47 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49829 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750984AbWEGEuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 00:50:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507045046.NEZB21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 00:50:46 -0400
To: git@vger.kernel.org
In-Reply-To: <7viroipijf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 06 May 2006 21:26:12 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19691>

Junio C Hamano <junkio@cox.net> writes:

> int match_pathspec(const char *path, int len,
> 	           struct pathspec **pathspec);
>
> 	See if the path (with length) matches the given spec.
> 	path[len-1] == '/' signals that the caller is traversing
> 	a tree and checking if it is worth descending into the
> 	tree.
> ...
> and when traversing the tree for A and B, upon seeing "Documentation"
> entry in the topleve tree object buffers, call:
>
> 	path_match("Documentation", 14, 1, spec)

Oops, match_pathspec("Documentation/", 15, spec) is what I meant
here.  Likewise in the later examples.
