From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Fri, 16 Sep 2005 00:08:24 -0400
Message-ID: <200509160415.j8G48Oto006070@inti.inf.utfsm.cl>
References: <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 06:59:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG8Jr-0003rj-Bc
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 06:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030597AbVIPE6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 00:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030598AbVIPE6z
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 00:58:55 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:209 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030597AbVIPE6y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 00:58:54 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8G48Oto006070;
	Fri, 16 Sep 2005 00:15:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Wed, 14 Sep 2005 20:21:33 MST." <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8659>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 14 Sep 2005, Alejandro Bonilla Beeche wrote:
> > 
> > debian:~# cd linux-2.6/
> > debian:~/linux-2.6# git log
> > /usr/local/bin/git-log-script: line 4: less: command not found
> 
> A very strange Linux installation that doesn't come with "less"...
> 
> What a strange box. Anyway, that does point out that maybe the git RPM 
> spec should have "less" as a dependency. 

Your wish is my command.

----
The git commands assume less(1) as pager. This adds the dependency, as
suggested by Linus.

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>


---

 git-core.spec.in |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

0abd0856f2cb750a019451c7547694f36e60e83b
diff --git a/git-core.spec.in b/git-core.spec.in
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -10,7 +10,7 @@ URL: 		http://kernel.org/pub/software/sc
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-root
-Requires: 	sh-utils, curl, diffutils, rsync, rcs, openssh-clients, perl, python >= 2.4, tk
+Requires: 	sh-utils, curl, diffutils, less, rsync, rcs, openssh-clients, perl, python >= 2.4, tk
 
 %description
 This is a stupid (but extremely fast) directory content manager.  It
@@ -44,6 +44,9 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %{_mandir}/man7/*.7*}
 
 %changelog
+* Fri Sep 16 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
+- Linus noticed that less is required, added to the dependencies
+
 * Sun Sep 11 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
 - Updated dependencies
 - Don't assume manpages are gzipped
