From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make fetch-pack play nicer with servers which do not speak multi_ack
Date: Tue, 25 Oct 2005 11:56:01 -0700
Message-ID: <7vll0he88u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510250854240.22398@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy84igfrl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510251104470.24174@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 20:57:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUTxv-0000eR-Dg
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 20:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVJYS4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 14:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVJYS4E
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 14:56:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42458 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932301AbVJYS4D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 14:56:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025185520.CEXY24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 14:55:20 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10611>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But you are right.  If you made 20 commits on top of my "master"
>> branch head, we should send those 20 (and the commit you based
>> on your changes, which the other end has), way before sending
>> the ancient v0.99 tag.  Probably, we should never be sending
>> v0.99 tag as "have" if we are going to send your "master" branch
>> head, since the commit that tag refers to is reachable by your
>> "master" branch head but there are a lot more commit between
>> them, some of which will give us better "common" selected, and
>> that v0.99 tag is what the other end said they have so is known
>> to be ACKed if sent.
>
> You.AN4re right. Complete common refs are sent even if they are ancestors of 
> other complete common refs. I.AN4ll think about that.

I just realized that I have two refs you would rather send the
last while fetching from me most of the time: junio-gpg-pub tag
and todo head.  If you manage to get acked either by non multi
aware remote before saying "have" on anything on the main
branch, I think you would get *everything* back --- which is
quite bad.
