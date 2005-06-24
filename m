From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: rev-parse, unknown arguments and extended sha1's
Date: Fri, 24 Jun 2005 18:17:18 +0200
Message-ID: <20050624161718.GA14909@pc117b.liacs.nl>
References: <20050624122436.GA15182@pc117b.liacs.nl> <Pine.LNX.4.58.0506240904240.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 18:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlqmn-0003f3-Ph
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 18:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbVFXQRz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbVFXQRy
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 12:17:54 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:35776 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S263106AbVFXQRg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 12:17:36 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5OGHJxh008975;
	Fri, 24 Jun 2005 18:17:24 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 139716FEA; Fri, 24 Jun 2005 18:17:18 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506240904240.11175@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2005 at 09:09:23AM -0700, Linus Torvalds wrote:
> Anyway, add the --revs-only, and the test against empty should make a bit 
> more sense. In fact, it _should_ test that it's a SHA1 (and not a rev 
> argument), but I couldn't come up with a good way to test that in shell.
> 

This is what I use:

rev2=`echo $rev | sed -e 's/[^0-9a-f]//'`
rev3=`echo $rev2 | sed -e 's/........................................//'`
if test "x$rev3" = "x" -a "x$rev" = "x$rev2"; then
	echo "valid SHA1"
fi

skimo
