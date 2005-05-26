From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] ls-tree matching multiple paths
Date: Thu, 26 May 2005 11:06:53 -0700
Message-ID: <7v4qcpdfpe.fsf@assigned-by-dhcp.cox.net>
References: <20050526034756.GA1488@port.evillabs.net>
	<7vsm0aeguo.fsf@assigned-by-dhcp.cox.net>
	<1117111843.11542.11.camel@jmcmullan.timesys>
	<1117120411.11542.16.camel@jmcmullan.timesys>
	<7vacmhdgct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 20:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbMj7-0008IF-HL
	for gcvg-git@gmane.org; Thu, 26 May 2005 20:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVEZSG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVEZSG5
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 14:06:57 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35808 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261671AbVEZSGz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 14:06:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526180655.OEZG550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 14:06:55 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <7vacmhdgct.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 26 May 2005 10:52:50 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> +040000	tree	X	path2/baz
JCH> +100644	blob	X	path2/baz/b

Side note.  Linus, don't you think it would make more sense to
change the column separator befor type and SHA1 from TAB to SP?
We should keep the one before the path to TAB for easier
splitting with cut (which defaults to a TAB).  This comes from
the same reasoning as the latest diff-raw format design we did.

While we are at it, we may want to do the same to ls-files,
which does not use TAB for inter_name_termination (it uses SP
for everything).

