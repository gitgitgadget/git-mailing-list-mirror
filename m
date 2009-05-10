From: Junio C Hamano <gitster@pobox.com>
Subject: Re: questions about git-mktree
Date: Sun, 10 May 2009 10:10:46 -0700
Message-ID: <7vvdo8zxwp.fsf@alter.siamese.dyndns.org>
References: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com>
	<7v63g829pg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 19:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3CYC-0002BP-Jf
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 19:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbZEJRKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZEJRKr
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 13:10:47 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62192 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZEJRKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 13:10:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510171047.QFCV17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 May 2009 13:10:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id ptAm1b0084aMwMQ03tAmlA; Sun, 10 May 2009 13:10:46 -0400
X-Authority-Analysis: v=1.0 c=1 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8
 a=fkCc-c7gyMTQsjttogwA:9 a=16Kc7uyXmCaxMnWV7TR5aDBAo_QA:4 a=qIVjreYYsbEA:10
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <7v63g829pg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 10 May 2009 09\:39\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118730>

Junio C Hamano <gitster@pobox.com> writes:

> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Does git-mktree normalize the sort order of the input or take it as it
>> is? I can see  a case for having it do normalization, if it doesn't
>> already and probably for this to be the default behaviour.
>
> It does have "accumulate and qsort before writing it out", since 83f5053
> (git-mktree: reverse of git-ls-tree., 2006-02-20).
>
> This program was done as a quick hack but it is so old that I forgot all
> about it.  If you are going to use it, you may have to do some reality
> checks on it first.  For example, notice that the date above predates the
> introduction of gitlinks, so I would not be too surprised if it barfed
> when given a commit object in its input.

Heh, it does verify that the object listed exists locally in the
repository, so submodules would not work in general.

I'm fixing it.  You _might_ get your recursive mktree as a side effect at
the end of the series, but no promises ;-)
