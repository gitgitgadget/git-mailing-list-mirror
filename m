From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] format-patch: Generate a newline between the subject header and the message body.
Date: Thu, 13 Jul 2006 14:48:32 -0700
Message-ID: <7v7j2huqfj.fsf@assigned-by-dhcp.cox.net>
References: <44B6369D.6070602@codeweavers.com>
	<7vbqrtur8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 23:48:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G193A-0002Qa-NX
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 23:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWGMVsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 17:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWGMVsf
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 17:48:35 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16597 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030418AbWGMVse (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 17:48:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713214834.MGRD2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 17:48:34 -0400
To: Robert Shearman <rob@codeweavers.com>
In-Reply-To: <7vbqrtur8q.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 13 Jul 2006 14:31:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23856>

Junio C Hamano <junkio@cox.net> writes:

> Robert Shearman <rob@codeweavers.com> writes:
>
>> This patch inserts a newline in two places - once in the loop to
>> separate the subject part of the commit message from the body part of
>> the commit message and another after the loop to counteract the eating
>> of whitespace at the end of the message.
>
> Thanks.
>
>  * Please sign your patch.
>
>  * This breaks a handful t4013 tests, but all in a good way (in
>    other words, the expected output files were wrong).
>
> I'll fix up the t/t4013/diff.* files myself.

Actually, I take that back.  This breaks normal commit log
messages by adding extra blank lines.  The extra LF is needed
when the commit log does not have any message (just title).

I'll be tweaking a few tests in t4013 to catch future breakage
of this kind.
