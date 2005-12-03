From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Sat, 3 Dec 2005 03:31:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512030323290.19086@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
 <Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051201033201.02b47071.tihirvon@gmail.com> <7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 03:32:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiNBt-00077W-M9
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 03:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVLCCby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 21:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVLCCby
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 21:31:54 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8349 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751172AbVLCCby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 21:31:54 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E9BB613FAB4; Sat,  3 Dec 2005 03:31:52 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D03269F50E; Sat,  3 Dec 2005 03:31:52 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B3D1B9F41D; Sat,  3 Dec 2005 03:31:52 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8AA7413FAB4; Sat,  3 Dec 2005 03:31:52 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13142>

Hi,

On Thu, 1 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > But it is only one line, heck only 20 bytes!
> 
> Hey, don't get so piped up.  Timo's patch has already been
> merged (thanks, Timo).

In case I did not make it clear: I was not mad or something like that. I 
only see 3 ways to go about that particular problem:

- maintain your private config.mak
- maintain your private Make (shell script)
- maintain your private Makefile

I actually did the third way for a while, always merging the newest 
version. But all of a sudden -- when I was working on another project, 
which *has* a config.mak -- I had the idea to do the first way.

Actually, the second way falls a little bit short for some of my 
applications: I sometimes override settings in the first part of the 
Makefile. This is not possible with Make.

> If you need an override, you have to write down and maintain
> those YesPlease _somewhere_ yourself anyway, outside what I
> ship.  Either "config.mak" or "Make" script.

As mentioned, with the difference that you just can't override some things 
in Make.

> If we have '-include' in the Makefile, we need to make a
> decision if what we are adding to the Makefile should be
> overridable by that config.mak every time, exactly because
> whatever is included becomes part of the Makefile.  IOW, that
> "only 20 bytes" adds work for the Makefile maintainer.

... which might have another (desired) effect: the structure of the 
Makefile is better. More organized.

Besides, if you change things in an organized Makefile, you tend to be a 
little bit more careful where you put things, so the cost of maintaining 
is not really high (happened to me...).

Hth,
Dscho
