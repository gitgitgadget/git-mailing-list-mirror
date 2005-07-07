From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] cogito.spec.in update
Date: Thu, 7 Jul 2005 11:33:14 -0700
Message-ID: <20050707183314.GO5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Ellson <ellson@research.att.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 20:33:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqbBm-0006X1-2z
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 20:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVGGSdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVGGSdZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 14:33:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261550AbVGGSdY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 14:33:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67IXEjA031431
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 11:33:14 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67IXEUU016908;
	Thu, 7 Jul 2005 11:33:14 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j67IXE8a016907;
	Thu, 7 Jul 2005 11:33:14 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update cogito.spec.in to current.  This uses .gz instead of .bz2 for source
target as suggested by John Ellson, as well as some assorted minor changes.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/cogito.spec.in b/cogito.spec.in
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -6,11 +6,11 @@ Summary:  	Git core and tools
 License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/cogito/
-Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.bz2
+Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.gz
 Obsoletes:	git
 BuildRequires:	zlib-devel, openssl-devel, curl-devel
 BuildRoot:	%{_tmppath}/%{name}-%{version}-root
-Prereq: 	sh-utils, diffutils, rcs, mktemp >= 1.5
+Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5
 
 %description
 GIT comes in two layers. The bottom layer is merely an extremely fast
@@ -35,11 +35,20 @@ rm -rf $RPM_BUILD_ROOT
 
 %files
 %defattr(-,root,root)
-/usr/bin/*
-/usr/lib/cogito
+%{_bindir}/*
+%dir /usr/lib/cogito
+/usr/lib/cogito/*
 %doc README COPYING Documentation/*
 
 %changelog
+* Wed Jul 6 2005 Chris Wright <chris@osdl.org> 0.12-1
+- update spec file
+
+* Thu Jun 9 2005 Chris Wright <chrisw@osdl.org> 0.11.3-1
+- Add openssl patch from Dan Holmsand <holmsand@gmail.com>
+- Add cg-Xlib patch to fix showdate output
+- Update %files with changes inspired by Neil Horman <nhorman@redhat.com>
+
 * Mon May 9 2005 H. Peter Anvin <hpa@zytor.com> 0.10-1
 - New upstream revision
 - Rename spec file to cogito.spec
