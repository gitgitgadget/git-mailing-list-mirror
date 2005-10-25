From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack extension
Date: Tue, 25 Oct 2005 14:04:57 -0700
Message-ID: <7vvezlcnpi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051025204754.GA8030@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 23:07:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUVyf-0005Tl-Lo
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 23:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVJYVE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVJYVE7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 17:04:59 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46250 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932382AbVJYVE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 17:04:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025210457.OSTX9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 17:04:57 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051025204754.GA8030@steel.home> (Alex Riesen's message of
	"Tue, 25 Oct 2005 22:47:54 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10618>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Schindelin, Sun, Oct 23, 2005 03:40:13 +0200:
>> This patch concludes the series, which makes 
>> git-fetch-pack/git-upload-pack negotiate a potentially better set of 
>> common revs. It should make a difference when fetching from a repository 
>> with a few branches.
>
> This broke git-pull for me (the local one):

Is this the same problem I fixed with this commit, which sits at
the tip on the "master" branch?

commit 7efc8e43508b415e2540dbcb79521bde16c51e0c
tree 6234aa4f7095054a137e030030f914dc6633f809
parent 40a10462498bdd23d4e49f02867b8be50eb78704
author Junio C Hamano <junkio@cox.net> 1130061738 -0700
committer Junio C Hamano <junkio@cox.net> 1130192018 -0700

    upload-pack: fix thinko in common-commit finder code.

    The code to check if we have the object the other side has was bogus
    (my fault).

    Signed-off-by: Junio C Hamano <junkio@cox.net>
