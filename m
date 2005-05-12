From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] improved delta support for git
Date: Thu, 12 May 2005 10:27:00 -0400
Message-ID: <200505121027.01964.mason@suse.com>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain> <7voebhkql5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 16:20:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWEXJ-0007fM-Kq
	for gcvg-git@gmane.org; Thu, 12 May 2005 16:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVELO1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 10:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVELO1K
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 10:27:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:49093 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261953AbVELO1H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 10:27:07 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B27DAA26C;
	Thu, 12 May 2005 16:27:06 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 01A5D5628B; Thu, 12 May 2005 16:27:05 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7voebhkql5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 12 May 2005 00:36, Junio C Hamano wrote:
> It appears to me that changes to the make_sure_we_have_it()
> routine along the following lines (completely untested) would
> suffice.  Instead of just returning success, we first fetch the
> named object from the remote side, read it to see if it is
> really the object we have asked, or just a delta, and if it is a
> delta call itself again on the underlying object that delta
> object depends upon.

If we fetch the named object and it is a delta, the delta will either depend 
on an object we already have or an object that we don't have.  If we don't 
have it, the pull should find it while pulling other commits we don't have.

-chris


