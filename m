From: Junio C Hamano <junkio@cox.net>
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 10:05:37 -0700
Message-ID: <7vac7ya5r2.fsf@assigned-by-dhcp.cox.net>
References: <20060626233838.GA3121@steel.home>
	<Pine.LNX.4.63.0606270936520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0606270158i16ebee20me81ca2b9fa71db5c@mail.gmail.com>
	<Pine.LNX.4.63.0606271248270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 19:05:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvH0Q-00057E-Qi
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 19:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWF0RFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161218AbWF0RFj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 13:05:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39902 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1161217AbWF0RFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 13:05:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627170538.JIHJ12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 13:05:38 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606271248270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 27 Jun 2006 12:51:35 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22745>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > - I always wondered why merge-recursive did not call merge-base, but did
>> >   its own thing. Hmm?
>> 
>> No idea yet.

A somewhat related issue is that when one head is given I'd
strongly prefer that merge-recursive did not call merge-base nor
did its own thing (that is, for the top-level).  Otherwise we
cannot use it for historyless three tree merge that we need for
rebase/revert/cherry-pick.
