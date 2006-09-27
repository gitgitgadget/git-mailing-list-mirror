From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] perl bindings fix compilation errors
Date: Tue, 26 Sep 2006 19:40:38 -0700
Message-ID: <7vwt7qjal5.fsf@assigned-by-dhcp.cox.net>
References: <20060925100319.GA1655@shadowen.org>
	<Pine.LNX.4.63.0609251223590.25371@wbgn013.biozentrum.uni-wuerzburg.de>
	<4517BEBC.4000002@shadowen.org>
	<7vfyeftehf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609261031430.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 04:41:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPLt-0002X1-6q
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 04:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWI0Ckl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 22:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWI0Ckk
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 22:40:40 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64927 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932086AbWI0Ckj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 22:40:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927024039.OKQD12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 22:40:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TEgc1V0011kojtg0000000
	Tue, 26 Sep 2006 22:40:36 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27853>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 25 Sep 2006, Junio C Hamano wrote:
>
>> It is certainly incorrect to say that it is a driver error to
>> git-pull (or git-checkout to switch branches) without running
>> "make clean" first to get rid of perl/Git.c while your Makefile
>> still knows it is a generated file.  Our Makefile should be more
>> helpful.
>
> How about this:

The problem is on which branch we would apply this and how long
we will carry it.  I suspect you would have to have it forever
and everywhere.  After all your bisect can hit a version with
Git.xs and then next build suggested by bisect may be a version
without it.  And the user is doing that bisect long after we
release version 47.

The worst part is that the version bisect suggests that does not
have Git.xs may be a version in the past -- which we obviously
cannot apply your patch to.
