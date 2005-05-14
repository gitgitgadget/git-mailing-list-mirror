From: Petr Baudis <pasky@ucw.cz>
Subject: Test scripts naming
Date: Sat, 14 May 2005 18:53:21 +0200
Message-ID: <20050514165321.GX3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 18:53:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWztM-00059Q-Nu
	for gcvg-git@gmane.org; Sat, 14 May 2005 18:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVENQx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 12:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVENQx1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 12:53:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19356 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262796AbVENQxW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 12:53:22 -0400
Received: (qmail 25582 invoked by uid 2001); 14 May 2005 16:53:21 -0000
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I think we should do something about the test script names. Currently
it appears almost like the scripts are basically unordered, and the
digit you increment is chosen mostly randomly. Also, the "freeform"
field after the test number is not as informative as it could be. What
are the rules you use for naming the testcases? Could you please
document it in the README?

  I'd propose:

  First digit: "family", e.g. the absolute basics and global stuff (0),
the basic db-side commands (read-tree, write-tree, commit-tree), the
basic working-tree-side commands (checkout-cache, update-cache), the
other basic commands (ls-files), the diff commands, the pull commands,
exporting commands, revision tree commands...

  Second digit: the particular command we are testing

  Third digit: (optionally) the particular switch or group of switches
we are testing

  Freeform part: commandname-details

  How would I rename the current scripts?

t1000-checkout-cache.sh -> t2000-checkout-cache-clash.sh
t1001-checkout-cache.sh -> t2001-checkout-cache-clash.sh
t0200-update-cache.sh   -> t2010-update-cache-badpath.sh
t0400-ls-files.sh       -> t3000-ls-files-others.sh
t0500-ls-files.sh       -> t3010-ls-files-killed.sh

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
