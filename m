From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 6/6] gitweb: Add gitweb manpages to 'gitweb' package in git.spec
Date: Sat,  8 Oct 2011 20:32:03 +0200
Message-ID: <1318098723-12813-7-git-send-email-jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:35:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCbkJ-0008Ft-HL
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 20:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab1JHSfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 14:35:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58345 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab1JHSfe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 14:35:34 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so448796eye.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3BlQdF9W7mlXHSJdrtfVeQA14IqetOEfkGOpbGOxEgk=;
        b=sJo+NlYP1LRVKwJd86KL3+gHZdu94t1blR/qawUdeDMRZ4Etvxq2QyGXmTAYMIkkrm
         EXnITnQPYVfF5eVcVips8IsdbhEifePrkJjsWflbk0AG5BusnE66Wl85sMEqoweyxf1A
         EE3k/+M5FInLVMRlWMs0u9wjeFZsRExCwXfAc=
Received: by 10.223.15.10 with SMTP id i10mr19759397faa.17.1318098932671;
        Sat, 08 Oct 2011 11:35:32 -0700 (PDT)
Received: from localhost.localdomain (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id m26sm20180604fac.6.2011.10.08.11.35.26
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 11:35:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183172>

This patch follows similar lines in %files section for 'gitk' and
'git-gui' subpackages.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This version adds gitweb's README and INSTALL to 'gitweb' subpackage.

 git.spec.in |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 91c8462..c562c62 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -199,7 +199,11 @@ rm -rf $RPM_BUILD_ROOT
 
 %files -n gitweb
 %defattr(-,root,root)
+%doc gitweb/README gitweb/INSTALL Documentation/*gitweb*.txt
 %{_datadir}/gitweb
+%{!?_without_docs: %{_mandir}/man1/*gitweb*.1*}
+%{!?_without_docs: %{_mandir}/man5/*gitweb*.5*}
+%{!?_without_docs: %doc Documentation/*gitweb*.html }
 
 %files -n perl-Git -f perl-files
 %defattr(-,root,root)
@@ -208,6 +212,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Sun Sep 18 2011 Jakub Narebski <jnareb@gmail.com>
+- Add gitweb manpages to 'gitweb' subpackage
+
 * Wed Jun 30 2010 Junio C Hamano <gitster@pobox.com>
 - Add 'gitweb' subpackage.
 
-- 
1.7.6
