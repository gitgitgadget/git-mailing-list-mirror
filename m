From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT character codecs
Date: Sun, 13 Nov 2005 02:21:36 -0800
Message-ID: <7v3bm0c0gf.fsf@assigned-by-dhcp.cox.net>
References: <20051113081443.38296.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 11:22:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbEzc-0006ru-Hj
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 11:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVKMKVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 05:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVKMKVk
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 05:21:40 -0500
Received: from eastrmmtao04.cox.net ([68.230.240.35]:34289 "EHLO
	eastrmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932301AbVKMKVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 05:21:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by eastrmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051113102010.KGD4997.eastrmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Nov 2005 05:20:10 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051113081443.38296.qmail@web26309.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Sun, 13 Nov 2005 00:14:43 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11730>

Marco Costalba <mcostalba@yahoo.it> writes:

> But I'm a bit reclutant to add this 'codec list' stuff
> because, as said, is *not* the real solution.

Why isn't it real?  UNIX files do not declare what encoding they
are in, and people get their work done with existing viewing or
editing tools (e.g.  vi, less, emacs, firefox [*1*], ...).  How
is your situation any different?

I suspect you could just take the default from LANG and LC_CTYPE
to cover 98% of the cases, and to cover the rest 2% the
problematic cases have a per-window override menu.  If you first
implement only the locale support without per-window override
and tell your users to set these environment variables to
iso-8859-15 when running qgit on your Italian project repository
(or use utf-8 on git.git), wouldn't that be sufficient for most
everyday uses?

[Footnotes]

*1* Ok, firefox is a bit different because they can read charset
attribute from content type, but even so they have a manual
override from View->CharEncoding menu to let their users cope
with broken pages.
