From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Fri, 6 Jul 2007 02:17:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707060201200.9789@racer.site>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 03:17:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6cRj-0002Rq-9u
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 03:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759587AbXGFBRQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 21:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760034AbXGFBRQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 21:17:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:42044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758293AbXGFBRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 21:17:16 -0400
Received: (qmail invoked by alias); 06 Jul 2007 01:17:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 06 Jul 2007 03:17:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FjddLQcqFyQ/iUcuclfAC/x2jcZLNBOJTQ2Flc2
	XGLp1xa9a6Oqwz
X-X-Sender: gene099@racer.site
In-Reply-To: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51709>

Hi,

[on this list, it is considered polite to not cull the Cc list anyway]

On Thu, 5 Jul 2007, Dan McGee wrote:

> In this commit:
> b516968ff62ec153e008d033c153affd7ba9ddc6

You might be interested to look only at the changes to builtin-push.c. I 
have a hunch that you just need to disable setting the remote if 
"remote.<name>.skipDefaultUpdate" is set.

Of course, for that to work, you would also need to add a member variable 
to struct remote in remote.h, and handle it at the end of handle_config() 
in remote.c.

Then just use remote->skip_default_update in builtin-push.c, to guard 
around lines 90--93.

As for submitting, please read Documentation/SubmittingPatches first, it 
is not really long, and most of it is obvious.

Hth,
Dscho
