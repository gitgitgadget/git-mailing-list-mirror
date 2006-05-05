From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 05 May 2006 02:51:01 -0700
Message-ID: <7vejz8241m.fsf@assigned-by-dhcp.cox.net>
References: <20060505005659.9092.qmail@science.horizon.com>
	<20060505062236.GA4544@c165.ib.student.liu.se>
	<20060505092332.GY27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 11:51:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbwxp-0005EV-1x
	for gcvg-git@gmane.org; Fri, 05 May 2006 11:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWEEJvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 05:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWEEJvD
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 05:51:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41696 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030349AbWEEJvC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 05:51:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505095102.NHWU9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 05:51:02 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060505092332.GY27689@pasky.or.cz> (Petr Baudis's message of
	"Fri, 5 May 2006 11:23:32 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19606>

Petr Baudis <pasky@suse.cz> writes:

> But the non-obviously important part here to note is that the branch B
> merely "corrects a typo on a comment somewhere" - the latest versions in
> branch A and branch B are always compared for renames, therefore if
> branch A renamed the file and branch B sums up to some larger-scale
> changes in the file, it still won't be merged properly.

I probably am guilty of starting this misinformation, but the
code does not compare the latest in A and B for rename
detection; it compares (O, A) and (O, B).

But the end result is the same - what you say is correct.  If a
path (say O to A) that renamed has too big a change, then no
matter how small the changes are on the other path (O to B),
rename detection can be fooled.  We could perhaps alleviate it
by following the whole commit chain.
