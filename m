From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach the git wrapper about --name-rev and --name-rev-by-tags
Date: Fri, 28 Jul 2006 08:43:18 -0700
Message-ID: <7vy7udloq1.fsf@assigned-by-dhcp.cox.net>
References: <20060524131022.GA11449@linux-mips.org>
	<Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
	<7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
	<20060525131241.GA8443@linux-mips.org>
	<7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607281308280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 17:43:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6UUm-0007Z1-Sc
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 17:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbWG1PnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 11:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbWG1PnV
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 11:43:21 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:12980 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1752001AbWG1PnU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 11:43:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060728154319.EELR12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Jul 2006 11:43:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607281308280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 28 Jul 2006 13:12:08 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24392>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	On Wed, 26 Jul 2006, Junio C Hamano wrote:
>
> 	>  * Passing the standard error from "fetch-pack -v" to "name-rev
> 	>    --stdin" makes it a bit more pleasant to see what is going on.
>
> 	This patch makes it even easier.

Probably wouldn't for that particular one, since what I wanted
to do was "git fetch-pack -v 2>&1 | git name-rev >/var/tmp/1",
so isatty(1) check in setup_name_rev_pager() is defeated by
redirection, and the information I wanted to pass name-rev would
not have passed it anyway.

But this _might_ be useful for other more general cases.  I'm
not sure -- it feels somewhat like a hack, though.
