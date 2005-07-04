From: "David S. Miller" <davem@davemloft.net>
Subject: Re: expensive local git clone
Date: Mon, 04 Jul 2005 14:00:43 -0700 (PDT)
Message-ID: <20050704.140043.112609056.davem@davemloft.net>
References: <20050704.125744.59481768.davem@davemloft.net>
	<Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
	<20050704204235.GE21128@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 23:03:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpY5v-0004cU-Uy
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 23:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVGDVCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 17:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVGDVCj
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 17:02:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16600
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261670AbVGDVCR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 17:02:17 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.50)
	id 1DpY3X-0000Ry-Gg; Mon, 04 Jul 2005 14:00:43 -0700
To: pasky@suse.cz
In-Reply-To: <20050704204235.GE21128@pasky.ji.cz>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Petr Baudis <pasky@suse.cz>
Date: Mon, 4 Jul 2005 22:42:35 +0200

> Dear diary, on Mon, Jul 04, 2005 at 10:39:09PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> told me that...
> > That said, the pack-file thing I'm working on won't be perfect either, and
> > the main advantage is that it should work over ssh. The fastest way to do
> > a clone is really to do a recursive hardlinked tree, so you may well want
> > to just do
> > 
> > 	#!/bin/sh
> > 	mkdir "$2" && cp -rl "$1/.git" "$2/.git"
> > 
> > and it should be about a million times faster and equally effective.
> > 
> > Untested, of course.
> 
> I wouldn't do that on anything but .git/objects. ;-)

Agreed.  When I do it by hand (but I shouldn't have to
do this by hand, git-clone-script should do it this way
if that's the best and most efficient) I usually link the
object directory then copy the rest of the stuff non-linked.

I keep hoping git-clone-script is going to be a good way
to clone two local trees.  Is my hope misguided?  :-)
