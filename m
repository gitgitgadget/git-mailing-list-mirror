From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] remove inline iteration variable
Date: Wed, 16 Aug 2006 22:10:19 +0200
Message-ID: <20060816201019.GA6083@steel.home>
References: <Pine.LNX.4.63.0608151022340.26891@chino.corp.google.com> <81b0412b0608160027l2ac53c10gd9a75525ca144f1d@mail.gmail.com> <Pine.LNX.4.63.0608161011100.20470@chino.corp.google.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 22:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDRiy-0004yI-28
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 22:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWHPUKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 16:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWHPUKo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 16:10:44 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:30402 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932202AbWHPUKo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 16:10:44 -0400
Received: from fwd26.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1GDRip-0005OB-01; Wed, 16 Aug 2006 22:10:39 +0200
Received: from tigra.home (JON96sZTgeR46Ilz644orulpo3mnv1arC9OtNwCx6mJNghOCrxmfch@[84.160.109.190]) by fwd26.sul.t-online.de
	with esmtp id 1GDRiW-1GClNo0; Wed, 16 Aug 2006 22:10:20 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 82421277AF;
	Wed, 16 Aug 2006 22:10:19 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GDRiV-0007Rz-6I; Wed, 16 Aug 2006 22:10:19 +0200
To: David Rientjes <rientjes@google.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608161011100.20470@chino.corp.google.com>
User-Agent: Mutt/1.5.11
X-ID: JON96sZTgeR46Ilz644orulpo3mnv1arC9OtNwCx6mJNghOCrxmfch
X-TOI-MSGID: f9929636-d620-4c1d-b6c3-28d274cce244
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25524>

David Rientjes, Wed, Aug 16, 2006 19:14:44 +0200:
> > > Remove unnecessary iteration variable in inline.
> > > -       for (i = 0; i < in; i++) putchar(' ');
> > > +       for (; in > 0; in--)
> > 
> > while(in--) putchar(' ');
> > 
> 
> That goes into an infinite loop if the argument is negative because
> it emits a cmpl $0, x(%ebp).  Should never happen, but there's no
> reason not to prevent it with a for loop.

while (in-- > 0) putchar(' ');

still shorter :)
