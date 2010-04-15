From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git-cvsimport: strip question-mark characters in tags
Date: Thu, 15 Apr 2010 03:39:45 +0200
Message-ID: <201004150339.45879.johan@herland.net>
References: <20100414133831.GA12135@f.santiago.vpn.redhat.com>
 <m27ho9sr0i.fsf@igel.home> <20100414214229.GA31757@f.santiago.vpn.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Ed Santiago <santiago@redhat.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 03:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2E47-0006EM-PP
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 03:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab0DOBkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 21:40:16 -0400
Received: from smtp.getmail.no ([84.208.15.66]:50084 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755514Ab0DOBkP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 21:40:15 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L0W00B1H9YA7N80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Apr 2010 03:39:46 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L0W00FF69YASO30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Apr 2010 03:39:46 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.15.12414
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
In-reply-to: <20100414214229.GA31757@f.santiago.vpn.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144940>

On Wednesday 14 April 2010, Ed Santiago wrote:
> On Wed, Apr 14, 2010 at 10:44:45PM +0200, Andreas Schwab wrote:
> > Ed Santiago <santiago@redhat.com> writes:
> > > Question mark character appears to be valid in a CVS tag,
> > 
> > According to the CVS docs only letters, digits, '-' and '_' are valid
> > for tag names.
> 
> Poor choice of words on my part.  What I *should* have said is
> something like:
> 
>    Although question marks and curly braces are not among the
>    set of characters which CVS considers to be valid for a tag,
>    real-world situations have been encontered in which a CVS
>    comma-v file has a tag including all those characters.  This
>    patch makes git-cvsimport accept and forgive that reality.

Indeed. I have even seen CVS tag names containing carriage returns (aka. CR, 
\r) in the wild...


...Johan


> How that tag got created, I really don't know.  I can imagine
> three ways it could've happened (rcs commands; broken/old version
> of CVS; custom tool for mucking with comma-v files).  My goal
> was to recognize that this sort of thing happens, and to make
> it easier for the next person to find & fix this in the script.
> With that goal in mind, removing $! and adding the comment is
> the only important part of my patch.  The question mark itself
> is not likely to be useful except in very rare and weird cases.
> 
> Ed


-- 
Johan Herland, <johan@herland.net>
www.herland.net
