From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 4/9 v6] difftool: remove explicit change of PATH
Date: Thu, 22 Mar 2012 15:52:19 -0400
Message-ID: <1332445944-10944-5-git-send-email-tim.henigan@gmail.com>
References: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:53:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo4h-0005M2-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756967Ab2CVTx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:53:27 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35572 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab2CVTx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:53:26 -0400
Received: by qaeb19 with SMTP id b19so544975qae.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LacwmwkF8l4XzcyBeqQU/sYHhCjh3cxf//wD/GIfmYE=;
        b=stgPfCe8YmK5yEclBhLeATEN85nopAY6/3Fx773jCL2RB2pOCCDfstYapB/WMTA9xf
         zYRFIgSjKaLzRTVRsHY0XHO/ywqbvekHLxwQosM285Bdt7rB0x13TZhCbc2zBk2N766X
         hwDB7DdaVTQspIpwMF9SGMvhHvbiLDcR/Pwr1aXwpqKW5n9QVmwXWnB8A38qhgfuDBkb
         vvLrQBezxw28mCRuGttnarRIQZj2onT1XlWKkmlG44+l3XkO4uhChqECC0ggj3asIzVE
         AmCpfBUPJ6ySIVtZgb9vQOd8Ryt5CJ48tYHSqhH7nl7y19R8w2G1HzHPU4w9kJJWO2F1
         xKuw==
Received: by 10.224.186.2 with SMTP id cq2mr7929416qab.48.1332446005551;
        Thu, 22 Mar 2012 12:53:25 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id fo9sm914014qab.21.2012.03.22.12.53.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:53:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
In-Reply-To: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193703>

Adding the script directory to PATH is not needed. The script is
located at '$(git --exec-path)', which is already on the PATH.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 33ae30a..77c9907 100755
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
 
@@ -33,8 +31,6 @@ USAGE
 
 sub setup_environment
 {
-	my $DIR = abs_path(dirname($0));
-	$ENV{PATH} = "$DIR:$ENV{PATH}";
 	$ENV{GIT_PAGER} = '';
 	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
 }
-- 
1.7.10.rc1.36.g15e879
