From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow an alias to start with "-p"
Date: Sun, 23 Jul 2006 23:32:00 -0700
Message-ID: <7v8xmjh5sv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 24 08:32:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4tzC-0005RR-PZ
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 08:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWGXGcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 02:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWGXGcD
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 02:32:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14072 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751412AbWGXGcC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 02:32:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724063202.VDNM554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 02:32:02 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 19 Jul 2006 01:25:57 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24117>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, something like
>
> 	[alias]
> 		pd = -p diff
>
> works as expected.

I like what it wants to do but I am afraid this leads to an
unmaintainable code (a micronit that already shows what I mean
is that you can say "git --paginate diff", but you cannot say
"pd = --paginate diff" in the configuration file).

Is there a cleaner way to do it without duplicating the argument
loop of git.c::main()?
