From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange date format in git-send-email
Date: Wed, 05 Jul 2006 14:22:38 -0700
Message-ID: <7vlkr7bvc1.fsf@assigned-by-dhcp.cox.net>
References: <200607050817.37366.martijn.kuipers@lx.it.pt>
	<e8fv2o$khv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 23:22:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyEpd-0006du-69
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 23:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWGEVWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 17:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWGEVWl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 17:22:41 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5628 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965024AbWGEVWk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 17:22:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060705212239.BBOE8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Jul 2006 17:22:39 -0400
To: jnareb@gmail.com
In-Reply-To: <e8fv2o$khv$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	05 Jul 2006 11:00:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23362>

Jakub Narebski <jnareb@gmail.com> writes:

> There were two patches on the list: one hacky adding setlocale 
> call (not applied), second implementing rfc-822 date in Perl.
> Should be in current.

What do you mean by "should be in current"?

I specifically asked you about this issue a few days ago, even
with a patch to test out for people who are having problems, but
haven't heard back anything yet.  The issue is still on hold and
not in "current" as far as I am concerned.

    To: Jakub Narebski <jnareb@gmail.com>
    Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
    From: Junio C Hamano <junkio@cox.net>
    Subject: Re: [PATCH] send-email: Use setlocale in addition to
        $ENV{LC_ALL} to set locale
    Date: Sun, 02 Jul 2006 19:49:50 -0700
    Message-ID: <7vd5cnv1v5.fsf@assigned-by-dhcp.cox.net>

    I was reviewing old log and noticed this topic has never been
    resolved.  Your proposal was to use POSIX::setlocale(), and
    Eric's counter-proposal was to mimic what 822-date script does,
    doing it by hand without mucking with locales, and the
    discussion seemed to have died there.  Does this still need to
    be addressed?

    My gut feeling is that it would probably be less problematic if
    we do not muck with locales at all (so drop POSIX::strftime as
    well).

    So maybe something like this (totally untested)?
    ...
