From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: when dwim'ing a ref, only allow heads
 andtags
Date: Tue, 24 Jul 2007 12:20:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241218270.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site> 
 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241134330.14781@racer.site>
 <46A5DCBC.E585A69D@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDISA-0002gN-Hx
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761583AbXGXLVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762725AbXGXLVT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:21:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:49286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761125AbXGXLVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:21:18 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:21:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 24 Jul 2007 13:21:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EHzoeMA7En8yK0lHHmppmvXHbFy9OorPmSvfJPu
	dq0PW2lPBGmflS
X-X-Sender: gene099@racer.site
In-Reply-To: <46A5DCBC.E585A69D@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53570>

Hi,

On Tue, 24 Jul 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > -                       grep /"$ref")"
> > +                       grep "refs/\(tags\|heads\)/$ref$")"
> 
> Thanks, but I don't think that this is a portable grep pattern:
> 
> $ echo "abc" | grep '\(a\|x\)'
> $ echo "abc" | egrep '(a|x)'
> abc
> 
> But then, this is on some AIX 4.3. How about:
> 
>    fgrep -e "refs/heads/$ref" -e "refs/tags/$ref"
> or
>    grep -e "^refs/heads/$ref" -e "^refs/tags/$ref"

Ah yes, I remember that Junio said some time ago that "\|" is not 
portable.

But to be portable, let's stay with grep, and not use some fancy stuff 
like egrep or fgrep.

Ciao,
Dscho
