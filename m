From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: Running gitweb under mod_perl
Date: Thu, 24 Aug 2006 16:05:26 +0200
Message-ID: <20060824140525.G638085b@leonov.stosberg.net>
References: <eck6sq$agn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 16:06:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGFps-0007vP-0K
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 16:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWHXOF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWHXOF2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 10:05:28 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:1666 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S1751561AbWHXOF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 10:05:27 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500)
	id 873FDF3A9D; Thu, 24 Aug 2006 16:05:26 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eck6sq$agn$1@sea.gmane.org>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25960>

Jakub Narebski wrote:

> Could you tell me what should I do to run gitweb under mod_perl,
> and not as CGI script? 

About two months ago I sent a set of three patches that made gitweb
run with Apache::Registry:

  http://marc.theaimsgroup.com/?l=git&m=115089541911624

The first two patches have found their way into git, so the only
thing left to do is to change the way the path to the git repository
is passed to the git commands.

I haven't updated that patch since then and with all the refactoring
gitweb has seen it surely won't apply anymore, but if there's
interest I can rebase it to current "next".

> What should I put in Apache configuration (Apache 2.0.54 if this
> matters, mod_perl 2.0.1) 

>From my configuration:

  <Directory /home/dennis/public_html/perl>
    Options -Indexes +ExecCGI
    AllowOverride None
    PerlSendHeader On
    SetHandler perl-script
    PerlHandler ModPerl::Registry
  </Directory>

Regards,
Dennis
