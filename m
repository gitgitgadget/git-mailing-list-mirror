From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] Library code for user-relative paths, take three.
Date: Thu, 17 Nov 2005 15:56:51 -0800
Message-ID: <7v8xvmsu9o.fsf@assigned-by-dhcp.cox.net>
References: <20051117193714.2B8995BF93@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 00:58:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ectch-0008Pe-3B
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVKQX4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbVKQX4y
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:56:54 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63955 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965149AbVKQX4x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 18:56:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117235628.EIBL3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 18:56:28 -0500
To: exon@op5.se (Andreas Ericsson)
In-Reply-To: <20051117193714.2B8995BF93@nox.op5.se> (Andreas Ericsson's
	message of "Thu, 17 Nov 2005 20:37:14 +0100 (CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12179>

exon@op5.se (Andreas Ericsson) writes:

> +	if(strict && *dir != '/')

(style everywhere)

	if (strict ...

> +	/* This is perfectly safe, and people tend to think of the directory
> +	 * where they ran git-init-db as their repository, so humour them. */
> +	(void)chdir(".git");

It might be safe, but I think it changes the behaviour of
upload-pack with strict case.  My gut reaction is we would want
"if (!strict)" in front.  Thoughts?
