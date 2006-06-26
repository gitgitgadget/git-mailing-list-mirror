From: Junio C Hamano <junkio@cox.net>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sun, 25 Jun 2006 23:49:05 -0700
Message-ID: <7vbqsgmmxq.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<20060625012435.GZ21864@pasky.or.cz>
	<7vfyhtopjm.fsf@assigned-by-dhcp.cox.net>
	<20060625093444.GD21864@pasky.or.cz>
	<Pine.LNX.4.63.0606251202320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060625102037.GI29364@pasky.or.cz>
	<7vzmg1v7ci.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606251537450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Jun 26 08:49:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FukuJ-0000DY-Az
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 08:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWFZGtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 02:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWFZGtL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 02:49:11 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:27544 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750785AbWFZGtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 02:49:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626064909.WSBG554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 02:49:09 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22655>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I can live with it. Although I still think that it would be a good idea to 
> convert (at least the most commonly used) scripts to C.
>
> Perl, Python and sometimes even bash are good for fast prototyping. But 
> for serious work, such as profiling, they are not that good.

I expect the eventual primary customer of Git.xs to be gitweb.

I do not necessarily agree with what you just said about
scripting languages.  Shell is a very good implementation
language for certain serious things that does not require
performance and non command line UI.

> And you can see different behaviour on different platforms (plus things 
> like the SunCC requirement for XS on Solaris), which make the scripts less 
> robust.

I am not sure about "less robust" part, but it certainly
involves initial pain to deal with portability across platforms.

That's why I want to make sure that the basics is sound before
we spend too much time and attention on converting existing
scripts.  I think the major part of bringing Git.xs series
acceptably mergeable is not about XS programming and Perl script
conversion, but primarily about the work on the build
infrastructure (Makefile, test scripts and .spec).
