From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH 3/3] cogito spec file 0.8-2
Date: Tue, 3 May 2005 11:33:25 -0700
Message-ID: <20050503183325.GO18917@shell0.pdx.osdl.net>
References: <20050503182850.GL18917@shell0.pdx.osdl.net> <20050503183038.GM18917@shell0.pdx.osdl.net> <20050503183211.GN18917@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, terje.rosten@ntnu.no
X-From: git-owner@vger.kernel.org Tue May 03 20:30:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT29b-0001zA-SB
	for gcvg-git@gmane.org; Tue, 03 May 2005 20:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVECSfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 14:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVECSef
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 14:34:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:45024 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261555AbVECSdd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 14:33:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43IXPs4007383
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 11:33:25 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43IXPB6008858;
	Tue, 3 May 2005 11:33:25 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j43IXPET008857;
	Tue, 3 May 2005 11:33:25 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050503183211.GN18917@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Some small additions to the cogito spec file:

 o include some documentation
 o use %{_prefix} macro
 o drop -n from %setup macro

(chrisw: dropped spec file rename)

Signed-off-by: Terje Rosten <terje.rosten@ntnu.no>
Signed-off-by: Chris Wright <chrisw@osdl.org>

--- cogito/git.spec~0.8-1	2005-05-03 11:02:28.000000000 -0700
+++ cogito/git.spec	2005-05-03 11:10:32.000000000 -0700
@@ -1,6 +1,6 @@
 Name: 		cogito
 Version: 	0.8
-Release: 	1
+Release: 	2
 Vendor: 	Petr Baudis <pasky@ucw.cz>
 Summary:  	Git core and tools
 License: 	GPL
@@ -21,7 +21,7 @@ enables human beings to work with the da
 similar to other SCM tools (like CVS, BitKeeper or Monotone).
 
 %prep
-%setup -q -n %{name}-%{version}
+%setup -q
 
 %build
 
@@ -29,7 +29,7 @@ make
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make DESTDIR=$RPM_BUILD_ROOT prefix=/usr/ install
+make DESTDIR=$RPM_BUILD_ROOT prefix=%{_prefix} install
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -37,8 +37,14 @@ rm -rf $RPM_BUILD_ROOT
 %files
 %defattr(-,root,root)
 /usr/bin/*
+%doc README README.reference COPYING Changelog
 
 %changelog
+* Wed Apr 27 2005 Terje Rosten <terje.rosten@ntnu.no> 0.8-2
+- Doc files
+- Use %%{_prefix} macro
+- Drop -n option to %%setup macro
+
 * Mon Apr 25 2005 Chris Wright <chrisw@osdl.org> 0.8-1
 - Update to cogito, rename package, move to /usr/bin, update prereqs
 
