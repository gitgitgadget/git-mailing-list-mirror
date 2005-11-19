From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Fri, 18 Nov 2005 16:48:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181643190.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
 <Pine.LNX.4.64.0511171520390.13959@g5.osdl.org> <20051118121210.GA19714@abridgegame.org>
 <Pine.LNX.4.63.0511181419340.28109@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0511180806550.25159@shark.he.net> <Pine.LNX.4.64.0511180857170.13959@g5.osdl.org>
 <7vzmo1ecbf.fsf@assigned-by-dhcp.cox.net> <437E6CAB.8060200@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:49:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdGur-0005Qp-DA
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 01:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVKSAtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 19:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVKSAtO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 19:49:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751254AbVKSAtO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 19:49:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAJ0n1nO008034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 16:49:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAJ0msd9010782;
	Fri, 18 Nov 2005 16:48:57 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437E6CAB.8060200@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12311>



On Sat, 19 Nov 2005, Andreas Ericsson wrote:
> 
> nox!exon:~$ date --iso-8601=seconds
> 2005-11-19T01:04:56+0100
> 
> No human will spell it with T though.

Git doesn't care.

	./test-date 2005-11-19T01:04:56+0100

results in

	2005-11-19T01:04:56+0100 -> 1132358696 +0100 -> Fri Nov 18 16:04:56 2005

which should be correct: I'm in PST, test-date shows the "git time" 
(seconds since the epoch plus TZ) and then the local time in 
human-readable ascii.

The "T" to the git date parser is just a superfluous character that just 
happens to be a perfectly valid way to separate out the numbers ;)

		Linus
