From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 09/16] entry.c: optionally checkout submodules
Date: Sat, 19 May 2007 00:33:38 +0200
Message-ID: <20070518223338.GF10475@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <1179516307425-git-send-email-skimo@liacs.nl> <20070518215642.GC10475@steel.home> <20070518220323.GL942MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 00:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpB1d-0005It-DF
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563AbXERWdl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761009AbXERWdl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:33:41 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:35920 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609AbXERWdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:33:40 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (klopstock mo37) (RZmta 6.5)
	with ESMTP id G0472bj4IKRvWc ; Sat, 19 May 2007 00:33:38 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3840A277BD;
	Sat, 19 May 2007 00:33:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1B9E6D195; Sat, 19 May 2007 00:33:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070518220323.GL942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47672>

Sven Verdoolaege, Sat, May 19, 2007 00:03:23 +0200:
> On Fri, May 18, 2007 at 11:56:42PM +0200, Alex Riesen wrote:
> > skimo@liacs.nl, Fri, May 18, 2007 21:24:58 +0200:
> > > +	if (err)
> > > +		return error("failed to run git-checkout in submodule '%s'", path);
> > 
> > We may need an option to ignore these failures. Maybe even active by
> > default. Imagine a superproject with _optional_ submodules, where it
> > is just nice to know that some submodules weren't checked out. BTW,
> > doesn't git-checkout already prints an error?
> 
> Probably.  You probably noticed that I haven't written any tests yet...
> 

I see. It was a very ... provocative patch series :)

> Still, the error that git-checkout prints may not give enough of a clue
> that something was wrong with a submodule.

Like, for example, it failed because the directory is not a git repo
yet, because the previous git-checkout was called _without_
--submodule and the directories created are just empty.

Anyway, just a "failed to run git-checkout" is not very helpful
either. Come to think about it, there is not very much you can tell
out of super-project context. git-checkout will always know better.
