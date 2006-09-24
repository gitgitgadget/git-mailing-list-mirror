From: Sam Ravnborg <sam@ravnborg.org>
Subject: git send-email woes
Date: Mon, 25 Sep 2006 00:43:16 +0200
Message-ID: <20060924224316.GA28051@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 00:38:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRcbt-0001jH-VL
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 00:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWIXWiC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 18:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWIXWiC
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 18:38:02 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:58244 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751356AbWIXWiA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 18:38:00 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 0AC388000A7
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 00:38:00 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id DF06E580D2; Mon, 25 Sep 2006 00:43:16 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27706>

I stumbled on two issues with git-send-email today.
First of I forgot to tell where to find the patch files to send.
But git-send-email only complained _after_ I had given all
the information manually.
It would have been niver to check that all mandatory arguments
was present before being interactive.

The second issue are best explained quoting a mail from Matti Arnio:
> > The GIT is at times producing emails that are not
> > utterly strictly speaking kosher RFC-(2)822 format.
> >
> > It might be a surprise to you that unquoted dots in
> > people's names cause syntax scanner indigestion,
> > because said character has very special meaning in
> > RFC-822 syntax.  All would be fine if
> >     Example J.P. Example <example@example.net>
> > had couple quotes:
> >     "Example J.P. Example" <example@example.net>

What I could see was that git-send-email takes mail address
verbatim from "Signed-off-by:" lines and use it.
Would it be possible to always quote it except when quoted
or to do a more intelligent RFC2822 check?

That would keep suprises lower.

I'm not good a perlish so I have not attempted fixing it myself...

	Sam
