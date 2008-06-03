From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: Eliminate curl binary
Date: Tue, 3 Jun 2008 15:58:51 +0200
Organization: <)><
Message-ID: <20080603135851.GB17302@camelia.ucw.cz>
References: <20080603105323.GA15825@camelia.ucw.cz> <200806031314.52579.johan@herland.net> <20080603121332.GA16570@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 16:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3X3D-0008GX-1N
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 15:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbYFCN6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbYFCN6z
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 09:58:55 -0400
Received: from ppp1053.in.ipex.cz ([212.71.160.53]:51510 "EHLO
	ppp1053.in.ipex.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbYFCN6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 09:58:54 -0400
Received: from ppp1053.in.ipex.cz (camelia.ucw.cz [127.0.0.1])
	by ppp1053.in.ipex.cz (8.14.2/8.13.8) with ESMTP id m53Dwqx9018229
	for <git@vger.kernel.org>; Tue, 3 Jun 2008 15:58:52 +0200
Received: (from kasal@localhost)
	by ppp1053.in.ipex.cz (8.14.2/8.13.8/Submit) id m53DwqCo018228
	for git@vger.kernel.org; Tue, 3 Jun 2008 15:58:52 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080603121332.GA16570@camelia.ucw.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83661>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello again.

(Sorry for answering twice, I type quicker than I think.)

> On Tue, Jun 03, 2008 at 01:14:52PM +0200, Johan Herland wrote:
> > In the next version of Git (v1.5.6, currently in RC1), git-clone.sh has 
> > been replaced by a builtin C version (builtin-clone.c, part of the git 

In that case, git.spec.in should not require curl.
(A diff with proposed patch attached.)

That said, I do think that including Fedora-style spec files and
other distribution-specific files into the tarball is a mistake.

Stepan Kasal

(FYI: I'm a Fedora developper, working for Red Hat.)

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-req-curl.patch"

diff --git a/git.spec.in b/git.spec.in
index 97a26be..cd8e883 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -7,12 +7,12 @@ Summary:  	Core git tools
 License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
-Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
-BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
+Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.bz2
+BuildRequires:	zlib-devel >= 1.2, openssl-devel, libcurl-devel, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 
 Requires:	perl-Git = %{version}-%{release}
-Requires:	zlib >= 1.2, rsync, curl, less, openssh-clients, expat
+Requires:	zlib >= 1.2, rsync, less, openssh-clients, expat
 Provides:	git-core = %{version}-%{release}
 Obsoletes:	git-core <= 1.5.4.2
 Obsoletes:	git-p4

--gBBFr7Ir9EOA20Yy--
