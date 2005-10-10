From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix cygwin install issues
Date: Mon, 10 Oct 2005 09:51:34 -0700
Message-ID: <7v64s571t5.fsf@assigned-by-dhcp.cox.net>
References: <20051010085259.GA18009@diku.dk>
	<7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net> <434A82A0.7060608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 18:53:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP0sI-00062b-QY
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 18:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVJJQvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 12:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVJJQvg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 12:51:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:59117 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750898AbVJJQvf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 12:51:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010165118.VIXI11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 12:51:18 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434A82A0.7060608@zytor.com> (H. Peter Anvin's message of "Mon,
	10 Oct 2005 08:02:56 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9898>

"H. Peter Anvin" <hpa@zytor.com> writes:

>> ...  I suspect it might be
>> the responsibility of the user to quote them if she chooses to
>> set bindir or DESTDIR to a funky value, like this:
>>     $ make bindir="'My Documents\Programs'"
>
> I don't think that's the right approach.
>
> 	$(INSTALL) -d -m755 '$(DESTDIR)$(bindir)'
>
> ... at least handles everything except embedded single quotes.

OK.  It is better than dq, and the user can still work it around
like this if she really wanted to:

	make bindir="Anna'\\''s Home/bin"

I wish we had $(shellquote $(DESTDIR)$(bindir)) in make ;-).
