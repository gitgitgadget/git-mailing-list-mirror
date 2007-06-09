From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 06/21] Refactor tag name verification loop to use index 'i'
 instead of incrementing pointer 'tag_line'
Date: Sat, 09 Jun 2007 23:34:32 +0200
Message-ID: <200706092334.32855.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090215.05318.johan@herland.net>
 <81b0412b0706091426x5cc496aft788376872fc56995@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 23:34:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8Zy-0008Ak-J4
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbXFIVeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbXFIVeh
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:34:37 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54611 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbXFIVeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:34:36 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE0050319N6P00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:34:35 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00BC519LAK60@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:34:33 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE0006F19LUA80@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:34:33 +0200 (CEST)
In-reply-to: <81b0412b0706091426x5cc496aft788376872fc56995@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49618>

On Saturday 09 June 2007, Alex Riesen wrote:
> On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > Signed-off-by: Johan Herland <johan@herland.net>
> > ---
> >  mktag.c |   29 ++++++++++++++++-------------
> >  1 files changed, 16 insertions(+), 13 deletions(-)
> 
> What is this change good for?
> How did you justify the type selection for your
> loop index variable?
> 
> IOW,  the patch looks very useless.

I agree. By itself, the patch is useless.

However, if you look at the next patch, you'll see that this exact piece of 
code is moved from verify_tag() to parse_and_verify_tag_buffer(), and in 
the new context, we can't increment tag_line, since the code that follows 
depends on tag_line not being moved.

In other words this patch is here so that the next patch will be easier to 
follow. because it's _literally_ moving copying code from verify_tag() and 
pasting it in parse_and_verify_tag_buffer().

I'm sorry if this is not clear from the patches.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
