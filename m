From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 14:12:02 +0200
Message-ID: <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
References: <1181425132239-git-send-email-hjemli@gmail.com>
 <11814251322779-git-send-email-hjemli@gmail.com>
 <20070610002802.GD31707@planck.djpig.de>
 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 14:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxMHO-0007FA-8F
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 14:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbXFJMMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 08:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbXFJMMH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 08:12:07 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:42069 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900AbXFJMME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 08:12:04 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JJF00CRV5W2KF@psmtp08.wxs.nl> for git@vger.kernel.org; Sun,
 10 Jun 2007 14:12:03 +0200 (MEST)
Received: (qmail 16369 invoked by uid 500); Sun, 10 Jun 2007 12:12:02 +0000
In-reply-to: <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49718>

On Sun, Jun 10, 2007 at 10:58:29AM +0200, Lars Hjemli wrote:
> On 6/10/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> >> +Each submodule can contain the following keys.
> >> +
> >> +module.$name.path::
> >> +     Define a path, relative to the top-level directory of the git
> >> +     working tree, where the submodule is expected to be checked out.
> >> +
> >> +module.$name.url::
> >> +     Define a url from where the submodule repository can be cloned.
> >
> >For .path a "Defaults to name of submodule" probably wouldn't hurt.
> 
> True. But there might be some issues with this rule, so I'll leave it
> as is for now.

And what might those issues be?

How about adding something like

	For a given path relative to the top-level directory of the
	git working tree, the logical name of the submodule at that
	path (if any) is the submodule <name> with a module.<name>.path
	value equal to that path, or, if no such submodule exists, the
	submodule <path>.  It is an error for different submodules to have
	identical path values.

For uniformity, you may also want to specify that a path value
must (or must not) end with a slash.

Other than that, I like it.
It doesn't have the extensions proposed by Linus, but it seems
to be forward compatible with them.

skimo
