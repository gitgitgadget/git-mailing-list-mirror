From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] git-clone: Keep remote names when cloning unless explicitly told not to.
Date: Thu, 10 Nov 2005 09:15:50 -0800
Message-ID: <7vd5l81l15.fsf@assigned-by-dhcp.cox.net>
References: <20051110115808.418125BF88@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 18:18:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaG1j-0002fe-2a
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 18:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVKJRPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 12:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVKJRPw
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 12:15:52 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29317 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751173AbVKJRPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 12:15:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110171458.VRWP776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 12:14:58 -0500
To: exon@op5.se (Andreas Ericsson)
In-Reply-To: <20051110115808.418125BF88@nox.op5.se> (Andreas Ericsson's
	message of "Thu, 10 Nov 2005 12:58:08 +0100 (CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11493>

exon@op5.se (Andreas Ericsson) writes:

> +	The name of a new directory to clone into.  The	"humanish"
> +	part of the source repository is used if no directory is
> +	explicitly given ("repo" for "/path/to/repo.git" and "foo"
> +	for "host.xz:foo/.git").  Cloning into an existing directory
> +	is not allowed.
>  
> +# Try using "humanish" part of source repo if user didn't specify one
> +[ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's#/*\.git$##' -e 's#.*[/:]##')

Micronit; if I version control contents of my home directory on
host.xz [*1*] under git, I would say host.xz:.git/ when cloning
it, wouldn't I?

Maybe we would want to check if the resulting $dir makes sense
after this step.

[Footnote]

*1* ... I wouldn't personally, but some people are known to do
that.
