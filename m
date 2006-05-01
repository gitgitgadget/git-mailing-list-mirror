From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Mon, 1 May 2006 16:04:10 +0200
Message-ID: <20060501140410.GA3505@mars.ravnborg.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 16:04:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaZ0X-0008Jz-2N
	for gcvg-git@gmane.org; Mon, 01 May 2006 16:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWEAOEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 10:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWEAOEJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 10:04:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:50441 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932114AbWEAOEI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 10:04:08 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 072641EC372;
	Mon,  1 May 2006 16:04:06 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 7889543C069; Mon,  1 May 2006 16:04:10 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19378>

On Sun, Apr 30, 2006 at 11:32:36PM -0700, Junio C Hamano wrote:
> This attempts to set up built-in "git grep" to further reduce
> our dependence on the shell, while at the same time optionally
> allowing to run grep against object database.  You could do
> funky things like these:
> 
> 	git grep --cached -e pattern	;# grep from index
> 	git grep -e pattern master	;# or in a rev
> 	git grep -e pattern master next ;# or in multiple revs
> 	git grep -e pattern pu^@	;# even like this with an
> 					;# extension from another topic ;-)
> 	git grep -e pattern master..next ;# or even from rev ranges
> 	git grep -e pattern master~20:Documentation
> 					;# or an arbitrary tree
> 	git grep -e pattern next:git-commit.sh
>         				;# or an arbitrary blob
> 

A feature I have been missing often has been the possibility to limit
grep (and ls-files) to certain filenames.
Say:
git grip -e DEBUG 'Kconfig*'

I usually do something stupid like:
git ls-files | grep Kconfig | xargs grep DEBUG

Thought it may be trivial to extend git grip while you are there anyway.
But obviously only if this is useful for more than just me.

	Sam
