From: Junio C Hamano <gitster@pobox.com>
Subject: Re: questions about git-mktree
Date: Sun, 10 May 2009 09:39:55 -0700
Message-ID: <7v63g829pg.fsf@alter.siamese.dyndns.org>
References: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, gitster@pobox.com,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 18:40:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3C4P-0005J4-Om
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 18:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbZEJQj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 12:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZEJQj4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 12:39:56 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46952 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbZEJQjz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 12:39:55 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510163956.PPSH20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Sun, 10 May 2009 12:39:56 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id psfw1b0014aMwMQ04sfw2u; Sun, 10 May 2009 12:39:56 -0400
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=bp8sV__4A8-7zqCg3JsA:9
 a=ruM5eLBiOQu9KDjv2uuVI_bZIbsA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com> (Jon Seymour's message of "Sun\, 10 May 2009 23\:41\:17 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118727>

Jon Seymour <jon.seymour@gmail.com> writes:

> Does git-mktree normalize the sort order of the input or take it as it
> is? I can see  a case for having it do normalization, if it doesn't
> already and probably for this to be the default behaviour.

It does have "accumulate and qsort before writing it out", since 83f5053
(git-mktree: reverse of git-ls-tree., 2006-02-20).

This program was done as a quick hack but it is so old that I forgot all
about it.  If you are going to use it, you may have to do some reality
checks on it first.  For example, notice that the date above predates the
introduction of gitlinks, so I would not be too surprised if it barfed
when given a commit object in its input.
