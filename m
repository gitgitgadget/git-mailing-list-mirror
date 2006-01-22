From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Mention install-doc in INSTALL
Date: Sun, 22 Jan 2006 01:12:55 +0100
Message-ID: <20060122001255.GR28365@pasky.or.cz>
References: <E1F0SYe-0005ix-WB@puzzle.fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 01:11:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Spb-0003CU-Dg
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 01:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWAVAL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 19:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWAVALZ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 19:11:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49628 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751239AbWAVALZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 19:11:25 -0500
Received: (qmail 5742 invoked by uid 2001); 22 Jan 2006 01:12:55 +0100
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <E1F0SYe-0005ix-WB@puzzle.fieldses.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15031>

Dear diary, on Sun, Jan 22, 2006 at 12:54:12AM CET, I got a letter
where "J. Bruce Fields" <bfields@fieldses.org> said that...
> I think most people will want to install the man pages as well.
> 
> (I'm less sure about the case of the home directory, as I assume there's
> unlikely to be a reasonable place to install man pages to in that case.)
> 
> Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

But you really do not want to build the documentation as root.
Cogito's "solution" is:

diff --git a/INSTALL b/INSTALL
index 916ddd4..464bfbb 100644
--- a/INSTALL
+++ b/INSTALL
@@ -90,3 +90,10 @@ Issues of note:
    You can place local settings in config.mak and the Makefile
    will include them.  Note that config.mak is not distributed;
    the name is reserved for local settings.
+
+ - By default, separate documentation (manpages, text, HTML) is not built
+   since it requires asciidoc and xmlto, and those tools are not so common.
+   You can build it by "make doc" and install it later by "make install-doc"
+   in the project root, or you can build directly in the "Documentation/"
+   subdirectory, where you can also choose to build only documentation in
+   particular format. See Documentation/Makefile for further details.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
