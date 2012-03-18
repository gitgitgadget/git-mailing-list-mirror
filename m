From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 3/9 v2] difftool: remove explicit change of PATH
Date: Sat, 17 Mar 2012 21:55:28 -0400
Message-ID: <1332035734-5443-4-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 02:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95MW-0004Hw-MB
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276Ab2CRB4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 21:56:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55335 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757012Ab2CRB4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 21:56:09 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so7559135iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TWp9Uh77l1CzpeeP9vXbpmy/+3oXGIIPmDOvIZzuhWE=;
        b=nIyEKdBVZIwYNI1+T5/s8CINu0MNFy758XETy51A7EkiMiJ51e+8aN0FbhS6Sb5vQr
         u9Ltfktc+J7o0Ws54UxyYqkL3vgOLDcTdbm9nIGkr6NMwYNwiRjGUJbO3UghFOzfVqC1
         fFjlyuIRej8m8xY3SXQ7Ir96gYKLdnkGdjcnREitYvfL3FfnmwP7gmBnvxzUdf6SLMzB
         uYolc6yJUOdKe8/UOsAD7v43Upc1RzegjTfDEVXpFWe/sYlhiQEbgIerm0N0wplvpEte
         2tj3u7d4tP+WMzWxCwGeDAV19+6pTdwiSuWYXO3zsSOgM12CExmbLo7WJYJZDuhV2alF
         6GRw==
Received: by 10.50.190.167 with SMTP id gr7mr2910921igc.8.1332035769531;
        Sat, 17 Mar 2012 18:56:09 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id b11sm4302898igq.7.2012.03.17.18.56.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 18:56:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193358>

Adding the script directory to PATH is not needed. The script is
located at '$(git --exec-path)', which is already on the PATH.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 81ecf34..53fcd7e 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -13,8 +13,6 @@
 use 5.008;
 use strict;
 use warnings;
-use Cwd qw(abs_path);
-use File::Basename qw(dirname);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
@@ -31,8 +29,6 @@ USAGE
 
 sub setup_environment
 {
-	my $DIR = abs_path(dirname($0));
-	$ENV{PATH} = "$DIR:$ENV{PATH}";
 	$ENV{GIT_PAGER} = '';
 	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
 }
-- 
1.7.9.1.290.gbd444
