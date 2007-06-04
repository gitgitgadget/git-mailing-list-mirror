From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] Support environment variables in config file
Date: Mon, 4 Jun 2007 10:44:11 +0200
Message-ID: <20070604084411.GA17622@moooo.ath.cx>
References: <20070603223727.GA16637@admingilde.org> <20070604053443.GA15148@moooo.ath.cx> <20070604072707.GE16637@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 10:44:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv8At-0001H1-55
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 10:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXFDIoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 04:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbXFDIoP
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 04:44:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:58159 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbXFDIoO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 04:44:14 -0400
Received: (qmail invoked by alias); 04 Jun 2007 08:44:12 -0000
Received: from pD9EBB5AC.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.172]
  by mail.gmx.net (mp050) with SMTP; 04 Jun 2007 10:44:12 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19kpLYEa2NktDVAAyKNsijxKDf+UlVJOyWiFStP7G
	GVE0mhhJ/45Lyr
Content-Disposition: inline
In-Reply-To: <20070604072707.GE16637@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49085>

Martin Waitz <tali@admingilde.org> wrote:
> Do you think the approach is ok?

Looks fine from the reading part.  Up to now
    $ git config "$key" "$value" &&
      [ "$value" = "$(git config "$key")" ] &&
      echo true
will echo true for all values (at least from the things I tried with
", \ and \n).  When interpreting $VAR this changes.  I dunno if there
are any programs out there that rely on the fact that the value you
get out of the config is exactly the same as you have put in.

> Can you see other examples where we may need $VAR support?
> Or would everybody be happy with support for ~/ in filenames?

In my config I don't even use the path to my home directory anywhere
and spontaneously I can't think of any config option for which I'd use
an environment variable as value.
