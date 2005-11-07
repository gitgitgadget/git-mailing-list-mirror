From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git binary directory?
Date: Sun, 6 Nov 2005 16:54:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511061653380.3316@g5.osdl.org>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
 <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511052013550.3316@g5.osdl.org>
 <7vy84249re.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511060816390.3316@g5.osdl.org>
 <7v7jbly1lh.fsf@assigned-by-dhcp.cox.net> <20051106221952.GP1431@pasky.or.cz>
 <7virv5wc86.fsf@assigned-by-dhcp.cox.net> <20051107004346.GR1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 01:56:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYvI3-0004zl-2Y
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 01:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVKGAzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 19:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVKGAzJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 19:55:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932384AbVKGAzI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 19:55:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA70svnO028063
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 6 Nov 2005 16:54:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA70stea011109;
	Sun, 6 Nov 2005 16:54:56 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051107004346.GR1431@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11243>



On Mon, 7 Nov 2005, Petr Baudis wrote:
> 
> I want to avoid extra fork()s and exec()s. They seem to routinely matter
> in orders of magnitude of speed in tight loops.

Yes. The more I think about it, the less I like the separate binary 
directory after all. The "git cmd" format is great for high-level 
commands, but we've always done "git-diff-tree" and "git-rev-list" etc 
without the "git cmd" indirection.

The downsides of a separate binary directory appear to be bigger than the 
upside..

		Linus
