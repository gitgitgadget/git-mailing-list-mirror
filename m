From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 14 May 2005 01:33:54 +0200
Message-ID: <20050513233354.GK32232@pasky.ji.cz>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org> <20050513224529.GF32232@pasky.ji.cz> <7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 01:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWjk7-00006Y-CV
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVEMXhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 19:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVEMXfU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 19:35:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11914 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262635AbVEMXd6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 19:33:58 -0400
Received: (qmail 11860 invoked by uid 2001); 13 May 2005 23:33:54 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 12:59:31AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Created: t/t2000-diff.sh (mode:100755)
> +Mode changed: path0 (100644->100755)

Great, so it's even worse than before. :/

My issues:

* Highly inconsistent format. Created has the "old-style" mode stuff
while changed mode looks completely differently. If you look at the
regular diffs, do you notice any format differences between creating
a file and modifying it?

	Actually, I think it should just always look as

		@ Mode changed: A->B C

	where either A or B may be empty (for file creation/deletion).
	I can see no point in further Created/Deleted lines.

* Filename not last. That'd be much friendlier to scripting, then you
could just split the line by spaces and at a certain point slurp the
rest and say that that would be a filename.

* No special prefix. Even if you think I shouldn't grep (it makes no
sense to me to redo half of the stuff when I already have something
reusable done, for no apparent benefit), I feel quite uncomfortable with
picking up and interpreting random pieces of surrounding text which
aren't marked as special in any way.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
