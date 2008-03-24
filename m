From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [msysGit] Re: Store autocrlf during init-db (was [msysGit] autocrlf problems with Git-preview20080301.exe)
Date: Mon, 24 Mar 2008 03:23:02 +0300
Message-ID: <20080324002302.GD25381@dpotapov.dyndns.org>
References: <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar> <20080323235610.GB25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803240101220.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 01:23:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdaTg-0007RE-JE
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 01:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757823AbYCXAXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757857AbYCXAXL
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 20:23:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:44676 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757823AbYCXAXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 20:23:10 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2689194fgb.17
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=3nK8n+KqqEndPPo4BXe3XMlQ8TYok60EFBXXPz4GbmU=;
        b=BFO89oGVXBqYZpgc4RYPRL9OHsZSlz6LAzve7i923KxgXMgCYiiGuDUF49HceKsbKI/kQeQVZaNLjvBA10JKTPAV9vxJrPDodmxTX6Rk6Z7lu97Q8Yx1Yy2p9QRZiLDUhuDYgTDn+o7KSY93gA+spDmqx5HbnkbUGCuB7HcClT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=um18VqHKmPdJYjTyZiwIC5Gvgi7xHmYYMBul/O1Yrfuc7DJVZhMwEZjXDR84Tjrf7QqI0yPeBA+ZzKZ64p9SPuAfDKTIcQU+vKdy2vQbGRpl6vlvbhMpd/K1KbCR8km6TGWW+n8UYmBzamzGaM3H96SFz2A+MQQvMrvarI+qvwY=
Received: by 10.82.161.19 with SMTP id j19mr15615951bue.9.1206318188280;
        Sun, 23 Mar 2008 17:23:08 -0700 (PDT)
Received: from localhost ( [85.140.170.114])
        by mx.google.com with ESMTPS id n10sm7403864mue.18.2008.03.23.17.23.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Mar 2008 17:23:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803240101220.4353@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77981>

On Mon, Mar 24, 2008 at 01:01:54AM +0100, Johannes Schindelin wrote:
> 
> On Mon, 24 Mar 2008, Dmitry Potapov wrote:
> 
> > We already have templates for different hooks, info/exclude, etc. So, 
> > instead of placing autocrlf in /etc/gitconfig, you should place this 
> > variable to /usr/share/git/templates/config and this file should be 
> > copied by git init or git clone as any other file in templates.
> 
> I thought we discussed that already?  And the consensus was that this does 
> not allow for per-user overriding.

I am sorry I missed this discussion. In this case, I believe that the
idea of templates should be extended, so any user may have his/her own
templates in $HOME/.gittemplates. IMHO, it makes much more sense than
making an exception for autocrlf in builtin-init-db.c and breaking
existing repositories...


Dmitry
