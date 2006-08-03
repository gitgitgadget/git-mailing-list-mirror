From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: What's in git.git
Date: Thu, 3 Aug 2006 02:31:13 -0700
Message-ID: <20060803093113.GB14400@prophet.net-ronin.org>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net> <20060802192922.GA30539@prophet.net-ronin.org> <7virlas9ol.fsf@assigned-by-dhcp.cox.net> <20060803053004.GA10413@prophet.net-ronin.org> <20060803054831.GB10413@prophet.net-ronin.org> <20060803073636.GA12755@prophet.net-ronin.org> <7vvepaqkki.fsf@assigned-by-dhcp.cox.net> <20060803085002.GA14400@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 11:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8ZY1-0003CB-Ec
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 11:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWHCJbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 05:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWHCJbS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 05:31:18 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:56784 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S932429AbWHCJbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 05:31:18 -0400
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1G8ZXt-0003z1-00; Thu, 03 Aug 2006 02:31:13 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060803085002.GA14400@prophet.net-ronin.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24717>

Okay, dug around a bit more, and I admit, I'm not very familiar with Tk
(just started reading about it when poking at the gitk weirdness).

After applying your patch, rm'ing ~/.gitk, *and* doing:

--- gitk        2006-08-03 02:27:20.000000000 -0700
+++ /home/barbeque/bin/gitk     2006-08-03 02:24:52.000000000 -0700
@@ -429,7 +429,7 @@
     panedwindow .ctop -orient vertical
     if {[info exists geometry(width)]} {
        .ctop conf -width $geometry(width) -height $geometry(height)
-       set texth [expr {$geometry(height) - $geometry(canvh) - 56}]
+       set texth [expr {$geometry(height) - $geometry(canvh) - 136}]
        set geometry(ctexth) [expr {($texth - 8) /
                                    [font metrics $textfont -linespace]}]
     }

Then subsequent launches of gitk appear to be correct.  However, if the stale
~/.gitk is still around, the bug stays around.

Since my eyes are getting fuzzy, can someone that knows TCL/Tk eyeball that
and see if it's the actual cause, or just papering over a bug?

Thanks!

-- DN
Daniel
