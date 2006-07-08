From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Sat, 8 Jul 2006 04:28:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607080414210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkr5szi2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 04:28:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz2Yx-0000Gn-KP
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 04:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWGHC2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 22:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWGHC2o
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 22:28:44 -0400
Received: from mail.gmx.de ([213.165.64.21]:31679 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932489AbWGHC2n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 22:28:43 -0400
Received: (qmail invoked by alias); 08 Jul 2006 02:28:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 08 Jul 2006 04:28:42 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkr5szi2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23474>

Hi,

On Fri, 7 Jul 2006, Junio C Hamano wrote:

>  - Early parts of Perly Git by Petr Baudis with help from others
>    are merged to "next".  Please report breakages before other
>    Perl scripts are converted to use this.

I saw many problems on my machines with this, just as I expected. Please 
play it _really_ safe. I hated to be forced to rewrite git-fmt-merge-msg 
in C, but I just could not use 'next' without that. I would hate it even 
more to rewrite git-mv in C just to make the tests happy (they are not on 
my iBook right now).

>  - GIT_TRACE by Matthias Lederhofer.  What it lets you do is
>    interesting (although I personally do not foresee myself
>    using it), and I am in favor of its inclusion.  The issue
>    that the mechanism does not let you trace some commands
>    (scripts) raised on the list has stalled this topic branch.
>    I'd either want people to agree that it is not a problem, or
>    if they feel it is a problem, have a fix for that, before
>    merging this to "next".

You probably allude to my comments, which were meant more as a hint to go 
towards C, instead of scripts. There is a lot to be said about C, but the 
fact is: if you have most of the core of git in C (if not all of it), you 
have less problems (especially when integrating over _all_ platforms and 
setups).

As it is, I am all for inclusion of GIT_TRACE support. If need be, 
everybody can add GIT_TRACE support to the script she is debugging. And if 
she's nice, she can send a patch to the list, too.

>  - Auto configuration by Pasky and Jakub.  This deserves a fresh
>    paragraph.

I can see why some may want autoconf (or a clone of MPlayer's configure) 
in git. But the fact is: on many platforms, the Makefile works out of the 
box. Especially on cygwin, where _any_ shell script -- and autoconf 
generated scripts in particular -- are slower than a dog's poo, it is 
_soooo_ much better to be able to just say "make".

Please, please, _please_ keep autoconfiguration _strictly_ opt-in.

>    Linus Torvalds:
>       builtin "git prune"

FWIW, I read the code, too, and I agree it is ready for 'next'. After my 
first read, I was curious why the parameter "object_array *p" was needed 
for all the process_* functions. It turned out that add_object() needs 
this. Just in case anybody else wonders.

Ciao,
Dscho
