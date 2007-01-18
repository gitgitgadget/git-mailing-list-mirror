From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Wed, 17 Jan 2007 16:13:43 -0800
Message-ID: <7v7ivlp4y0.fsf@assigned-by-dhcp.cox.net>
References: <17437.1168911089@lotus.CS.Berkeley.EDU>
	<7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
	<200701171629.l0HGTCE3019292@laptop13.inf.utfsm.cl>
	<7vk5zlsglk.fsf@assigned-by-dhcp.cox.net>
	<45AEB932.3060509@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 01:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Kua-0000cF-BI
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 01:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXARANq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 19:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXARANq
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 19:13:46 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50237 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXARANp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 19:13:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070118001344.TZRE97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 19:13:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CQE11W0131kojtg0000000; Wed, 17 Jan 2007 19:14:02 -0500
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
In-Reply-To: <45AEB932.3060509@fs.ei.tum.de> (Simon Schubert's message of
	"Thu, 18 Jan 2007 01:02:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37048>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> Junio C Hamano wrote:
>>>> We have done this already so it might be too late to raise this
>>>> question, but does everybody have printf?
>> The problematic are less common ones, ranging from (not so less
>> common) OSX, Solaris to (much less common) AIX that some people
>> seem to run git on (or at least compile git for).
>
> printf(1) is part of POSIX/SUSv3, so systems *should* have it.

A lot of the portability problem we suffered were about the
things that systems *should* have it.

Unfortunately a standard does not matter a whit on its own when
dealing with the real world.  That's why I muttered the above
even though I knew POSIX says you should have one.

We use POSIX as one of the yardsticks to see what we should stay
away (i.e. "that is not even in POSIX so let's not use it for
now"), and also how far we are willing to bend over (i.e. "any
reasonable system should have it; besides, it is in POSIX.
Let's use it -- it is so convenient -- and insane platforms can
screw themselves").

The key point in the latter is that "besides" is not "because".
