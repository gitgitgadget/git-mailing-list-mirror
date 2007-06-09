From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Add autoconf-based build infrastructure for tig
Date: Sat, 9 Jun 2007 11:31:01 +0200
Message-ID: <20070609093101.GA25039@diku.dk>
References: <20070531215508.GB9260@diku.dk> <20070603193521.GA10161@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 11:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwxI2-0001yH-Fw
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 11:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbXFIJbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 05:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbXFIJbG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 05:31:06 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:48692 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbXFIJbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 05:31:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 14373F000D;
	Sat,  9 Jun 2007 11:31:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R-w-yOZhvs2l; Sat,  9 Jun 2007 11:31:02 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id EB767F0034;
	Sat,  9 Jun 2007 11:31:01 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A47076DFB78; Sat,  9 Jun 2007 11:28:45 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id CECA062A5D; Sat,  9 Jun 2007 11:31:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603193521.GA10161@midwinter.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49566>

Hi Steven,

Steven Grimm <koreth@midwinter.com> wrote Sun, Jun 03, 2007:
> ---
> 	This is a first cut at building tig using autoconf. I'm including
> 	a script to run the various autoconf tools rather than packaging
> 	up a finished configure script. With this patch, tig configures
> 	and builds on both Linux (FC4) and OS X. I left a lot of the code
> 	from the original Makefile intact so as to (hopefully) not mess
> 	up building release tarballs, etc.

First of all, thank you for starting this work!

I've only played little with this patch, but overall I like most of the
changes. I would, however, want to look into making the dependency on
autoconf optional (like it is for git) and avoid using automake at all.
It would make the autoconf.sh bootstrap script obsolete, since the
Makefile can just take care of it, and it would keep the build system
simple.

So the idea is for configure to also generate a Makefile.config that can
be sourced by the Makefile. Then of course inclusion of the config.h
file should depend on some -DHAVE_CONFIG_H flag for the compiler.

What do you think? You are of course welcome to come up with a patch for
this proposal, but else I would like to get your permission/sign-off to
include the configure.ac script and the tig.c changes you made.

-- 
Jonas Fonseca
