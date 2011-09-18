From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFCv4 4/4] gitweb: Add gitweb manpages to 'gitweb' package in git.spec
Date: Sun, 18 Sep 2011 15:34:44 +0200
Message-ID: <1316352884-26193-5-git-send-email-jnareb@gmail.com>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	admin@repo.or.cz, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Sep 18 15:36:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5HXR-0002Ra-Eu
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 15:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab1IRNfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 09:35:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59914 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551Ab1IRNfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 09:35:44 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so3099867fxe.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wZPHNMWYkIo1RmYkcYPSOB1YrbYTXKY/v7t348b4Ubg=;
        b=q+h6bqD16BFKkZK/hD97U56/lrFQa8ob93ILoorOjVnuAXLC7WvVryYCp6dLlJ0xWF
         XgT1OpXyWXDuE/7IsSCFNanZ33xfwhaCTeyXhzgDizvylkw+DGX2ncMU9wMoeg4xtQh1
         ISWeluoWQImcyvbeg4xmdzNIPNe1/6jZl2sF8=
Received: by 10.223.33.17 with SMTP id f17mr3234978fad.3.1316352922462;
        Sun, 18 Sep 2011 06:35:22 -0700 (PDT)
Received: from localhost.localdomain (abvm199.neoplus.adsl.tpnet.pl. [83.8.210.199])
        by mx.google.com with ESMTPS id x22sm18322348faa.5.2011.09.18.06.35.20
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 06:35:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1316352884-26193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181609>

This patch follows similar lines in %files section for 'gitk' and
'git-gui' subpackages.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
New in this version of series... though IIRC this change was present
in some version of those patches (probably not as separate patch,
though).

 git.spec.in |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 91c8462..dfc5093 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -199,7 +199,11 @@ rm -rf $RPM_BUILD_ROOT
 
 %files -n gitweb
 %defattr(-,root,root)
+%doc Documentation/*gitweb*.txt
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
