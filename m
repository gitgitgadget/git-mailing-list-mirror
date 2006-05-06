From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unresolved issues #2
Date: Sat, 6 May 2006 23:33:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605062332420.6423@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605041627310.6713@iabervon.org> <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
 <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
 <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE> <Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
 <BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE> <Pine.LNX.4.64.0605061008340.16343@g5.osdl.org>
 <7vvesirh0q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat May 06 23:33:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcUPF-0003YF-TT
	for gcvg-git@gmane.org; Sat, 06 May 2006 23:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWEFVdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 17:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWEFVdb
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 17:33:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:26808 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932084AbWEFVdb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 17:33:31 -0400
Received: (qmail invoked by alias); 06 May 2006 21:33:30 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp034) with SMTP; 06 May 2006 23:33:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvesirh0q.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19671>

Hi,

On Sat, 6 May 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Finally, I think "git repo-config" is buggy. Try with this .config file:
> > ...
> > So we'd really be screwing with porcelain if we made them use this ;)
> 
> Thanks Linus and Sean for bringing this up and fixing it.
> 
> I have a vague feeling that this may not be the last breakage of
> the repo-config command.  My first reaction to the repo-config
> code was "eek".  It tries to reuse as much the existing material
> as possible -- I understand it was done that way in order to
> preserve the comments and blank lines from the original config
> file intact, but it just felt very error prone (demonstrated by
> cases like this and the other one Sean brought up) and generally
> wrong.

It was done because the very syntax of the config suggests it be a 
user-editable file. I do not want to mess with the comments more than 
necessary.

> It might make sense to rewrite it to parse and read the existing
> configuration as a whole, do necessary manupulations on the
> parsed internal representation in-core, and write the result out
> from scratch.  That would fix another of my pet peeve: after an
> invocation of repo-config to remove the last variable in a
> section, it leaves an empty section header in.

Does it really hurt? I think not.

Anyway, I'll look into this.

Ciao,
Dscho
