From: Junio C Hamano <junkio@cox.net>
Subject: Re: A note on merging conflicts..
Date: Sat, 01 Jul 2006 12:56:07 -0700
Message-ID: <7vzmftcd60.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
	<20060701150926.GA25800@lsrfire.ath.cx>
	<7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
	<44A6CD1D.2000600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 21:56:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwlZj-0000a2-K9
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 21:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWGAT4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWGAT4J
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 15:56:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25760 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751919AbWGAT4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 15:56:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701195608.BAEQ22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Jul 2006 15:56:08 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44A6CD1D.2000600@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sat, 01 Jul 2006 21:29:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23061>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I wonder why the two clear_commit_marks() calls at the end of
> get_merge_bases() are not sufficient, though.

I missed to notice that Johannes had added those calls there; we
should remove them from get_merge_bases().

The normal case of git-merge-base calling get_merge_bases() once
and exiting should NOT have to pay for the clean-up cost at all.
