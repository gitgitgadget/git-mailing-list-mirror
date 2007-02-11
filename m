From: Bruno Haible <bruno@clisp.org>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 00:52:23 +0100
Message-ID: <200702120052.23468.bruno@clisp.org>
References: <200702111252.28393.bruno@clisp.org> <20070211152840.GA2781@steel.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOOp-00081Q-Dh
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932925AbXBKXqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932926AbXBKXqY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:46:24 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:59765 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932925AbXBKXqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:46:23 -0500
Received: from linuix.haible.de (cable-137-244.iesy.net [81.210.137.244])
	by post.webmailer.de (klopstock mo34) (RZmta 4.5)
	with ESMTP id D00fdbj1BIQWWz ; Mon, 12 Feb 2007 00:46:21 +0100 (MET)
User-Agent: KMail/1.5.4
In-Reply-To: <20070211152840.GA2781@steel.home>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY4JDyuz6KRYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39333>

Alex Riesen wrote:
> - do not use "tr.c", unless you really need it: git has to read more
>   of a commit in this case. Just "git log" takes only 0.9 sec on the
>   machine above.

"git log" is indeed faster, but is useless for the given task, since it doesn't
show which of the 4 megabytes of commit messages apply to tr.c.

> > On a file in a local copy of the coreutils git repository,
> > "git log tr.c > output" takes
> 
> Why do you need _all_ commits, btw?

I want to quickly find the cause of a behaviour change between tr.c of
coreutils 5.2.1 and the one of coreutils 6.4. It's a period of 1.5 years,
but limited to a single file. Can't git produce this quickly?

> > 2) Why so much system CPU time, but only on MacOS X?
> 
> MacOS X is famous for its bad perfomance when doing serious work.
> The mmap(2) of it, in particular.

But at least, a MacOS X machine is still interactively usable when it uses
6 times more swap than the machine's RAM size. Whereas a Linux 2.4 machine
is interactively unusable already with 1.5 to 2 times more swap than the
machine has RAM.

Bruno
