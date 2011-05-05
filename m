From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Thu, 5 May 2011 17:00:36 +0200
Message-ID: <20110505150036.GB31229@camk.edu.pl>
References: <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net>
 <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
 <4DC0E99E.6090402@viscovery.net>
 <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net>
 <7v4o5afht7.fsf@alter.siamese.dyndns.org>
 <7vwri5c27e.fsf@alter.siamese.dyndns.org>
 <20110505142910.GA31229@camk.edu.pl>
 <4DC2B814.5070507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 05 17:00:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI02t-000288-F2
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 17:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab1EEPAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 11:00:44 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:52895 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122Ab1EEPAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 11:00:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id D1AFE5F004B;
	Thu,  5 May 2011 17:00:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8dhB+7+WRG2c; Thu,  5 May 2011 17:00:36 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id BA95F5F0046;
	Thu,  5 May 2011 17:00:36 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id A932F80AC5; Thu,  5 May 2011 17:00:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC2B814.5070507@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172836>

On Thu, May 05, 2011 at 04:45:40PM +0200, Johannes Sixt wrote:
> A:

> > 1. ./configure --prefix=dir1  and dir1 != /usr

> >     git_etcdir = etc

> > 2. ./configure --prefix=/usr

> >     git_etcdir = /etc

> > 3. ./configure --prefix=dir1 --syscondir=dir2 (here dir2 has to be
> > an
> > absolute path)

> >     git_etcdir =  dir2

> Why do you have the restriction that --sysconfdir must be absolute? Is
> it
> imposed by autotools?

Yes, configure does not accept relative pathnames.

>   4. ./configure --sysconfdir=dir2

>      git_etcdir =  dir2

> B:

> > 1. make prefix=dir1 and dir1 != /usr

> >     git_etcdir = etc

> > 2. make prefix=/usr

> >     git_etcdir = /etc

> > 3. make prefix=dir1 sysconfdir=dir2 (here dir2 can be an absolute or
> > a relative path)

> >     git_etcdir = dir2

>   4. make sysconfdir=dir2

>       git_etcdir = dir2

> C:
> in config.mak write none, one, or both of

>   prefix=dir1
>   sysconfdir=dir2

> with the same 4 case distinctions and corresponding desired results as
> in B.

> Looks fine and simple to implement, except that I don't see that you
> have
> to introduce git_etcdir; can't you just stick with the name
> "sysconfdir"?

I can do it, if Junio is ok with it.

Should the patch be based on main or on the previous patch that was
merged to next?

-- 
  Kacper Kornet
