From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: GIT 0.99.4 (preview)
Date: Sun, 07 Aug 2005 23:18:19 -0400
Message-ID: <200508080318.j783IJNw012384@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 06:17:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1z4h-0007ip-6b
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 06:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVHHERB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 00:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVHHERB
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 00:17:01 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48841 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750705AbVHHERA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 00:17:00 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j783IJNw012384;
	Sun, 7 Aug 2005 23:18:19 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Sat, 06 Aug 2005 23:00:20 MST." <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

My proposed patch, the description as is is misleading.

The rest of the .spec file looks sane (yes, I've built my share of RPMs
over the years).

diff --git a/git-core.spec.in b/git-core.spec.in
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -2,7 +2,7 @@
 Name: 		git-core
 Version: 	@@VERSION@@
 Release: 	1
-Vendor: 	Linus Torvalds <torvalds@osdl.org>
+Vendor: 	Junio C Hamano <junkio@cox.net>
 Summary:  	Git core and tools
 License: 	GPL
 Group: 		Development/Tools
@@ -13,22 +13,23 @@ BuildRoot:	%{_tmppath}/%{name}-%{version
 Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5
 
 %description
-GIT comes in two layers. The bottom layer is merely an extremely fast
-and flexible filesystem-based database designed to store directory trees
-with regard to their history. The top layer is a SCM-like tool which
-enables human beings to work with the database in a manner to a degree
-similar to other SCM tools (like CVS, BitKeeper or Monotone).
+This is a stupid (but extremely fast) directory content manager.  It
+doesn't do a whole lot, but what it _does_ do is track directory
+contents efficiently. It is intended to be the base of an efficient,
+distributed source code management system. This package includes
+rudimentary tools that can be used as a SCM, but you should look
+elsewhere for tools for ordinary humans layered on top of this.
 
 %prep
 %setup -q
 
 %build
-
 make prefix=%{_prefix} all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make dest=$RPM_BUILD_ROOT prefix=%{_prefix} mandir=%{_mandir} install install-tools %{!?_without_docs: install-doc}
+make dest=$RPM_BUILD_ROOT prefix=%{_prefix} mandir=%{_mandir} \
+     install install-tools %{!?_without_docs: install-doc}
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -43,7 +44,13 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %{_mandir}/man7/*.7.gz}
 
 %changelog
+* Sun Aug 07 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
+- Redid the description
+- Cut overlong make line, loosened changelog a bit
+- I think Junio (or perhaps OSDL?) should be vendor...
+
 * Thu Jul 14 2005 Eric Biederman <ebiederm@xmission.com>
 - Add the man pages, and the --without docs build option
+
 * Wed Jul 7 2005 Chris Wright <chris@osdl.org>
 - initial git spec file

-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
