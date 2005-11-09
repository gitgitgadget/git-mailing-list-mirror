From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Wed, 09 Nov 2005 12:38:29 -0800
Message-ID: <7v1x1peeuy.fsf@assigned-by-dhcp.cox.net>
References: <E1EZqAA-0002B0-Un@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 21:40:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZwii-00085w-QH
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 21:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030652AbVKIUir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 15:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbVKIUiq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 15:38:46 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40854 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030774AbVKIUip (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 15:38:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109203747.PAEP29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 15:37:47 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EZqAA-0002B0-Un@jdl.com> (Jon Loeliger's message of "Wed, 09
	Nov 2005 07:38:54 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11411>

Jon Loeliger <jdl@freescale.com> writes:

>     Normally you can just do "make" followed by "make install", and that
>     will install the git programs in your own ~/bin/ directory.  If you want
>     to do a global install, you can do
>
> 	    make prefix=/usr install
>
> I ran "make" as myself, and then later
> I ran "make prefix=/usr install" as root.

Would this be explicit enough?

-- >8 -- cut here -- >8 --

diff --git a/INSTALL b/INSTALL
index bbb13f3..b2cdb31 100644
--- a/INSTALL
+++ b/INSTALL
@@ -7,8 +7,10 @@ to do a global install, you can do
 
 	make prefix=/usr install
 
-(or prefix=/usr/local, of course).  Some day somebody may send me a RPM
-spec file or something, and you can do "make rpm" or whatever.
+(or prefix=/usr/local, of course).  Just like any program suite
+that uses $prefix, the built results have some paths encoded,
+which are derived from $prefix, so "make all; make prefix=/usr
+install" would not work.
 
 Issues of note:
 
