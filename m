From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 14/16] t7800 (difftool): add missing &&
Date: Sat, 25 Sep 2010 13:07:05 -0600
Message-ID: <1285441627-28233-15-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4v-0005Xq-ER
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784Ab0IYTF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39899 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab0IYTF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:56 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so880409pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xp9Irg2uBRxItYR/hUwJQLkvFQtoEy+WDjAXrEUSagY=;
        b=mJ/nPvP7L/CVFfAUsM0amrymA3cLY6oUleltQZtbkuvYNPJysBrDzmelb3IyfxK96S
         vqwfS9ZxBnITg5dmC01x8V4m2jrNK7Cr8WaCNtAm5anW3D/rwOrzoV6rRnNDXMDOft3i
         ynA7KMFtTcQy8d3S71XFgA2M898JB04mfF2S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lrVG+nptCvNkB4Y77kW2BoMZPokBDAfC9ej+7Yo6/bquWcGsW7Qc18iqhEa28+2fZF
         ZNRZneJLkekEOcuTgot43CoxXabk9kdqzApr3h7AvFe8m1peQ85bKuWrzF6yXYa7NGco
         KF9cUuzlz4z2JELLsGVBDITKNXCWlSHFfOMXY=
Received: by 10.114.25.5 with SMTP id 5mr5648838way.137.1285441556465;
        Sat, 25 Sep 2010 12:05:56 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.54
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157180>

Also remove a call to 'git config --unset difftool.prompt', since that is
already unset by restore_test_defaults.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7800-difftool.sh |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 58dc6f6..ffb1960 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -98,7 +98,7 @@ test_expect_success PERL 'difftool --gui works without configured diff.guitool'
 
 # Specify the diff tool using $GIT_DIFF_TOOL
 test_expect_success PERL 'GIT_DIFF_TOOL variable' '
-	git config --unset diff.tool
+	git config --unset diff.tool &&
 	GIT_DIFF_TOOL=test-tool &&
 	export GIT_DIFF_TOOL &&
 
@@ -166,7 +166,6 @@ test_expect_success PERL 'difftool.prompt config variable is false' '
 
 # Test that we don't have to pass --no-prompt when mergetool.prompt is false
 test_expect_success PERL 'difftool merge.prompt = false' '
-	git config --unset difftool.prompt
 	git config mergetool.prompt false &&
 
 	diff=$(git difftool branch) &&
@@ -211,7 +210,7 @@ test_expect_success PERL 'difftool last flag wins' '
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
 test_expect_success PERL 'difftool + mergetool config variables' '
-	remove_config_vars
+	remove_config_vars &&
 	git config merge.tool test-tool &&
 	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
 
@@ -254,17 +253,17 @@ test_expect_success PERL 'difftool -x cat' '
 '
 
 test_expect_success PERL 'difftool --extcmd echo arg1' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" branch)
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" branch) &&
 	test "$diff" = file
 '
 
 test_expect_success PERL 'difftool --extcmd cat arg1' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branch)
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branch) &&
 	test "$diff" = master
 '
 
 test_expect_success PERL 'difftool --extcmd cat arg2' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branch)
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branch) &&
 	test "$diff" = branch
 '
 
-- 
1.7.3.95.g14291
