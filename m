From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 21:07:08 +0200
Message-ID: <200709022107.08804.johannes.sixt@telecom.at>
References: <46DACD93.9000509@trolltech.com> <200709022016.54262.johannes.sixt@telecom.at> <46DB0478.8050402@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 21:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRumz-0001YV-HD
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 21:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXIBTHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbXIBTHM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 15:07:12 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:53560 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXIBTHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 15:07:11 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 4B2F6977A0;
	Sun,  2 Sep 2007 21:07:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0F45E57CDC;
	Sun,  2 Sep 2007 21:07:09 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <46DB0478.8050402@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57379>

On Sunday 02 September 2007 20:44, Marius Storm-Olsen wrote:
> Johannes Sixt wrote:
> > I'm slightly negative about this. For a native Windows project the
> > executable bit does not matter, and for a cross-platform project this
> > check is not sufficient, but can even become annoying (think of a file
> > named 'www.google.com'). So we can just as well spare the few cycles.
>
> Ok, that's fine by me. It was only added for completeness, and with no
> benefits I'd say we drop it too.

I'll amend the patch accordingly.

> >>  		return 0;
> >> +	}
> >> +	errno = ENOENT;
> >
> > Of course we need a bit more detailed error conditions, most importantly
> > EACCES should be distinguished.
>
> Right, you want to do that in a second commit?

Yes, please. Please don't forget to take care of the trailing-slash annoyance.

-- Hannes
