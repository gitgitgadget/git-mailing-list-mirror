From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Wine + GIT
Date: Tue, 06 Dec 2005 11:53:09 -0600
Message-ID: <1133891589.8577.63.camel@cashmere.sps.mot.com>
References: <20051206173909.GE17457@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 18:56:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejh0o-0000iY-D4
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 18:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVLFRxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 12:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVLFRxa
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 12:53:30 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:8075 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932614AbVLFRx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 12:53:27 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id jB6I6Jt9005217;
	Tue, 6 Dec 2005 11:06:19 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id jB6I0sbd029549;
	Tue, 6 Dec 2005 12:00:54 -0600 (CST)
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20051206173909.GE17457@fieldses.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13284>

On Tue, 2005-12-06 at 11:39, J. Bruce Fields wrote:

> I've enjoyed getting tab completions without having to add whatever's
> required to my .bashrc to teach it about git subcommands.  Oh well,
> I'll
> get over it.

I believe this effort is already well under way.
Uh, I also thought we were going to place it in
some "contrib" directory too...?

Also, before I learned of that bash completion effort,
I was contemplating modifying the git.c command recognition
so that it effectively did this:

   cmd = ... whatever from command line
   if (exec(cmd)) works then
       happily clean up and exit
   else
       using the existing directory scan as a new function,
       determine if "cmd" is a proper prefix of some command,
       if it is unique then
           exec(unique-cmd-disambiguated)
       else
           complain that it is not unique
       fi
    fi

That way:
    "git mer" would fail
    "git merge" would run "git-merge"
    "git merge-" would fail
    "git merge-o" would fail,
    "git-merge-oc" would run "git-merge-octopus".

Any interest?  Overkill?  Bad idea?

jdl
