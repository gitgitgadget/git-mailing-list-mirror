From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 10:44:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607271038520.4168@g5.osdl.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
 <20060727114105.GZ13776@pasky.or.cz> <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
 <Pine.LNX.4.63.0607271602060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060727172047.GB13776@pasky.or.cz> <20060727172329.GC13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 19:45:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69va-0008GP-OB
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWG0Rpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWG0Rpd
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:45:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22174 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750813AbWG0Rpd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:45:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6RHjBnW014172
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Jul 2006 10:45:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6RHiwE6010640;
	Thu, 27 Jul 2006 10:45:04 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060727172329.GC13776@pasky.or.cz>
X-Spam-Status: No, hits=-0.571 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24323>



On Thu, 27 Jul 2006, Petr Baudis wrote:
> 
>   That said, Git still requires RCS for the merge operation. Any plans
> to finally switch to diff3 and toss out another useless dependency?

If libxdiff ever gets a real 3-way merge, I think we'd do it in a 
heartbeat.

Right now it has a function called "xdl_merge3()", but it doesn't actually 
have anythign to do with a real merge:

  "The function works by creating a differential between mmfo and mmf2 and
   by applying the resulting patch to mmf1"

so it's really just a "diff + patch".

I asked Davide about it some time ago, and I think he said that he'd like 
to do it properly, but it's always been on his back-burner and that he 
didn't foresee that changing in the immediate future..

So we can hope. Or somebody who knows the algorithms could just implement 
it and send it to both us and Davide (libxdiff _is_ LGPL, btw).

		Linus
