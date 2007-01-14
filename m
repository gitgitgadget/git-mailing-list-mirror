From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] Always perfer annotated tags in git-describe.
Date: Sun, 14 Jan 2007 11:11:04 -0800
Message-ID: <7v8xg5h19z.fsf@assigned-by-dhcp.cox.net>
References: <20070113222752.GA18011@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:30:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWZ-0000uB-SU
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:35 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7r-0003eK-HC
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbXANTLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 14:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXANTLK
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 14:11:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:33015 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbXANTLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 14:11:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114191105.QTQA20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sun, 14 Jan 2007 14:11:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B7BM1W00d1kojtg0000000; Sun, 14 Jan 2007 14:11:22 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36824>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> @@ -148,17 +149,17 @@ static void describe(const char *arg, int last_one)
>  			else
>  				all_matches = p;
>  			cur_match = p;
> +			if (n->prio == 2)
> +				continue;

When you do not have _any_ annotated tag but you do have
lightweight tags, wouldn't this make the traversal go all the
way down to root?
