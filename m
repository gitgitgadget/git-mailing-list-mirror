From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] close clobbers mmap's errno in read_cache
Date: Sat, 8 Oct 2005 01:50:11 +0200
Message-ID: <20051007235011.GA8189@steel.home>
References: <20051007214551.GA8893@steel.home> <20051007214845.GH8383MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 01:51:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO1yn-0000CN-Rr
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 01:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVJGXuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 19:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVJGXuS
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 19:50:18 -0400
Received: from devrace.com ([198.63.210.113]:44812 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964886AbVJGXuR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 19:50:17 -0400
Received: from tigra.home (p54A0E160.dip.t-dialin.net [84.160.225.96])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j9802cD6081542;
	Fri, 7 Oct 2005 19:02:38 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EO1yd-0006eT-00; Sat, 08 Oct 2005 01:50:11 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EO1yd-00028I-Dm; Sat, 08 Oct 2005 01:50:11 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051007214845.GH8383MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.5 required=4.5 tests=AWL,BAYES_20,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9831>

Sven Verdoolaege, Fri, Oct 07, 2005 23:48:45 +0200:
> On Fri, Oct 07, 2005 at 11:45:51PM +0200, Alex Riesen wrote:
> >  	}
> > +	i = errno;
> >  	close(fd);
> >  	if (map == MAP_FAILED)
> > -		die("index file mmap failed (%s)", strerror(errno));
> > +		die("index file mmap failed (%s)", strerror(i));
> >  
> 
> Why don't you just move the close after the test ?

I don't know.

> There's no point in closing if you're going to die.
> 
> skimo

Of course you're right :) I'm just blind after eight.
