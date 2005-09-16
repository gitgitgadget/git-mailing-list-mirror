From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] Update cogito.spec.in
Date: Thu, 15 Sep 2005 23:47:24 -0700
Message-ID: <20050916064720.GI8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 08:48:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGA0c-0007ck-0L
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 08:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbVIPGra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 02:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbVIPGra
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 02:47:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161061AbVIPGr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 02:47:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8G6lOBo024824
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 23:47:25 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8G6lOLP014157;
	Thu, 15 Sep 2005 23:47:24 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8G6lOIP014156;
	Thu, 15 Sep 2005 23:47:24 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8667>

Latest updates to cogito.spec.in generated from review for Fedora Extras.

Signed-off-by: Chris Wright <chrisw@osdl.org>

---

 cogito.spec.in |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

e0ca49e6c375a68b3e4b3edfff752fef2cf585f6
diff --git a/cogito.spec.in b/cogito.spec.in
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -1,15 +1,14 @@
 Name: 		cogito
 Version: 	@@VERSION@@
 Release: 	1
-Vendor: 	Petr Baudis <pasky@suse.cz>
 Summary:  	The Cogito Version Control System
 License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/cogito/
 Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.gz
-BuildRoot:	%{_tmppath}/%{name}-%{version}-root
-Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5, git-core >= 0.99.3
-BuildArchitectures:	noarch
+BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
+Requires: 	git-core >= 0.99.3
+BuildArch:	noarch
 
 %description
 Cogito is a version control system layered on top of the git tree history
@@ -34,11 +33,18 @@ rm -rf $RPM_BUILD_ROOT
 %files
 %defattr(-,root,root)
 %{_bindir}/*
-%dir /usr/lib/cogito
-/usr/lib/cogito/*
+%dir %{_libdir}/cogito
+%{_libdir}/cogito/*
 %doc README COPYING Documentation/*
 
 %changelog
+* Thu Sep 15 2005 Chris Wright <chrisw@osdl.org> 0.14.1-1
+- Update to 0.14.1
+
+* Mon Aug 15 2005 Chris Wright <chrisw@osdl.org> 0.13-3
+- Update Buildroot, Requires and drop Vendor
+- use %{_libdir}
+
 * Wed Aug 10 2005 Pavel Roskin <proski@gnu.org> 0.13-1
 - Update summary and description
 - Make architecture-independent
