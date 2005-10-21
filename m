From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Fri, 21 Oct 2005 14:32:00 -0700
Message-ID: <7vbr1iv9nz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwtk6vlqz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510212134570.5542@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 23:32:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET4Uh-0002SW-5w
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 23:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVJUVcD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 17:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVJUVcD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 17:32:03 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:59785 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751150AbVJUVcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 17:32:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051021213132.QARR776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 17:31:32 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510212134570.5542@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 21 Oct 2005 21:44:12 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10450>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes. This makes it more simple, and is very efficient in the common case. 
> How about increasing MAX_HAS to 64?

The other day I saw HPA tried to sneak in a change to increase
it to 64, mingled with other changes.  I think increasing it
makes sense.

Now the question is, if we count MAX_HAS on the fetch-pack side,
how would we coordinate that value with the real limit the other
end uses.  I guess that would not matter too much.  It would not
affect the correctness anyway.
