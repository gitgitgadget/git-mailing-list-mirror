From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2] autoconf: Use ./configure script in git *.spec file
Date: Mon, 3 Jul 2006 02:02:55 +0200
Message-ID: <200607030202.55919.jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 03 02:02:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxBtg-0002ae-ID
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 02:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWGCACf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 20:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWGCACe
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 20:02:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:16569 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750788AbWGCACe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 20:02:34 -0400
Received: by nf-out-0910.google.com with SMTP id k26so311409nfc
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 17:02:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fcfbTM2percR+KEzu0oD8HjAL1MCUvA3kQQdNCJKglyaDA5mP2IkqxOg8skIPDQLBD/tUTZFoPP/zS7FvoZX+LzpOShfADep++dNx/B+s9QnuWs/9Z9ItP1Bnql3iTFExZs2hJpuUQDt7eJDLF/wXRfI7z84uaN5ro6XGEHowUo=
Received: by 10.48.221.6 with SMTP id t6mr1937704nfg;
        Sun, 02 Jul 2006 17:02:32 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id b1sm441851nfe.2006.07.02.17.02.32;
        Sun, 02 Jul 2006 17:02:32 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607030156.50455.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23140>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 git.spec.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 8ccd256..1abb7d1 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -74,13 +74,13 @@ Git revision tree visualiser ('gitk')
 %setup -q
 
 %build
+%configure
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} all %{!?_without_docs: doc}
+     all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} mandir=%{_mandir} \
      install %{!?_without_docs: install-doc}
 
 (find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
-- 
1.4.0
