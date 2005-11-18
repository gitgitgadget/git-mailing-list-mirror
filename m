From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: master has some toys
Date: Fri, 18 Nov 2005 03:48:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511180345450.6359@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
 <b0943d9e0511160311k725526d8v@mail.gmail.com> <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
 <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
 <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
 <7vy83ny450.fsf@assigned-by-dhcp.cox.net> <81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
 <7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 03:50:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcwJE-00035L-7a
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 03:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVKRCs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 21:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVKRCs7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 21:48:59 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3980 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751439AbVKRCs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 21:48:59 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2972313FE38; Fri, 18 Nov 2005 03:48:58 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0D5ED9F34A; Fri, 18 Nov 2005 03:48:58 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EA4619CC6E; Fri, 18 Nov 2005 03:48:57 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CAE4B13FE38; Fri, 18 Nov 2005 03:48:57 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: John Benes <smartcat99s@gmail.com>
In-Reply-To: <437D2D14.5080205@gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12185>

Hi,

On Thu, 17 Nov 2005, John Benes wrote:

> I was able to compile master and pu on Cygwin without NO_MMAP=YesPlease
> in the Cygwin section.  However, the make test failed on the
> binary-apply on both master and pu, output follows.

Nobody doubts that you can *compile* it. The problem is the fixing of the 
mmap()ed regions after fork(). Since win32 is such a sane system, it does 
not provide mmap() or fork() out of the box. And under some very obscure 
circumstances, cygwin's emulation of mmap() and fork() fails.

BTW, it would be more helpful if you do not just tell *what* test fails, 
but *how*. For example, try to run "git-whatchanged -p" and send just 
the first page of the output (both stdout and stderr). I bet it says it 
has a problem fixing up mmap() after fork().

Hth,
Dscho
