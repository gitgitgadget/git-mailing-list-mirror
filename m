From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 21:54:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602142150140.23719@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
 <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
 <87fymlvgzv.wl%cworth@cworth.org> <20060214202728.GE31278@pasky.or.cz>
 <Pine.LNX.4.63.0602142136250.23659@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzgtr7u2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 21:54:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97Ba-0004b2-I7
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 21:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWBNUyH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 15:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWBNUyH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 15:54:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:17094 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161080AbWBNUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 15:54:06 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 34C5D146F08; Tue, 14 Feb 2006 21:54:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 26F42A1C;
	Tue, 14 Feb 2006 21:54:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D6BF8146F08; Tue, 14 Feb 2006 21:54:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzgtr7u2.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16172>

Hi,

On Tue, 14 Feb 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Tue, 14 Feb 2006, Petr Baudis wrote:
> >
> >> [...]
> >>
> >> It works by creating a new branch cg-seek-point and storing the seeked
> >> point there; if HEAD is already on the branch, it merely changes the
> >> seek point and resets the working tree appropriately. cg-seek without
> >> any arguments will then return to your original head, whose name was
> >> stored in .git/head-name.
> >
> > And if you want to prevent accidental commit, just "chmod a-w 
> > $GIT_DIR/index".
> 
> That is a wrong answer.  It is perfectly sane to modify index
> without an intention to commit that change (you can always say
> "git reset").

Okay, I was not being completely truthful. If I did not get the original 
idea of git-seek wrong, then it was kind of an excursion, just taking a 
peek. And if you want to return from that excursion, I thought maybe it 
would make sense to disallow index operations *at all* until returning to 
the HEAD.

But I agree it is nasty. And Linus mentioned that the benefits of being 
able to commit into a temporary branch outweigh the shortcoming easily. 
(The shortcoming being that you have to keep in mind that you are in 
another branch. Which does not come easily to a fresh CVS convert.)

Ciao,
Dscho
