From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Submodules
Date: Wed, 08 Aug 2007 21:53:51 +0200
Message-ID: <20070808195351.GQ999MdfPADPa@greensroom.kotnet.org>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
 <Pine.LNX.4.64.0708072349400.14781@racer.site>
 <a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
 <20070808104117.GK999MdfPADPa@greensroom.kotnet.org>
 <7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrbR-0007fR-CD
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762277AbXHHTxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760294AbXHHTxx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:53:53 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:36064 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761294AbXHHTxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:53:53 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMH008YV0LRQP@psmtp08.wxs.nl> for git@vger.kernel.org; Wed,
 08 Aug 2007 21:53:51 +0200 (MEST)
Received: (qmail 1883 invoked by uid 500); Wed, 08 Aug 2007 19:53:51 +0000
In-reply-to: <7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55351>

On Wed, Aug 08, 2007 at 12:33:26PM -0700, Junio C Hamano wrote:
> +  Note that the current submodule support is minimal and this is
> +  deliberately so.  A design decision we made is that operations
> +  at the supermodule level do not recurse into submodules by
> +  default.  The expectation is that later we would add a
> +  mechanism to tell git which submodules the user is interested
> +  in, and this information might be used to determine the
> +  recursive behaviour of certain commands (e.g. "git checkout"
> +  and "git diff"), but currently we haven't agreed on what that
> +  mechanism should look like.  Therefore, if you use submodules,
> +  you would probably need "git submodule update" on the
> +  submodules you care about after running a "git checkout" at
> +  the supermodule level.
> +

Maybe you could be a bit more explicit about the
possibly unexpected results of "git checkout".
Perhaps something like the following instead of the
last sentence:

    In particular, if you have any submodules checked out,
    running a "git checkout" at the supermodule level will
    not update these submodules.  They will therefore appear
    to be modified (to the state prior to the checkout)
    to any subsequent git command, until they have been
    updated explicitly using "git submodule update".

skimo
