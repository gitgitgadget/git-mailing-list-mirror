From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Sat, 28 Apr 2007 13:50:59 +0200
Message-ID: <20070428115059.GA4888@steel.home>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br> <1177693212202-git-send-email-lcapitulino@mandriva.com.br> <Pine.LNX.4.64.0704280446180.12006@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	junkio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 28 13:51:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhlSG-0001zW-Ds
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 13:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270AbXD1LvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 07:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756269AbXD1LvF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 07:51:05 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:56123 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbXD1LvC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 07:51:02 -0400
Received: from tigra.home ([195.4.175.39] [195.4.175.39])
	by post.webmailer.de (mrclete mo44) (RZmta 5.8)
	with ESMTP id E04b53j3SBJFZA ; Sat, 28 Apr 2007 13:50:59 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 86B1C277BD;
	Sat, 28 Apr 2007 13:50:59 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 56296CF17; Sat, 28 Apr 2007 13:50:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704280446180.12006@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOMblA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45776>

Johannes Schindelin, Sat, Apr 28, 2007 04:46:41 +0200:
> > +#define for_each_revision(commit, rev) \
> > +	for (prepare_revision_walk(rev); \
> > +		  (commit = get_revision(rev)) != NULL; )
> > +
> >  #endif
> 
> I object to this, additionally to the magic argument that I agree to, on 
> the grounds that it is actually wrong. The first iteration will work on an 
> _uninitialized_ "commit" variable.

No, it wont. Check it. This code is correct.

> Furthermore, it is not like it was a huge piece of code that is being 
> replaced by a shortcut. There are better places to do some libification 
> than this.

It is not about libification. It is plain readability issue.
Look at what list_for_each_* macros did to the source of Linux kernel.
