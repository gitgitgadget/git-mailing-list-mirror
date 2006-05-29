From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/1] Tried to fix git-svn's handling of filenames with embedded '@'.
Date: Sun, 28 May 2006 22:25:01 -0700
Message-ID: <20060529052403.GA24077@localdomain>
References: <m21wuem2xj.fsf@ziti.fhcrc.org> <m2verqkobr.fsf@ziti.fhcrc.org> <7vlksldgp2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 29 07:25:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkaFY-0002AN-Iq
	for gcvg-git@gmane.org; Mon, 29 May 2006 07:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWE2FZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWE2FZE
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 01:25:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7851 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751188AbWE2FZD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 01:25:03 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DA90A7DC005;
	Sun, 28 May 2006 22:25:01 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 28 May 2006 22:25:01 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlksldgp2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20917>

Junio C Hamano <junkio@cox.net> wrote:
> Seth Falcon <sethfalcon@gmail.com> writes:
> 
> > svn has trouble parsing files with embedded '@' characters.  For
> > example,
> >
> >   svn propget svn:keywords foo@bar.c
> >   svn: Syntax error parsing revision 'bar.c'
> >
> > I asked about this on #svn and the workaround suggested was to append
> > an explicit revision specifier:
> >
> >   svn propget svn:keywords foo@bar.c@BASE
> >
> > This patch appends '@BASE' to the filename in all calls to 'svn
> > propget'.
> 
> Eric, this sounds sane to me.  Ack?

Doesn't work with svn 1.1 (a requirement of mine, unfortunately).  I'll
have a fix for that in a bit.

-- 
Eric Wong
