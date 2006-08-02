From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 21:40:11 +0200
Message-ID: <E1G8MZf-00022S-0v@moooo.ath.cx>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Aug 02 21:40:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8MZr-0004sr-Qb
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 21:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWHBTkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 15:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWHBTkT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 15:40:19 -0400
Received: from moooo.ath.cx ([85.116.203.178]:13722 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932183AbWHBTkR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 15:40:17 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24672>

Junio C Hamano <junkio@cox.net> wrote:
> They all try to make customization can be done in one
> place, and the difference is mostly of taste, so I'd just pick
> one from Martin.
I hope it will be possible (see require suggestion from Jeff King) to
specify the file also from the environment because then it is possible
to develop on an uncostumized version of gitweb.perl.  Now I noticed
a problem: do not use the @@FOO@@ in double quotes because perl will
spit a lot of warnings like
"Possible unintended interpolation of @GIT_VERSION in string"
Either we should use another delimiter or use single quotes (this is
the way it is done in git-send-email.perl and git-svn.perl).  I don't
know how likely it is that characters that are interpreted different
in double quotes are in filenames but I'd prefer single quotes just to
be on the safe site.  This disallows using '/etc/foo/$ENV{SITE_NAME}'
as config file but one can just use '/etc/foo/bar' which requires
'/etc/foo/$ENV{SITE_NAME}'.
