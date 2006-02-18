From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] Optionally work without python
Date: Fri, 17 Feb 2006 22:50:28 -0800
Message-ID: <7vvevdtb2j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602171523510.24274@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 07:50:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FALvP-0007E6-3l
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 07:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWBRGub (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 01:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWBRGub
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 01:50:31 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21711 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750932AbWBRGua (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 01:50:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218064857.VRL6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 01:48:57 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16394>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In some setups (notably server setups) you do not need that dependency.
> Gracefully handle the absence of python when NO_PYTHON is defined.

> +ifdef NO_PYTHON
> +	TEST_DEFS += NO_PYTHON=YesPlease
> +endif

I wonder if there is a better way to do this.  All future
NO_BLAH that may affect tests need to have something like this
otherwise.

> -default_strategies='recursive'
> +if test -z "@@NO_PYTHON@@"; then
> +	default_strategies='recursive'
> +else
> +	default_strategies='resolve'
> +fi

Somebody commented on this part to make it shorter...

I'll take 2, 3, and 4 from this series for now.  They will
appear in "next".  Thanks.
