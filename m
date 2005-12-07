From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Initial AIX portability fixes.
Date: Tue, 06 Dec 2005 16:08:21 -0800
Message-ID: <7vzmndzs3u.fsf@assigned-by-dhcp.cox.net>
References: <20493.1133907616@lotus.CS.Berkeley.EDU>
	<Pine.LNX.4.63.0512070055430.5888@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 01:09:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjmrC-0006Kn-KX
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbVLGAIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 19:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbVLGAIY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:08:24 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:47253 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932668AbVLGAIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 19:08:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207000652.NYHD17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 19:06:52 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512070055430.5888@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 7 Dec 2005 00:58:28 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13307>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 6 Dec 2005, Jason Riedy wrote:
>
>> -#define _XOPEN_SOURCE /* glibc2 needs this */
>> +#define _XOPEN_SOURCE 500 /* glibc2 and AIX 5.3L need this */
>> +#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>
> Why not enclose the #define in #ifndef/#endif, and do the real magic in 
> the Makefile? Within the AIX clause:
>
> 	ALL_CFLAGS += -D_XOPEN_SOURCE=500 -XOPEN_SOURCE_EXTENDED=1
>
> This way the source does not get cluttered with platform dependent 
> defines.

True but the original convert-objects.c defines _XOPEN_SOURCE on
all platforms not just AIX.
