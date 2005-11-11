From: Petr Baudis <pasky@ucw.cz>
Subject: The host:remote syntax mess
Date: Fri, 11 Nov 2005 02:22:16 +0100
Message-ID: <20051111012216.GJ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 11 02:22:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaNcU-0007Xm-7d
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 02:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVKKBWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 20:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVKKBWT
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 20:22:19 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28590 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932281AbVKKBWT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 20:22:19 -0500
Received: (qmail 12490 invoked by uid 2001); 11 Nov 2005 02:22:16 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11549>

  Hello,

  I've just noticed that host:remote syntax seems to have been hijacked
again and is now attached to the GIT protocol in

	Documentation/pull-fetch-param.txt

(which BTW misses git+ssh). I said "seems", because connect.c still
appears to assume it is SSH. So what is the plan? One possible
explanation is just that the git+ssh line should have been between the
git line and the : line in the documentation.

  But if you really intend to change it, please don't. It's enough mess
as it is now, and I'm actually not convinced at all that we should
support it at all (god forbid promote it). When you have a location
specifier, you don't want it to randomly switch protocols, especially
such significantly different ones as ssh and git.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
