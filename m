From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 3/9] difftool: remove explicit change of PATH
Date: Fri, 16 Mar 2012 21:57:16 -0400
Message-ID: <1331949442-15039-4-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:58:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8iuS-0005eo-Nc
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 02:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032986Ab2CQB6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 21:58:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51068 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032979Ab2CQB6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 21:58:05 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so6233121iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TWp9Uh77l1CzpeeP9vXbpmy/+3oXGIIPmDOvIZzuhWE=;
        b=1IV01E37BcTNavZCHEISkRhedqKOI4i603ATcg8D4VHHgv+IfT/n0cWir4kJpvhhe3
         DQ8tHt8byd2Oh1RRCmyvNVZ0MHrQLGUqk3lvm5ot57qsZqlwzEFE0w5pju7LAC5ktJR6
         65P3tiuxdR6l3Z0C62scyxvEa5r51aFqSeRb7fN4WWyr8FFGBfah4KC6VtLcMkxV0nhQ
         JFJCXcIA/6g0GWVw31KYy9QAIUqp/EK+gvuSBRVPbgfg/mCaKvhffi4POlctRoWKlNWq
         C8id5S+0SpOR0xylEmBZTdlH31PLp+A11/Z8susPuacc8LiE3iImh0TvMn1kKGxvm3gq
         FJmQ==
Received: by 10.50.45.234 with SMTP id q10mr943611igm.54.1331949485435;
        Fri, 16 Mar 2012 18:58:05 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id cu4sm1211430igc.15.2012.03.16.18.58.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 18:58:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193291>

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
