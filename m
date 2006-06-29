From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] autoconf: Use autoconf to write installation directories to config.mak
Date: Thu, 29 Jun 2006 14:46:21 +0200
Message-ID: <E1FvvuX-0002Lr-Nt@moooo.ath.cx>
References: <200606290301.51657.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 14:46:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvvuh-0001kB-6A
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 14:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWF2Mq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 08:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWF2Mq1
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 08:46:27 -0400
Received: from moooo.ath.cx ([85.116.203.178]:63931 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750816AbWF2Mq0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 08:46:26 -0400
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200606290301.51657.jnareb@gmail.com>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22858>

> This is beginning of patch series introducing installation configuration
> using autoconf (and no other autotools) to git. The idea is to generate
> config.mak using ./configure (generated from configure.ac) from
> config.mak.in, so one can use autoconf as an _alternative_ to ordinary
> Makefile, and creating one's own config.mak.

Are you sure this should be named config.mak? From INSTALL:
> You can place local settings in config.mak and the Makefile
> will include them.  Note that config.mak is not distributed;
> the name is reserved for local settings.

So with another filename either include it
- before config.mak: the user may override ./configure options with
  config.mak
- after config.mak: ./configure overrides config.mak
At least do not overwrite config.mak if it exists.
