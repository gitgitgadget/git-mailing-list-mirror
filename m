From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 10:38:45 -0400
Message-ID: <1F7F4219-8B2C-40A3-9F4D-BA79FAD7E2DB@silverinsanity.com>
References: <20070719104351.GA17182@midwinter.com> <20070719110224.GA4293@piper.oerlikon.madduck.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 16:38:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBX9X-0005QL-6j
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 16:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbXGSOir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 10:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXGSOir
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 10:38:47 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49273 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXGSOiq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 10:38:46 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 275091FFC243;
	Thu, 19 Jul 2007 14:38:45 +0000 (UTC)
In-Reply-To: <20070719110224.GA4293@piper.oerlikon.madduck.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52994>


On Jul 19, 2007, at 7:02 AM, martin f krafft wrote:

> +1 on the patch, but I also wonder why use of a pager is default in
> git anyway. At least I find it to be contrary to what I am used to
> on the Unix command line.
>
> For reference, there was an argument about this in
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=424978, which
> includes a long IRC log in German, unfortunately, where a bunch of
> people agreed with my proposal *not* to use a pager by default,
> since it makes it difficult to use information from the output to
> assemble the next command on the command line. Every terminal in use
> nowadays can easily scroll and even search back 250 lines with the
> added benefit of not randomly clearing the screen when you quit
> $PAGER.

I think it's because much of the core git community lives more on the  
console or simple terminals like xterm than in something with easy  
search and scrolling features like konsole or Terminal.app.  Git  
output tends to become very long very quickly, and usually you want  
to start reading from the beginning.

Many command line tools either output small chunks of input (ls, in  
most directories), output slowly (make), or their input is mostly  
only important when it errors out (make).  Git's output tends to be  
quite long and have the most relevant (read: recent) information at  
the beginning so paging is pretty much a must, instead of an  
occasional need.

If someone thinks that git paging by default is obnoxious, it just  
takes running "git config --global core.pager cat".  Now, no more  
paging.  If you find your $PAGER clearing the screen when quitting  
obnoxious, I suggest checking your configuration.  In particular, I  
find setting $LESS to "FX" (at least) to be most useful.

~~ Brian
