From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Speed up get_projects_list for large source
	trees
Date: Wed, 17 Oct 2007 01:20:58 +0200
Message-ID: <20071016232058.GA18279@machine.or.cz>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz> <vpqlka3sdka.fsf@bauges.imag.fr> <3A2DCEC6-953A-41B0-AB9E-7374EEB625E8@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 01:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihvio-0004RH-Nj
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 01:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188AbXJPXVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 19:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbXJPXU7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 19:20:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46791 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbXJPXU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 19:20:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2A0865A45C; Wed, 17 Oct 2007 01:20:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3A2DCEC6-953A-41B0-AB9E-7374EEB625E8@vicaya.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61276>

  Hi,

On Tue, Oct 16, 2007 at 02:04:14AM -0700, Luke Lu wrote:
> Hi, I've been using git for a month now and loving it. This is my first 
> ever patch for git using git. I spent sometime to find out why the project 
> listing is taking 200s, everytime! I guess that gitweb is mostly used to 
> serve bare repositories, which would never encounter such problems. It 
> takes .2s, after the patch on my laptop. That's 1000x improvement for me 
> (on Mac OS X 1.4.10.)

  that'd be sweet to have but this is unfortunately not so simple; this
change would e.g. break gitweb on repo.or.cz, where some projects can
live quite deep inside the tree due to forks.

  I guess the best way would be to introduce a configuration option that
lets you potentially limit the $pfxdepth, but does not force the limit.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
