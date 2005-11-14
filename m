From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] git-cvsexportcommit.perl: Fix usage() output.
Date: Mon, 14 Nov 2005 14:14:40 -0800
Message-ID: <7vbr0mx4fj.fsf@assigned-by-dhcp.cox.net>
References: <20051114164047.GB9131@raven.localdomain>
	<20051114164505.GF9131@raven.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 23:16:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbmbB-0004BN-5a
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 23:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVKNWOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 17:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVKNWOn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 17:14:43 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2783 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932188AbVKNWOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 17:14:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114221408.WVFP20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 17:14:08 -0500
To: Kevin Geiss <kevin@desertsol.com>
In-Reply-To: <20051114164505.GF9131@raven.localdomain> (Kevin Geiss's message
	of "Mon, 14 Nov 2005 09:45:05 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11856>

Kevin Geiss <kevin@desertsol.com> writes:

>  sub usage {
>  	print STDERR <<END;
> -Usage: GIT_DIR=/path/to/.gi ${\basename $0}      # fetch/update GIT from CVS
> -       [-h] [-p] [ parent ] commit
> +Usage: GIT_DIR=/path/to/.git ${\basename $0} [-h] [-p] [-v] [-c] [ parent ] commit
>  END
>  	exit(1);
>  }

I hate to be nitpicky, but this slurps in File::Basename
(9Kbytes) only to shorten the displayed command name.

I personally do not like programs that shorten $0 (or in C
argv[0]) when they identify themselves.  This is probably just
me, but I was bitten by such programs too many times while
debugging them, after wasting too many hours only to find that I
was not running the executable I thought I was running but
something else that happened to be earlier on my PATH X-<.
