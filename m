From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge (resolve) _is_ stupid
Date: Mon, 31 Jul 2006 04:01:18 -0700
Message-ID: <7v7j1u6nsx.fsf@assigned-by-dhcp.cox.net>
References: <7v7j1u88ol.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607311236070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 13:01:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7VWW-0001vj-OO
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 13:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWGaLBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 07:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWGaLBV
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 07:01:21 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:48845 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932185AbWGaLBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 07:01:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731110119.JZRE6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 07:01:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607311236070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 31 Jul 2006 12:42:35 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24513>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The culprit is the call to parse_commit() in merge_bases(). How about 
> this?

Do you mean merge_bases() in commit.c which is called by
get_merge_bases()?  If so the patch feels like papering over a
more grave bug -- the result from make_virtual_commit does not
seem to have any proper parent information, so how is merge_bases()
expected to return anything sensible?

I am confused, but going to bed first.
