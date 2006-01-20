From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] DT_UNKNOWN: do not fully trust existence of DT_UNKNOWN
Date: Fri, 20 Jan 2006 22:53:14 +0100
Message-ID: <20060120215314.GA4203@steel.home>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <7voe277lbe.fsf@assigned-by-dhcp.cox.net> <81b0412b0601200701n76f1d912y4671c6800735cd0d@mail.gmail.com> <7vzmlqaf5o.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Fri Jan 20 22:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F04CJ-00011s-Ls
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 22:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWATVx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 16:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWATVx2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 16:53:28 -0500
Received: from devrace.com ([198.63.210.113]:36876 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751175AbWATVx1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2006 16:53:27 -0500
Received: from tigra.home (p54A06CFB.dip.t-dialin.net [84.160.108.251])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0KLrGna041619;
	Fri, 20 Jan 2006 15:53:17 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F04C3-0006sb-00; Fri, 20 Jan 2006 22:53:15 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F04C2-0001DJ-LN; Fri, 20 Jan 2006 22:53:14 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmlqaf5o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=2.0 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL,RCVD_IN_SORBS_WEB autolearn=no 
	version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14978>

Junio C Hamano, Fri, Jan 20, 2006 20:10:59 +0100:
> >> The recent Cygwin defines DT_UNKNOWN although it does not have d_type
> >> in struct dirent.  Give an option to tell us not to use d_type on such
> >> platforms.  Hopefully this problem will be transient.
> >
> > You still have to #undef all the DT_ macros if you have a somewhat
> > old Cygwin (before Christopher removed the macros).
> 
> Ah, you mean something like this?
> 
> +#undef DT_UNKNOWN
> +#undef DT_DIR
> +#undef DT_REG
> +#undef DT_LNK

yes, of course
