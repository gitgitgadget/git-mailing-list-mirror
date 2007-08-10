From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout-index needs a working tree
Date: Thu, 09 Aug 2007 17:55:08 -0700
Message-ID: <7vd4xww6mr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
	<20070809223530.GA29680@cassiopeia>
	<Pine.LNX.4.64.0708100129200.21857@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:55:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJIma-0006bI-Fq
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 02:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816AbXHJAzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 20:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756625AbXHJAzL
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 20:55:11 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61865 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813AbXHJAzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 20:55:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810005509.UGEQ2095.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 20:55:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a0v81X0041kojtg0000000; Thu, 09 Aug 2007 20:55:08 -0400
In-Reply-To: <Pine.LNX.4.64.0708100129200.21857@racer.site> (Johannes
	Schindelin's message of "Fri, 10 Aug 2007 01:31:06 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55494>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That is _completely_ expected.  If it is a bare repository, you can _only_ 
> override that check by GIT_WORK_TREE or --work-tree.
>
> But I have to wonder: if you want to use git checkout-index, which is a 
> work-tree operation, why did you mark it as bare to begin with?

I do not necessarily think --prefix=untar/it/here/ is a work
tree operation.

Perhaps we probably are better off if we add something that says
specifying GIT_DIR alone means you are at the top of work tree
(to resurrect the traditional behaviour), to alleviate fallouts
like this and the other cvsserver one?  If one does not like
that traditional behaviour, the new GIT_WORK_TREE support can
be used override it.
